-- triggrest
USE HOTEL;

DELIMITER //

CREATE PROCEDURE sp_crear_reserva(
    IN p_id_cliente INT,
    IN p_id_habitacion INT,
    IN p_fecha_reserva DATE,
    IN p_fecha_ingreso DATE,
    IN p_fecha_salida DATE
)
BEGIN
    DECLARE v_costo_base DECIMAL(10,2);
    DECLARE v_costo_final DECIMAL(10,2);
    DECLARE v_dias_anticipacion INT;
    DECLARE v_dias_estadia INT;

    SET v_dias_anticipacion = DATEDIFF(p_fecha_ingreso, p_fecha_reserva);
    SET v_dias_estadia = DATEDIFF(p_fecha_salida, p_fecha_ingreso);

    SELECT precio_base INTO v_costo_base FROM habitacion WHERE id_habitacion = p_id_habitacion;

    SET v_costo_base = v_costo_base * v_dias_estadia;

    IF v_dias_anticipacion >= 15 THEN
        SET v_costo_final = v_costo_base * 0.9;
    ELSE
        SET v_costo_final = v_costo_base;
    END IF;

    INSERT INTO reserva (id_cliente, id_habitacion, fecha_reserva, fecha_ingreso, fecha_salida, costo_base, costo_final)
    VALUES (p_id_cliente, p_id_habitacion, p_fecha_reserva, p_fecha_ingreso, p_fecha_salida, v_costo_base, v_costo_final);

    UPDATE habitacion SET disponible = FALSE WHERE id_habitacion = p_id_habitacion;
END//

DELIMITER ;



--
-- procedimientooss:
DELIMITER //

CREATE TRIGGER trg_after_delete_reserva
AFTER DELETE ON reserva
FOR EACH ROW
BEGIN
    UPDATE habitacion SET disponible = TRUE WHERE id_habitacion = OLD.id_habitacion;
END//

DELIMITER ;



CALL sp_crear_reserva(
    4,                                     -- id_cliente
    3,                                     -- id_habitacion
    CURDATE(),                             -- fecha_reserva
    DATE_ADD(CURDATE(), INTERVAL 13 DAY),  -- salida (3 días de estadía)
    DATE_ADD(CURDATE(), INTERVAL 16 DAY)  -- ingreso
    
);

CALL sp_crear_reserva(
    1,                                     -- id_cliente
    2,                                     -- id_habitacion
    CURDATE(),                             -- fecha_reserva
	DATE_ADD(CURDATE(), INTERVAL 10 DAY),  -- salida (3 días de estadía)
    DATE_ADD(CURDATE(), INTERVAL 18 DAY)  -- ingreso
   
);

-- selects 

SELECT * FROM cliente;

SELECT * FROM habitacion WHERE disponible = TRUE;

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

-- Informacion completa segun los datos recolectados
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
 



