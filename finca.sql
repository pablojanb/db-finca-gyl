-- crear base de datos
CREATE DATABASE IF NOT EXISTS finca_prueba
CHARACTER SET utf8mb4
COLLATE utf8mb4_spanish_ci;


-- definimos la DB que vamos a trabajar para no aclararlo en cada consulta y que sean mas legibles
USE finca_prueba;

/*
CREATE TABLE finca_prueba.fincas (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  propietario_id INT NOT NULL,
  detalle_id INT NOT NULL,
  direccion_id INT NOT NULL,
  tarifa_hora DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;
*/


-- creo tabla finca
CREATE TABLE fincas (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  propietario_id INT NOT NULL,
  detalle_id INT NOT NULL,
  direccion_id INT NOT NULL,
  tarifa_hora DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;


-- creo tabla horarios_funcionamiento
CREATE TABLE horarios_funcionamiento (
  id INT NOT NULL AUTO_INCREMENT,
  finca_id INT NOT NULL,
  hora_inicio TIME NOT NULL,
  hora_fin TIME NOT NULL,
  dia_semana VARCHAR(45) NOT NULL,
  descuento DECIMAL(10, 2) NULL,
  recargo DECIMAL(10, 2) NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;


-- creo tabla propietarios
CREATE TABLE propietarios (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  apellido VARCHAR(45) NOT NULL,
  fecha_nac  DATE NOT NULL,
  contacto_id INT NOT NULL,
  usuario_id INT NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;


-- creo tabla contactos
CREATE TABLE contactos (
  id INT NOT NULL AUTO_INCREMENT,
  email VARCHAR(45) NOT NULL,
  telefono VARCHAR(45) NOT NULL,
  email_alternativo VARCHAR(45) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;


-- creo tabla detalle
CREATE TABLE detalles (
  id INT NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(400) NOT NULL,
  cant_habitacion INT NOT NULL,
  cant_banio INT NOT NULL,
  metros_cuad INT NOT NULL,
  capacidad_max INT NOT NULL,
  wifi BOOLEAN NOT NULL,
  piscina BOOLEAN NOT NULL,
  parrilla BOOLEAN NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;


-- creo tabla direccion
CREATE TABLE direcciones (
  id INT NOT NULL AUTO_INCREMENT,
  calle VARCHAR(45) NOT NULL,
  altura INT NULL,
  ciudad VARCHAR(45) NOT NULL,
  provincia VARCHAR(45) NOT NULL,
  aclaracion VARCHAR(200) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;


-- creo tabla reserva
CREATE TABLE reservas (
  id INT NOT NULL AUTO_INCREMENT,
  finca_id INT NOT NULL,
  cliente_id INT NOT NULL,
  desde DATETIME NOT NULL,
  hasta DATETIME NOT NULL,
  total DECIMAL(10, 2) NOT NULL,
  estado BOOLEAN DEFAULT FALSE,
  PRIMARY KEY (id))
ENGINE = InnoDB;


-- creo tabla fecha_especial
CREATE TABLE fechas_especiales (
  id INT NOT NULL AUTO_INCREMENT,
  fecha DATE NOT NULL,
  dia_semana VARCHAR(45) NOT NULL,
  hora_inicio TIME NOT NULL,
  hora_fin TIME NOT NULL,
  descuento DECIMAL(10, 2) NULL,
  recargo DECIMAL(10, 2) NULL,
  motivo VARCHAR(200) NOT NULL,
  finca_id INT NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;


-- creo tabla cliente
CREATE TABLE clientes (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  apellido VARCHAR(45) NOT NULL,
  dni VARCHAR(45) NOT NULL,
  correo VARCHAR(45) NOT NULL,
  usuario_id INT NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;


-- Tabla Usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(40) NOT NULL,
    email VARCHAR(40) NOT NULL UNIQUE,
    contrasenia VARCHAR(255) NOT NULL,
    cuenta_activa BOOLEAN DEFAULT TRUE
);

-- Tabla Rol
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL UNIQUE
);


-- Tabla Usuario_Rol (tabla intermedia 1-1)
CREATE TABLE usuario_rol (
  rol_id INT NOT NULL,
  usuario_id INT NOT NULL
);



-- Tabla Permisos
CREATE TABLE permisos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL
);


-- Tabla Rol_Permisos (tabla intermedia 1-1)
CREATE TABLE rol_permisos (
  rol_id INT NOT NULL,
  permiso_id INT NOT NULL
);


-- TABLA AUTENTICACION EXTERNA
CREATE TABLE autenticacion_externa (
  id INT NOT NULL AUTO_INCREMENT,
  nombre_proveedor VARCHAR(45) NOT NULL,
  proveedor_usuario_id VARCHAR(45) NOT NULL,
  usuario_id INT NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;

-- TABLA IMAGEN_FINCA

CREATE TABLE imagenes_fincas(
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
url VARCHAR(2048) NOT NULL,
es_portada BOOLEAN NOT NULL,
finca_id INT NOT NULL
);

-- TABLA documentacion

CREATE TABLE documentacion(
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
propietario_id INT NOT NULL,
plano_catastral VARCHAR(45) NOT NULL,
escritura_propiedad VARCHAR(45) NOT NULL,
impuesto_inmuebles VARCHAR(45) NOT NULL
);

-- PAGOS

CREATE table pagos(
id INT NOT NULL AUTO_INCREMENT,
reserva_id INT NOT NULL,
monto_total DECIMAL(10, 2) NOT NULL,
modopago_id INT NOT NULL,
fecha_hora DATETIME NOT NULL,
descuento_aplicado DECIMAL NOT NULL,
recargo_aplicado DECIMAL NOT NULL,
estado_pago BOOLEAN,
PRIMARY KEY (id)
);

CREATE table modo_de_pago(
id INT NOT NULL AUTO_INCREMENT,
tipo VARCHAR(15) NOT NULL,
detalles VARCHAR(60) NOT NULL,
PRIMARY KEY(id) 
);

CREATE TABLE comprobante_pago(
id INT AUTO_INCREMENT PRIMARY KEY,
pago_id INT,
monto DECIMAL(10,2),
modo_id INT,
descripcion VARCHAR(100)
);










-- FOREIGN KEYS

-- FINCA - DETALLE 1-1
-- FINCA - PROPIETARIO 1-1
-- FINCA - DIRECCION 1-1


ALTER TABLE fincas
ADD CONSTRAINT fk_finca_detalle
FOREIGN KEY (detalle_id) REFERENCES detalles(id)
ON DELETE CASCADE,
ADD CONSTRAINT fk_finca_propietario
FOREIGN KEY (propietario_id) REFERENCES propietarios(id)
ON DELETE CASCADE,
ADD CONSTRAINT fk_finca_direccion
FOREIGN KEY (direccion_id) REFERENCES direcciones(id)
ON DELETE CASCADE;


/*

SE PUEDE ESTABLECER FKs AL MOMENTO DE CREAR LAS TABLAS

CREATE TABLE fincas (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  propietario_id INT NOT NULL,
  detalle_id INT NOT NULL,
  direccion_id INT NOT NULL,
  tarifa_hora DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_finca_propietario FOREIGN KEY (propietario_id) REFERENCES propietarios(id)
  ON DELETE CASCADE,
  CONSTRAINT fk_finca_detalle FOREIGN KEY (detalle_id) REFERENCES detalles(id)
  ON DELETE CASCADE,
  CONSTRAINT fk_finca_direccion FOREIGN KEY (direccion_id) REFERENCES direcciones(id)
  ON DELETE CASCADE
) ENGINE = InnoDB;
*/




-- FINCA - horarios_funcionamiento 1-n

ALTER TABLE horarios_funcionamiento
ADD CONSTRAINT fk_finca_horarios
FOREIGN KEY (finca_id)
REFERENCES fincas(id)
ON DELETE CASCADE;


-- RESERVA - fincas 1-n
-- RESERVA - clientes 1-n

ALTER TABLE reservas
ADD CONSTRAINT fk_reserva_fincas
FOREIGN KEY (finca_id) REFERENCES fincas(id)
ON DELETE CASCADE,
ADD CONSTRAINT fk_reserva_clientes
FOREIGN KEY (cliente_id) REFERENCES clientes(id)
ON DELETE CASCADE;


-- CLIENTE - usuarios 1-1

ALTER TABLE clientes
ADD CONSTRAINT fk_clientes_usuarios
FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
ON DELETE CASCADE;

-- USUARIO_ROL - usuario
-- USUARIO_ROL - rol
-- (n-n)
ALTER TABLE usuario_rol
ADD CONSTRAINT fk_usuario_rol_rol
FOREIGN KEY (rol_id) REFERENCES roles(id)
ON DELETE CASCADE,
ADD CONSTRAINT fk_usuario_rol_usuario
FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
ON DELETE CASCADE;

-- ROL_PERMISOS - permisos
-- ROL_PERMISOS - roles
-- (n-n)
ALTER TABLE rol_permisos
ADD CONSTRAINT fk_rol_permisos_rol
FOREIGN KEY (rol_id) REFERENCES roles(id)
ON DELETE CASCADE,
ADD CONSTRAINT fk_rol_permisos_permiso
FOREIGN KEY (permiso_id) REFERENCES permisos(id)
ON DELETE CASCADE;

-- AUTENTICACION EXTERNA - usuario
ALTER TABLE autenticacion_externa
ADD CONSTRAINT fk_autenticacion_externa_usuario
FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
ON DELETE CASCADE;


-- FECHAS_ESPECIALES - finca
ALTER TABLE fechas_especiales
ADD CONSTRAINT fk_fecha_especial_finca
FOREIGN KEY (finca_id) REFERENCES fincas(id)
ON DELETE CASCADE;


-- IMAGENES_FINCAS - fincas
ALTER TABLE imagenes_fincas
ADD CONSTRAINT fk_imagenes_fincas_finca
FOREIGN KEY (finca_id) REFERENCES fincas(id)
ON DELETE CASCADE;


-- PAGOS - modo de pago
-- PAGOS - reserva
ALTER TABLE pagos
ADD CONSTRAINT fk_pagos_modo_de_pago
FOREIGN KEY (modopago_id) REFERENCES modo_de_pago(id)
ON DELETE CASCADE,
ADD CONSTRAINT fk_pagos_reserva
FOREIGN KEY (reserva_id) REFERENCES reservas(id)
ON DELETE CASCADE;

-- COMPROBANTE DE PAGO - pagos
-- COMPROBANTE DE PAGO - modo_pago
ALTER TABLE comprobante_pago
ADD CONSTRAINT fk_comprobante_pago_pagos
FOREIGN KEY (pago_id) REFERENCES pagos(id)
ON DELETE CASCADE,
ADD CONSTRAINT fk_comprobante_modo
FOREIGN KEY (modo_id) REFERENCES modo_de_pago(id)
ON DELETE CASCADE;


-- PROPIETARIO - contacto
ALTER TABLE propietarios
ADD CONSTRAINT fk_propietarios_contacto
FOREIGN KEY (contacto_id) REFERENCES contactos(id)
ON DELETE CASCADE;

-- PROPIETARIO - usuario
ALTER TABLE propietarios
ADD CONSTRAINT fk_propietarios_usuario
FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
ON DELETE CASCADE;

-- DOCUMENTACION - propietario
ALTER TABLE documentacion
ADD CONSTRAINT fk_documentacion_propietarios
FOREIGN KEY (propietario_id) REFERENCES propietarios(id)
ON DELETE CASCADE;



-- CRUD DISTINTAS TABLAS



-- agrego permisos
INSERT INTO permisos (nombre) VALUES
('Crear reservas'),
('Modificar información de fincas'),
('Ver historial de clientes');


-- agrego roles
INSERT INTO roles (nombre) VALUES
('Propietario'),
('Cliente');


-- asignos permisos a roles

INSERT INTO rol_permisos (rol_id, permiso_id) VALUES
(1, 3), -- Propietario puede ver historial de clientes
(1, 2), -- Propietario puede modificar información de fincas
(2, 1); -- Cliente puede crear reservas





-- agrego usuarios (cuenta_activa es por default true al crear)

INSERT INTO usuarios (nombre_usuario, email, contrasenia) VALUES
('robertofinca', 'roberto@gmail.com', '123'),
('eduardofinca', 'eduardo@gmail.com', '123'),
('luciana2025', 'luciana@gmail.com', '123'),
('martinasosa', 'martinasosa@gmail.com', '123'),
('franciscolopez', 'franciscolopez@gmail.com', '123'),
('marianaperezfinca', 'mariana@gmail.com', '123');

/*
UPDATE finca_prueba.usuarios
SET nombre_usuario = 'roberto'
WHERE id = 1;
*/


-- asignos roles a usuarios
INSERT INTO usuario_rol (rol_id, usuario_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(2, 5),
(1, 6);
-- robertofinca también es cliente por ejemplo
INSERT INTO usuario_rol (rol_id, usuario_id) VALUES
(2, 1); 


-- agrego contacto
INSERT INTO contactos 
(email, telefono, email_alternativo) 
VALUES
('roberto@gmail.com', '+54 9 11 1234-5678', 'info2@casamontana.com'),
('eduardo@gmail.com', '+54 9 261 432-1987', 'reservas2@cabanalago.com'),
('mariana@gmail.com', '+54 9 351 765-4321', 'contacto2@ranchorural.com');

-- agrego propietarios
INSERT INTO propietarios (nombre, apellido, fecha_nac, contacto_id, usuario_id) VALUES
('Roberto', 'Ramírez', '1980-05-12', 1, 1),
('Eduardo', 'González', '1992-09-23', 2, 2),
('Mariana', 'Fernández', '1975-01-30', 3, 6);


-- agrego clientes
INSERT INTO clientes (nombre, apellido, dni, correo, usuario_id) VALUES
('Luciana', 'Pérez', '30123456', 'luciana@gmail.com', 3),
('Martina', 'Sosa', '28987654', 'martinasosa@gmail.com', 4),
('Francisco', 'Lopez', '32123456', 'franciscolopez@gmail.com', 5);

/*
DELETE FROM finca_prueba.clientes
WHERE id = 1;


UPDATE finca_prueba.clientes
SET apellido = 'perez'
WHERE id = 2;
*/

-- agrego autenticacion externa
INSERT INTO autenticacion_externa 
(nombre_proveedor, proveedor_usuario_id, usuario_id) VALUES
('Google', 'google-oauth2|1234567890', 1),
('Facebook', 'fb-99887766', 2),
('GitHub', 'github|luci_321', 3);



-- agrego detalle
INSERT INTO detalles
(descripcion, cant_habitacion, cant_banio, metros_cuad, capacidad_max, wifi, piscina, parrilla) 
VALUES
('Casa rural con hermosa vista a las montañas', 3, 2, 120, 6, TRUE, TRUE, TRUE),
('Cabaña acogedora cerca del lago', 2, 1, 80, 4, TRUE, FALSE, TRUE),
('Amplio rancho para grupos grandes', 5, 3, 200, 12, FALSE, TRUE, TRUE);


-- agrego direccion
INSERT INTO direcciones
(calle, altura, ciudad, provincia, aclaracion) 
VALUES
('Los Álamos', 1234, 'San Rafael', 'Mendoza', 'A 5 km del centro, camino a Valle Grande'),
('El Lago', 456, 'Villa La Angostura', 'Neuquén', 'Frente al lago Nahuel Huapi'),
('Ruta 40', NULL, 'Tilcara', 'Jujuy', 'Sin numeración, acceso por calle de tierra, entrada con cartel');


-- agrego finca
INSERT INTO fincas
(nombre, propietario_id, detalle_id, direccion_id, tarifa_hora) 
VALUES
('Casa Montaña', 1, 1, 1, 30000.00),
('Cabaña Lago Azul', 2, 2, 2, 40000.00),
('Rancho Tilcara', 3, 3, 3, 45000.00);


-- agrego fechas especiales
INSERT INTO fechas_especiales 
(fecha, dia_semana, hora_inicio, hora_fin, descuento, recargo, motivo, finca_id) 
VALUES
('2025-12-24', 'Martes', '18:00:00', '23:59:00', NULL, 1500.00, 'Nochebuena', 1),
('2025-01-01', 'Miércoles', '00:00:00', '12:00:00', 2000.00, NULL, 'Año Nuevo - mañana', 2),
('2025-07-09', 'Miércoles', '10:00:00', '20:00:00', 1000.00, 1000.00, 'Día de la Independencia', 3);


-- agrego imagenes a fincas
INSERT INTO imagenes_fincas (url, es_portada, finca_id) VALUES
('https://mi-sitio.com/imagenes/finca1_1.jpg', TRUE, 1),
('https://mi-sitio.com/imagenes/finca2_1.jpg', TRUE, 2),
('https://mi-sitio.com/imagenes/finca3_2.jpg', FALSE, 3);



-- agrego horarios
INSERT INTO horarios_funcionamiento 
(finca_id, hora_inicio, hora_fin, dia_semana, descuento, recargo) 
VALUES
(1, '08:00:00', '20:00:00', 'Lunes', 0.00, 0.00),
(1, '07:00:00', '21:00:00', 'Viernes', 10.00, 0.00),
(2, '06:00:00', '23:00:00', 'Sábado', 0.00, 5.00);


-- agrego reserva
INSERT INTO reservas 
(finca_id, cliente_id, desde, hasta, total, estado) 
VALUES
(1, 1, '2025-06-15 10:00:00', '2025-06-15 14:00:00', 6000.00, TRUE),
(2, 2, '2025-06-16 15:00:00', '2025-06-16 18:00:00', 3600.00, FALSE),
(3, 3, '2025-06-17 09:00:00', '2025-06-17 13:00:00', 7200.00, TRUE),
(3, 1, '2025-07-15 10:00:00', '2025-07-15 14:00:00', 7200.00, TRUE),
(2, 1, '2025-07-16 15:00:00', '2025-07-16 18:00:00', 3600.00, FALSE),
(3, 1, '2025-08-17 09:00:00', '2025-08-17 13:00:00', 7200.00, TRUE),
(3, 2, '2025-05-15 10:00:00', '2025-05-15 14:00:00', 7200.00, TRUE),
(2, 2, '2025-04-16 15:00:00', '2025-06-16 18:00:00', 3600.00, FALSE),
(3, 3, '2025-03-17 09:00:00', '2025-06-17 13:00:00', 7200.00, TRUE),
(2, 3, '2025-02-15 10:00:00', '2025-06-15 14:00:00', 6000.00, TRUE),
(1, 3, '2025-01-15 10:00:00', '2025-06-15 14:00:00', 6000.00, TRUE);

-- agrego modos de pago
INSERT INTO modo_de_pago (tipo, detalles) VALUES
('Efectivo', 'Pagado en recepción'),
('Tarjeta', 'Visa'),
('Tarjeta', 'Mastercard'),
('Transferencia', 'MercadoPago'),
('Transferencia', 'Bancaria');

-- agrego pagos
INSERT INTO pagos (
  reserva_id, monto_total, modopago_id, fecha_hora, descuento_aplicado, recargo_aplicado, estado_pago
) VALUES
(1, 6000.00, 1, '2025-06-14 10:30:00', 1000.00, 0.00, TRUE),
(2, 3600.00, 2, '2025-06-15 14:45:00', 0.00, 200.00, FALSE),
(3, 7200.00, 4, '2025-06-16 11:15:00', 500.00, 0.00, TRUE),
(4, 7200.00, 3, '2025-07-14 11:15:00', 500.00, 0.00, TRUE),
(5, 3600.00, 3, '2025-07-15 11:15:00', 500.00, 0.00, FALSE),
(6, 7200.00, 4, '2025-08-16 11:15:00', 500.00, 0.00, TRUE),
(7, 7200.00, 4, '2025-05-14 11:15:00', 500.00, 0.00, TRUE),
(8, 3600.00, 3, '2025-04-15 11:15:00', 500.00, 0.00, FALSE),
(9, 7200.00, 5, '2025-03-16 11:15:00', 500.00, 0.00, TRUE),
(10, 6000.00, 5, '2025-02-14 11:15:00', 500.00, 0.00, TRUE),
(11, 6000.00, 3, '2025-01-14 11:15:00', 500.00, 0.00, TRUE);


-- agrego comprobantes de pago

INSERT INTO comprobante_pago (pago_id, monto, modo_id, descripcion) VALUES
(1, 6000.00, 1, 'Pago en efectivo en recepción'),
(3, 7200.00, 4, 'Transferencia mercado pago confirmada'),
(4, 7200.00, 3, 'Tarjeta Mastercard - cuotas sin interés'),
(6, 7200.00, 4, 'Transferencia mercado pago confirmada'),
(7, 7200.00, 4, 'Transferencia mercado pago confirmada'),
(9, 7200.00, 5, 'Transferencia bancaria confirmada'),
(10, 6000.00, 5, 'Transferencia bancaria confirmada'),
(11, 6000.00, 3, 'Tarjeta Mastercard - cuotas sin interés');




-- EJEMPLOS CONSULTA

-- FINCAS ABIERTA LOS VIERNES
SELECT f.nombre, hf.dia_semana, hf.hora_inicio, hf.hora_fin
FROM fincas f
JOIN horarios_funcionamiento hf ON f.id = hf.finca_id
WHERE hf.dia_semana = 'Viernes';


-- FECHAS ESPECIALES CON RECARGO
SELECT f.nombre AS finca, fe.fecha, fe.motivo, fe.recargo
FROM fechas_especiales fe
JOIN fincas f ON fe.finca_id = f.id
WHERE fe.recargo IS NOT NULL AND fe.recargo > 0;


-- USUARIOS CON ROL CLIENTE
SELECT u.id, u.nombre_usuario, u.email
FROM usuarios u
JOIN usuario_rol ur ON u.id = ur.usuario_id
JOIN roles r ON ur.rol_id = r.id
WHERE r.nombre = 'Cliente';






-- CONSULTAS A LA BASE DE DATOS

-- CONSULTA 1: historial de reservas realizadas por un cliente en específico
SELECT reservas.finca_id, fincas.nombre, reservas.desde, reservas.hasta, reservas.total, reservas.estado
FROM reservas
JOIN fincas ON reservas.finca_id = fincas.id
WHERE reservas.cliente_id = 1;


-- CONSULTA 2: pagos y su estado
SELECT pagos.id, reservas.id AS reserva_id, pagos.monto_total, pagos.fecha_hora, pagos.estado_pago
FROM pagos
JOIN reservas ON pagos.reserva_id = reservas.id;


-- CONSULTA 3: fechas especiales con descuentos
SELECT f.nombre, fe.fecha, fe.motivo, fe.descuento
FROM fechas_especiales fe
JOIN fincas f ON fe.finca_id = f.id
WHERE fe.descuento IS NOT NULL AND fe.descuento > 0;

-- CONSULTA 4: n° de reservas por cada finca
SELECT fincas.nombre, COUNT(finca_prueba.reservas.id) AS total_reservas
FROM fincas
LEFT JOIN reservas ON fincas.id = reservas.finca_id
GROUP BY fincas.nombre;

-- CONSULTA 5: responsables con sus telefonos

SELECT p.nombre, p.apellido, c.telefono, c.email
FROM propietarios p, contactos c
WHERE p.id = c.id;