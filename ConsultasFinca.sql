-- CONSULTAS A LA BASE DE DATOS

-- CONSULTA 1: historial de reservas realizadas por un cliente en específico
SELECT finca_prueba.reservas.finca_id, finca_prueba.fincas.nombre, finca_prueba.reservas.desde, finca_prueba.reservas.hasta, finca_prueba.reservas.total, finca_prueba.reservas.estado
FROM finca_prueba.reservas
JOIN finca_prueba.fincas ON finca_prueba.reservas.finca_id = finca_prueba.fincas.id
WHERE finca_prueba.reservas.cliente_id = 1;

-- agregar más reservas para el usuario cosa de tener más historial

-- CONSULTA 2: pagos realizados y su estado
SELECT finca_prueba.pagos.id, finca_prueba.reservas.id AS reserva_id, finca_prueba.pagos.monto_total, finca_prueba.pagos.fecha_hora, finca_prueba.pagos.estado_pago
FROM finca_prueba.pagos
JOIN finca_prueba.reservas ON finca_prueba.pagos.reserva_id = finca_prueba.reservas.id;


-- CONSULTA 3: fechas especiales con descuentos
SELECT finca_prueba.fincas.nombre, finca_prueba.fechas_especiales.fecha, finca_prueba.fechas_especiales.motivo, finca_prueba.fechas_especiales.descuento
FROM finca_prueba.fechas_especiales
JOIN finca_prueba.fincas ON finca_prueba.fechas_especiales.finca_id = finca_prueba.fincas.id
WHERE finca_prueba.fechas_especiales.descuento IS NOT NULL AND finca_prueba.fechas_especiales.descuento > 0;

-- CONSULTA 4: n° de reservas por cada finca
SELECT finca_prueba.fincas.nombre, COUNT(finca_prueba.reservas.id) AS total_reservas
FROM finca_prueba.fincas
LEFT JOIN finca_prueba.reservas ON finca_prueba.fincas.id = finca_prueba.reservas.finca_id
GROUP BY finca_prueba.fincas.nombre;

-- CONSULTA 5: responsables con sus telefonos
SELECT finca_prueba.contactos.nombre_responsable, finca_prueba.contactos.telefono
FROM finca_prueba.contactos;

-- ACTUALIZACIONES PARA QUE HAYA VARIEDAD EN LAS CONSULTAS

INSERT INTO finca_prueba.reservas 
(finca_id, cliente_id, desde, hasta, total, estado) 
VALUES
(3, 1, '2025-07-15 10:00:00', '2025-07-15 14:00:00', 7200.00, TRUE),
(2, 1, '2025-07-16 15:00:00', '2025-07-16 18:00:00', 3600.00, FALSE),
(3, 1, '2025-08-17 09:00:00', '2025-08-17 13:00:00', 7200.00, TRUE),
(3, 2, '2025-05-15 10:00:00', '2025-05-15 14:00:00', 7200.00, TRUE),
(1, 2, '2025-06-15 10:00:00', '2025-06-15 14:00:00', 6000.00, TRUE),
(2, 2, '2025-04-16 15:00:00', '2025-06-16 18:00:00', 3600.00, FALSE),
(3, 3, '2025-03-17 09:00:00', '2025-06-17 13:00:00', 7200.00, TRUE),
(2, 3, '2025-02-15 10:00:00', '2025-06-15 14:00:00', 6000.00, TRUE),
(1, 3, '2025-01-15 10:00:00', '2025-06-15 14:00:00', 6000.00, TRUE)
;

INSERT INTO finca_prueba.pagos (reserva_id, monto_total, modopago_id, fecha_hora, descuento_aplicado, recargo_aplicado, estado_pago) VALUES
(1, 6000.00, 1, '2025-07-14 09:00:00', 200.00, 0.00, TRUE),  
(2, 3600.00, 2, '2025-07-15 14:30:00', 0.00, 100.00, FALSE), 
(3, 7200.00, 3, '2025-08-16 12:00:00', 300.00, 0.00, TRUE),  
(4, 6000.00, 1, '2025-05-14 10:00:00', 500.00, 0.00, TRUE),  
(5, 6000.00, 2, '2025-06-14 11:30:00', 0.00, 200.00, TRUE),  
(6, 3600.00, 3, '2025-06-15 15:00:00', 100.00, 0.00, FALSE),  
(7, 7200.00, 1, '2025-06-16 10:30:00', 700.00, 0.00, TRUE),  
(8, 6000.00, 2, '2025-06-17 14:00:00', 0.00, 150.00, TRUE),  
(9, 6000.00, 3, '2025-06-18 09:45:00', 300.00, 0.00, TRUE);  