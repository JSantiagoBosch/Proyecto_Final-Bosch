-- Cambiamos el delimitador para evitar conflictos con el ; en los procedimientos
DELIMITER //

-- Procedimiento 1: RegistrarCliente
CREATE PROCEDURE RegistrarCliente(
    IN p_nombre VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_telefono VARCHAR(20)
)
BEGIN
    INSERT INTO clientes (nombre, email, telefono) 
    VALUES (p_nombre, p_email, p_telefono);
END //

-- Procedimiento 2: AgregarNuevaPropiedad
CREATE PROCEDURE AgregarNuevaPropiedad(
    IN p_direccion VARCHAR(255),
    IN p_precio DECIMAL(10,2),
    IN p_tipo VARCHAR(50),
    IN p_estado VARCHAR(20)
)
BEGIN
    INSERT INTO propiedades (direccion, precio, tipo, estado) 
    VALUES (p_direccion, p_precio, p_tipo, p_estado);
END //

-- Procedimiento 3: RegistrarVisita
CREATE PROCEDURE RegistrarVisita(
    IN p_id_cliente INT,
    IN p_id_propiedad INT,
    IN p_fecha_visita DATE
)
BEGIN
    INSERT INTO visitas (id_cliente, id_propiedad, fecha_visita) 
    VALUES (p_id_cliente, p_id_propiedad, p_fecha_visita);
END //

-- Procedimiento 4: RealizarTransacción
CREATE PROCEDURE RealizarTransacción(
    IN p_id_cliente INT,
    IN p_id_propiedad INT,
    IN p_tipo_transaccion VARCHAR(20),
    IN p_precio DECIMAL(10,2),
    IN p_fecha_transaccion DATE
)
BEGIN
    INSERT INTO transacciones (id_cliente, id_propiedad, tipo_transaccion, precio, fecha_transaccion) 
    VALUES (p_id_cliente, p_id_propiedad, p_tipo_transaccion, p_precio, p_fecha_transaccion);
END //

-- Procedimiento 5: ActualizarEstadoPropiedad
CREATE PROCEDURE ActualizarEstadoPropiedad(
    IN p_id_propiedad INT,
    IN p_nuevo_estado VARCHAR(20)
)
BEGIN
    UPDATE propiedades 
    SET estado = p_nuevo_estado 
    WHERE id_propiedad = p_id_propiedad;
END //

-- Procedimiento 6: EliminarCliente
CREATE PROCEDURE EliminarCliente(
    IN p_id_cliente INT
)
BEGIN
    DELETE FROM clientes 
    WHERE id_cliente = p_id_cliente;
END //

-- Procedimiento 7: ResumenTransacciones
CREATE PROCEDURE ResumenTransacciones(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    SELECT * 
    FROM transacciones 
    WHERE fecha_transaccion BETWEEN p_fecha_inicio AND p_fecha_fin;
END //

-- Restauramos el delimitador por defecto
DELIMITER ;
