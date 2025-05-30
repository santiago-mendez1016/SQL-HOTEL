USE HOTEL;


INSERT INTO cliente (nombre, documento, correo) VALUES
('Ana Torres', '111222333', 'ana@mail.com'),
('Juan Pérez', '12345678', 'juanp@mail.com'),
('María Gómez', '87654321', 'mariag@mail.com'),
('Santiago Méndez', '999888777', 'santiago@mail.com');


INSERT INTO habitacion (numero, capacidad, disponible, precio_base) VALUES
(201, 1, TRUE, 50),
(202, 2, TRUE, 80),
(203, 3, TRUE, 120),
(204, 4, TRUE, 150);
