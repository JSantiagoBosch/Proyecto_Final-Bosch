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
    IN p_estado VARCHAR(20),
    IN p_id_agente INT,
    IN p_ciudad VARCHAR(100),
    IN p_superficie INT
)
BEGIN
    -- Insertar una nueva propiedad, incluyendo el campo superficie
    INSERT INTO propiedades (direccion, precio, tipo, estado, id_agente, ciudad, superficie) 
    VALUES (p_direccion, p_precio, p_tipo, p_estado, p_id_agente, p_ciudad, p_superficie);
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
    IN p_fecha_transaccion DATETIME
)
BEGIN
    -- Inserta los datos en la tabla 'transacciones'
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

DROP PROCEDURE IF EXISTS EliminarCliente;

-- Procedimiento 6: EliminarCliente
CREATE PROCEDURE EliminarCliente(
    IN p_id_cliente INT
)
BEGIN
    -- Eliminar las visitas asociadas al cliente
    DELETE FROM visitas WHERE id_cliente = p_id_cliente;

    -- Eliminar las transacciones asociadas al cliente
    DELETE FROM transacciones WHERE id_cliente = p_id_cliente;

    -- Eliminar cliente
    DELETE FROM clientes WHERE id_cliente = p_id_cliente;
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