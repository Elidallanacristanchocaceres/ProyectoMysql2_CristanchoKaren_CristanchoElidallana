-- 1. **RegistrarNuevaVenta**

DELIMITER $$

CREATE PROCEDURE RegistrarNuevaVenta(
    IN p_producto_id INT,
    IN p_cliente_id INT,
    IN p_cantidad INT,
    IN p_precio_unitario DECIMAL(10,2),
    IN p_fecha_venta DATE
)
BEGIN
    DECLARE p_cantidad_actual INT;

    SELECT cantidad INTO p_cantidad_actual
    FROM Inventarios
    WHERE producto_id = p_producto_id;

    IF p_cantidad_actual IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El producto no existe en el inventario';
    ELSEIF p_cantidad_actual < p_cantidad THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay suficiente cantidad en inventario';
    ELSE
        INSERT INTO Ventas (producto_id, cantidad, precio_unitario, fecha_venta, cliente_id)
        VALUES (p_producto_id, p_cantidad, p_precio_unitario, p_fecha_venta, p_cliente_id);

        UPDATE Inventarios
        SET cantidad = cantidad - p_cantidad, fecha_actualizacion = p_fecha_venta
        WHERE producto_id = p_producto_id;
    END IF;
END$$

DELIMITER ;

CALL RegistrarNuevaVenta(1, 30, 3, 19.70, '2024-03-06');

-- 2. **RegistrarNuevoProveedor**

DELIMITER $$

CREATE PROCEDURE RegistrarNuevoProveedor(
    IN p_nombre VARCHAR(100),
    IN p_direccion VARCHAR(200),
    IN p_telefono VARCHAR(15),
    IN p_email VARCHAR(100)
)
BEGIN

    INSERT INTO Proveedores (nombre, direccion, telefono, email)
    VALUES (p_nombre, p_direccion, p_telefono, p_email);
END$$

DELIMITER ;

CALL RegistrarNuevoProveedor('Lucia', 'Calle Ficticia 123', '555-1234', 'lucia@email.com');


-- 3. **RegistrarNuevoEmpleado**
DELIMITER $$

CREATE PROCEDURE RegistrarNuevoEmpleado(
    IN p_nombre VARCHAR(100),
    IN p_tipo_empleado VARCHAR(50),
    IN p_salario DECIMAL(10,2),
    IN p_fecha_ingreso DATE,
    IN p_estado VARCHAR(20)
)
BEGIN

    INSERT INTO Empleados (nombre, tipo_empleado, salario, fecha_ingreso, estado)
    VALUES (p_nombre, p_tipo_empleado, p_salario, p_fecha_ingreso, p_estado);
END$$
DELIMITER ;

CALL RegistrarNuevoEmpleado('Juan Pérez', 'Operador', 1200.00, '2024-11-01', 'Activo');


-- 4. **ActualizarEstadoMaquinaria**
DELIMITER $$

CREATE PROCEDURE ActualizarEstadoMaquinaria(
    IN p_maquinaria_id INT,
    IN p_estado VARCHAR(20)
)
BEGIN

    UPDATE Maquinaria
    SET estado = p_estado
    WHERE maquinaria_id = p_maquinaria_id;
END$$

DELIMITER ;

CALL ActualizarEstadoMaquinaria(1, 'En mantenimiento');


-- 5. **RegistrarMantenimientoMaquinaria**
DELIMITER $$

CREATE PROCEDURE RegistrarMantenimientoMaquinaria(
    IN p_maquinaria_id INT,
    IN p_fecha_mantenimiento DATE,
    IN p_tipo_mantenimiento VARCHAR(50),
    IN p_costo DECIMAL(10,2),
    IN p_descripcion TEXT
)
BEGIN

    INSERT INTO Mantenimiento_Maquinaria (maquinaria_id, fecha_mantenimiento, tipo_mantenimiento, costo, descripcion)
    VALUES (p_maquinaria_id, p_fecha_mantenimiento, p_tipo_mantenimiento, p_costo, p_descripcion);
    
    UPDATE Maquinaria
    SET estado = 'En mantenimiento'
    WHERE maquinaria_id = p_maquinaria_id;
END$$

DELIMITER ;

CALL RegistrarMantenimientoMaquinaria(1, '2024-11-25', 'Revisión general', 200.00, 'Cambio de aceite y revisión de partes');


-- 6. **ActualizarInventario**
DELIMITER $$

CREATE PROCEDURE ActualizarInventario(
    IN p_producto_id INT,
    IN p_cantidad INT,
    IN p_fecha_actualizacion DATE
)
BEGIN

    UPDATE Inventarios
    SET cantidad = cantidad + p_cantidad, fecha_actualizacion = p_fecha_actualizacion
    WHERE producto_id = p_producto_id;

    IF ROW_COUNT() = 0 THEN
        INSERT INTO Inventarios (producto_id, cantidad, fecha_actualizacion)
        VALUES (p_producto_id, p_cantidad, p_fecha_actualizacion);
    END IF;
END$$

DELIMITER ;

CALL ActualizarInventario(1, 50, '2024-11-26');


-- 7. **RegistrarNuevaCompra**
DELIMITER $$

CREATE PROCEDURE RegistrarNuevaCompra(
    IN p_producto_id INT,
    IN p_proveedor_id INT,
    IN p_cantidad INT,
    IN p_precio_unitario DECIMAL(10,2),
    IN p_fecha_compra DATE
)
BEGIN

    INSERT INTO Compras (producto_id, cantidad, precio_unitario, fecha_compra, proveedor_id)
    VALUES (p_producto_id, p_cantidad, p_precio_unitario, p_fecha_compra, p_proveedor_id);
    

    CALL ActualizarInventario(p_producto_id, p_cantidad, p_fecha_compra);
END$$

DELIMITER ;

CALL RegistrarNuevaCompra(1, 1, 100, 45.00, '2024-11-25');


-- 8. **ActualizarEstadoTarea**
DELIMITER $$

CREATE PROCEDURE ActualizarEstadoTarea(
    IN p_tarea_id INT,
    IN p_estado VARCHAR(20)
)
BEGIN

    UPDATE Tareas
    SET estado = p_estado
    WHERE tarea_id = p_tarea_id;
END$$

DELIMITER ;

CALL ActualizarEstadoTarea(1, 'Completado');


-- 9. **RegistrarNuevaTarea**
DELIMITER $$

CREATE PROCEDURE RegistrarNuevaTarea(
    IN p_descripcion TEXT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE,
    IN p_estado VARCHAR(20)
)
BEGIN

    INSERT INTO Tareas (descripcion, fecha_inicio, fecha_fin, estado)
    VALUES (p_descripcion, p_fecha_inicio, p_fecha_fin, p_estado);
END$$

DELIMITER ;

CALL RegistrarNuevaTarea('Revisión de maquinaria', '2024-11-25', '2024-11-30', 'Pendiente');


-- 10. **RegistrarHistorialCambioEmpleado**
DELIMITER $$

CREATE PROCEDURE RegistrarHistorialCambioEmpleado(
    IN p_empleado_id INT,
    IN p_tipo_cambio VARCHAR(50),
    IN p_valor_anterior DECIMAL(10,2),
    IN p_valor_nuevo DECIMAL(10,2),
    IN p_fecha_cambio DATE
)
BEGIN

    INSERT INTO Historial_Empleados (empleado_id, tipo_cambio, valor_anterior, valor_nuevo, fecha_cambio)
    VALUES (p_empleado_id, p_tipo_cambio, p_valor_anterior, p_valor_nuevo, p_fecha_cambio);
END$$

DELIMITER ;

CALL RegistrarHistorialCambioEmpleado(1, 'Salario', 1200.00, 1300.00, '2024-11-26');


-- 11. **RegistrarHistorialCambioInventario**
DELIMITER $$

CREATE PROCEDURE RegistrarHistorialCambioInventario(
    IN p_inventario_id INT,
    IN p_tipo_cambio VARCHAR(50),
    IN p_cantidad_anterior INT,
    IN p_cantidad_nueva INT,
    IN p_fecha_cambio DATE
)
BEGIN

    INSERT INTO Historial_Inventarios (inventario_id, tipo_cambio, cantidad_anterior, cantidad_nueva, fecha_cambio)
    VALUES (p_inventario_id, p_tipo_cambio, p_cantidad_anterior, p_cantidad_nueva, p_fecha_cambio);
END$$

DELIMITER ;

CALL RegistrarHistorialCambioInventario(1, 'Ajuste por error', 50, 60, '2024-11-26');


-- 12. **ActualizarEstadoCultivo**
DELIMITER $$

CREATE PROCEDURE ActualizarRendimientoCultivo(
    IN p_cultivo_id INT,
    IN p_nuevo_rendimiento DECIMAL(10, 2)
)
BEGIN
    UPDATE Cultivos
    SET rendimiento_promedio = p_nuevo_rendimiento
    WHERE cultivo_id = p_cultivo_id;
END$$

DELIMITER ;

CALL ActualizarRendimientoCultivo(1, 9.00);


-- 13. **RegistrarControlCalidad**
DELIMITER $$

CREATE PROCEDURE RegistrarControlCalidad(
    IN p_producto_id INT,
    IN p_fecha_revision DATE,
    IN p_resultado VARCHAR(50),
    IN p_observaciones TEXT
)
BEGIN
    INSERT INTO Control_Calidad (producto_id, fecha_revision, resultado, observaciones)
    VALUES (p_producto_id, p_fecha_revision, p_resultado, p_observaciones);
END$$

DELIMITER ;

CALL RegistrarControlCalidad(1, '2024-11-25', 'Aprobado', 'El producto cumple con los estándares de calidad');


-- 14. **RegistrarCosecha**
DELIMITER $$

CREATE PROCEDURE RegistrarCosecha(
    IN p_cultivo_id INT,
    IN p_cantidad DECIMAL(10,2),
    IN p_fecha_cosecha DATE,
    IN p_calidad_control VARCHAR(50),
    IN p_destino VARCHAR(100)
)
BEGIN
    IF p_calidad_control IS NULL THEN
        SET p_calidad_control = 'Sin control';
    END IF;

    INSERT INTO Cosecha (cultivo_id, cantidad_recolectada, fecha_cosecha, calidad_control, destino)
    VALUES (p_cultivo_id, p_cantidad, p_fecha_cosecha, p_calidad_control, p_destino);
END$$

DELIMITER ;

CALL RegistrarCosecha(1, 100, '2024-11-26', NULL, 'Mercado Local');


-- 15. **ActualizarFechaProducto**
DELIMITER $$

CREATE PROCEDURE ActualizarFechaActualizacionProducto(
    IN p_producto_id INT,
    IN p_nueva_fecha_actualizacion DATE
)
BEGIN
    UPDATE Inventarios
    SET fecha_actualizacion = p_nueva_fecha_actualizacion
    WHERE producto_id = p_producto_id;
END$$

DELIMITER ;

CALL ActualizarFechaActualizacionProducto(1, '2025-11-26');


-- 16. **RegistrarPagoProveedor**
DELIMITER $$

CREATE PROCEDURE RegistrarPagoProveedor(
    IN p_proveedor_id INT,
    IN p_monto DECIMAL(10,2),
    IN p_fecha_pago DATE
)
BEGIN

    INSERT INTO Pagos_Proveedores (proveedor_id, monto, fecha_pago)
    VALUES (p_proveedor_id, p_monto, p_fecha_pago);
END$$

DELIMITER ;

CALL RegistrarPagoProveedor(1, 500.00, '2024-11-26');


-- 17. **RegistrarIngresoEmpleado**
DELIMITER $$

CREATE PROCEDURE RegistrarIngresoEmpleado(
    IN p_empleado_id INT,
    IN p_fecha_ingreso DATE
)
BEGIN

    UPDATE Empleados
    SET fecha_ingreso = p_fecha_ingreso
    WHERE empleado_id = p_empleado_id;
END$$

DELIMITER ;

CALL RegistrarIngresoEmpleado(1, '2024-11-01');


-- 18. **Manejar la devolución de ventas**
DELIMITER $$

CREATE PROCEDURE RegistrarDevolucionVenta(
    IN p_venta_id INT,
    IN p_producto_id INT,
    IN p_cantidad_devuelta INT,
    IN p_fecha_devolucion DATE
)
BEGIN
    DECLARE v_precio_unitario DECIMAL(10,2);
    DECLARE v_cantidad_original INT;

    SELECT precio_unitario, cantidad
    INTO v_precio_unitario, v_cantidad_original
    FROM Ventas
    WHERE venta_id = p_venta_id AND producto_id = p_producto_id;

    IF p_cantidad_devuelta <= v_cantidad_original THEN

        UPDATE Inventarios
        SET cantidad = cantidad + p_cantidad_devuelta
        WHERE producto_id = p_producto_id;

        UPDATE Ventas
        SET cantidad = cantidad - p_cantidad_devuelta
        WHERE venta_id = p_venta_id AND producto_id = p_producto_id;


        INSERT INTO Devoluciones (venta_id, producto_id, cantidad_devuelta, fecha_devolucion)
        VALUES (p_venta_id, p_producto_id, p_cantidad_devuelta, p_fecha_devolucion);
    ELSE

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La cantidad devuelta no puede ser mayor que la cantidad original de la venta';
    END IF;
END $$

DELIMITER ;

CALL RegistrarDevolucionVenta(1, 10, 2, '2024-11-26');


-- 19. **GenerarInformeVentas**
DELIMITER $$
CREATE PROCEDURE GenerarInformeVentas(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    SELECT * FROM Ventas
    WHERE fecha_venta BETWEEN p_fecha_inicio AND p_fecha_fin;
END$$
DELIMITER ;
CALL GenerarInformeVentas('2024-01-15', '2024-03-06');


-- 20. **GenerarInformeMantenimiento**
DELIMITER $$
CREATE PROCEDURE GenerarInformeMantenimiento(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    SELECT * FROM Mantenimiento_Maquinaria
    WHERE fecha_mantenimiento BETWEEN p_fecha_inicio AND p_fecha_fin;
END$$
DELIMITER ;
CALL GenerarInformeMantenimiento('2024-11-01', '2024-11-26');

