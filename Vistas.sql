create or replace view vw_propiedad_agente
as
select 
    p.direccion,
    p.ciudad,
    p.tipo,
    p.precio,
    p.estado,
    a.Nombre as Nombre_Agente
from 
    propiedades p
join 
    agentes a on p.id_agente = a.ID_agente;



create or replace view vw_visitas_agentes
as
select 
    v.fecha_visita,
    c.nombre as cliente_nombre,
    a.nombre as agente_nombre,
    p.direccion as propiedad_direccion,
    p.ciudad as propiedad_ciudad,
    p.tipo as propiedad_tipo
from 
    visitas v
join 
    clientes c on v.id_cliente = c.id_cliente
join 
    propiedades p on v.id_propiedad = p.id_propiedad
join 
    agentes a on p.id_agente = a.ID_agente;



create or replace view vw_transacciones_clientes
as
select 
    c.nombre as Nombre_Cliente,
    p.direccion as Direccion_Propiedad,
    p.ciudad as Ciudad_Propiedad,
    t.tipo_transaccion as Tipo_Transaccion,
    t.precio as Precio_Transaccion,
    t.fecha_transaccion as Fecha_Transaccion
from
    transacciones t
join 
    clientes c on t.id_cliente = c.id_cliente
join 
    propiedades p on t.id_propiedad = p.id_propiedad;



create or replace view vw_propiedad_mas_visitada
as
select 
    p.id_propiedad as ID_Propiedad,
    p.direccion as Direccion,
    p.ciudad as Ciudad,
    COUNT(v.id_visita) as Total_Visitas
from 
    propiedades p
join 
    visitas v on p.id_propiedad = v.id_propiedad
group by 
    p.id_propiedad, p.direccion, p.ciudad
order by 
    Total_Visitas desc;



create or replace view vw_clientes_mas_transacciones
as
select 
    c.nombre as Nombre_Cliente,
    COUNT(t.id_transaccion) as Total_Transacciones
from 
    clientes c
join 
    transacciones t on c.id_cliente = t.id_cliente
group by 
    c.id_cliente, c.nombre
order by 
    Total_Transacciones desc;


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
    
    
    
