USE HOTEL;

DELIMITER //

CREATE TRIGGER trg_after_delete_reserva
AFTER DELETE ON reserva
FOR EACH ROW
BEGIN
    UPDATE habitacion SET disponible = TRUE WHERE id_habitacion = OLD.id_habitacion;
END//

DELIMITER ;
