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