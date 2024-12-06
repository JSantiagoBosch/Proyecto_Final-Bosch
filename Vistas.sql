CREATE OR REPLACE VIEW vw_propiedad_agente
AS
SELECT 
    p.direccion,
    p.ciudad,
    p.tipo,
    p.precio,
    p.estado,
    a.Nombre AS Nombre_Agente
FROM 
    propiedades p
JOIN 
    agentes a ON p.id_agente = a.ID_agente;



CREATE OR REPLACE VIEW vw_visitas_agentes
AS
SELECT 
    v.fecha_visita,
    c.nombre AS cliente_nombre,
    a.nombre AS agente_nombre,
    p.direccion AS propiedad_direccion,
    p.ciudad AS propiedad_ciudad,
    p.tipo AS propiedad_tipo
FROM 
    visitas v
JOIN 
    clientes c ON v.id_cliente = c.id_cliente
JOIN 
    propiedades p ON v.id_propiedad = p.id_propiedad
JOIN 
    agentes a ON p.id_agente = a.ID_agente;



CREATE OR REPLACE VIEW vw_transacciones_clientes
AS
SELECT 
    c.nombre AS Nombre_Cliente,
    p.direccion AS Direccion_Propiedad,
    p.ciudad AS Ciudad_Propiedad,
    t.tipo_transaccion AS Tipo_Transaccion,
    t.precio AS Precio_Transaccion,
    t.fecha_transaccion AS Fecha_Transaccion
FROM
    transacciones t
JOIN 
    clientes c ON t.id_cliente = c.id_cliente
JOIN 
    propiedades p ON t.id_propiedad = p.id_propiedad;



CREATE OR REPLACE VIEW vw_propiedad_mas_visitada
AS
SELECT 
    p.id_propiedad AS ID_Propiedad,
    p.direccion AS Direccion,
    p.ciudad AS Ciudad,
    COUNT(v.id_visita) AS Total_Visitas
FROM 
    propiedades p
JOIN 
    visitas v ON p.id_propiedad = v.id_propiedad
GROUP BY 
    p.id_propiedad, p.direccion, p.ciudad
ORDER BY 
    Total_Visitas DESC;



CREATE OR REPLACE VIEW vw_clientes_mas_transacciones
AS
SELECT 
    c.nombre AS Nombre_Cliente,
    COUNT(t.id_transaccion) AS Total_Transacciones
FROM 
    clientes c
JOIN 
    transacciones t ON c.id_cliente = t.id_cliente
GROUP BY 
    c.id_cliente, c.nombre
ORDER BY 
    Total_Transacciones DESC;


CREATE OR REPLACE VIEW vw_propiedades_disponibles_detalles
AS
SELECT 
    p.direccion AS Direccion,
    p.ciudad AS Ciudad,
    p.tipo AS Tipo,
    p.precio AS Precio,
    p.superficie AS Superficie,
    a.nombre AS Agente_Responsable,
    p.estado AS Estado_Propiedad,
    COUNT(v.id_visita) AS Total_Visitas,
    COUNT(t.id_transaccion) AS Total_Transacciones
FROM 
    propiedades p
JOIN 
    agentes a ON p.id_agente = a.id_agente
LEFT JOIN 
    visitas v ON p.id_propiedad = v.id_propiedad
LEFT JOIN 
    transacciones t ON p.id_propiedad = t.id_propiedad
WHERE 
    p.estado = 'disponible'
GROUP BY 
    p.id_propiedad, p.direccion, p.ciudad, p.tipo, p.precio, p.superficie, a.nombre, p.estado
ORDER BY 
    p.precio DESC;


CREATE OR REPLACE VIEW vw_transacciones_agentes
AS
SELECT 
    a.nombre AS Nombre_Agente,
    COUNT(t.id_transaccion) AS Total_Transacciones
FROM 
    agentes a
JOIN 
    propiedades p ON a.id_agente = p.id_agente
JOIN 
    transacciones t ON p.id_propiedad = t.id_propiedad
GROUP BY 
    a.id_agente, a.nombre
ORDER BY 
    Total_Transacciones DESC;