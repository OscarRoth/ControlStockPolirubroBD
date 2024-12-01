-- Creación de la base de datos
CREATE DATABASE PolirubroDB;
USE PolirubroDB;

-- Tabla: Categoria
CREATE TABLE Categoria (
    IdCategoria INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Subcategoria VARCHAR(100)
);

-- Tabla: Polirubro
CREATE TABLE Polirubro (
    IdPolirubro INT AUTO_INCREMENT PRIMARY KEY,
    NIF VARCHAR(50) NOT NULL,
    Direccion VARCHAR(255) NOT NULL
);

-- Tabla: Proveedor
CREATE TABLE Proveedor (
    IdProveedor INT AUTO_INCREMENT PRIMARY KEY,
    CUIT VARCHAR(20) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Direccion VARCHAR(255) NOT NULL
);

-- Tabla: Cliente
CREATE TABLE Cliente (
    IdCliente INT AUTO_INCREMENT PRIMARY KEY,
    DNI VARCHAR(20) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    FechaNac DATE NOT NULL,
    Telefono VARCHAR(20),
    Direccion VARCHAR(255),
    Email VARCHAR(100)
);

-- Tabla: Producto
CREATE TABLE Producto (
    IdProducto INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    IdCategoria INT NOT NULL,
    FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria)
);

-- Tabla: Compra
CREATE TABLE Compra (
    IdCompra INT AUTO_INCREMENT PRIMARY KEY,
    NumFactura VARCHAR(50) NOT NULL,
    IdProveedor INT NOT NULL,
    IdPolirubro INT NOT NULL,
    Total DECIMAL(10, 2) NOT NULL,
    Fecha DATE NOT NULL,
    FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor),
    FOREIGN KEY (IdPolirubro) REFERENCES Polirubro(IdPolirubro)
);

-- Tabla: CompraDetalle
CREATE TABLE CompraDetalle (
    IdCompraDetalle INT AUTO_INCREMENT PRIMARY KEY,
    IdCompra INT NOT NULL,
    IdProducto INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnit DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (IdCompra) REFERENCES Compra(IdCompra),
    FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto)
);

-- Tabla: Venta
CREATE TABLE Venta (
    IdVenta INT AUTO_INCREMENT PRIMARY KEY,
    NumFactura VARCHAR(50) NOT NULL,
    IdPolirubro INT NOT NULL,
    IdCliente INT NOT NULL,
    Fecha DATE NOT NULL,
    Total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (IdPolirubro) REFERENCES Polirubro(IdPolirubro),
    FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente)
);

-- Tabla: VentaDetalle
CREATE TABLE VentaDetalle (
    IdVentaDetalle INT AUTO_INCREMENT PRIMARY KEY,
    IdVenta INT NOT NULL,
    IdProducto INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnit DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (IdVenta) REFERENCES Venta(IdVenta),
    FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto)
);

-- Tabla: Inventario
CREATE TABLE Inventario (
    IdInventario INT AUTO_INCREMENT PRIMARY KEY,
    IdProducto INT NOT NULL,
    CantidadActual INT NOT NULL,
    CantidadMinima INT NOT NULL,
    FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto)
);

-- Tabla: PrecioVenta
CREATE TABLE PrecioVenta (
    IdPrecioVenta INT AUTO_INCREMENT PRIMARY KEY,
    IdProducto INT NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL,
    FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto)
);

-- INSERTS para poblar las tablas

-- Categoria
INSERT INTO Categoria (Nombre, Subcategoria) VALUES 
('Electrónica', 'Audio'),
('Hogar', 'Muebles');

-- Polirubro
INSERT INTO Polirubro (NIF, Direccion) VALUES 
('123456789', 'Av. Principal 123'),
('987654321', 'Calle Secundaria 456');

-- Proveedor
INSERT INTO Proveedor (CUIT, Nombre, Direccion) VALUES 
('30-12345678-9', 'Proveedor A', 'Calle A 123'),
('30-98765432-1', 'Proveedor B', 'Calle B 456');

-- Cliente
INSERT INTO Cliente (DNI, Nombre, Apellido, FechaNac, Telefono, Direccion, Email) VALUES 
('12345678', 'Juan', 'Pérez', '1985-06-15', '1122334455', 'Calle Falsa 123', 'juan.perez@example.com'),
('87654321', 'María', 'Gómez', '1990-11-20', '5566778899', 'Avenida Siempreviva 456', 'maria.gomez@example.com');

-- Producto
INSERT INTO Producto (Nombre, IdCategoria) VALUES 
('Televisor 40"', 1),
('Silla', 2);

-- Compra
INSERT INTO Compra (NumFactura, IdProveedor, IdPolirubro, Total, Fecha) VALUES 
('FAC-001', 1, 1, 10000.00, '2024-11-30'),
('FAC-002', 2, 2, 5000.00, '2024-11-29');

-- CompraDetalle
INSERT INTO CompraDetalle (IdCompra, IdProducto, Cantidad, PrecioUnit) VALUES 
(1, 1, 10, 1000.00),
(2, 2, 5, 500.00);

-- Venta
INSERT INTO Venta (NumFactura, IdPolirubro, IdCliente, Fecha, Total) VALUES 
('VEN-001', 1, 1, '2024-11-30', 1200.00),
('VEN-002', 2, 2, '2024-11-29', 2500.00);

-- VentaDetalle
INSERT INTO VentaDetalle (IdVenta, IdProducto, Cantidad, PrecioUnit) VALUES 
(1, 1, 1, 1200.00),
(2, 2, 5, 500.00);

-- Inventario
INSERT INTO Inventario (IdProducto, CantidadActual, CantidadMinima) VALUES 
(1, 20, 5),
(2, 10, 2);

-- PrecioVenta
INSERT INTO PrecioVenta (IdProducto, Precio, FechaInicio, FechaFin) VALUES 
(1, 1200.00, '2024-01-01', '2024-12-31'),
(2, 500.00, '2024-01-01', '2024-12-31');
