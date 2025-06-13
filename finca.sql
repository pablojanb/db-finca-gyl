-- crear base de datos
CREATE DATABASE IF NOT EXISTS finca_prueba
CHARACTER SET utf8mb4
COLLATE utf8mb4_spanish_ci;


-- creo tabla finca
CREATE TABLE finca_prueba.fincas (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  propietario_id INT NOT NULL,
  detalle_id INT NOT NULL,
  contacto_id INT NOT NULL,
  direccion_id INT NOT NULL,
  tarifa_hora DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;


-- creo tabla horarios_funcionamiento
CREATE TABLE finca_prueba.horarios_funcionamiento (
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
CREATE TABLE finca_prueba.propietarios (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  apellido VARCHAR(45) NOT NULL,
  fecha_nac  DATE NOT NULL,
  contacto_id INT NOT NULL,
  usuario_id INT NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;


-- creo tabla contactos
CREATE TABLE finca_prueba.contactos (
  id INT NOT NULL AUTO_INCREMENT,
  email VARCHAR(45) NOT NULL,
  telefono VARCHAR(45) NOT NULL,
  email_alternativo VARCHAR(45) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;


-- creo tabla detalle
CREATE TABLE finca_prueba.detalles (
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
CREATE TABLE finca_prueba.direcciones (
  id INT NOT NULL AUTO_INCREMENT,
  calle VARCHAR(45) NOT NULL,
  altura INT NULL,
  ciudad VARCHAR(45) NOT NULL,
  provincia VARCHAR(45) NOT NULL,
  aclaracion VARCHAR(200) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;


-- creo tabla reserva
CREATE TABLE finca_prueba.reservas (
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
CREATE TABLE finca_prueba.fechas_especiales (
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
CREATE TABLE finca_prueba.clientes (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45) NOT NULL,
  apellido VARCHAR(45) NOT NULL,
  dni VARCHAR(45) NOT NULL,
  correo VARCHAR(45) NOT NULL,
  usuario_id INT NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;


-- Tabla Usuarios
CREATE TABLE finca_prueba.usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(40) NOT NULL,
    email VARCHAR(40) NOT NULL UNIQUE,
    contrasenia VARCHAR(255) NOT NULL,
    cuenta_activa BOOLEAN DEFAULT TRUE
);

-- Tabla Rol
CREATE TABLE finca_prueba.roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL UNIQUE
);


-- Tabla Usuario_Rol (tabla intermedia 1-1)
CREATE TABLE finca_prueba.usuario_rol (
  rol_id INT NOT NULL,
  usuario_id INT NOT NULL
);



-- Tabla Permisos
CREATE TABLE finca_prueba.permisos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL
);


-- Tabla Rol_Permisos (tabla intermedia 1-1)
CREATE TABLE finca_prueba.rol_permisos (
  rol_id INT NOT NULL,
  permiso_id INT NOT NULL
);


-- TABLA AUTENTICACION EXTERNA
CREATE TABLE finca_prueba.autenticacion_externa (
  id INT NOT NULL AUTO_INCREMENT,
  nombre_proveedor VARCHAR(45) NOT NULL,
  proveedor_usuario_id VARCHAR(45) NOT NULL,
  usuario_id INT NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB;

-- TABLA IMAGEN_FINCA

CREATE TABLE finca_prueba.imagenes_fincas(
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
url VARCHAR(2048) NOT NULL,
es_portada BOOLEAN NOT NULL,
finca_id INT NOT NULL
);

-- PAGOS

CREATE table finca_prueba.pagos(
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

CREATE table finca_prueba.modo_de_pago(
id INT NOT NULL AUTO_INCREMENT,
tipo VARCHAR(15) NOT NULL,
detalles VARCHAR(60) NOT NULL,
PRIMARY KEY(id) 
);

CREATE TABLE finca_prueba.comprobante_pago(
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


ALTER TABLE finca_prueba.fincas
ADD CONSTRAINT fk_finca_detalle
FOREIGN KEY (detalle_id) REFERENCES finca_prueba.detalles(id)
ON DELETE CASCADE,
ADD CONSTRAINT fk_finca_propietario
FOREIGN KEY (propietario_id) REFERENCES finca_prueba.propietarios(id)
ON DELETE CASCADE,
ADD CONSTRAINT fk_finca_direccion
FOREIGN KEY (direccion_id) REFERENCES finca_prueba.direcciones(id)
ON DELETE CASCADE;


-- FINCA - horarios_funcionamiento 1-n

ALTER TABLE finca_prueba.horarios_funcionamiento
ADD CONSTRAINT fk_finca_horarios
FOREIGN KEY (finca_id)
REFERENCES finca_prueba.fincas(id)
ON DELETE CASCADE;


-- RESERVA - fincas 1-n
-- RESERVA - clientes 1-n

ALTER TABLE finca_prueba.reservas
ADD CONSTRAINT fk_reserva_fincas
FOREIGN KEY (finca_id) REFERENCES finca_prueba.fincas(id)
ON DELETE CASCADE,
ADD CONSTRAINT fk_reserva_clientes
FOREIGN KEY (cliente_id) REFERENCES finca_prueba.clientes(id)
ON DELETE CASCADE;


-- CLIENTE - usuarios 1-1

ALTER TABLE finca_prueba.clientes
ADD CONSTRAINT fk_clientes_usuarios
FOREIGN KEY (usuario_id) REFERENCES finca_prueba.usuarios(id)
ON DELETE CASCADE;

-- USUARIO_ROL - usuario
-- USUARIO_ROL - rol
-- (n-n)
ALTER TABLE finca_prueba.usuario_rol
ADD CONSTRAINT fk_usuario_rol_rol
FOREIGN KEY (rol_id) REFERENCES finca_prueba.roles(id)
ON DELETE CASCADE,
ADD CONSTRAINT fk_usuario_rol_usuario
FOREIGN KEY (usuario_id) REFERENCES finca_prueba.usuarios(id)
ON DELETE CASCADE;

-- ROL_PERMISOS - permisos
-- ROL_PERMISOS - roles
-- (n-n)
ALTER TABLE finca_prueba.rol_permisos
ADD CONSTRAINT fk_rol_permisos_rol
FOREIGN KEY (rol_id) REFERENCES finca_prueba.roles(id)
ON DELETE CASCADE,
ADD CONSTRAINT fk_rol_permisos_permiso
FOREIGN KEY (permiso_id) REFERENCES finca_prueba.permisos(id)
ON DELETE CASCADE;

-- AUTENTICACION EXTERNA - usuario
ALTER TABLE finca_prueba.autenticacion_externa
ADD CONSTRAINT fk_autenticacion_externa_usuario
FOREIGN KEY (usuario_id) REFERENCES finca_prueba.usuarios(id)
ON DELETE CASCADE;


-- FECHAS_ESPECIALES - finca
ALTER TABLE finca_prueba.fechas_especiales
ADD CONSTRAINT fk_fecha_especial_finca
FOREIGN KEY (finca_id) REFERENCES finca_prueba.fincas(id)
ON DELETE CASCADE;


-- IMAGENES_FINCAS - fincas
ALTER TABLE finca_prueba.imagenes_fincas
ADD CONSTRAINT fk_imagenes_fincas_finca
FOREIGN KEY (finca_id) REFERENCES finca_prueba.fincas(id)
ON DELETE CASCADE;


-- PAGOS - modo de pago
-- PAGOS - reserva
ALTER TABLE finca_prueba.pagos
ADD CONSTRAINT fk_pagos_modo_de_pago
FOREIGN KEY (modopago_id) REFERENCES finca_prueba.modo_de_pago(id)
ON DELETE CASCADE,
ADD CONSTRAINT fk_pagos_reserva
FOREIGN KEY (reserva_id) REFERENCES finca_prueba.reservas(id)
ON DELETE CASCADE;

-- COMPROBANTE DE PAGO - pagos
-- COMPROBANTE DE PAGO - modo_pago
ALTER TABLE finca_prueba.comprobante_pago
ADD CONSTRAINT fk_comprobante_pago_pagos
FOREIGN KEY (pago_id) REFERENCES finca_prueba.pagos(id)
ON DELETE CASCADE,
ADD CONSTRAINT fk_comprobante_modo
FOREIGN KEY (modo_id) REFERENCES finca_prueba.modo_de_pago(id)
ON DELETE CASCADE;


-- PROPIETARIO - contacto
ALTER TABLE finca_prueba.propietarios
ADD CONSTRAINT fk_propietarios_contacto
FOREIGN KEY (contacto_id) REFERENCES finca_prueba.contactos(id)
ON DELETE CASCADE;





-- CRUD DISTINTAS TABLAS



-- agrego permisos
INSERT INTO finca_prueba.permisos (nombre) VALUES
('Crear reservas'),
('Modificar información de fincas'),
('Ver historial de clientes');





-- agrego roles
INSERT INTO finca_prueba.roles (nombre) VALUES
('Administrador'),
('Recepcionista'),
('Cliente');


-- asignos permisos a roles

INSERT INTO finca_prueba.rol_permisos (rol_id, permiso_id) VALUES
(1, 1), -- Administrador puede crear reservas
(1, 2), -- Administrador puede modificar fincas
(1, 3), -- Administrador puede ver historial
(2, 1), -- Recepcionista puede crear reservas
(2, 3), -- Recepcionista puede ver historial
(3, 1); -- Cliente puede crear reservas





-- agrego usuarios (cuenta_activa es por default true al crear)

INSERT INTO finca_prueba.usuarios (nombre_usuario, email, contrasenia) VALUES
('admin01', 'admin@finca.com', 'admin123'),
('recepcion01', 'recep@finca.com', 'recep123'),
('cliente01', 'cliente@finca.com', 'cliente123');

/*
UPDATE finca_prueba.usuarios
SET nombre_usuario = 'roberto'
WHERE id = 1;
*/


-- asignos roles a usuarios
INSERT INTO finca_prueba.usuario_rol (rol_id, usuario_id) VALUES
(1, 1),
(2, 2),
(3, 3);
-- admin01 también es cliente por ejemplo
INSERT INTO finca_prueba.usuario_rol (rol_id, usuario_id) VALUES
(3, 1); 


-- agrego contacto
INSERT INTO finca_prueba.contactos 
(email, telefono, email_alternativo) 
VALUES
('info@casamontana.com', '+54 9 11 1234-5678', 'info2@casamontana.com'),
('reservas@cabanalago.com', '+54 9 261 432-1987', 'reservas2@cabanalago.com'),
('contacto@ranchorural.com', '+54 9 351 765-4321', 'contacto2@ranchorural.com');

-- agrego propietarios
INSERT INTO finca_prueba.propietarios (nombre, apellido, fecha_nac, contacto_id, usuario_id) VALUES
('Carlos', 'Ramírez', '1980-05-12', 1, 1),
('Lucía', 'González', '1992-09-23', 2, 2),
('Miguel', 'Fernández', '1975-01-30', 3, 3);


-- agrego clientes
INSERT INTO finca_prueba.clientes (nombre, apellido, dni, correo, usuario_id) VALUES
('Juan', 'Pérez', '30123456', 'juan.perez@gmail.com', 3),
('Laura', 'Gómez', '28987654', 'laura.gomez@gmail.com', 2),
('Carlos', 'Lopez', '32123456', 'carlos.lopez@gmail.com', 1);

/*
DELETE FROM finca_prueba.clientes
WHERE id = 1;


UPDATE finca_prueba.clientes
SET apellido = 'perez'
WHERE id = 2;
*/

-- agrego autenticacion externa
INSERT INTO finca_prueba.autenticacion_externa 
(nombre_proveedor, proveedor_usuario_id, usuario_id) VALUES
('Google', 'google-oauth2|1234567890', 1),
('Facebook', 'fb-99887766', 2),
('GitHub', 'github|carlitos_321', 3);



-- agrego detalle
INSERT INTO finca_prueba.detalles
(descripcion, cant_habitacion, cant_banio, metros_cuad, capacidad_max, wifi, piscina, parrilla) 
VALUES
('Casa rural con hermosa vista a las montañas', 3, 2, 120, 6, TRUE, TRUE, TRUE),
('Cabaña acogedora cerca del lago', 2, 1, 80, 4, TRUE, FALSE, TRUE),
('Amplio rancho para grupos grandes', 5, 3, 200, 12, FALSE, TRUE, TRUE);


-- agrego direccion
INSERT INTO finca_prueba.direcciones
(calle, altura, ciudad, provincia, aclaracion) 
VALUES
('Los Álamos', 1234, 'San Rafael', 'Mendoza', 'A 5 km del centro, camino a Valle Grande'),
('El Lago', 456, 'Villa La Angostura', 'Neuquén', 'Frente al lago Nahuel Huapi'),
('Ruta 40', NULL, 'Tilcara', 'Jujuy', 'Sin numeración, acceso por calle de tierra, entrada con cartel');


-- agrego finca
INSERT INTO finca_prueba.fincas
(nombre, propietario_id, detalle_id, contacto_id, direccion_id, tarifa_hora) 
VALUES
('Casa Montaña', 1, 1, 1, 1, 1500.00),
('Cabaña Lago Azul', 2, 2, 2, 2, 1200.00),
('Rancho Tilcara', 3, 3, 3, 3, 1800.00);


-- agrego fechas especiales
INSERT INTO finca_prueba.fechas_especiales 
(fecha, dia_semana, hora_inicio, hora_fin, descuento, recargo, motivo, finca_id) 
VALUES
('2025-12-24', 'Martes', '18:00:00', '23:59:00', NULL, 1500.00, 'Nochebuena', 1),
('2025-01-01', 'Miércoles', '00:00:00', '12:00:00', 2000.00, NULL, 'Año Nuevo - mañana', 2),
('2025-07-09', 'Miércoles', '10:00:00', '20:00:00', 1000.00, 1000.00, 'Día de la Independencia', 3);


-- agrego imagenes a fincas
INSERT INTO finca_prueba.imagenes_fincas (url, es_portada, finca_id) VALUES
('https://mi-sitio.com/imagenes/finca1_1.jpg', TRUE, 1),
('https://mi-sitio.com/imagenes/finca2_1.jpg', TRUE, 2),
('https://mi-sitio.com/imagenes/finca3_2.jpg', FALSE, 3);



-- agrego horarios
INSERT INTO finca_prueba.horarios_funcionamiento 
(finca_id, hora_inicio, hora_fin, dia_semana, descuento, recargo) 
VALUES
(1, '08:00:00', '20:00:00', 'Lunes', 0.00, 0.00),
(1, '07:00:00', '21:00:00', 'Viernes', 10.00, 0.00),
(2, '06:00:00', '23:00:00', 'Sábado', 0.00, 5.00);


-- agrego reserva
INSERT INTO finca_prueba.reservas 
(finca_id, cliente_id, desde, hasta, total, estado) 
VALUES
(1, 1, '2025-06-15 10:00:00', '2025-06-15 14:00:00', 6000.00, TRUE),
(2, 2, '2025-06-16 15:00:00', '2025-06-16 18:00:00', 3600.00, FALSE),
(3, 3, '2025-06-17 09:00:00', '2025-06-17 13:00:00', 7200.00, TRUE);


-- agrego modos de pago
INSERT INTO finca_prueba.modo_de_pago (tipo, detalles) VALUES
('Efectivo', 'Pagado en recepción'),
('Tarjeta', 'Visa'),
('Tarjeta', 'Mastercard'),
('Transferencia', 'MercadoPago'),
('Transferencia', 'Bancaria');

-- agrego pagos
INSERT INTO finca_prueba.pagos (
  reserva_id, monto_total, modopago_id, fecha_hora, descuento_aplicado, recargo_aplicado, estado_pago
) VALUES
(1, 15000.00, 1, '2025-06-12 10:30:00', 1000.00, 0.00, TRUE),
(2, 22000.00, 2, '2025-06-13 14:45:00', 0.00, 200.00, TRUE),
(3, 18000.00, 3, '2025-06-14 11:15:00', 500.00, 0.00, FALSE);


-- agrego comprobantes de pago

INSERT INTO finca_prueba.comprobante_pago (pago_id, monto, modo_id, descripcion) VALUES
(1, 15000.00, 1, 'Pago en efectivo en recepción'),
(2, 22000.00, 2, 'Tarjeta Visa - cuotas sin interés'),
(3, 18000.00, 3, 'Transferencia bancaria confirmada');




-- EJEMPLOS CONSULTA

-- FINCAS ABIERTA LOS VIERNES
SELECT f.nombre, hf.dia_semana, hf.hora_inicio, hf.hora_fin
FROM finca_prueba.fincas f
JOIN finca_prueba.horarios_funcionamiento hf ON f.id = hf.finca_id
WHERE hf.dia_semana = 'Viernes';


-- FECHAS ESPECIALES CON RECARGO
SELECT f.nombre AS finca, fe.fecha, fe.motivo, fe.recargo
FROM finca_prueba.fechas_especiales fe
JOIN finca_prueba.fincas f ON fe.finca_id = f.id
WHERE fe.recargo IS NOT NULL AND fe.recargo > 0;


-- USUARIOS CON ROL ADMIN
SELECT u.id, u.nombre_usuario, u.email
FROM finca_prueba.usuarios u
JOIN finca_prueba.usuario_rol ur ON u.id = ur.usuario_id
JOIN finca_prueba.roles r ON ur.rol_id = r.id
WHERE r.nombre = 'Administrador';