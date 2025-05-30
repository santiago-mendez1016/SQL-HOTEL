USE HOTEL;

SELECT * FROM cliente;

-- 2. Ver habitaciones disponibles
SELECT * FROM habitacion WHERE disponible = TRUE;

-- 3. (Opcional) Ver todas las habitaciones, con estado
SELECT 
    id_habitacion,
    numero,
    capacidad,
    precio_base,
    CASE 
        WHEN disponible = TRUE THEN 'Disponible'
        ELSE 'Ocupada'
    END AS estado
FROM habitacion;


SELECT
    r.id_reserva,
    c.nombre AS cliente,
    c.documento,
    c.correo,
    h.numero AS num_habitacion,
    h.capacidad,
    h.precio_base,
    r.fecha_reserva,
    r.fecha_ingreso,
    r.fecha_salida,
    DATEDIFF(r.fecha_salida, r.fecha_ingreso) AS dias_estadia,
    r.costo_base,
    r.costo_final,
    CASE 
        WHEN DATEDIFF(r.fecha_ingreso, r.fecha_reserva) >= 15 THEN 'Sí (10% descuento)'
        ELSE 'No'
    END AS aplica_descuento
FROM reserva r
JOIN cliente c ON r.id_cliente = c.id_cliente
JOIN habitacion h ON r.id_habitacion = h.id_habitacion
ORDER BY r.fecha_reserva DESC;
