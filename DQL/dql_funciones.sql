--1. Calcular el rendimiento promedio por hectárea de un cultivo
DELIMITER //
CREATE FUNCTION RendimientoPromedioPorHectarea(cultivoID INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT rendimiento_promedio / hectareas 
    INTO promedio 
    FROM Cultivos 
    WHERE cultivo_id = cultivoID;
    RETURN promedio;
END;
//
DELIMITER ;

SELECT RendimientoPromedioPorHectarea(1);


--2. Calcular el costo operativo total en un período
DELIMITER //
CREATE FUNCTION CostoOperativoTotal(inicio DATE, fin DATE) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
 DECLARE total DECIMAL(10,2);
 SELECT SUM(monto) 
 INTO total 
 FROM Costos_Operativos 
 WHERE fecha BETWEEN inicio AND fin;
 RETURN total;
END;
//
DELIMITER ;

SELECT CostoOperativoTotal('2024-01-01', '2024-12-31');


--3. Obtener el porcentaje de maquinaria en mantenimiento actualmente
DELIMITER //
CREATE FUNCTION PorcentajeMaquinariaEnMantenimiento() RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE total_maquinaria INT;
    DECLARE en_mantenimiento INT;
    DECLARE porcentaje DECIMAL(5,2);
    
    SELECT COUNT(*) INTO total_maquinaria FROM Maquinaria;
    
    SELECT COUNT(*) INTO en_mantenimiento 
    FROM Maquinaria
    WHERE estado = 'En Mantenimiento';

    SET porcentaje = (en_mantenimiento / total_maquinaria) * 100;
    
    RETURN porcentaje;
END;
//
DELIMITER ;

SELECT PorcentajeMaquinariaEnMantenimiento();


--4. Calcular el ingreso total de ventas por cliente
DELIMITER //
CREATE FUNCTION IngresoTotalPorCliente(clienteID INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
 DECLARE total DECIMAL(10,2);
 SELECT SUM(cantidad * precio_unitario) 
 INTO total 
 FROM Ventas 
 WHERE cliente_id = clienteID;
 RETURN total;
END;
//
DELIMITER ;

SELECT IngresoTotalPorCliente(1);


--5. Calcular el salario promedio por tipo de empleado
 DELIMITER //
   CREATE FUNCTION SalarioPromedioPorTipo(tipo VARCHAR(50)) RETURNS DECIMAL(10,2)
   DETERMINISTIC
   BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT AVG(salario) 
    INTO promedio 
    FROM Empleados 
    WHERE tipo_empleado = tipo;
    RETURN promedio;
   END;
   //
   DELIMITER ;

SELECT SalarioPromedioPorTipo('Gerente');


--6. Calcular la cantidad de productos no disponibles en inventario
 DELIMITER //
   CREATE FUNCTION ProductosSinInventario() RETURNS INT
   DETERMINISTIC
   BEGIN
    DECLARE cantidad INT;
    SELECT COUNT(*) 
    INTO cantidad 
    FROM Inventarios 
    WHERE cantidad = 0;
    RETURN cantidad;
   END;
   //
   DELIMITER ;

SELECT ProductosSinInventario();


--7. Calcular la rotación de inventario de un producto
 DELIMITER //
   CREATE FUNCTION RotacionDeInventario(productoID INT) RETURNS DECIMAL(10,2)
   DETERMINISTIC
   BEGIN
    DECLARE rotacion DECIMAL(10,2);
    SELECT (SUM(cantidad) / COUNT(DISTINCT fecha_actualizacion)) 
    INTO rotacion 
    FROM Inventarios 
    WHERE producto_id = productoID;
    RETURN rotacion;
   END;
   //
   DELIMITER ;

SELECT RotacionDeInventario(1);


--8. Calcular la cantidad total de tareas completadas
 DELIMITER //
   CREATE FUNCTION TareasCompletadas() RETURNS INT
   DETERMINISTIC
   BEGIN
    DECLARE cantidad INT;
    SELECT COUNT(*) 
    INTO cantidad 
    FROM Tareas 
    WHERE estado = 'Completado';
    RETURN cantidad;
   END;
   //
   DELIMITER ;

SELECT TareasCompletadas();


--9. Calcular el costo total de producción por cultivo
 DELIMITER //
   CREATE FUNCTION CostoTotalProduccion(cultivoID INT) RETURNS DECIMAL(10,2)
   DETERMINISTIC
   BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(monto) 
    INTO total 
    FROM Costos_Produccion 
    WHERE cultivo_id = cultivoID;
    RETURN total;
   END;
   //
   DELIMITER ;

SELECT CostoTotalProduccion(1);


--10. Calcular la cantidad de hectáreas asignadas por zona
 DELIMITER //
    CREATE FUNCTION HectareasPorZona(zonaNombre VARCHAR(100)) RETURNS INT
    DETERMINISTIC
    BEGIN
    DECLARE hectareasTotales INT;
    SELECT SUM(hectareas) 
    INTO hectareasTotales 
    FROM Ubicacion_Cultivo 
    WHERE zona = zonaNombre;
    RETURN hectareasTotales;
    END;
    //
    DELIMITER ;

SELECT HectareasPorZona('Zona Norte');


--11. Estimar el costo promedio de mantenimiento por maquinaria
    DELIMITER //
    CREATE FUNCTION CostoPromedioMantenimiento(maquinariaID INT) RETURNS DECIMAL(10,2)
    DETERMINISTIC
    BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT AVG(costo) 
    INTO promedio 
    FROM Mantenimiento_Maquinaria 
    WHERE maquinaria_id = maquinariaID;
    RETURN promedio;
    END;
    //
    DELIMITER ;
    
    SELECT CostoPromedioMantenimiento(1);
     

--12. Calcular el total de ventas de un producto específico
     DELIMITER //
        CREATE FUNCTION TotalVentasProducto(productoID INT) RETURNS DECIMAL(10,2)
        DETERMINISTIC
        BEGIN
        DECLARE total DECIMAL(10,2);
        SELECT SUM(cantidad * precio_unitario) 
        INTO total 
        FROM Ventas 
        WHERE producto_id = productoID;
        RETURN total;
        END;
        //
        DELIMITER ;
    
    SELECT TotalVentasProducto(1);
    

--13.  Calcular el tiempo promedio de respuesta en tareas
DELIMITER //
CREATE FUNCTION TiempoPromedioTareas() RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT IFNULL(AVG(TIMESTAMPDIFF(DAY, fecha_inicio, fecha_fin)), 0)
    INTO promedio
    FROM Tareas
    WHERE estado = 'Completada'
      AND fecha_inicio IS NOT NULL
      AND fecha_fin IS NOT NULL;
    
    RETURN promedio;
END;
//
DELIMITER ;

SELECT TiempoPromedioTareas();
    

--14. Calcular la cantidad total de maquinaria en uso
DELIMITER //
CREATE FUNCTION MaquinariaEnUso() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;
    SELECT COUNT(*) 
    INTO cantidad 
    FROM Maquinaria 
    WHERE estado = 'En Uso';
    RETURN cantidad;
END;
//
DELIMITER ;

SELECT MaquinariaEnUso();


--15. Obtener el número total de clientes
DELIMITER //
CREATE FUNCTION TotalClientes() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) 
    INTO total 
    FROM Clientes;
    RETURN total;
END;
//
DELIMITER ;

SELECT TotalClientes();


--16. Calcular el número total de tareas pendientes
DELIMITER //
CREATE FUNCTION TareasPendientes() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;
    SELECT COUNT(*) 
    INTO cantidad 
    FROM Tareas 
    WHERE estado = 'Pendiente';
    RETURN cantidad;
END;
//
DELIMITER ;

SELECT TareasPendientes();


--17. Calcular el porcentaje de empleados activos
DELIMITER //
CREATE FUNCTION PorcentajeEmpleadosActivos() RETURNS DECIMAL(5,2)
DETERMINISTIC
BEGIN
    DECLARE total_empleados INT;
    DECLARE empleados_activos INT;
    DECLARE porcentaje DECIMAL(5,2);
    
    SELECT COUNT(*) INTO total_empleados FROM Empleados;
    
    SELECT COUNT(*) INTO empleados_activos 
    FROM Empleados
    WHERE estado = 'Activo';

    SET porcentaje = (empleados_activos / total_empleados) * 100;
    
    RETURN porcentaje;
END;
//
DELIMITER ;

SELECT PorcentajeEmpleadosActivos();


--18. **Función para obtener el total de ventas de un cliente específico**
DELIMITER //
CREATE FUNCTION TotalVentasPorCliente(clienteID INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(cantidad * precio_unitario) 
    INTO total 
    FROM Ventas 
    WHERE cliente_id = clienteID;
    RETURN total;
END;
//
DELIMITER ;

SELECT TotalVentasPorCliente(1); 


--19. **Función para obtener el promedio de ventas por producto**
DELIMITER //
CREATE FUNCTION PromedioVentasPorProducto(productoID INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT AVG(cantidad) 
    INTO promedio 
    FROM Ventas 
    WHERE producto_id = productoID;
    RETURN promedio;
END;
//
DELIMITER ;
SELECT PromedioVentasPorProducto(1);

--20. **Función para calcular el inventario total de un producto**
DELIMITER //
CREATE FUNCTION InventarioTotalProducto(productoID INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE totalInventario INT;
    SELECT SUM(I.cantidad) 
    INTO totalInventario 
    FROM Inventarios I
    WHERE I.producto_id = productoID;
    RETURN totalInventario;
END;
//
DELIMITER ;

SELECT InventarioTotalProducto(3); 


