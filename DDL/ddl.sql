CREATE DATABASE Finca_Agricola;
USE Finca_Agricola;

CREATE TABLE Proveedores (

  proveedor_id INT AUTO_INCREMENT PRIMARY KEY,

  nombre VARCHAR(100),

  direccion VARCHAR(200),

  telefono VARCHAR(15),

  email VARCHAR(100)

);

CREATE TABLE Productos (

  producto_id INT AUTO_INCREMENT PRIMARY KEY,

  nombre VARCHAR(100) NOT NULL,

  tipo_producto VARCHAR(50),

  unidad_medida VARCHAR(20),

  descripcion TEXT

);

CREATE TABLE Clientes (

  cliente_id INT AUTO_INCREMENT PRIMARY KEY,

  nombre VARCHAR(100),

  direccion VARCHAR(200),

  telefono VARCHAR(15),

  email VARCHAR(100)

);

CREATE TABLE Empleados (

  empleado_id INT AUTO_INCREMENT PRIMARY KEY,

  nombre VARCHAR(100),

  tipo_empleado VARCHAR(50),

  salario DECIMAL(10,2),

  fecha_ingreso DATE,

  estado VARCHAR(20)

);

CREATE TABLE Maquinaria (

  maquinaria_id INT AUTO_INCREMENT PRIMARY KEY,

  nombre VARCHAR(100),

  tipo_maquinaria VARCHAR(50),

  estado VARCHAR(20),

  fecha_adquisicion DATE,

  fecha_ultimo_mantenimiento DATE

);

CREATE TABLE Tareas (

  tarea_id INT AUTO_INCREMENT PRIMARY KEY,

  descripcion TEXT,

  fecha_inicio DATE,

  fecha_fin DATE,

  estado VARCHAR(20)

);

CREATE TABLE Cultivos (

  cultivo_id INT AUTO_INCREMENT PRIMARY KEY,

  producto_id INT,

  fecha_siembra DATE,

  fecha_cosecha DATE,

  hectareas INT,

  rendimiento_promedio DECIMAL(10,2),

  FOREIGN KEY (producto_id) REFERENCES Productos(producto_id)

);

CREATE TABLE Inventarios (

  inventario_id INT AUTO_INCREMENT PRIMARY KEY,

  producto_id INT,

  cantidad INT,

  fecha_actualizacion DATE,

  FOREIGN KEY (producto_id) REFERENCES Productos(producto_id)

);

CREATE TABLE Ventas (

  venta_id INT AUTO_INCREMENT PRIMARY KEY,

  producto_id INT,

  cantidad INT,

  precio_unitario DECIMAL(10,2),

  fecha_venta DATE,

  cliente_id INT,

  FOREIGN KEY (producto_id) REFERENCES Productos(producto_id),

  FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id)

);

CREATE TABLE Compras (

  compra_id INT AUTO_INCREMENT PRIMARY KEY,

  producto_id INT,

  cantidad INT,

  precio_unitario DECIMAL(10,2),

  fecha_compra DATE,

  proveedor_id INT,

  FOREIGN KEY (producto_id) REFERENCES Productos(producto_id),

  FOREIGN KEY (proveedor_id) REFERENCES Proveedores(proveedor_id)

);

CREATE TABLE Historial_Empleados (

  historial_id INT AUTO_INCREMENT PRIMARY KEY,

  empleado_id INT,

  tipo_cambio VARCHAR(50),

  valor_anterior DECIMAL(10,2),

  valor_nuevo DECIMAL(10,2),

  fecha_cambio DATE,

  FOREIGN KEY (empleado_id) REFERENCES Empleados(empleado_id)

);

CREATE TABLE Asignacion_Maquinaria (

  asignacion_id INT AUTO_INCREMENT PRIMARY KEY,

  maquinaria_id INT,

  tarea_id INT,

  fecha_inicio DATE,

  fecha_fin DATE,

  estado VARCHAR(20),
    
  empleado_id INT,
    
  FOREIGN KEY (empleado_id) REFERENCES Empleados(empleado_id),

  FOREIGN KEY (maquinaria_id) REFERENCES Maquinaria(maquinaria_id),

  FOREIGN KEY (tarea_id) REFERENCES Tareas(tarea_id)

);

CREATE TABLE Mantenimiento_Maquinaria (

  mantenimiento_id INT AUTO_INCREMENT PRIMARY KEY,

  maquinaria_id INT,

  fecha_mantenimiento DATE,

  tipo_mantenimiento VARCHAR(50),

  costo DECIMAL(10,2),

  descripcion TEXT,

  FOREIGN KEY (maquinaria_id) REFERENCES Maquinaria(maquinaria_id)

);

CREATE TABLE Costos_Operativos (

  costo_id INT AUTO_INCREMENT PRIMARY KEY,

  tipo_costo VARCHAR(50),

  monto DECIMAL(10,2),

  fecha DATE

);

CREATE TABLE Pagos_Proveedores (

  pago_id INT AUTO_INCREMENT PRIMARY KEY,

  proveedor_id INT,

  monto DECIMAL(10,2),

  fecha_pago DATE,

  metodo_pago VARCHAR(50),

  FOREIGN KEY (proveedor_id) REFERENCES Proveedores(proveedor_id)

);

CREATE TABLE Pagos_Empleados (

  pago_id INT AUTO_INCREMENT PRIMARY KEY,

  empleado_id INT,

  monto DECIMAL(10,2),

  fecha_pago DATE,

  metodo_pago VARCHAR(50),

  FOREIGN KEY (empleado_id) REFERENCES Empleados(empleado_id)

);

CREATE TABLE Roles (

  rol_id INT AUTO_INCREMENT PRIMARY KEY,

  nombre_rol VARCHAR(50),

  descripcion TEXT

);

CREATE TABLE Usuarios (

  usuario_id INT AUTO_INCREMENT PRIMARY KEY,

  nombre_usuario VARCHAR(50),

  contrasena VARCHAR(255),

  rol_id INT,

  FOREIGN KEY (rol_id) REFERENCES Roles(rol_id)

);

CREATE TABLE Auditoria_Accessos (

  auditoria_id INT AUTO_INCREMENT PRIMARY KEY,

  usuario_id INT,

  accion VARCHAR(100),

  fecha_hora TIMESTAMP,

  detalles TEXT,

  FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)

);

CREATE TABLE Historial_Ventas (

  historial_id INT AUTO_INCREMENT PRIMARY KEY,

  venta_id INT,

  tipo_cambio VARCHAR(50),

  valor_anterior DECIMAL(10,2),

  valor_nuevo DECIMAL(10,2),

  fecha_cambio DATE,

  FOREIGN KEY (venta_id) REFERENCES Ventas(venta_id)

);

CREATE TABLE Historial_Inventarios (

  historial_id INT AUTO_INCREMENT PRIMARY KEY,

  inventario_id INT,

  tipo_cambio VARCHAR(50),

  cantidad_anterior INT,

  cantidad_nueva INT,

  fecha_cambio DATE,

  FOREIGN KEY (inventario_id) REFERENCES Inventarios(inventario_id)

);

CREATE TABLE Control_Calidad (

  calidad_id INT AUTO_INCREMENT PRIMARY KEY,

  producto_id INT,

  fecha_revision DATE,

  resultado VARCHAR(50),

  observaciones TEXT,

  FOREIGN KEY (producto_id) REFERENCES Productos(producto_id)

);

CREATE TABLE Rendimiento_Cultivo (

  rendimiento_id INT AUTO_INCREMENT PRIMARY KEY,

  cultivo_id INT,

  rendimiento DECIMAL(10,2),

  fecha_calculo DATE,

  FOREIGN KEY (cultivo_id) REFERENCES Cultivos(cultivo_id)

);

CREATE TABLE Ubicacion_Cultivo (

  ubicacion_id INT AUTO_INCREMENT PRIMARY KEY,

  cultivo_id INT,

  zona VARCHAR(100),

  hectareas INT,

  FOREIGN KEY (cultivo_id) REFERENCES Cultivos(cultivo_id)

);

CREATE TABLE Tareas_Mantenimiento (

  tarea_mantenimiento_id INT AUTO_INCREMENT PRIMARY KEY,

  maquinaria_id INT,

  descripcion TEXT,

  frecuencia VARCHAR(50),

  fecha_programada DATE,

  fecha_realizada DATE,

  estado VARCHAR(20),

  FOREIGN KEY (maquinaria_id) REFERENCES Maquinaria(maquinaria_id)

);

CREATE TABLE Evaluacion_Desempeno (

  evaluacion_id INT AUTO_INCREMENT PRIMARY KEY,

  empleado_id INT,

  fecha_evaluacion DATE,

  puntuacion DECIMAL(3,1),

  comentarios TEXT,

  FOREIGN KEY (empleado_id) REFERENCES Empleados(empleado_id)

);

CREATE TABLE Cosecha (

  cosecha_id INT AUTO_INCREMENT PRIMARY KEY,

  cultivo_id INT,

  cantidad_recolectada DECIMAL(10,2),

  fecha_cosecha DATE,

  calidad_control VARCHAR(50),

  destino VARCHAR(100),

  FOREIGN KEY (cultivo_id) REFERENCES Cultivos(cultivo_id)

);

CREATE TABLE Costos_Produccion (

  costo_produccion_id INT AUTO_INCREMENT PRIMARY KEY,

  cultivo_id INT,

  tipo_costo VARCHAR(50),

  monto DECIMAL(10,2),

  fecha DATE,

  FOREIGN KEY (cultivo_id) REFERENCES Cultivos(cultivo_id)

);

CREATE TABLE Pagos_Vendedores (

  pago_vendedor_id INT AUTO_INCREMENT PRIMARY KEY,

  vendedor_id INT,

  monto DECIMAL(10,2),

  fecha_pago DATE,

  metodo_pago VARCHAR(50),

  FOREIGN KEY (vendedor_id) REFERENCES Empleados(empleado_id)

);