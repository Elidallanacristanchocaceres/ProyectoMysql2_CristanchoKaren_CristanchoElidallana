1. Calcular el rendimiento promedio por hectárea de cada cultivo
DELIMITER $$
CREATE FUNCTION CalcularRendimientoPromedio(cultivo_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE rendimiento_promedio DECIMAL(10,2);

    SELECT AVG(rendimiento) INTO rendimiento_promedio
    FROM Rendimiento_Cultivo
    WHERE cultivo_id = cultivo_id;

    RETURN rendimiento_promedio;
END $$

DELIMITER ;

SELECT CalcularRendimientoPromedio(1);


2. Estimar el costo operativo total de la finca en un período de tiempo determinado
DELIMITER $$
CREATE FUNCTION CostoOperativoTotal(fecha_inicio DATE, fecha_fin DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_costo DECIMAL(10,2);

    SELECT COALESCE(SUM(monto), 0) INTO total_costo
    FROM Costos_Operativos
    WHERE fecha BETWEEN fecha_inicio AND fecha_fin;

    RETURN total_costo;
END $$

DELIMITER ;

SELECT CostoOperativoTotal('2024-01-15', '2024-05-05');


3. Calcular el total de ventas por cliente
DELIMITER $$
CREATE FUNCTION TotalVentasPorCliente(cliente_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_ventas DECIMAL(10,2);

    SELECT COALESCE(SUM(cantidad * precio_unitario), 0) INTO total_ventas
    FROM Ventas
    WHERE cliente_id = cliente_id;

    RETURN total_ventas;
END $$

DELIMITER ;

SELECT TotalVentasPorCliente(1); 


4. Calcular el total de compras por proveedor
DELIMITER $$
CREATE FUNCTION TotalComprasPorProveedor(proveedor_id INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE total_compras DECIMAL(10,2);
    
    SELECT SUM(cantidad * precio_unitario) INTO total_compras
    FROM Compras
    WHERE proveedor_id = proveedor_id;
    
    RETURN total_compras;
END $$

DELIMITER ;
SELECT TotalComprasPorProveedor(1);


5. Obtener el salario promedio de los empleados
DELIMITER $$
CREATE FUNCTION SalarioPromedio() 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    
    SELECT AVG(salario) INTO promedio
    FROM Empleados;
    
    RETURN promedio;
END $$

DELIMITER ;

SELECT SalarioPromedio();


6. Calcular el total de inventario de un producto
DELIMITER $$
CREATE FUNCTION TotalInventarioPorProducto(producto_id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_inventario INT;
    
    SELECT SUM(cantidad) INTO total_inventario
    FROM Inventarios
    WHERE producto_id = producto_id;
    
    RETURN total_inventario;
END $$

DELIMITER ;

SELECT TotalInventarioPorProducto(1);


7. Calcular el costo total de mantenimiento de maquinaria
DELIMITER $$
CREATE FUNCTION CostoTotalMantenimiento(maquinaria_id INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_mantenimiento DECIMAL(10,2);
    
    SELECT SUM(costo) INTO total_mantenimiento
    FROM Mantenimiento_Maquinaria
    WHERE maquinaria_id = maquinaria_id;
    
    RETURN total_mantenimiento;
END $$

DELIMITER ;

SELECT CostoTotalMantenimiento(1);


8. Contar el número de tareas pendientes
DELIMITER $$
CREATE FUNCTION ContarTareasPendientes() 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_tareas INT;
    
    SELECT COUNT(*) INTO total_tareas
    FROM Tareas
    WHERE estado = 'Pendiente';
    
    RETURN total_tareas;
END $$

DELIMITER ;

SELECT ContarTareasPendientes();


9. Obtener el porcentaje de calidad de un producto
DELIMITER $$
CREATE FUNCTION PorcentajeCalidadProducto(producto_id INT) 
RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE total_revisiones INT;
    DECLARE total_aprobadas INT;
    DECLARE porcentaje DECIMAL(5,2);
    
    SELECT COUNT(*) INTO total_revisiones
    FROM Control_Calidad
    WHERE producto_id = producto_id;
    
    SELECT COUNT(*) INTO total_aprobadas
    FROM Control_Calidad
    WHERE producto_id = producto_id AND resultado = 'Aprobado';
    
    SET porcentaje = (total_aprobadas / total_revisiones) * 100;
    
    RETURN porcentaje;
END $$

DELIMITER ;

SELECT PorcentajeCalidadProducto(1);

10. Calcular el total de pagos a empleados en un período
DELIMITER $$
CREATE FUNCTION TotalPagosEmpleados(fecha_inicio DATE, fecha_fin DATE) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_pagos DECIMAL(10,2);
    
    SELECT SUM(monto) INTO total_pagos
    FROM Pagos_Empleados
    WHERE fecha_pago BETWEEN fecha_inicio AND fecha_fin;
    
    RETURN total_pagos;
END $$

DELIMITER ;

SELECT TotalPagosEmpleados('2024-01-15', '2024-05-10');

11. Obtener el rendimiento promedio de un cultivo

DELIMITER //
CREATE FUNCTION RendimientoPromedioCultivo(cultivo_id INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    
    SELECT AVG(rendimiento) INTO promedio
    FROM Rendimiento_Cultivo
    WHERE cultivo_id = cultivo_id;
    
    RETURN promedio;
END //

DELIMITER ;

SELECT RendimientoPromedioCultivo(1); 


12. Calcular el total de pagos a proveedores en un período

DELIMITER //
CREATE FUNCTION TotalPagosProveedores(fecha_inicio DATE, fecha_fin DATE) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_pagos DECIMAL(10,2);
    
    SELECT SUM(monto) INTO total_pagos
    FROM Pagos_Proveedores
    WHERE fecha_pago BETWEEN fecha_inicio AND fecha_fin;
    
    RETURN total_pagos;
END //

DELIMITER ;

SELECT TotalPagosProveedores('2024-01-15', '2024-05-10');


13. Calcular el costo promedio por hectárea de un cultivo

DELIMITER //
CREATE FUNCTION CostoPromedioPorHectarea(cultivo_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE costo_total DECIMAL(10,2);
    DECLARE hectareas INT;

    SELECT COALESCE(SUM(monto), 0) INTO costo_total
    FROM Costos_Produccion
    WHERE cultivo_id = cultivo_id;

    SELECT COALESCE(SUM(hectareas), 0) INTO hectareas
    FROM Cultivos
    WHERE cultivo_id = cultivo_id;

    IF hectareas = 0 THEN
        RETURN 0;
    END IF;
END //

DELIMITER ;

SELECT CostoPromedioPorHectarea(1);


14. Obtener el total de tareas de mantenimiento programadas

DELIMITER //
CREATE FUNCTION TotalTareasMantenimientoProgramadas(maquinaria_id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_tareas INT;
    
    SELECT COUNT(*) INTO total_tareas
    FROM Tareas_Mantenimiento
    WHERE maquinaria_id = maquinaria_id AND estado = 'Programada';
    
    RETURN total_tareas;
END //

DELIMITER ;

SELECT TotalTareasMantenimientoProgramadas(1);


15. Calcular el total de cosechas realizadas de un cultivo

DELIMITER //
CREATE FUNCTION TotalCosechasRealizadas(cultivo_id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_cosechas INT;
    
    SELECT COUNT(*) INTO total_cosechas
    FROM Cosecha
    WHERE cultivo_id = cultivo_id;
    
    RETURN total_cosechas;
END //

DELIMITER ;

SELECT TotalCosechasRealizadas(1);


16. Calcular el total de empleados activos

DELIMITER //
CREATE FUNCTION TotalEmpleadosActivos() 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_empleados INT;
    
    SELECT COUNT(*) INTO total_empleados
    FROM Empleados
    WHERE estado = 'Activo';
    
    RETURN total_empleados;
END //

DELIMITER ;

SELECT TotalEmpleadosActivos();


17. Obtener el total de ingresos por ventas en un período

DELIMITER //
CREATE FUNCTION TotalIngresosPorVentas(fecha_inicio DATE, fecha_fin DATE) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_ingresos DECIMAL(10,2);
    
    SELECT SUM(cantidad * precio_unitario) INTO total_ingresos
    FROM Ventas
    WHERE fecha_venta BETWEEN fecha_inicio AND fecha_fin;
    
    RETURN total_ingresos;
END //

DELIMITER ;

SELECT TotalIngresosPorVentas('2024-01-15', '2024-03-06');


18. Calcular el promedio de puntuaciones de evaluación de un empleado

DELIMITER //
CREATE FUNCTION PromedioEvaluacionesEmpleado(empleado_id INT) 
RETURNS DECIMAL(3,1)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(3,1);
    
    SELECT AVG(puntuacion) INTO promedio
    FROM Evaluacion_Desempeno
    WHERE empleado_id = empleado_id;
    
    RETURN promedio;
END //

DELIMITER ;

SELECT PromedioEvaluacionesEmpleado(1);


19. Obtener el total de maquinaria en un estado específico

DELIMITER //
CREATE FUNCTION TotalMaquinariaPorEstado(estado_maquinaria VARCHAR(20)) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_maquinaria INT;
    
    SELECT COUNT(*) INTO total_maquinaria
    FROM Maquinaria
    WHERE estado = estado_maquinaria;
    
    RETURN total_maquinaria;
END //

DELIMITER ;

SELECT TotalMaquinariaPorEstado('Operativa');



20. Calcular el costo total de producción de un cultivo

DELIMITER //
CREATE FUNCTION CostoTotalProduccion(cultivo_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE costo_total DECIMAL(10,2);

    SELECT COALESCE(SUM(monto), 0) INTO costo_total
    FROM Costos_Produccion
    WHERE cultivo_id = cultivo_id;

    RETURN costo_total;
END //

DELIMITER ;

SELECT CostoTotalProduccion(1);

