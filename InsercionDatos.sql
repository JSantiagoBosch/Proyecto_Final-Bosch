insert into agentes (nombre, email, telefono) 
values 
('Manuel Rodriguez','manuelrodriguez@gmail.com','1176239381'),
('Carlo Gomez', 'carlos.gomez@gmail.com', '1177859300'),
('Lucia Fernández', 'luciafernandez@gmail.com', '1192883749'),
('Juan Perez', 'juanperez@gmail.com', '1117239705');

insert into clientes (nombre, email, telefono, tipo_busq)
values
('Fabian Martin', 'fabianmartin@gmail.com', '1166574893', 'compra'),
('Sofia Rivas', 'sofiarivas@gmail.com', '1199594856', 'compra'),
('Juan Muñoz', 'juanmunios@gmail.com', '1127331898', 'compra'),
('Lautaro Ramos', 'lautaroramos@gmail.com', '1191387738', 'compra'),
('María Dutto', 'mariadutto@gmail.com', '1110478829', 'alquiler'),
('Ana Rios', 'anarios@gmail.com', '1156478344', 'alquiler'),
('Jorge Colman', 'jorgecolman@gmail.com', '1156473319', 'alquiler'),
('Mario Roldan', 'marioroldan@gmail.com', '1140394911', 'alquiler');

insert into propiedades (id_agente, direccion, ciudad, tipo, precio, superficie, estado)
values
(1, 'Calle Falsa 123', 'Buenos Aires', 'casa', 150000, 120, 'vendido'),
(2, 'Avenida Siempreviva 742', 'Buenos Aires', 'departamento', 100000, 80, 'vendido'),
(1, 'Calle de los Pinos 45', 'Rosario', 'casa', 200000, 150, 'disponible'),
(3, 'Avenida Libertador 500', 'Mendoza', 'terreno', 80000, 500, 'disponible'),
(2, 'Calle del Sol 89', 'Cordoba', 'departamento', 120000, 90, 'alquilado'),
(4, 'Calle Corrientes 1500', 'Buenos Aires', 'departamento', 95000, 75, 'disponible'),
(2, 'Calle del Bosque 23', 'Mar del Plata', 'casa', 180000, 140, 'disponible'),
(3, 'Calle Independencia 305', 'San Juan', 'terreno', 70000, 450, 'disponible'),
(1, 'Avenida Callao 700', 'Buenos Aires', 'departamento', 110000, 85, 'alquilado'),
(4, 'Calle San Martín 22', 'La Plata', 'casa', 250000, 180, 'vendido');

insert into visitas (id_propiedad, id_cliente, fecha_visita)
values
(1, 1, '2024-09-15'),
(2, 2, '2024-09-16'),
(3, 3, '2024-09-17'),
(4, 4, '2024-09-18'),
(5, 5, '2024-09-19'),
(6, 6, '2024-09-20');


insert into transacciones (id_propiedad, id_cliente, tipo_transaccion, precio, fecha_transaccion)
values
(5, 1, 'Alquiler', 10000, '2024-09-22'),
(9, 2, 'Alquiler', 8000, '2024-09-24'),
(2, 3, 'Venta', 150000, '2024-09-21'),
(10, 4, 'Venta', 200000, '2024-09-23'),
(1, 5, 'Venta', 180000, '2024-09-25');