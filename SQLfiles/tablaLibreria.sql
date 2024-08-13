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
