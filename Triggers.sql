DELIMITER //

-- Trigger para registrar cambios en la tabla clientes
CREATE TRIGGER after_cliente_update
AFTER UPDATE ON clientes
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_clientes (id_cliente, cambio, fecha)
    VALUES (OLD.id_cliente, CONCAT('Cambio de ', OLD.nombre, ' a ', NEW.nombre), NOW());
END; //

DROP TRIGGER IF EXISTS after_transaccion_insert;


CREATE TRIGGER after_transaccion_insert
AFTER INSERT ON transacciones
FOR EACH ROW
BEGIN
    UPDATE propiedades
    SET estado = CASE
        WHEN NEW.tipo_transaccion = 'Venta' THEN 'vendido'
        WHEN NEW.tipo_transaccion = 'Alquiler' THEN 'alquilado'
        ELSE estado
    END
    WHERE id_propiedad = NEW.id_propiedad;
END //


-- Trigger para mantener un registro de visitas
CREATE TRIGGER before_visita_insert
BEFORE INSERT ON visitas
FOR EACH ROW
BEGIN
    DECLARE visit_count INT;

    SELECT COUNT(*) INTO visit_count
    FROM visitas
    WHERE id_cliente = NEW.id_cliente
    AND id_propiedad = NEW.id_propiedad
    AND fecha_visita = NEW.fecha_visita;

    IF visit_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente ya ha visitado esta propiedad en esta fecha.';
    END IF;
END; //

-- Trigger para auditar eliminaciones de propiedades
CREATE TRIGGER before_propiedad_delete
BEFORE DELETE ON propiedades
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_propiedades (id_propiedad, accion, fecha)
    VALUES (OLD.id_propiedad, 'Eliminación', NOW());
END; //

DELIMITER ;
