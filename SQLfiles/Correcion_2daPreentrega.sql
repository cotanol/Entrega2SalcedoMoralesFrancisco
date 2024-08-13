USE LibreriaDB;
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
