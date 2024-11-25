1. Registrar un nuevo empleado
DELIMITER $$
CREATE PROCEDURE sp_registrar_empleado(
    IN p_nombre VARCHAR(100),
    IN p_apellido VARCHAR(100),
    IN p_telefono VARCHAR(15),
    IN p_direccion VARCHAR(150),
    IN p_puesto VARCHAR(100),
    IN p_salario DECIMAL(10, 2)
)
BEGIN
    INSERT INTO Empleados (nombre, apellido, telefono, direccion, puesto, salario)
    VALUES (p_nombre, p_apellido, p_telefono, p_direccion, p_puesto, p_salario);
END $$

DELIMITER ;

CALL sp_registrar_empleado('Juan', 'Perez', '123456789', 'Calle Finca 123', 'Agricultor', 1500.00);


2. Registrar un nuevo proveedor
DELIMITER $$
CREATE PROCEDURE sp_registrar_proveedor(
    IN p_nombre VARCHAR(100),
    IN p_telefono VARCHAR(15),
    IN p_correo VARCHAR(100),
    IN p_direccion VARCHAR(150)
)
BEGIN
    INSERT INTO Proveedores (nombre, telefono, correo, direccion)
    VALUES (p_nombre, p_telefono, p_correo, p_direccion);
END $$

DELIMITER ;

CALL sp_registrar_proveedor('Lucia', '987654321', 'lucia@gmail.com', 'Calle Proveedor 456');


3. Registrar una nueva maquinaria
DELIMITER $$
CREATE PROCEDURE sp_registrar_maquinaria(
    IN p_tipo VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_estado VARCHAR(50),
    IN p_fecha_adquisicion DATE
)
BEGIN
    INSERT INTO Maquinaria (tipo, descripcion, estado, fecha_adquisicion)
    VALUES (p_tipo, p_descripcion, p_estado, p_fecha_adquisicion);
END $$

DELIMITER ;

CALL sp_registrar_maquinaria('Tractor', 'Tractor de 100 hp', 'Operativo', '2024-01-15');


4. Actualizar el estado de una maquinaria
DELIMITER $$
CREATE PROCEDURE sp_actualizar_estado_maquinaria(
    IN p_id_maquinaria INT,
    IN p_estado VARCHAR(50)
)
BEGIN
    UPDATE Maquinaria
    SET estado = p_estado
    WHERE id_maquinaria = p_id_maquinaria;
END $$

DELIMITER ;

CALL sp_actualizar_estado_maquinaria(1, 'En mantenimiento');


5. Registrar un mantenimiento de maquinaria
DELIMITER $$
CREATE PROCEDURE sp_registrar_mantenimiento(
    IN p_id_maquinaria INT,
    IN p_id_empleado INT,
    IN p_fecha DATE,
    IN p_descripcion TEXT,
    IN p_costo DECIMAL(10, 2)
)
BEGIN
    INSERT INTO Mantenimiento (id_maquinaria, id_empleado, fecha, descripcion, costo)
    VALUES (p_id_maquinaria, p_id_empleado, p_fecha, p_descripcion, p_costo);
END $$

DELIMITER ;

CALL sp_registrar_mantenimiento(1, 1, '2024-11-24', 'Cambio de aceite y revisión general', 300.00);


6. Registrar una venta y actualizar inventarios
DELIMITER $$
CREATE PROCEDURE sp_procesar_venta(
    IN p_id_cliente INT,
    IN p_id_empleado INT,
    IN p_fecha DATE,
    IN p_id_producto INT,
    IN p_cantidad DECIMAL(10, 2),
    IN p_precio_unitario DECIMAL(10, 2)
)
BEGIN
    DECLARE total DECIMAL(10, 2);
    INSERT INTO Ventas (id_cliente, id_empleado, fecha, total) VALUES (p_id_cliente, p_id_empleado, p_fecha, 0);
    SET @id_venta = LAST_INSERT_ID();

    INSERT INTO DetalleVentas (id_venta, id_producto, cantidad, precio_unitario)
    VALUES (@id_venta, p_id_producto, p_cantidad, p_precio_unitario);

    UPDATE Inventario SET cantidad = cantidad - p_cantidad WHERE id_producto = p_id_producto;
    SET total = p_cantidad * p_precio_unitario;
    UPDATE Ventas SET total = total WHERE id_venta = @id_venta;
END $$
DELIMITER ;

CALL sp_procesar_venta(1, 1, '2024-11-24', 1, 10, 25.00);


7. Registrar una compra
DELIMITER $$
CREATE PROCEDURE sp_registrar_compra(
    IN p_id_proveedor INT,
    IN p_id_empleado INT,
    IN p_fecha DATE,
    IN p_id_producto INT,
    IN p_cantidad DECIMAL(10, 2),
    IN p_precio_unitario DECIMAL(10, 2)
)
BEGIN
    DECLARE total DECIMAL(10, 2);
    INSERT INTO Compras (id_proveedor, id_empleado, fecha, total) VALUES (p_id_proveedor, p_id_empleado, p_fecha, 0);
    SET @id_compra = LAST_INSERT_ID();

    INSERT INTO DetalleCompras (id_compra, id_producto, cantidad, precio_unitario)
    VALUES (@id_compra, p_id_producto, p_cantidad, p_precio_unitario);
    
    UPDATE Inventario SET cantidad = cantidad + p_cantidad WHERE id_producto = p_id_producto;
    SET total = p_cantidad * p_precio_unitario;
    UPDATE Compras SET total = total WHERE id_compra = @id_compra;
END $$

DELIMITER ;

CALL sp_registrar_compra(1, 1, '2024-11-24', 1, 20, 15.00);


8. Registrar una producción de productos
DELIMITER $$
CREATE PROCEDURE sp_registrar_produccion(
    IN p_id_producto INT,
    IN p_fecha DATE,
    IN p_cantidad DECIMAL(10, 2)
)
BEGIN
    INSERT INTO Produccion (id_producto, fecha, cantidad)
    VALUES (p_id_producto, p_fecha, p_cantidad);
END $$

DELIMITER ;

CALL sp_registrar_produccion(1, '2024-11-24', 100.00);


9. Actualizar inventario después de una producción
DELIMITER $$
CREATE PROCEDURE sp_actualizar_inventario_produccion(
    IN p_id_producto INT,
    IN p_cantidad DECIMAL(10, 2)
)
BEGIN
    UPDATE Inventario
    SET cantidad = cantidad + p_cantidad
    WHERE id_producto = p_id_producto;
END $$

DELIMITER ;

CALL sp_actualizar_inventario_produccion(1, 100.00);


10. Actualizar inventario después de una venta
DELIMITER $$
CREATE PROCEDURE sp_actualizar_inventario_venta(
    IN p_id_producto INT,
    IN p_cantidad DECIMAL(10, 2)
)
BEGIN
    UPDATE Inventario
    SET cantidad = cantidad - p_cantidad
    WHERE id_producto = p_id_producto;
END $$

DELIMITER ;

CALL sp_actualizar_inventario_venta(1, 10.00);


11. Obtener el total de ventas de un cliente
DELIMITER $$
CREATE PROCEDURE sp_total_ventas_cliente(
    IN p_id_cliente INT
)
BEGIN
    SELECT SUM(total) AS total_ventas
    FROM Ventas
    WHERE id_cliente = p_id_cliente;
END $$

DELIMITER ;

CALL sp_total_ventas_cliente(1);


12. Obtener el total de compras de un proveedor
DELIMITER $$
CREATE PROCEDURE sp_total_compras_proveedor(
    IN p_id_proveedor INT
)
BEGIN
    SELECT SUM(total) AS total_compras
    FROM Compras
    WHERE id_proveedor = p_id_proveedor;
END $$

DELIMITER ;

CALL sp_total_compras_proveedor(1);


13. Obtener inventario por producto
DELIMITER $$
CREATE PROCEDURE sp_inventario_por_producto(
    IN p_id_producto INT
)
BEGIN
    SELECT p.nombre, i.cantidad
    FROM Inventario i
    JOIN Productos p ON i.id_producto = p.id_producto
    WHERE i.id_producto = p_id_producto;
END $$

DELIMITER ;

CALL sp_inventario_por_producto(1);


14. Asignar tarea a un empleado
DELIMITER $$
CREATE PROCEDURE sp_asignar_tarea(
    IN p_id_empleado INT,
    IN p_descripcion TEXT,
    IN p_fecha_asignacion DATE,
    IN p_fecha_limite DATE,
    IN p_estado VARCHAR(50)
)
BEGIN
    INSERT INTO AsignacionTareas (id_empleado, descripcion, fecha_asignacion, fecha_limite, estado)
    VALUES (p_id_empleado, p_descripcion, p_fecha_asignacion, p_fecha_limite, p_estado);
END $$

DELIMITER ;
CALL sp_asignar_tarea(1, 'Revisión de maquinaria', '2024-11-24', '2024-12-01', 'Pendiente');


15. Actualizar estado de una tarea
DELIMITER $$
CREATE PROCEDURE sp_actualizar_estado_tarea(
    IN p_id_tarea INT,
    IN p_estado VARCHAR(50)
)
BEGIN
    UPDATE AsignacionTareas
    SET estado = p_estado
    WHERE id_tarea = p_id_tarea;
END $$

DELIMITER ;

CALL sp_actualizar_estado_tarea(1, 'Completada');


16. Generar reporte de ventas por fecha
DELIMITER $$
CREATE PROCEDURE sp_reporte_ventas_por_fecha(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    SELECT v.id_venta, v.fecha, v.total, c.nombre AS cliente, e.nombre AS empleado
    FROM Ventas v
    JOIN Clientes c ON v.id_cliente = c.id_cliente
    JOIN Empleados e ON v.id_empleado = e.id_empleado
    WHERE v.fecha BETWEEN p_fecha_inicio AND p_fecha_fin;
END $$

DELIMITER ;

CALL sp_reporte_ventas_por_fecha('2024-11-01', '2024-11-24');


17. Generar reporte de compras por proveedor
DELIMITER $$
CREATE PROCEDURE sp_reporte_compras_por_proveedor(
    IN p_id_proveedor INT
)
BEGIN
    SELECT c.id_compra, c.fecha, c.total, e.nombre AS empleado
    FROM Compras c
    JOIN Empleados e ON c.id_empleado = e.id_empleado
    WHERE c.id_proveedor = p_id_proveedor;
END $$

DELIMITER ;

CALL sp_reporte_compras_por_proveedor(1);


18. Eliminar un producto del inventario
DELIMITER $$
CREATE PROCEDURE sp_eliminar_producto_inventario(
    IN p_id_producto INT
)
BEGIN
    DELETE FROM Inventario
    WHERE id_producto = p_id_producto;
END $$

DELIMITER ;

CALL sp_eliminar_producto_inventario(1);


19. Actualizar precio de un producto
DELIMITER $$
CREATE PROCEDURE sp_actualizar_precio_producto(
    IN p_id_producto INT,
    IN p_precio DECIMAL(10, 2)
)
BEGIN
    UPDATE Productos
    SET precio = p_precio
    WHERE id_producto = p_id_producto;
END $$

DELIMITER ;
CALL sp_actualizar_precio_producto(2, 30.00);


20. Registrar una relación entre cliente y producto
DELIMITER $$
CREATE PROCEDURE sp_registrar_relacion_cliente_producto(
    IN p_id_cliente INT,
    IN p_id_producto INT
)
BEGIN
    INSERT INTO RelacionClientesProductos (id_cliente, id_producto)
    VALUES (p_id_cliente, p_id_producto);
END $$

DELIMITER ;

CALL sp_registrar_relacion_cliente_producto(1, 1);
