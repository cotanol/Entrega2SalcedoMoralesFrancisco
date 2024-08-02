-- Eliminar la base de datos si ya existe
DROP DATABASE IF EXISTS LibreriaDB;

-- Crear la base de datos
CREATE DATABASE LibreriaDB;

-- Usar la base de datos creada
USE LibreriaDB;

-- Crear la tabla Categorias
CREATE TABLE Categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

-- Crear la tabla Editoriales
CREATE TABLE Editoriales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    pais VARCHAR(100)
);

-- Crear la tabla Autores
CREATE TABLE Autores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL
);

-- Crear la tabla Libros
CREATE TABLE Libros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    id_categoria INT,
    id_editorial INT,
    fecha_publicacion DATE,
    precio DECIMAL(10, 2),
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id),
    FOREIGN KEY (id_editorial) REFERENCES Editoriales(id)
);

-- Crear la tabla Clientes
CREATE TABLE Clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    telefono VARCHAR(20)
);

-- Crear la tabla Ventas
CREATE TABLE Ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    fecha_venta DATE NOT NULL,
    total DECIMAL(10, 2),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id)
);

-- Crear la tabla intermedia Libros_Autores
CREATE TABLE Libros_Autores (
    id_libro INT,
    id_autor INT,
    PRIMARY KEY (id_libro, id_autor),
    FOREIGN KEY (id_libro) REFERENCES Libros(id),
    FOREIGN KEY (id_autor) REFERENCES Autores(id)
);

-- Crear la tabla intermedia Ventas_Libros
CREATE TABLE Ventas_Libros (
    id_venta INT,
    id_libro INT,
    cantidad INT,
    PRIMARY KEY (id_venta, id_libro),
    FOREIGN KEY (id_venta) REFERENCES Ventas(id),
    FOREIGN KEY (id_libro) REFERENCES Libros(id)
);

-- Crear la tabla RegistroVentas
CREATE TABLE RegistroVentas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT,
    fecha_insercion DATETIME
);

-- Insertar categorías
INSERT INTO Categorias (nombre) VALUES 
('Ficción'), 
('No Ficción'), 
('Ciencia'), 
('Historia'), 
('Fantasía'), 
('Biografía'), 
('Tecnología');

-- Insertar editoriales
INSERT INTO Editoriales (nombre, pais) VALUES 
('Editorial A', 'España'), 
('Editorial B', 'México'), 
('Editorial C', 'Argentina'), 
('Editorial D', 'Colombia'), 
('Editorial E', 'Chile');

-- Insertar autores
INSERT INTO Autores (nombre, apellido) VALUES 
('Gabriel', 'García Márquez'), 
('Isabel', 'Allende'), 
('Jorge', 'Luis Borges'), 
('Mario', 'Vargas Llosa'), 
('Julio', 'Cortázar');

-- Insertar libros
INSERT INTO Libros (titulo, id_categoria, id_editorial, fecha_publicacion, precio) 
VALUES 
('Cien Años de Soledad', 1, 1, '1967-06-05', 19.99), 
('La Casa de los Espíritus', 1, 2, '1982-10-20', 17.99),
('El Aleph', 1, 3, '1949-07-15', 15.50),
('Conversación en La Catedral', 1, 4, '1969-05-18', 22.00),
('Rayuela', 1, 5, '1963-10-25', 18.75),
('Ficciones', 1, 3, '1944-01-01', 14.99),
('Crónica de una Muerte Anunciada', 1, 1, '1981-04-01', 16.00);

-- Insertar clientes
INSERT INTO Clientes (nombre, email, telefono) 
VALUES 
('Juan Pérez', 'juan.perez@example.com', '1234567890'), 
('María García', 'maria.garcia@example.com', '0987654321'),
('Carlos López', 'carlos.lopez@example.com', '5551234567'),
('Ana Torres', 'ana.torres@example.com', '5559876543'),
('Luis González', 'luis.gonzalez@example.com', '5556789012');

-- Insertar ventas
INSERT INTO Ventas (id_cliente, fecha_venta, total) 
VALUES 
(1, '2023-07-01', 37.98), 
(2, '2023-07-02', 17.99),
(3, '2023-07-03', 32.50),
(4, '2023-07-04', 22.00),
(5, '2023-07-05', 41.75);

-- Insertar libros-autores
INSERT INTO Libros_Autores (id_libro, id_autor) 
VALUES 
(1, 1), 
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 3),
(7, 1);

-- Insertar ventas-libros
INSERT INTO Ventas_Libros (id_venta, id_libro, cantidad) 
VALUES 
(1, 1, 1), 
(1, 2, 1), 
(2, 2, 1), 
(3, 3, 2), 
(4, 4, 1),
(5, 5, 2), 
(5, 6, 1);

-- Crear la vista VistaLibrosPorCategoria
-- Descripción detallada: Muestra información detallada de los libros junto con sus categorías correspondientes.
-- Objetivo: Facilitar la consulta de los libros categorizados por su género, permitiendo así un acceso rápido a la información de libros por categorías.
-- Tablas que lo componen: Libros, Categorias.
CREATE VIEW VistaLibrosPorCategoria AS
SELECT l.id, l.titulo, c.nombre AS categoria, l.fecha_publicacion, l.precio
FROM Libros l
JOIN Categorias c ON l.id_categoria = c.id;

-- Crear la vista VistaVentasPorCliente
-- Descripción detallada: Proporciona un resumen de las ventas realizadas, asociando cada venta con el cliente que la realizó.
-- Objetivo: Permitir la revisión de las ventas por cliente, facilitando la gestión y análisis de las transacciones realizadas.
-- Tablas que lo componen: Ventas, Clientes.
CREATE VIEW VistaVentasPorCliente AS
SELECT v.id, c.nombre AS cliente, v.fecha_venta, v.total
FROM Ventas v
JOIN Clientes c ON v.id_cliente = c.id;

-- Crear la vista VistaLibrosConAutores
-- Descripción detallada: Muestra una lista de libros junto con sus respectivos autores, consolidando los datos de múltiples autores por libro.
-- Objetivo: Ofrecer una vista integral que relacione los libros con sus autores, útil para consultas bibliográficas y de inventario.
-- Tablas que lo componen: Libros, Libros_Autores, Autores.
CREATE VIEW VistaLibrosConAutores AS
SELECT l.id, l.titulo, GROUP_CONCAT(CONCAT(a.nombre, ' ', a.apellido) SEPARATOR ', ') AS autores
FROM Libros l
JOIN Libros_Autores la ON l.id = la.id_libro
JOIN Autores a ON la.id_autor = a.id
GROUP BY l.id, l.titulo;

-- Eliminar funciones si ya existen
DROP FUNCTION IF EXISTS CalcularDescuento;
DROP FUNCTION IF EXISTS TotalVentasCliente;
DROP FUNCTION IF EXISTS ObtenerPrecioLibro;

DELIMITER //

-- Crear la función CalcularDescuento
-- Descripción detallada: Calcula el precio con descuento basado en un precio original y un porcentaje de descuento.
-- Objetivo: Facilitar la aplicación de descuentos en el sistema de ventas, mejorando la flexibilidad en la gestión de precios.
-- Tablas que manipulan: Ninguna (función aritmética).
CREATE FUNCTION CalcularDescuento(precio DECIMAL(10, 2), porcentaje DECIMAL(5, 2)) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    RETURN precio - (precio * (porcentaje / 100));
END //

DELIMITER ;

DELIMITER //

-- Crear la función TotalVentasCliente
-- Descripción detallada: Suma el total de todas las ventas realizadas por un cliente específico.
-- Objetivo: Proporcionar una forma rápida de obtener el total gastado por un cliente, útil para análisis de comportamiento de clientes y generación de reportes.
-- Tablas que manipulan: Ventas.
CREATE FUNCTION TotalVentasCliente(cliente_id INT) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(total) INTO total FROM Ventas WHERE id_cliente = cliente_id;
    RETURN total;
END //

DELIMITER ;

DELIMITER //

-- Crear la función ObtenerPrecioLibro
-- Descripción detallada: Devuelve el precio de un libro específico basado en su ID.
-- Objetivo: Facilitar la obtención del precio de un libro para operaciones que requieren conocer el costo de los productos.
-- Tablas que manipulan: Libros.
CREATE FUNCTION ObtenerPrecioLibro(libro_id INT) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE precio DECIMAL(10, 2);
    SELECT precio INTO precio FROM Libros WHERE id = libro_id;
    RETURN precio;
END //

DELIMITER ;

-- Eliminar procedimientos almacenados si ya existen
DROP PROCEDURE IF EXISTS InsertarNuevoLibro;
DROP PROCEDURE IF EXISTS ActualizarPrecioLibro;
DROP PROCEDURE IF EXISTS EliminarLibro;

DELIMITER //

-- Crear el stored procedure InsertarNuevoLibro
-- Descripción detallada: Inserta un nuevo libro en la tabla Libros con la información proporcionada.
-- Objetivo: Automatizar la inserción de nuevos registros de libros, asegurando la consistencia y la integridad de los datos.
-- Tablas que lo componen: Libros.
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

DELIMITER ;

DELIMITER //

-- Crear el stored procedure ActualizarPrecioLibro
-- Descripción detallada: Actualiza el precio de un libro específico identificado por su ID.
-- Objetivo: Permitir la modificación del precio de un libro existente, facilitando la gestión dinámica de precios en el catálogo.
-- Tablas que lo componen: Libros.
CREATE PROCEDURE ActualizarPrecioLibro(
    IN libro_id INT,
    IN nuevo_precio DECIMAL(10, 2)
)
BEGIN
    UPDATE Libros SET precio = nuevo_precio WHERE id = libro_id;
END //

DELIMITER ;

DELIMITER //

-- Crear el stored procedure EliminarLibro
-- Descripción detallada: Elimina un libro de la tabla Libros basado en su ID.
-- Objetivo: Facilitar la eliminación de registros de libros, asegurando que los datos obsoletos o incorrectos sean removidos del sistema.
-- Tablas que lo componen: Libros.
CREATE PROCEDURE EliminarLibro(
    IN libro_id INT
)
BEGIN
    DELETE FROM Libros WHERE id = libro_id;
END //

DELIMITER ;

-- Eliminar triggers si ya existen
DROP TRIGGER IF EXISTS ActualizarFechaModificacionLibros;
DROP TRIGGER IF EXISTS RegistroInsercionesVentas;
DROP TRIGGER IF EXISTS EvitarVentasNegativas;

DELIMITER //

-- Crear un trigger para actualizar la fecha de modificación en la tabla Libros
-- Descripción detallada: Antes de actualizar un registro en la tabla Libros, establece la fecha de publicación al momento actual.
-- Objetivo: Mantener un registro preciso de cuándo se realizaron las modificaciones en los libros, asegurando la trazabilidad de los cambios.
-- Tablas que manipulan: Libros.
CREATE TRIGGER ActualizarFechaModificacionLibros
BEFORE UPDATE ON Libros
FOR EACH ROW
BEGIN
    SET NEW.fecha_publicacion = NOW();
END //

DELIMITER ;

DELIMITER //

-- Crear un trigger para registrar inserciones en la tabla Ventas
-- Descripción detallada: Después de insertar una nueva venta en la tabla Ventas, registra la inserción en la tabla RegistroVentas.
-- Objetivo: Mantener un registro histórico de todas las inserciones de ventas, facilitando el seguimiento y la auditoría de las transacciones.
-- Tablas que manipulan: Ventas, RegistroVentas.
CREATE TRIGGER RegistroInsercionesVentas
AFTER INSERT ON Ventas
FOR EACH ROW
BEGIN
    INSERT INTO RegistroVentas (id_venta, fecha_insercion)
    VALUES (NEW.id, NOW());
END //

DELIMITER ;

DELIMITER //

-- Crear un trigger para evitar ventas con total negativo
-- Descripción detallada: Antes de insertar un nuevo registro en la tabla Ventas, verifica que el total no sea negativo.
-- Objetivo: Asegurar la integridad de los datos evitando que se registren ventas con un total negativo, lo cual no es lógico en una transacción de venta.
-- Tablas que manipulan: Ventas.
CREATE TRIGGER EvitarVentasNegativas
BEFORE INSERT ON Ventas
FOR EACH ROW
BEGIN
    IF NEW.total < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El total de la venta no puede ser negativo';
    END IF;
END //

DELIMITER ;

-- Consultar registros en la tabla RegistroVentas para verificar el funcionamiento del trigger
SELECT * FROM RegistroVentas;
