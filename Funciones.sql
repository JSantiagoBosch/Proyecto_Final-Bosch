-- Cambiamos el delimitador para evitar conflictos con el ; en las funciones
DELIMITER //

-- Función 1: ObtenerPrecioPromedioPropiedades
CREATE FUNCTION PrecioPromedioPropiedades()
RETURNS DECIMAL(10,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE precio_promedio DECIMAL(10,2);
    SELECT AVG(precio) INTO precio_promedio
    FROM propiedades
    WHERE estado = 'disponible';
    RETURN precio_promedio;
END //

-- Función 2: ContadorTipoPropiedad
CREATE FUNCTION ContadorTipoPropiedad()
RETURNS TEXT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE resultado TEXT;
    
    -- Usamos una subconsulta para generar el GROUP_CONCAT y almacenarlo en resultado
    SELECT GROUP_CONCAT(tipo_cantidad SEPARATOR ', ')
    INTO resultado
    FROM (
        SELECT CONCAT(tipo, ': ', COUNT(*)) AS tipo_cantidad
        FROM propiedades
        GROUP BY tipo
    ) AS subquery;

    RETURN resultado;
END //


-- Función 3: ObtenerInfoCliente
CREATE FUNCTION ObtenerInfoCliente(p_id_cliente INT)
RETURNS VARCHAR(1000)
READS SQL DATA
BEGIN
    DECLARE info_cliente TEXT;
    
    -- Construimos la información del cliente
    SELECT CONCAT('Nombre: ', nombre, ', Email: ', email, ', Teléfono: ', telefono)
    INTO info_cliente
    FROM clientes
    WHERE id_cliente = p_id_cliente;
    
    -- Devolvemos la información
    RETURN info_cliente;
END //

-- Función 4: PropiedadDisponible
CREATE FUNCTION PropiedadDisponible(p_id_propiedad INT)
RETURNS VARCHAR(50)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE estado_propiedad VARCHAR(50);

    -- Obtener el estado de la propiedad
    SELECT estado 
    INTO estado_propiedad
    FROM propiedades
    WHERE id_propiedad = p_id_propiedad
    LIMIT 1;
    
    -- Evaluamos si está disponible
    IF estado_propiedad = 'disponible' THEN
        RETURN 'La propiedad está disponible';
    ELSE
        RETURN 'La propiedad no está disponible';
    END IF;
END //


-- Función 5: HistorialVisitasCliente
CREATE FUNCTION HistorialVisitasCliente(id_cliente INT)
RETURNS VARCHAR(1000)
READS SQL DATA
BEGIN
    DECLARE historial_visitas TEXT;
    
    SELECT GROUP_CONCAT(CONCAT('Propiedad ID: ', v.id_propiedad, ', Fecha de Visita: ', v.fecha_visita) SEPARATOR '; ') 
    INTO historial_visitas
    FROM visitas v
    WHERE v.id_cliente = id_cliente;
    
    RETURN IFNULL(historial_visitas, 'No se encontraron visitas para este cliente');
END //

-- Función 6: TransaccionesCliente
CREATE FUNCTION TransaccionesCliente(id_cliente INT)
RETURNS VARCHAR(1000)
READS SQL DATA
BEGIN
    DECLARE transacciones TEXT DEFAULT '';
    
    SELECT GROUP_CONCAT(CONCAT('Tipo: ', t.tipo_transaccion, ', Monto: ', t.precio, ', Fecha: ', t.fecha_transaccion) SEPARATOR '; ')
    INTO transacciones
    FROM transacciones t
    WHERE t.id_cliente = id_cliente;
    
    RETURN IFNULL(transacciones, 'No se encontraron transacciones para este cliente');
END //

-- Restauramos el delimitador por defecto
DELIMITER ;


