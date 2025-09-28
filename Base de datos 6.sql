-- Eliminar base de datos si existe y crearla nueva
DROP DATABASE IF EXISTS tienda_aji6;
CREATE DATABASE tienda_aji6;
USE tienda_aji6;

-- Creación de la tabla clientes (MODIFICADA)
CREATE TABLE clientes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    direccion TEXT,
    telefono VARCHAR(20),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Creación de la tabla productos
CREATE TABLE productos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    categoria VARCHAR(50),
    descripcion TEXT,
    imagen VARCHAR(255),
    activo BOOLEAN DEFAULT TRUE
);

-- Creación de la tabla pedidos (MODIFICADA)
CREATE TABLE pedidos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    idcliente INT NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10,2) NOT NULL DEFAULT 0,
    estado ENUM('pendiente', 'procesando', 'completado', 'cancelado') DEFAULT 'pendiente',
    FOREIGN KEY (idcliente) REFERENCES clientes(id) ON DELETE CASCADE
);

-- Tabla de detalle del pedido (MODIFICADA)
CREATE TABLE detalles_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) GENERATED ALWAYS AS (cantidad * precio_unitario) STORED,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE CASCADE
);

-- Creación de la tabla proveedores
CREATE TABLE proveedores(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    materiaprima VARCHAR(100),
    contacto VARCHAR(100),
    telefono VARCHAR(20)
);

-- Insertar productos de ejemplo
INSERT INTO productos (nombre, precio, stock, categoria, descripcion) VALUES
('Salsa de ají tradicional', 30000.00, 100, 'salsa', 'Salsa de ají picante tradicional con especias secretas'),
('Salsa de ají con mango', 45000.00, 150, 'salsa', 'Salsa de ají con dulce sabor a mango y un toque picante'),
('Salsa de ají con piña', 50000.00, 65, 'salsa', 'Salsa exótica de ají con piña tropical'),
('Salsa de ají extra picante', 35000.00, 80, 'salsa', 'Para los amantes del picante extremo'),
('Salsa de ají suave', 25000.00, 120, 'salsa', 'Salsa suave ideal para niños y personas sensibles al picante');

-- Insertar proveedores
INSERT INTO proveedores (nombre, materiaprima, contacto, telefono) VALUES
('Granja María', 'Ají', 'maria@granja.com', '3001234567'),
('Granja Doña Juana', 'Mango', 'juana@granja.com', '3002345678'),
('Granja Luis', 'Piña', 'luis@granja.com', '3003456789'),
('Granja Ecológica', 'Verduras orgánicas', 'eco@granja.com', '3004567890');

-- Insertar clientes de prueba con contraseñas hasheadas (password: 123456)
INSERT INTO clientes (nombre, correo, password, direccion, telefono) VALUES
('Juan Rodriguez', 'rrodriguez@gmail.com', '$2a$10$rQ9b6Jk4UqYz5x8wV7nBcOcWQ1Zx3Y6A9B2C4D7E0F1G2H3I4J5K', 'Calle 15', '3143286790'),
('Jorge Arboleda Cruz', 'jarboledacruz@yahoo.com', '$2a$10$sR0c7K1LvMw2y9x8wV7nBcOcWQ1Zx3Y6A9B2C4D7E0F1G2H3I4J5K', 'Calle 156', '3187652312'),
('Rosa María Suarez', 'rmariasuarez@gmail.com', '$2a$10$tS1d8M2NwOx3z0y9x8wV7nBcOcWQ1Zx3Y6A9B2C4D7E0F1G2H3I4J5K', 'Avenida 12 barrio los martires', '3201235678');

-- Crear pedidos de ejemplo
INSERT INTO pedidos (idcliente, total, estado) VALUES
(1, 90000.00, 'completado'),
(2, 45000.00, 'procesando'),
(3, 50000.00, 'pendiente');

-- Insertar detalles de pedidos
INSERT INTO detalles_pedido (pedido_id, producto_id, cantidad, precio_unitario) VALUES
(1, 2, 2, 45000.00),
(2, 1, 1, 45000.00),
(3, 3, 1, 50000.00);

-- Actualizar el usuario existente o crear uno nuevo
DROP USER IF EXISTS 'tienda_user'@'localhost';
CREATE USER 'tienda_user'@'localhost' IDENTIFIED BY 'admin12345';
GRANT ALL PRIVILEGES ON tienda_aji6.* TO 'tienda_user'@'localhost';
FLUSH PRIVILEGES;

-- Verificar las tablas creadas
SHOW TABLES;

-- Mostrar datos de ejemplo
SELECT '=== CLIENTES ===' as Info;
SELECT * FROM clientes;

SELECT '=== PRODUCTOS ===' as Info;
SELECT * FROM productos;

SELECT '=== PEDIDOS ===' as Info;
SELECT * FROM pedidos;

SELECT '=== DETALLES PEDIDO ===' as Info;
SELECT * FROM detalles_pedido;

SELECT '=== PROVEEDORES ===' as Info;
SELECT * FROM proveedores;