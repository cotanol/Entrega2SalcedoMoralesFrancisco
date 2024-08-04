-- Eliminar la base de datos si ya existe
DROP DATABASE IF EXISTS LibreriaDB;

-- Crear la base de datos
CREATE DATABASE LibreriaDB;

-- Usar la base de datos creada
USE LibreriaDB;

-- Crear la tabla Categorias
CREATE TABLE Categorias (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada categoría
    nombre VARCHAR(255) NOT NULL       -- Nombre de la categoría
);

-- Crear la tabla Editoriales
CREATE TABLE Editoriales (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada editorial
    nombre VARCHAR(255) NOT NULL,      -- Nombre de la editorial
    pais VARCHAR(100)                  -- País de origen de la editorial
);

-- Crear la tabla Autores
CREATE TABLE Autores (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada autor
    nombre VARCHAR(255) NOT NULL,      -- Nombre del autor
    apellido VARCHAR(255) NOT NULL     -- Apellido del autor
);

-- Crear la tabla Libros
CREATE TABLE Libros (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada libro
    titulo VARCHAR(255) NOT NULL,      -- Título del libro
    id_categoria INT,                  -- Identificador de la categoría del libro
    id_editorial INT,                  -- Identificador de la editorial del libro
    fecha_publicacion DATE,            -- Fecha de publicación del libro
    precio DECIMAL(10, 2),             -- Precio del libro
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id), -- Relación con la tabla Categorias
    FOREIGN KEY (id_editorial) REFERENCES Editoriales(id) -- Relación con la tabla Editoriales
);

-- Crear la tabla Clientes
CREATE TABLE Clientes (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada cliente
    nombre VARCHAR(255) NOT NULL,      -- Nombre del cliente
    email VARCHAR(255) UNIQUE NOT NULL,-- Correo electrónico del cliente, debe ser único
    telefono VARCHAR(20)               -- Teléfono del cliente
);

-- Crear la tabla Ventas
CREATE TABLE Ventas (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada venta
    id_cliente INT,                    -- Identificador del cliente que realizó la compra
    fecha_venta DATE NOT NULL,         -- Fecha de la venta
    total DECIMAL(10, 2),              -- Total de la venta
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id) -- Relación con la tabla Clientes
);

-- Crear la tabla intermedia Libros_Autores
CREATE TABLE Libros_Autores (
    id_libro INT,                      -- Identificador del libro
    id_autor INT,                      -- Identificador del autor
    PRIMARY KEY (id_libro, id_autor),  -- Clave primaria compuesta por el id del libro y del autor
    FOREIGN KEY (id_libro) REFERENCES Libros(id), -- Relación con la tabla Libros
    FOREIGN KEY (id_autor) REFERENCES Autores(id) -- Relación con la tabla Autores
);

-- Crear la tabla intermedia Ventas_Libros
CREATE TABLE Ventas_Libros (
    id_venta INT,                      -- Identificador de la venta
    id_libro INT,                      -- Identificador del libro
    cantidad INT,                      -- Cantidad de libros vendidos
    PRIMARY KEY (id_venta, id_libro),  -- Clave primaria compuesta por el id de la venta y del libro
    FOREIGN KEY (id_venta) REFERENCES Ventas(id), -- Relación con la tabla Ventas
    FOREIGN KEY (id_libro) REFERENCES Libros(id)  -- Relación con la tabla Libros
);

-- Crear la tabla RegistroVentas
CREATE TABLE RegistroVentas (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada registro
    id_venta INT,                      -- Identificador de la venta registrada
    fecha_insercion DATETIME           -- Fecha y hora de la inserción del registro
);

-- Crear la tabla Sucursales
CREATE TABLE Sucursales (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada sucursal
    nombre VARCHAR(255) NOT NULL,      -- Nombre de la sucursal
    direccion VARCHAR(255) NOT NULL,   -- Dirección de la sucursal
    ciudad VARCHAR(100) NOT NULL,      -- Ciudad donde se encuentra la sucursal
    pais VARCHAR(100) NOT NULL         -- País donde se encuentra la sucursal
);

-- Crear la tabla Empleados
CREATE TABLE Empleados (
    id INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único y auto incrementable para cada empleado
    nombre VARCHAR(255) NOT NULL,      -- Nombre del empleado
    apellido VARCHAR(255) NOT NULL,    -- Apellido del empleado
    id_sucursal INT,                   -- Identificador de la sucursal donde trabaja el empleado
    puesto VARCHAR(255),               -- Puesto del empleado
    FOREIGN KEY (id_sucursal) REFERENCES Sucursales(id) -- Relación con la tabla Sucursales
);

-- Crear la vista VistaLibrosPorCategoria
CREATE VIEW VistaLibrosPorCategoria AS
SELECT l.id, l.titulo, c.nombre AS categoria, l.fecha_publicacion, l.precio
FROM Libros l
JOIN Categorias c ON l.id_categoria = c.id;
-- Esta vista muestra la lista de libros junto con su categoría, fecha de publicación y precio.
-- Es útil para obtener una visión general de los libros clasificados por categoría.

-- Crear la vista VistaVentasPorCliente
CREATE VIEW VistaVentasPorCliente AS
SELECT v.id, c.nombre AS cliente, v.fecha_venta, v.total
FROM Ventas v
JOIN Clientes c ON v.id_cliente = c.id;
-- Esta vista muestra la lista de ventas junto con el nombre del cliente, la fecha de la venta y el total de la venta.
-- Es útil para ver las ventas realizadas por cada cliente.

-- Crear la vista VistaLibrosConAutores
CREATE VIEW VistaLibrosConAutores AS
SELECT l.id, l.titulo, GROUP_CONCAT(CONCAT(a.nombre, ' ', a.apellido) SEPARATOR ', ') AS autores
FROM Libros l
JOIN Libros_Autores la ON l.id = la.id_libro
JOIN Autores a ON la.id_autor = a.id
GROUP BY l.id, l.titulo;
-- Esta vista muestra la lista de libros junto con los nombres completos de sus autores concatenados.
-- Es útil para obtener una visión general de los libros y sus autores.

-- Eliminar funciones si ya existen
DROP FUNCTION IF EXISTS CalcularDescuento;
DROP FUNCTION IF EXISTS TotalVentasCliente;
DROP FUNCTION IF EXISTS ObtenerPrecioLibro;

DELIMITER //

-- Crear la función CalcularDescuento
CREATE FUNCTION CalcularDescuento(precio DECIMAL(10, 2), porcentaje DECIMAL(5, 2)) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    RETURN precio - (precio * (porcentaje / 100));
END //
-- Esta función calcula el precio con descuento dado un precio original y un porcentaje de descuento.
-- Es útil para aplicar descuentos a los precios de los libros.

DELIMITER ;

DELIMITER //

-- Crear la función TotalVentasCliente
CREATE FUNCTION TotalVentasCliente(cliente_id INT) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(total) INTO total FROM Ventas WHERE id_cliente = cliente_id;
    RETURN total;
END //
-- Esta función calcula el total de ventas realizadas por un cliente dado su id.
-- Es útil para obtener el monto total de ventas por cliente.

DELIMITER ;

DELIMITER //

-- Crear la función ObtenerPrecioLibro
CREATE FUNCTION ObtenerPrecioLibro(libro_id INT) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE precio DECIMAL(10, 2);
    SELECT precio INTO precio FROM Libros WHERE id = libro_id;
    RETURN precio;
END //
-- Esta función obtiene el precio de un libro dado su id.
-- Es útil para obtener el precio de un libro específico.

DELIMITER ;

-- Eliminar procedimientos almacenados si ya existen
DROP PROCEDURE IF EXISTS InsertarNuevoLibro;
DROP PROCEDURE IF EXISTS ActualizarPrecioLibro;
DROP PROCEDURE IF EXISTS EliminarLibro;

DELIMITER //

-- Crear el stored procedure InsertarNuevoLibro
CREATE PROCEDURE InsertarNuevoLibro(
    IN titulo VARCHAR(255),
    IN id_categoria INT,
    IN id_editorial INT,
    IN fecha_publicacion DATE,
    IN precio DECIMAL(10, 2)
)
BEGIN
    INSERT INTO Libros (titulo, id_categoria, id_editorial, fecha_publicacion, precio)
    VALUES (titulo, id_categoria, id_editorial, fecha_publicacion, precio);
END //
-- Este procedimiento almacena inserta un nuevo libro en la tabla Libros con los datos proporcionados.
-- Es útil para agregar nuevos libros a la base de datos.

DELIMITER ;

DELIMITER //

-- Crear el stored procedure ActualizarPrecioLibro
CREATE PROCEDURE ActualizarPrecioLibro(
    IN libro_id INT,
    IN nuevo_precio DECIMAL(10, 2)
)
BEGIN
    UPDATE Libros SET precio = nuevo_precio WHERE id = libro_id;
END //
-- Este procedimiento almacena actualiza el precio de un libro dado su id.
-- Es útil para modificar el precio de un libro existente.

DELIMITER ;

DELIMITER //

-- Crear el stored procedure EliminarLibro
CREATE PROCEDURE EliminarLibro(
    IN libro_id INT
)
BEGIN
    DELETE FROM Libros WHERE id = libro_id;
END //
-- Este procedimiento almacena elimina un libro de la tabla Libros dado su id.
-- Es útil para remover libros de la base de datos.

DELIMITER ;

-- Eliminar triggers si ya existen
DROP TRIGGER IF EXISTS ActualizarFechaModificacionLibros;
DROP TRIGGER IF EXISTS RegistroInsercionesVentas;
DROP TRIGGER IF EXISTS EvitarVentasNegativas;

DELIMITER //

-- Crear un trigger para actualizar la fecha de modificación en la tabla Libros
CREATE TRIGGER ActualizarFechaModificacionLibros
BEFORE UPDATE ON Libros
FOR EACH ROW
BEGIN
    SET NEW.fecha_publicacion = NOW();
END //
-- Este trigger actualiza la fecha de publicación de un libro a la fecha y hora actuales antes de cualquier actualización.
-- Es útil para llevar un control de cuándo se modificó por última vez un libro.

DELIMITER ;

DELIMITER //

-- Crear un trigger para registrar inserciones en la tabla RegistroVentas
CREATE TRIGGER RegistroInsercionesVentas
AFTER INSERT ON Ventas
FOR EACH ROW
BEGIN
    INSERT INTO RegistroVentas (id_venta, fecha_insercion)
    VALUES (NEW.id, NOW());
END //
-- Este trigger registra la inserción de una nueva venta en la tabla RegistroVentas.
-- Es útil para llevar un registro de las ventas realizadas.

DELIMITER ;

DELIMITER //

-- Crear un trigger para evitar ventas con total negativo
CREATE TRIGGER EvitarVentasNegativas
BEFORE INSERT ON Ventas
FOR EACH ROW
BEGIN
    IF NEW.total < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El total de la venta no puede ser negativo';
    END IF;
END //
-- Este trigger evita que se inserten ventas con un total negativo.
-- Es útil para asegurar la integridad de los datos y prevenir errores lógicos.

DELIMITER ;
