-- 1. Actualizar el inventario después de una venta
DELIMITER $$
CREATE TRIGGER after_venta_insert
AFTER INSERT ON Ventas
FOR EACH ROW
BEGIN
    UPDATE Inventarios
    SET cantidad = cantidad - NEW.cantidad
    WHERE producto_id = NEW.producto_id;
END $$
DELIMITER ;

-- Para probar
INSERT INTO Inventarios (producto_id, cantidad, fecha_actualizacion) VALUES (1, 100, CURDATE());
INSERT INTO Ventas (producto_id, cantidad, precio_unitario, fecha_venta, cliente_id) VALUES (1, 10, 50.00, CURDATE(), 1);
SELECT * FROM Inventarios WHERE producto_id = 1; 


-- 2. Registrar cambios en el salario de los empleados
DELIMITER $$
CREATE TRIGGER after_empleado_update
AFTER UPDATE ON Empleados
FOR EACH ROW
BEGIN
    IF OLD.salario <> NEW.salario THEN
        INSERT INTO Historial_Empleados (empleado_id, tipo_cambio, valor_anterior, valor_nuevo, fecha_cambio)
        VALUES (NEW.empleado_id, 'Salario', OLD.salario, NEW.salario, CURDATE());
    END IF;
END $$
DELIMITER ;

-- Para probar
UPDATE Empleados SET salario = 1200.00 WHERE empleado_id = 1;
SELECT * FROM Historial_Empleados WHERE empleado_id = 1;

-- 3. Mantener el estado de la maquinaria al registrar un mantenimiento
DELIMITER $$
CREATE TRIGGER after_mantenimiento_insert
AFTER INSERT ON Mantenimiento_Maquinaria
FOR EACH ROW
BEGIN
    UPDATE Maquinaria
    SET estado = 'En mantenimiento'
    WHERE maquinaria_id = NEW.maquinaria_id;
END $$
DELIMITER ;

-- Para probar
INSERT INTO Mantenimiento_Maquinaria (maquinaria_id, fecha_mantenimiento, tipo_mantenimiento, costo, descripcion) VALUES (1, CURDATE(), 'Revisión', 100.00, 'Revisión general');
SELECT * FROM Maquinaria WHERE maquinaria_id = 1; 


-- 4. Registrar auditoría de cambios en el inventario
DELIMITER $$
CREATE TRIGGER after_inventario_update
AFTER UPDATE ON Inventarios
FOR EACH ROW
BEGIN
    INSERT INTO Historial_Inventarios (inventario_id, tipo_cambio, cantidad_anterior, cantidad_nueva, fecha_cambio)
    VALUES (NEW.inventario_id, 'Ajuste', OLD.cantidad, NEW.cantidad, CURDATE());
END $$
DELIMITER ;

-- Para probar
UPDATE Inventarios SET cantidad = 50 WHERE inventario_id = 1;
SELECT * FROM Historial_Inventarios WHERE inventario_id = 1; 


-- 5. Auditar accesos de usuario
DELIMITER $$
CREATE TRIGGER after_usuario_insert
AFTER INSERT ON Usuarios
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria_Accessos (usuario_id, accion, fecha_hora)
    VALUES (NEW.usuario_id, 'Registro de Usuario', NOW());
END $$
DELIMITER ;

-- Para probar
INSERT INTO Usuarios (nombre_usuario, contrasena, rol_id) VALUES ('usuario_test', 'seguro123', 2);
SELECT * FROM Auditoria_Accessos WHERE usuario_id = (SELECT usuario_id FROM Usuarios WHERE nombre_usuario = 'usuario_test');

-- 6. Marcar como completadas las tareas finalizadas
DELIMITER $$
CREATE TRIGGER after_tarea_update
AFTER UPDATE ON Tareas
FOR EACH ROW
BEGIN
    IF NEW.estado = 'Completado' THEN
        UPDATE Tareas
        SET estado = 'Finalizado'
        WHERE tarea_id = NEW.tarea_id;
    END IF;
END $$
DELIMITER ;

-- Para probar
INSERT INTO Tareas (descripcion, fecha_inicio, fecha_fin, estado) VALUES ('Tarea de prueba', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 5 DAY), 'En progreso');
UPDATE Tareas SET estado = 'Completado' WHERE tarea_id = 1;
SELECT * FROM Tareas WHERE tarea_id = 1;


-- 7. Auditar accesos de usuario
DELIMITER $$
CREATE TRIGGER after_usuario_insert
AFTER INSERT ON Usuarios
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria_Accessos (usuario_id, accion, fecha_hora)
    VALUES (NEW.usuario_id, 'Registro de Usuario', NOW());
END $$
DELIMITER ;

-- Para probar
INSERT INTO Usuarios (nombre_usuario, contrasena, rol_id) VALUES ('usuario1', 'password123', 1);
SELECT * FROM Auditoria_Accessos WHERE usuario_id = (SELECT usuario_id FROM Usuarios WHERE nombre_usuario = 'usuario1');


-- 8. Actualizar automáticamente el inventario cuando se registre un nuevo producto
DELIMITER $$
CREATE TRIGGER after_producto_insert
AFTER INSERT ON Productos
FOR EACH ROW
BEGIN
    INSERT INTO Inventarios (producto_id, cantidad, fecha_actualizacion)
    VALUES (NEW.producto_id, 0, CURDATE());
END $$
DELIMITER ;

INSERT INTO Productos (nombre, tipo_producto, unidad_medida, descripcion) VALUES ('Naranja', 'Fruta', 'Kilo', 'Naranja dulce');
SELECT * FROM Inventarios WHERE producto_id = (SELECT producto_id FROM Productos WHERE nombre = 'Naranja' LIMIT 1);


-- 9. Prevenir que tareas se eliminen sin ser completadas
DELIMITER $$
CREATE TRIGGER before_tarea_delete
BEFORE DELETE ON Tareas
FOR EACH ROW
BEGIN
    IF OLD.estado <> 'Completada' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar la tarea, no está completada';
    END IF;
END $$
DELIMITER ;

-- Para probar
DELETE FROM Tareas WHERE tarea_id = 1; 

-- 10. Auditar cambios de calidad de los productos
DELIMITER $$
CREATE TRIGGER after_control_calidad_insert
AFTER INSERT ON Control_Calidad
FOR EACH ROW
BEGIN
    INSERT INTO Control_Calidad_Historial (producto_id, fecha_revision, resultado, observaciones)
    VALUES (NEW.producto_id, NEW.fecha_revision, NEW.resultado, NEW.observaciones);
END $$
DELIMITER ;

-- Para probar
INSERT INTO Control_Calidad (producto_id, fecha_revision, resultado, observaciones) VALUES (1, CURDATE(), 'Aprobado', 'Cumple con los estándares');
SELECT * FROM Control_Calidad WHERE producto_id = 1; 


-- 11. Restablecer estado de un empleado a inactivo
DELIMITER $$
CREATE TRIGGER after_pagos_empleado_insert
AFTER INSERT ON Pagos_Empleados
FOR EACH ROW
BEGIN
    UPDATE Empleados
    SET estado = 'Activo'
    WHERE empleado_id = NEW.empleado_id;
    
    UPDATE Empleados
    SET estado = 'Inactivo'
    WHERE empleado_id = NEW.empleado_id AND (CURDATE() - (SELECT MAX(fecha_pago) FROM Pagos_Empleados WHERE empleado_id = NEW.empleado_id)) > 60;
END $$
DELIMITER ;

-- Para probar
INSERT INTO Pagos_Empleados (empleado_id, monto, fecha_pago, metodo_pago) VALUES (1, 1000.00, CURDATE(), 'Transferencia'); 


-- 12. Incrementar la cantidad de productos después de una compra
DELIMITER $$
CREATE TRIGGER after_compra_insert
AFTER INSERT ON Compras
FOR EACH ROW
BEGIN
    UPDATE Inventarios
    SET cantidad = cantidad + NEW.cantidad
    WHERE producto_id = NEW.producto_id;
END $$
DELIMITER ;

-- Para probar
INSERT INTO Compras (producto_id, cantidad, precio_unitario, fecha_compra, proveedor_id) VALUES (1, 30, 20.00, CURDATE(), 1);
SELECT * FROM Inventarios WHERE producto_id = 1; 

-- 13. Prevenir que tareas se eliminen sin ser completadas
DELIMITER $$
CREATE TRIGGER before_tarea_delete
BEFORE DELETE ON Tareas
FOR EACH ROW
BEGIN
    IF OLD.estado <> 'Completada' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede eliminar la tarea, no está completada';
    END IF;
END $$
DELIMITER ;

-- Para probar
DELETE FROM Tareas WHERE tarea_id = 1; 

-- 14. Prevenir la venta de productos sin stock
DELIMITER $$
CREATE TRIGGER before_venta_insert
BEFORE INSERT ON Ventas
FOR EACH ROW
BEGIN
    DECLARE cantidad_actual INT;

    SELECT cantidad INTO cantidad_actual
    FROM Inventarios
    WHERE producto_id = NEW.producto_id;

    IF cantidad_actual < NEW.cantidad THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay suficiente stock para realizar la venta';
    END IF;
END $$
DELIMITER ;

- Para probar
INSERT INTO Inventarios (producto_id, cantidad, fecha_actualizacion) VALUES (2, 5, CURDATE());
INSERT INTO Ventas (producto_id, cantidad, precio_unitario, fecha_venta, cliente_id) VALUES (2, 10, 50.00, CURDATE(), 1); 

-- 15. Incrementar el contador de ventas en la tabla de Productos
DELIMITER $$
CREATE TRIGGER after_venta_insert
AFTER INSERT ON Ventas
FOR EACH ROW
BEGIN
    UPDATE Productos
    SET contador_ventas = contador_ventas + 1
    WHERE producto_id = NEW.producto_id;
END $$
DELIMITER ;

-- Para probar
INSERT INTO Productos (nombre, tipo_producto, unidad_medida, descripcion) VALUES ('Manzana', 'Fruta', 'Kilo', 'Manzana roja');
INSERT INTO Ventas (producto_id, cantidad, precio_unitario, fecha_venta, cliente_id) VALUES (1, 10, 30.00, CURDATE(), 1);
SELECT * FROM Productos WHERE producto_id = 1; 

-- 16. Registrar un pago a un empleado y actualizar su historial
DELIMITER $$
CREATE TRIGGER after_pago_empleado_insert
AFTER INSERT ON Pagos_Empleados
FOR EACH ROW
BEGIN
    INSERT INTO Historial_Empleados (empleado_id, tipo_cambio, valor_anterior, valor_nuevo, fecha_cambio)
    VALUES (NEW.empleado_id, 'Pago', 0, NEW.monto, CURDATE()); 
END $$
DELIMITER ;

-- Probar
INSERT INTO Pagos_Empleados (empleado_id, monto, fecha_pago, metodo_pago) VALUES (1, 300.00, CURDATE(), 'Transferencia');
SELECT * FROM Historial_Empleados WHERE empleado_id = 1; 


-- 17 Registrar historial de cambios de estado de las tareas
DELIMITER $$
CREATE TRIGGER after_tarea_update
AFTER UPDATE ON Tareas
FOR EACH ROW
BEGIN
    INSERT INTO Tareas (tarea_id, estado_anterior, estado_nuevo, fecha_cambio)
    VALUES (NEW.tarea_id, OLD.estado, NEW.estado, CURDATE());
END $$
DELIMITER ;

-- Probar
INSERT INTO Tareas (descripcion, fecha_inicio, fecha_fin, estado) VALUES ('Tarea de limpieza', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 DAY), 'Pendiente');
UPDATE Tareas SET estado = 'En Progreso' WHERE tarea_id = 1;
SELECT * FROM Tareas WHERE tarea_id = 1; 

-- 18. Almacenar el historial de precios de productos
DELIMITER $$
CREATE TRIGGER after_producto_update
AFTER UPDATE ON Productos
FOR EACH ROW
BEGIN
    IF OLD.precio_unitario <> NEW.precio_unitario THEN
        INSERT INTO Historial_Precio (producto_id, precio_anterior, precio_nuevo, fecha_cambio)
        VALUES (NEW.producto_id, OLD.precio_unitario, NEW.precio_unitario, CURDATE());
    END IF;
END $$
DELIMITER ;

-- Para probar
UPDATE Productos SET precio_unitario = 35.00 WHERE producto_id = 1;
SELECT * FROM Historial_Precio WHERE producto_id = 1; 


-- 19. Registrar un acceso de usuario
DELIMITER $$
CREATE TRIGGER after_usuario_insert
AFTER INSERT ON Usuarios
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria_Accessos (usuario_id, accion, fecha_hora)
    VALUES (NEW.usuario_id, 'Registro de Usuario', NOW());
END $$
DELIMITER ;

-- Para probar
INSERT INTO Usuarios (nombre_usuario, contrasena, rol_id) VALUES ('usuario_test', 'seguro123', 2);
SELECT * FROM Auditoria_Accessos WHERE usuario_id = (SELECT usuario_id FROM Usuarios WHERE nombre_usuario = 'usuario_test');


-- 20. Trigger para auditar cambios en el historial de inventarios:
DELIMITER //
CREATE TRIGGER after_costos_operativos_update
AFTER UPDATE ON Costos_Operativos
FOR EACH ROW
BEGIN
    INSERT INTO Costos_Operativos (tipo_costo, monto, fecha)
    VALUES (NEW.tipo_costo, NEW.monto, CURDATE());
END;
//
DELIMITER ;

UPDATE Costos_Operativos SET monto = 3000.00 WHERE costo_id = 1;
SELECT * FROM Costos_Operativos WHERE costo_id = 1;