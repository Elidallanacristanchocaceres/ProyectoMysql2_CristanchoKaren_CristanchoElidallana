1. Cantidad total de cada producto en inventario
SELECT p.nombre AS Producto, SUM(i.cantidad) AS Cantidad_Total
FROM Productos p
JOIN Inventario i ON p.id_producto = i.id_producto
GROUP BY p.id_producto;

2. Productos con mas de 10 unidades en inventario
SELECT p.nombre AS Producto, i.cantidad AS Cantidad
FROM Productos p
JOIN Inventario i ON p.id_producto = i.id_producto
WHERE i.cantidad > 10;

3. Última fecha de actualización del inventario por producto
SELECT p.nombre AS Producto, MAX(i.fecha_actualizacion) AS Ultima_Actualizacion
FROM Productos p
JOIN Inventario i ON p.id_producto = i.id_producto
GROUP BY p.id_producto;

4. Valor total del inventario por producto
SELECT p.nombre AS Producto, (i.cantidad * p.precio) AS Valor_Total
FROM Productos p
JOIN Inventario i ON p.id_producto = i.id_producto;

5. Producción total por producto en un mes específico
SELECT p.nombre AS Producto, SUM(pr.cantidad) AS Produccion_Total
FROM Productos p
JOIN Produccion pr ON p.id_producto = pr.id_producto
WHERE MONTH(pr.fecha) = 01 AND YEAR(pr.fecha) = 2024
GROUP BY p.id_producto;

6. Promedio diario de producción por producto en noviembre de 2024
SELECT p.nombre AS Producto, AVG(pr.cantidad) AS Promedio_Diario
FROM Productos p
JOIN Produccion pr ON p.id_producto = pr.id_producto
WHERE MONTH(pr.fecha) = 02 AND YEAR(pr.fecha) = 2024
GROUP BY p.id_producto;

7. Producto con mayor cantidad producida en un mes específico
SELECT p.nombre AS Producto, SUM(pr.cantidad) AS Cantidad_Producida
FROM Productos p
JOIN Produccion pr ON p.id_producto = pr.id_producto
WHERE MONTH(pr.fecha) = 02 AND YEAR(pr.fecha) = 2024
GROUP BY p.id_producto
ORDER BY Cantidad_Producida DESC
LIMIT 1;

8. Ventas totales realizadas por cada empleado
SELECT e.nombre AS Empleado, e.apellido, COUNT(v.id_venta) AS Ventas_Realizadas
FROM Empleados e
JOIN Ventas v ON e.id_empleado = v.id_empleado
GROUP BY e.id_empleado;

9. Total de ingresos generados por ventas en un mes de 2024
SELECT SUM(v.total) AS Total_Ingresos
FROM Ventas v
WHERE MONTH(v.fecha) = 01 AND YEAR(v.fecha) = 2024;

10. Productos más vendidos en un mes de 2024
SELECT p.nombre AS Producto, SUM(dv.cantidad) AS Cantidad_Vendida
FROM Productos p
JOIN DetalleVentas dv ON p.id_producto = dv.id_producto
JOIN Ventas v ON dv.id_venta = v.id_venta
WHERE MONTH(v.fecha) = 01 AND YEAR(v.fecha) = 2024
GROUP BY p.id_producto
ORDER BY Cantidad_Vendida DESC;

11. Total gastado en compras a proveedores en un mes de 2024
SELECT SUM(c.total) AS Total_Compras
FROM Compras c
WHERE MONTH(c.fecha) = 11 AND YEAR(c.fecha) = 2024;

12. Proveedores más utilizados en noviembre de 2024
SELECT p.nombre AS Proveedor, COUNT(c.id_compra) AS Compras_Realizadas
FROM Proveedores p
JOIN Compras c ON p.id_proveedor = c.id_proveedor
WHERE MONTH(c.fecha) = 11 AND YEAR(c.fecha) = 2024
GROUP BY p.id_proveedor
ORDER BY Compras_Realizadas DESC;

13. Total de costos por mantenimiento en noviembre de 2024
SELECT SUM(m.costo) AS Total_Costos_Mantenimiento
FROM Mantenimiento m
WHERE MONTH(m.fecha) = 01 AND YEAR(m.fecha) = 2024;

14. Maquinarias con mayores costos de mantenimiento en noviembre de 2024
SELECT ma.tipo AS Maquinaria, SUM(m.costo) AS Costo_Total
FROM Maquinaria ma
JOIN Mantenimiento m ON ma.id_maquinaria = m.id_maquinaria
WHERE MONTH(m.fecha) = 02 AND YEAR(m.fecha) = 2024
GROUP BY ma.id_maquinaria
ORDER BY Costo_Total DESC;

15. Empleados con más tareas asignadas en noviembre de 2024
SELECT e.nombre AS Empleado, COUNT(t.id_tarea) AS Tareas_Asignadas
FROM Empleados e
JOIN AsignacionTareas t ON e.id_empleado = t.id_empleado
WHERE MONTH(t.fecha_asignacion) = 11 AND YEAR(t.fecha_asignacion) = 2024
GROUP BY e.id_empleado
ORDER BY Tareas_Asignadas DESC;

16. Empleados involucrados en más mantenimientos
SELECT e.nombre AS Empleado, COUNT(m.id_mantenimiento) AS Mantenimientos_Realizados
FROM Empleados e
JOIN Mantenimiento m ON e.id_empleado = m.id_empleado
GROUP BY e.id_empleado
ORDER BY Mantenimientos_Realizados DESC;

17. Productos más vendidos y el ingreso generado por cada uno
SELECT p.nombre AS Producto, 
    SUM(dv.cantidad) AS Cantidad_Vendida,
    SUM(dv.cantidad * dv.precio_unitario) AS Total_Generado
FROM Productos p
JOIN DetalleVentas dv ON p.id_producto = dv.id_producto
GROUP BY p.id_producto
ORDER BY Total_Generado DESC;

18. Ingreso promedio diario en noviembre de 2024
SELECT AVG(Diario.Total) AS Ingreso_Promedio_Diario
FROM (
    SELECT DATE(v.fecha) AS Fecha, SUM(v.total) AS Total
    FROM Ventas v
    WHERE MONTH(v.fecha) = 02 AND YEAR(v.fecha) = 2024
    GROUP BY Fecha
) Diario;

19. Proveedor más económico para cada producto
SELECT rpp.id_producto, p.nombre AS Producto, pr.nombre AS Proveedor, MIN(c.total) AS Costo_Minimo
FROM RelacionProveedoresProductos rpp
JOIN Proveedores pr ON rpp.id_proveedor = pr.id_proveedor
JOIN Compras c ON pr.id_proveedor = c.id_proveedor
JOIN Productos p ON rpp.id_producto = p.id_producto
GROUP BY rpp.id_producto, pr.id_proveedor;

20. Empleados con mayor desempeño (ventas + tareas + mantenimientos)
SELECT e.nombre AS Empleado, 
    (COUNT(v.id_venta) + COUNT(t.id_tarea) + COUNT(m.id_mantenimiento)) AS Desempeño
FROM Empleados e
LEFT JOIN Ventas v ON e.id_empleado = v.id_empleado
LEFT JOIN AsignacionTareas t ON e.id_empleado = t.id_empleado
LEFT JOIN Mantenimiento m ON e.id_empleado = m.id_empleado
GROUP BY e.id_empleado
ORDER BY Desempeño DESC;

21. Productos con cantidad mayor a 10 unidades en inventario
SELECT p.nombre, i.cantidad 
FROM Inventario i 
JOIN Productos p ON i.id_producto = p.id_producto 
WHERE i.cantidad > 10;

22. Valor total de inventario por producto
SELECT p.nombre, SUM(i.cantidad * p.precio) AS valor_inventario 
FROM Inventario i 
JOIN Productos p ON i.id_producto = p.id_producto 
GROUP BY p.nombre;

23. Fecha de la última actualización de inventario
SELECT MAX(fecha_actualizacion) AS ultima_actualizacion FROM Inventario;

24. Cantidad total de productos en inventario por tipo de producto
SELECT p.tipo, SUM(i.cantidad) AS cantidad_total 
FROM Inventario i 
JOIN Productos p ON i.id_producto = p.id_producto 
GROUP BY p.tipo;

25. Productos sin movimiento en el inventario en los últimos 30 días
SELECT p.nombre 
FROM Productos p 
LEFT JOIN Inventario i ON p.id_producto = i.id_producto 
WHERE i.fecha_actualizacion < CURDATE() - INTERVAL 30 DAY;

26. Producción total mensual de cada producto
SELECT p.nombre, MONTH(pr.fecha) AS mes, SUM(pr.cantidad) AS total_producido 
FROM Produccion pr 
JOIN Productos p ON pr.id_producto = p.id_producto 
GROUP BY p.nombre, MONTH(pr.fecha);

27. Productos con mayor producción en el último año
SELECT p.nombre, SUM(pr.cantidad) AS total_producido 
FROM Produccion pr 
JOIN Productos p ON pr.id_producto = p.id_producto 
WHERE pr.fecha >= CURDATE() - INTERVAL 1 YEAR 
GROUP BY p.nombre 
ORDER BY total_producido DESC 
LIMIT 5;

28. Producción diaria promedio por producto
SELECT p.nombre, AVG(pr.cantidad) AS produccion_diaria_promedio 
FROM Produccion pr 
JOIN Productos p ON pr.id_producto = p.id_producto 
GROUP BY p.nombre;

29. Costo total de producción según el precio del producto
SELECT p.nombre, SUM(pr.cantidad * p.precio) AS costo_total_produccion 
FROM Produccion pr 
JOIN Productos p ON pr.id_producto = p.id_producto 
GROUP BY p.nombre;

30. Días sin registro de producción en los últimos 3 meses
SELECT DISTINCT pr.fecha 
FROM Produccion pr 
WHERE pr.fecha NOT IN (
    SELECT DISTINCT fecha 
    FROM Produccion 
    WHERE fecha >= CURDATE() - INTERVAL 3 MONTH
);

31. Ingresos totales generados por cada empleado en ventas
SELECT e.nombre, e.apellido, SUM(v.total) AS ingresos_generados 
FROM Ventas v 
JOIN Empleados e ON v.id_empleado = e.id_empleado 
GROUP BY e.nombre, e.apellido 
ORDER BY ingresos_generados DESC;

32. Ventas diarias promedio por empleado
SELECT e.nombre, e.apellido, AVG(v.total) AS ventas_diarias_promedio 
FROM Ventas v 
JOIN Empleados e ON v.id_empleado = e.id_empleado 
GROUP BY e.nombre, e.apellido;

33. Ventas realizadas en días festivos (ejemplo: Navidad, Año Nuevo)
SELECT * 
FROM Ventas 
WHERE fecha IN ('2024-12-25', '2024-01-01');

34. Productos más vendidos del año
SELECT p.nombre, SUM(dv.cantidad) AS total_vendido 
FROM DetalleVentas dv 
JOIN Productos p ON dv.id_producto = p.id_producto 
JOIN Ventas v ON dv.id_venta = v.id_venta 
WHERE YEAR(v.fecha) = YEAR(CURDATE()) 
GROUP BY p.nombre 
ORDER BY total_vendido DESC 
LIMIT 5;

35. Proveedores con mayor volumen de compras en el último mes
SELECT pr.nombre, SUM(c.total) AS volumen_compras 
FROM Compras c 
JOIN Proveedores pr ON c.id_proveedor = pr.id_proveedor 
WHERE c.fecha >= CURDATE() - INTERVAL 1 MONTH 
GROUP BY pr.nombre 
ORDER BY volumen_compras DESC;

36. Costo promedio por compra por proveedor
SELECT pr.nombre, AVG(c.total) AS costo_promedio 
FROM Compras c 
JOIN Proveedores pr ON c.id_proveedor = pr.id_proveedor 
GROUP BY pr.nombre;

37. Productos comprados más frecuentemente por proveedor
SELECT pr.nombre AS proveedor, p.nombre AS producto, COUNT(dc.id_producto) AS veces_comprado 
FROM DetalleCompras dc 
JOIN Productos p ON dc.id_producto = p.id_producto 
JOIN Compras c ON dc.id_compra = c.id_compra 
JOIN Proveedores pr ON c.id_proveedor = pr.id_proveedor 
GROUP BY pr.nombre, p.nombre 
ORDER BY veces_comprado DESC;

38. Compras realizadas en los últimos 7 días
SELECT * 
FROM Compras 
WHERE fecha >= CURDATE() - INTERVAL 7 DAY;

39. Costo total de compras en el último trimestre
SELECT SUM(total) AS costo_total 
FROM Compras 
WHERE fecha >= CURDATE() - INTERVAL 3 MONTH;

40. Tareas pendientes de empleados
SELECT e.nombre, e.apellido, COUNT(t.id_tarea) AS tareas_pendientes 
FROM AsignacionTareas t 
JOIN Empleados e ON t.id_empleado = e.id_empleado 
WHERE t.estado = 'Pendiente' 
GROUP BY e.nombre, e.apellido;

41. Promedio de salario por puesto
SELECT puesto, AVG(salario) AS salario_promedio
FROM Empleados
GROUP BY puesto;

42. Empleados con más participación en mantenimientos de maquinaria
SELECT e.nombre, e.apellido, COUNT(m.id_mantenimiento) AS mantenimientos 
FROM Mantenimiento m 
JOIN Empleados e ON m.id_empleado = e.id_empleado 
GROUP BY e.nombre, e.apellido 
ORDER BY mantenimientos DESC;

43. Productos que tienen un precio superior al precio promedio de todos los productos
SELECT p.nombre, p.precio
FROM Productos p
WHERE p.precio > (SELECT AVG(precio) FROM Productos);

44. Maquinaria más utilizada en mantenimientos
SELECT m.tipo, COUNT(mt.id_mantenimiento) AS total_mantenimientos 
FROM Maquinaria m 
JOIN Mantenimiento mt ON m.id_maquinaria = mt.id_maquinaria 
GROUP BY m.tipo 
ORDER BY total_mantenimientos DESC;

45. Costo total de mantenimientos por maquinaria en el último año
SELECT m.tipo, SUM(mt.costo) AS costo_total 
FROM Maquinaria m 
JOIN Mantenimiento mt ON m.id_maquinaria = mt.id_maquinaria 
WHERE mt.fecha >= CURDATE() - INTERVAL 1 YEAR 
GROUP BY m.tipo;

46. Maquinarias adquiridas hace más de 5 años
SELECT * 
FROM Maquinaria 
WHERE fecha_adquisicion <= CURDATE() - INTERVAL 5 YEAR;

47. Promedio de costos por mantenimiento por maquinaria
SELECT m.tipo, AVG(mt.costo) AS costo_promedio 
FROM Maquinaria m 
JOIN Mantenimiento mt ON m.id_maquinaria = mt.id_maquinaria 
GROUP BY m.tipo;

48. Empleados que han realizado más ventas que el promedio de todos los empleados
SELECT e.nombre, e.apellido, COUNT(v.id_venta) AS ventas_realizadas
FROM Empleados e
JOIN Ventas v ON e.id_empleado = v.id_empleado
GROUP BY e.id_empleado
HAVING ventas_realizadas > (SELECT AVG(ventas_realizadas)
    FROM (SELECT COUNT(id_venta) AS ventas_realizadas
    FROM Ventas
    GROUP BY id_empleado) AS subconsulta);


49. Clientes con más compras realizadas
SELECT c.nombre, COUNT(v.id_venta) AS total_compras 
FROM Clientes c 
JOIN Ventas v ON c.id_cliente = v.id_cliente 
GROUP BY c.nombre 
ORDER BY total_compras DESC;

50. Clientes que han gastado más que el promedio de todos los clientes
SELECT c.nombre, SUM(v.total) AS total_gastado
FROM Clientes c
JOIN Ventas v ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente
HAVING total_gastado > (SELECT AVG(total_gastado)
FROM (SELECT SUM(total) AS total_gastado
FROM Ventas
GROUP BY id_cliente) AS subconsulta);
