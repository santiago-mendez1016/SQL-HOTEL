USE HOTEL;

-- Buscar ID del cliente y habitación
-- SELECT id_cliente FROM cliente WHERE documento = '999888777'; -- Devolverá 4
-- SELECT id_habitacion FROM habitacion WHERE capacidad = 3 AND disponible = TRUE LIMIT 1; -- Devolverá 3

-- Crear reserva para Santiago Méndez con 10 días de anticipación (sin descuento)
CALL sp_crear_reserva(
    4,                              -- id_cliente
    3,                              -- id_habitacion
    CURDATE(),                      -- fecha_reserva
    DATE_ADD(CURDATE(), INTERVAL 10 DAY),  -- ingreso
    DATE_ADD(CURDATE(), INTERVAL 13 DAY)   -- salida (3 días de estadía)
);

