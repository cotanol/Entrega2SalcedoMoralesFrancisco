-- Usar la base de datos creada
USE LibreriaDB;

-- Insertar categorías
INSERT INTO Categorias (nombre) VALUES 
('Ficción'), 
('No Ficción'), 
('Ciencia'), 
('Historia'), 
('Fantasía'), 
('Biografía'), 
('Tecnología'), 
('Aventura'), 
('Misterio'), 
('Romance'), 
('Humor'), 
('Drama'), 
('Poesía'), 
('Ensayo'), 
('Cómic');

-- Insertar editoriales
INSERT INTO Editoriales (nombre, pais) VALUES 
('Editorial A', 'España'), 
('Editorial B', 'México'), 
('Editorial C', 'Argentina'), 
('Editorial D', 'Colombia'), 
('Editorial E', 'Chile'), 
('Editorial F', 'Perú'), 
('Editorial G', 'Brasil'), 
('Editorial H', 'Uruguay'), 
('Editorial I', 'Paraguay'), 
('Editorial J', 'Bolivia'), 
('Editorial K', 'Venezuela'), 
('Editorial L', 'Ecuador'), 
('Editorial M', 'Panamá'), 
('Editorial N', 'Costa Rica'), 
('Editorial O', 'Guatemala');

-- Insertar autores
INSERT INTO Autores (nombre, apellido) VALUES 
('Gabriel', 'García Márquez'), 
('Isabel', 'Allende'), 
('Jorge', 'Luis Borges'), 
('Mario', 'Vargas Llosa'), 
('Julio', 'Cortázar'), 
('Pablo', 'Neruda'), 
('Octavio', 'Paz'), 
('Gabriela', 'Mistral'), 
('Laura', 'Esquivel'), 
('Carlos', 'Fuentes'), 
('Roberto', 'Bolaño'), 
('Alejo', 'Carpentier'), 
('Juan', 'Rulfo'), 
('Javier', 'Marías'), 
('César', 'Vallejo');

-- Insertar libros
INSERT INTO Libros (titulo, id_categoria, id_editorial, fecha_publicacion, precio) 
VALUES 
('Cien Años de Soledad', 1, 1, '1967-06-05', 19.99), 
('La Casa de los Espíritus', 1, 2, '1982-10-20', 17.99),
('El Aleph', 1, 3, '1949-07-15', 15.50),
('Conversación en La Catedral', 1, 4, '1969-05-18', 22.00),
('Rayuela', 1, 5, '1963-10-25', 18.75),
('Ficciones', 1, 3, '1944-01-01', 14.99),
('Crónica de una Muerte Anunciada', 1, 1, '1981-04-01', 16.00),
('Los Detectives Salvajes', 1, 11, '1998-04-05', 23.50),
('Pedro Páramo', 1, 14, '1955-03-15', 12.75),
('El Llano en Llamas', 1, 14, '1953-10-01', 14.00),
('El Amante Japonés', 2, 2, '2015-05-28', 19.00),
('La Fiesta del Chivo', 2, 4, '2000-11-08', 21.50),
('La Tregua', 2, 6, '1960-03-15', 16.50),
('Las Armas Secretas', 3, 5, '1959-01-01', 17.25),
('Sobre Héroes y Tumbas', 3, 3, '1961-05-01', 18.00);

-- Insertar clientes
INSERT INTO Clientes (nombre, email, telefono) 
VALUES 
('Juan Pérez', 'juan.perez@example.com', '1234567890'), 
('María García', 'maria.garcia@example.com', '0987654321'),
('Carlos López', 'carlos.lopez@example.com', '5551234567'),
('Ana Torres', 'ana.torres@example.com', '5559876543'),
('Luis González', 'luis.gonzalez@example.com', '5556789012'),
('Laura Martínez', 'laura.martinez@example.com', '5552345678'),
('Pedro Sánchez', 'pedro.sanchez@example.com', '5553456789'),
('Lucía Fernández', 'lucia.fernandez@example.com', '5554567890'),
('Jorge Rodríguez', 'jorge.rodriguez@example.com', '5555678901'),
('Sofía Ramírez', 'sofia.ramirez@example.com', '5556789012'),
('Andrés Hernández', 'andres.hernandez@example.com', '5557890123'),
('Elena Moreno', 'elena.moreno@example.com', '5558901234'),
('Alberto Ruiz', 'alberto.ruiz@example.com', '5559012345'),
('Cristina Navarro', 'cristina.navarro@example.com', '5550123456'),
('Diego Castillo', 'diego.castillo@example.com', '5551234567');

-- Insertar ventas
INSERT INTO Ventas (id_cliente, fecha_venta, total) 
VALUES 
(1, '2023-07-01', 37.98), 
(2, '2023-07-02', 17.99),
(3, '2023-07-03', 32.50),
(4, '2023-07-04', 22.00),
(5, '2023-07-05', 41.75),
(6, '2023-07-06', 28.50),
(7, '2023-07-07', 15.00),
(8, '2023-07-08', 30.00),
(9, '2023-07-09', 19.99),
(10, '2023-07-10', 27.99),
(11, '2023-07-11', 21.00),
(12, '2023-07-12', 45.75),
(13, '2023-07-13', 33.50),
(14, '2023-07-14', 29.00),
(15, '2023-07-15', 39.99);

-- Insertar libros-autores
INSERT INTO Libros_Autores (id_libro, id_autor) 
VALUES 
(1, 1), 
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 3),
(7, 1),
(8, 11),
(9, 14),
(10, 14),
(11, 2),
(12, 4),
(13, 6),
(14, 5),
(15, 3);

-- Insertar ventas-libros
INSERT INTO Ventas_Libros (id_venta, id_libro, cantidad) 
VALUES 
(1, 1, 1), 
(1, 2, 1), 
(2, 2, 1), 
(3, 3, 2), 
(4, 4, 1),
(5, 5, 2), 
(5, 6, 1),
(6, 7, 1),
(7, 8, 1),
(8, 9, 1),
(9, 10, 1),
(10, 11, 1),
(11, 12, 1),
(12, 13, 2),
(13, 14, 1),
(14, 15, 1),
(15, 1, 2);

-- Insertar sucursales
INSERT INTO Sucursales (nombre, direccion, ciudad, pais) 
VALUES 
('Sucursal Centro', 'Calle Mayor 1', 'Madrid', 'España'),
('Sucursal Norte', 'Avenida Libertad 45', 'Barcelona', 'España'),
('Sucursal Sur', 'Calle Sevilla 123', 'Sevilla', 'España'),
('Sucursal Este', 'Calle Valencia 78', 'Valencia', 'España'),
('Sucursal Oeste', 'Calle Coruña 56', 'La Coruña', 'España'),
('Sucursal México DF', 'Avenida Reforma 123', 'Ciudad de México', 'México'),
('Sucursal Buenos Aires', 'Calle Florida 789', 'Buenos Aires', 'Argentina'),
('Sucursal Bogotá', 'Carrera 7 85', 'Bogotá', 'Colombia'),
('Sucursal Santiago', 'Calle Ahumada 654', 'Santiago', 'Chile'),
('Sucursal Lima', 'Avenida Larco 321', 'Lima', 'Perú'),
('Sucursal Quito', 'Calle Amazonas 123', 'Quito', 'Ecuador'),
('Sucursal Caracas', 'Avenida Libertador 789', 'Caracas', 'Venezuela'),
('Sucursal La Paz', 'Calle Comercio 456', 'La Paz', 'Bolivia'),
('Sucursal San José', 'Avenida Central 789', 'San José', 'Costa Rica'),
('Sucursal Asunción', 'Avenida Mariscal 123', 'Asunción', 'Paraguay');

-- Insertar empleados
INSERT INTO Empleados (nombre, apellido, id_sucursal, puesto) 
VALUES 
('José', 'Martínez', 1, 'Gerente'),
('Ana', 'López', 2, 'Vendedor'),
('Luis', 'Pérez', 3, 'Vendedor'),
('Laura', 'Gómez', 4, 'Vendedor'),
('Carlos', 'Sánchez', 5, 'Gerente'),
('María', 'Rodríguez', 6, 'Vendedor'),
('Pedro', 'Hernández', 7, 'Vendedor'),
('Lucía', 'Ramírez', 8, 'Vendedor'),
('Jorge', 'García', 9, 'Gerente'),
('Sofía', 'Fernández', 10, 'Vendedor'),
('Miguel', 'García', 11, 'Vendedor'),
('Cristina', 'López', 12, 'Vendedor'),
('Roberto', 'Martínez', 13, 'Vendedor'),
('Patricia', 'González', 14, 'Vendedor'),
('Fernando', 'Rodríguez', 15, 'Gerente');
