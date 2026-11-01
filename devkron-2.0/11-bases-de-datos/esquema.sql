-- Esquema de ejemplo (MySQL) para los programas de esta carpeta.
-- Créelo en una base de pruebas y defina la conexión "tienda@ejemplos" en connections.xml
-- (copie connections.xml.example de la instalación y llene Host, UserName, Password, DefaultSchema y Port).
CREATE TABLE productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sku VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(12,2) NOT NULL,
    existencia INT NOT NULL DEFAULT 0
);

CREATE TABLE ventas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATETIME NOT NULL,
    cliente VARCHAR(100) NOT NULL,
    total DECIMAL(12,2) NOT NULL
);

CREATE TABLE ventas_partidas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    venta INT NOT NULL,
    producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio DECIMAL(12,2) NOT NULL
);

INSERT INTO productos (sku, nombre, precio, existencia) VALUES
    ('CAF-01', 'Café de Chiapas 500 g', 120.00, 30),
    ('TE-01', 'Té verde 100 g', 45.50, 12),
    ('CHO-01', 'Chocolate de mesa', 60.00, 0);
