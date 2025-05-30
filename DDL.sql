DROP DATABASE IF EXISTS HOTEL;
CREATE DATABASE HOTEL;
USE HOTEL;

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    documento VARCHAR(20) UNIQUE NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE habitacion (
    id_habitacion INT AUTO_INCREMENT PRIMARY KEY,
    numero INT UNIQUE NOT NULL,
    capacidad INT NOT NULL CHECK (capacidad IN (1, 2, 3, 4)),
    disponible BOOLEAN DEFAULT TRUE,
    precio_base DECIMAL(10,2) NOT NULL DEFAULT 100.00
);

CREATE TABLE reserva (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_habitacion INT NOT NULL,
    fecha_reserva DATE NOT NULL,
    fecha_ingreso DATE NOT NULL,
    fecha_salida DATE NOT NULL,
    costo_base DECIMAL(10,2) NOT NULL,
    costo_final DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_habitacion) REFERENCES habitacion(id_habitacion)
);
