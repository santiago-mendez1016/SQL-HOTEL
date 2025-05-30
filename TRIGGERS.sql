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
