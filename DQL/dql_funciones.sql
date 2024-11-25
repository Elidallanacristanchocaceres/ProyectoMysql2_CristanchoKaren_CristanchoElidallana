### **1. Costo total de mantenimiento de una máquina**

DELIMITER $$

CREATE FUNCTION CostoTotalMantenimiento(id_maquina INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(costo) INTO total
    FROM Mantenimiento
    WHERE id_maquinaria = id_maquina;
    RETURN COALESCE(total, 0);
END $$

DELIMITER ;


Probar
SELECT CostoTotalMantenimiento(1);



### *2. Número de tareas asignadas a un empleado*

DELIMITER $$

CREATE FUNCTION TareasAsignadasEmpleado(id_empleado INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM AsignacionTareas
    WHERE id_empleado = id_empleado;
    RETURN total;
END $$

DELIMITER ;

Probar 
SELECT TareasAsignadasEmpleado(2);



### **3. Total de ventas realizadas por un empleado**

DELIMITER $$

CREATE FUNCTION VentasPorEmpleado(id_empleado INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(total) INTO total
    FROM Ventas
    WHERE id_empleado = id_empleado;
    RETURN COALESCE(total, 0);
END $$

DELIMITER ;


Probar
SELECT VentasPorEmpleado(3);



### **4. Cantidad total de productos vendidos en una venta**

DELIMITER $$

CREATE FUNCTION CantidadProductosVendidos(id_venta INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE cantidad_total DECIMAL(10,2);
    SELECT SUM(cantidad) INTO cantidad_total
    FROM DetalleVentas
    WHERE id_venta = id_venta;
    RETURN COALESCE(cantidad_total, 0);
END $$

DELIMITER ;


Probar
SELECT CantidadProductosVendidos(5);



### **5. Promedio de salario de los empleados**

DELIMITER $$

CREATE FUNCTION SalarioPromedio()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT AVG(salario) INTO promedio
    FROM Empleados;
    RETURN COALESCE(promedio, 0);
END $$

DELIMITER ;


Probar
SELECT SalarioPromedio();



### **7. Cantidad total de productos comprados en una compra**

DELIMITER $$

CREATE FUNCTION CantidadProductosComprados(id_compra INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE cantidad_total DECIMAL(10,2);
    SELECT SUM(cantidad) INTO cantidad_total
    FROM DetalleCompras
    WHERE id_compra = id_compra;
    RETURN COALESCE(cantidad_total, 0);
END $$

DELIMITER ;


Probar 
SELECT CantidadProductosComprados(3);



### **8. Determinar el estado de una máquina**

DELIMITER $$

CREATE FUNCTION EstadoMaquina(id_maquina INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE estado_actual VARCHAR(50);
    SELECT estado INTO estado_actual
    FROM Maquinaria
    WHERE id_maquinaria = id_maquina;
    RETURN COALESCE(estado_actual, 'Desconocido');
END $$

DELIMITER ;


Probar
SELECT EstadoMaquina(2);



### **9. Calcular el valor total del inventario**

DELIMITER $$

CREATE FUNCTION ValorTotalInventario()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(I.cantidad * P.precio) INTO total
    FROM Inventario I
    JOIN Productos P ON I.id_producto = P.id_producto;
    RETURN COALESCE(total, 0);
END $$

DELIMITER ;


Probar
SELECT ValorTotalInventario();



### **10. Total de ventas de un cliente**

DELIMITER $$

CREATE FUNCTION TotalVentasCliente(id_cliente INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(total) INTO total
    FROM Ventas
    WHERE id_cliente = id_cliente;
    RETURN COALESCE(total, 0);
END $$

DELIMITER ;


Probar
SELECT TotalVentasCliente(1);



### **11. Días transcurridos desde la última tarea asignada a un empleado**

DELIMITER $$

CREATE FUNCTION DiasDesdeUltimaTarea(id_empleado INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE dias INT;
    SELECT DATEDIFF(CURDATE(), MAX(fecha_asignacion)) INTO dias
    FROM AsignacionTareas
    WHERE id_empleado = id_empleado;
    RETURN COALESCE(dias, -1); -- Retorna -1 si no hay tareas
END $$

DELIMITER ;

Probar
SELECT DiasDesdeUltimaTarea(2);



### **12. Número total de productos distintos vendidos**

DELIMITER $$

CREATE FUNCTION TotalProductosVendidos()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(DISTINCT id_producto) INTO total
    FROM DetalleVentas;
    RETURN COALESCE(total, 0);
END $$

DELIMITER ;


Probar
SELECT TotalProductosVendidos();



### **13. Promedio de costo de mantenimiento de todas las máquinas**

DELIMITER $$

CREATE FUNCTION PromedioCostoMantenimiento()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT AVG(costo) INTO promedio
    FROM Mantenimiento;
    RETURN COALESCE(promedio, 0);
END $$

DELIMITER ;


Probar
SELECT PromedioCostoMantenimiento();



### **14. Costo total de producción de un producto**

DELIMITER $$

CREATE FUNCTION CostoTotalProduccion(id_producto INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(cantidad * precio) INTO total
    FROM Produccion P
    JOIN Productos PR ON P.id_producto = PR.id_producto
    WHERE P.id_producto = id_producto;
    RETURN COALESCE(total, 0);
END $$

DELIMITER ;


Probar
SELECT CostoTotalProduccion(4);



### **15. Última fecha de actualización de inventario**

DELIMITER $$

CREATE FUNCTION UltimaActualizacionInventario()
RETURNS DATE
DETERMINISTIC
BEGIN
    DECLARE ultima_fecha DATE;
    SELECT MAX(fecha_actualizacion) INTO ultima_fecha
    FROM Inventario;
    RETURN ultima_fecha;
END $$

DELIMITER ;


Probar
SELECT UltimaActualizacionInventario();



### **16. Costo total de una compra**

DELIMITER $$

CREATE FUNCTION CostoTotalCompra(id_compra INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(cantidad * precio_unitario) INTO total
    FROM DetalleCompras
    WHERE id_compra = id_compra;
    RETURN COALESCE(total, 0);
END $$

DELIMITER ;


Probar
SELECT CostoTotalCompra(3);




### **17. Número total de clientes que han realizado compras**

DELIMITER $$

CREATE FUNCTION ClientesConCompras()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(DISTINCT id_cliente) INTO total
    FROM Ventas;
    RETURN COALESCE(total, 0);
END $$

DELIMITER ;


Probar
SELECT ClientesConCompras();



### **18. Promedio de ventas por cliente**

DELIMITER $$

CREATE FUNCTION PromedioVentasPorCliente()
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT AVG(total) INTO promedio
    FROM Ventas;
    RETURN COALESCE(promedio, 0);
END $$

DELIMITER ;


Probar
SELECT PromedioVentasPorCliente();



### **19. Total de empleados con tareas pendientes**

DELIMITER $$

CREATE FUNCTION EmpleadosConTareasPendientes()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(DISTINCT id_empleado) INTO total
    FROM AsignacionTareas
    WHERE estado = 'Pendiente';
    RETURN COALESCE(total, 0);
END $$

DELIMITER ;


Probar
SELECT EmpleadosConTareasPendientes();




### **20. Ganancia neta por producto (ventas - costo de producción)**

DELIMITER $$

CREATE FUNCTION GananciaNetaPorProducto(id_producto INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_ventas DECIMAL(10,2);
    DECLARE costo_produccion DECIMAL(10,2);
    DECLARE ganancia DECIMAL(10,2);

    SELECT SUM(cantidad * precio_unitario) INTO total_ventas
    FROM DetalleVentas
    WHERE id_producto = id_producto;

    SELECT SUM(cantidad * precio) INTO costo_produccion
    FROM Produccion P
    JOIN Productos PR ON P.id_producto = PR.id_producto
    WHERE P.id_producto = id_producto;

    SET ganancia = COALESCE(total_ventas, 0) - COALESCE(costo_produccion, 0);
    RETURN ganancia;
END $$

DELIMITER ;


Probar
SELECT GananciaNetaPorProducto(5);

