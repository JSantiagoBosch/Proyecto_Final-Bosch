 -- Eliminamos si existe la base de datos
drop schema if exists inmobiliaria_model;

-- Creamos una base de datos si no existe
CREATE SCHEMA IF NOT EXISTS inmobiliaria_model;

-- Usamos la base de dato inmobiliaria_model
USE inmobiliaria_model;
  
-- Tabla: Propiedades
CREATE TABLE if not exists propiedades (
    id_propiedad int auto_increment primary key,
    id_agente int NOT NULL,
    direccion varchar(50) NOT NULL,
    ciudad varchar(50) NOT NULL,
    tipo enum('casa', 'departamento', 'terreno') NOT NULL,
    precio decimal NOT NULL,
    superficie decimal NOT NULL,
    estado enum('disponible', 'vendido', 'alquilado') NOT NULL
);


-- Tabla: Clientes
CREATE TABLE if not exists clientes (
    id_cliente int auto_increment primary key,
    nombre varchar (255) NOT NULL,
    email varchar(255) NOT NULL,
    telefono varchar(255) NOT NULL,
    tipo_busq enum('compra', 'alquiler') NOT NULL
);


-- Tabla: Visitas
CREATE TABLE if not exists visitas (
    id_visita int auto_increment primary key,
    id_propiedad int NOT NULL,
    id_cliente int NOT NULL,
    fecha_visita DATETIME NOT NULL,
    foreign key (id_propiedad) references propiedades(id_propiedad),
    foreign key (id_cliente) references clientes(id_cliente)
);


-- Tabla: Agentes
CREATE TABLE if not exists agentes (
    id_agente int auto_increment primary key,
    nombre varchar (255) NOT NULL,
    email varchar(255) NOT NULL,
    telefono varchar(255) NOT NULL
);


-- Tabla: Transacciones
CREATE TABLE if not exists transacciones (
	id_transaccion int auto_increment primary key,
    id_propiedad int NOT NULL,
    id_cliente int NOT NULL,
    tipo_transaccion enum('Venta', 'Alquiler') NOT NULL,
    precio decimal NOT NULL,
    fecha_transaccion DATETIME NOT NULL,
    foreign key (id_propiedad) references propiedades(id_propiedad),
    foreign key (id_cliente) references clientes(id_cliente)
);

-- Tabla para auditoría de cambios en clientes
CREATE TABLE if not exists auditoria_clientes (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    cambio VARCHAR(255),
    fecha DATETIME,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Tabla para auditoría de cambios en propiedades
CREATE TABLE if not exists auditoria_propiedades (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_propiedad INT,
    accion VARCHAR(50),
    fecha DATETIME,
    FOREIGN KEY (id_propiedad) REFERENCES propiedades(id_propiedad)
);


-- Modificación de la tabla Propiedades para relacionarla con Agentes
ALTER TABLE propiedades
ADD CONSTRAINT fk_agente
FOREIGN KEY (id_agente) REFERENCES agentes(id_agente);

