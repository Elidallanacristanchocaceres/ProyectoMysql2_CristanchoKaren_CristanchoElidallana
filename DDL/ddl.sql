CREATE DATABASE FincaAgricola;

USE FincaAgricola;

CREATE TABLE Empleados (

  id_empleado INT AUTO_INCREMENT PRIMARY KEY,

  nombre VARCHAR(100) NOT NULL,

  apellido VARCHAR(100) NOT NULL,

  telefono VARCHAR(15),

  direccion VARCHAR(150),

  puesto VARCHAR(100) NOT NULL,

  salario DECIMAL(10, 2) NOT NULL

);

CREATE TABLE Maquinaria (

  id_maquinaria INT AUTO_INCREMENT PRIMARY KEY,

  tipo VARCHAR(100) NOT NULL,

  descripcion TEXT,

  estado VARCHAR(50) NOT NULL,

  fecha_adquisicion DATE NOT NULL

);

CREATE TABLE Mantenimiento (

  id_mantenimiento INT AUTO_INCREMENT PRIMARY KEY,

  id_maquinaria INT NOT NULL,

  id_empleado INT NOT NULL,

  fecha DATE NOT NULL,

  descripcion TEXT,

  costo DECIMAL(10, 2) NOT NULL,

  CONSTRAINT fk_mantenimiento_maquinaria FOREIGN KEY (id_maquinaria) REFERENCES Maquinaria(id_maquinaria),

  CONSTRAINT fk_mantenimiento_empleado FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado)

);

CREATE TABLE Productos (

  id_producto INT AUTO_INCREMENT PRIMARY KEY,

  nombre VARCHAR(100) NOT NULL,

  tipo VARCHAR(50) NOT NULL,

  descripcion TEXT,

  precio DECIMAL(10, 2) NOT NULL,

  unidad_medida VARCHAR(50) NOT NULL

);

CREATE TABLE Inventario (

  id_inventario INT AUTO_INCREMENT PRIMARY KEY,

  id_producto INT NOT NULL,

  cantidad DECIMAL(10, 2) NOT NULL,

  fecha_actualizacion DATE NOT NULL,

  CONSTRAINT fk_inventario_producto FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)

);

CREATE TABLE Clientes (

  id_cliente INT AUTO_INCREMENT PRIMARY KEY,

  nombre VARCHAR(100) NOT NULL,

  telefono VARCHAR(15) NOT NULL,

  correo VARCHAR(100) NOT NULL,

  direccion VARCHAR(150) NOT NULL

);

CREATE TABLE Ventas (

  id_venta INT AUTO_INCREMENT PRIMARY KEY,

  id_cliente INT NOT NULL,

  id_empleado INT NOT NULL,

  fecha DATE NOT NULL,

  total DECIMAL(10, 2) NOT NULL,

  CONSTRAINT fk_ventas_cliente FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),

  CONSTRAINT fk_ventas_empleado FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado)

);

CREATE TABLE DetalleVentas (

  id_detalle INT AUTO_INCREMENT PRIMARY KEY,

  id_venta INT NOT NULL,

  id_producto INT NOT NULL,

  cantidad DECIMAL(10, 2) NOT NULL,

  precio_unitario DECIMAL(10, 2) NOT NULL,

  CONSTRAINT fk_detalleventas_venta FOREIGN KEY (id_venta) REFERENCES Ventas(id_venta),

  CONSTRAINT fk_detalleventas_producto FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)

);

CREATE TABLE Proveedores (

  id_proveedor INT AUTO_INCREMENT PRIMARY KEY,

  nombre VARCHAR(100) NOT NULL,

  telefono VARCHAR(15),

  correo VARCHAR(100),

  direccion VARCHAR(150)

);

CREATE TABLE Compras (

  id_compra INT AUTO_INCREMENT PRIMARY KEY,

  id_proveedor INT NOT NULL,

  id_empleado INT NOT NULL,

  fecha DATE NOT NULL,

  total DECIMAL(10, 2) NOT NULL,

  CONSTRAINT fk_compras_proveedor FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor),

  CONSTRAINT fk_compras_empleado FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado)

);

CREATE TABLE DetalleCompras (

  id_detalle INT AUTO_INCREMENT PRIMARY KEY,

  id_compra INT NOT NULL,

  id_producto INT NOT NULL,

  cantidad DECIMAL(10, 2) NOT NULL,

  precio_unitario DECIMAL(10, 2) NOT NULL,

  CONSTRAINT fk_detallecompras_compra FOREIGN KEY (id_compra) REFERENCES Compras(id_compra),

  CONSTRAINT fk_detallecompras_producto FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)

);

CREATE TABLE Produccion (

  id_produccion INT AUTO_INCREMENT PRIMARY KEY,

  id_producto INT NOT NULL,

  fecha DATE NOT NULL,

  cantidad DECIMAL(10, 2) NOT NULL,

  CONSTRAINT fk_produccion_producto FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)

);

CREATE TABLE RelacionProveedoresProductos (

  id_relacion INT AUTO_INCREMENT PRIMARY KEY,

  id_proveedor INT NOT NULL,

  id_producto INT NOT NULL,

  CONSTRAINT fk_relacionproveedores_proveedor FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor),

  CONSTRAINT fk_relacionproveedores_producto FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)

);

CREATE TABLE RelacionClientesProductos (

  id_relacion INT AUTO_INCREMENT PRIMARY KEY,

  id_cliente INT NOT NULL,

  id_producto INT NOT NULL,

  CONSTRAINT fk_relacionclientes_cliente FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),

  CONSTRAINT fk_relacionclientes_producto FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)

);

CREATE TABLE AsignacionTareas (

  id_tarea INT AUTO_INCREMENT PRIMARY KEY,

  id_empleado INT NOT NULL,

  descripcion TEXT NOT NULL,

  fecha_asignacion DATE NOT NULL,

  fecha_limite DATE,

  estado VARCHAR(50) NOT NULL,

  CONSTRAINT fk_asignaciontareas_empleado FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado)

);