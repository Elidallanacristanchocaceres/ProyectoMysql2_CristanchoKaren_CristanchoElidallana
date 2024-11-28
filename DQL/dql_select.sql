-- 1. Estado Actual de los Inventarios.
SELECT p.nombre, i.cantidad
FROM inventarios i
JOIN productos p ON i.producto_id = p.producto_id;

-- 2. Ventas Totales por Producto.
SELECT p.nombre, SUM(v.cantidad * v.precio_unitario) AS ventas_totales
FROM Ventas v
JOIN Productos p ON v.producto_id = p.producto_id
GROUP BY p.nombre;

-- 3. Productos con inventario superior a 100 unidades.
SELECT p.nombre, i.cantidad 
FROM Inventarios i
JOIN Productos p ON i.producto_id = p.producto_id
WHERE i.cantidad > 100;

-- 4. Total de cultivos por tipo de producto:
SELECT p.tipo_producto, COUNT(c.cultivo_id) AS total_cultivos
FROM Cultivos c
JOIN Productos p ON c.producto_id = p.producto_id
GROUP BY p.tipo_producto;

-- 5. Productos con más de 50 unidades y su valor total en inventario (precio unitario \* cantidad)
SELECT p.nombre, i.cantidad, (i.cantidad * v.precio_unitario) AS valor_inventario
FROM Inventarios i
JOIN Productos p ON i.producto_id = p.producto_id
JOIN Ventas v ON p.producto_id = v.producto_id
WHERE i.cantidad > 50;

-- 6. Productos más vendidos (por cantidad).
SELECT p.nombre, SUM(v.cantidad) AS cantidad_vendida
FROM Ventas v
JOIN Productos p ON v.producto_id = p.producto_id
GROUP BY p.nombre
ORDER BY cantidad_vendida DESC;

-- 7. Total de productos comprados y vendidos por proveedor.
SELECT pr.nombre, SUM(c.cantidad) AS total_comprado, SUM(v.cantidad) AS total_vendido
FROM Compras c
JOIN Proveedores pr ON c.proveedor_id = pr.proveedor_id
JOIN Ventas v ON c.producto_id = v.producto_id
GROUP BY pr.nombre;

-- 8. Ventas totales por mes.
SELECT MONTH(fecha_venta) AS mes, SUM(cantidad * precio_unitario) AS total_ventas
FROM Ventas
GROUP BY mes;

-- 9. Total de compras por proveedor y producto.
SELECT pr.nombre, p.nombre, SUM(c.cantidad) AS cantidad_comprada
FROM Compras c
JOIN Proveedores pr ON c.proveedor_id = pr.proveedor_id
JOIN Productos p ON c.producto_id = p.producto_id
GROUP BY pr.nombre, p.nombre;

-- 10. Ventas totales por mes de cada producto.
SELECT p.nombre, MONTH(v.fecha_venta) AS mes, SUM(v.cantidad * v.precio_unitario) AS total_ventas
FROM Ventas v
JOIN Productos p ON v.producto_id = p.producto_id
GROUP BY p.nombre, mes;

-- 11. Productos con mayor cantidad de ventas en el último año.
SELECT p.nombre, SUM(v.cantidad) AS cantidad_vendida
FROM Ventas v
JOIN Productos p ON v.producto_id = p.producto_id
WHERE v.fecha_venta > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY p.nombre
ORDER BY cantidad_vendida DESC
LIMIT 10;

-- 12. Costo de mantenimiento de maquinaria por tipo.
SELECT m.tipo_maquinaria, SUM(mm.costo) AS costo_mantenimiento
FROM Mantenimiento_Maquinaria mm
JOIN Maquinaria m ON mm.maquinaria_id = m.maquinaria_id
GROUP BY m.tipo_maquinaria;

-- 13. Total de maquinaria por estado (funcionando, inactiva, en mantenimiento):
SELECT estado, COUNT(*) AS total_maquinaria
FROM Maquinaria
GROUP BY estado;

-- 14. Evaluación de desempeño de empleados (últimos 6 meses).
SELECT e.nombre, AVG(ed.puntuacion) AS promedio_desempeno
FROM Evaluacion_Desempeno ed
JOIN Empleados e ON ed.empleado_id = e.empleado_id
WHERE ed.fecha_evaluacion > DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY e.nombre;

-- 15. Empleados con mejor desempeño en el último trimestre.
SELECT e.nombre, AVG(ed.puntuacion) AS promedio_desempeno
FROM Evaluacion_Desempeno ed
JOIN Empleados e ON ed.empleado_id = e.empleado_id
WHERE ed.fecha_evaluacion > DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY e.nombre
ORDER BY promedio_desempeno DESC;

-- 16. Gastos operativos totales por tipo de costo.
SELECT tipo_costo, SUM(monto) AS total_gastos
FROM Costos_Operativos
GROUP BY tipo_costo;

-- 17. Empleados con salario superior al promedio.
SELECT e.nombre, e.salario
FROM Empleados e
WHERE e.salario > (SELECT AVG(salario) FROM Empleados);

-- 18. Empleado con menor desempeño en los últimos 6 meses.
SELECT e.nombre, AVG(ed.puntuacion) AS promedio_desempeno
FROM Evaluacion_Desempeno ed
JOIN Empleados e ON ed.empleado_id = e.empleado_id
WHERE ed.fecha_evaluacion > DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY e.nombre
ORDER BY promedio_desempeno ASC
LIMIT 1;

-- 19. Ingresos por ventas en los últimos 12 meses por cliente.
SELECT c.nombre, SUM(v.cantidad * v.precio_unitario) AS total_compras
FROM Ventas v
JOIN Clientes c ON v.cliente_id = c.cliente_id
WHERE v.fecha_venta > DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY c.nombre;

-- 20. Producto con la mayor cantidad en inventario.
SELECT p.nombre, i.cantidad
FROM Productos p
JOIN Inventarios i ON p.producto_id = i.producto_id
WHERE i.cantidad = (SELECT MAX(cantidad) FROM Inventarios);

-- 21. Cantidad total de productos vendidos por cada cliente.
SELECT cl.nombre AS cliente, SUM(v.cantidad) AS total_vendido
FROM ventas v
JOIN clientes cl ON v.cliente_id = cl.cliente_id
GROUP BY cl.nombre;

-- 22. Costos de producción por cultivo
SELECT p.nombre AS cultivo, SUM(cp.monto) AS total_costos
FROM costos_produccion cp
JOIN cultivos cu ON cp.cultivo_id = cu.cultivo_id
JOIN productos p ON cu.producto_id = p.producto_id
GROUP BY p.nombre;

-- 23. Promedio de ventas por mes.
SELECT MONTH(v.fecha_venta) AS mes, AVG(v.precio_unitario * v.cantidad) AS promedio_ventas
FROM ventas v
GROUP BY mes;

-- 24. Productos más vendidos.
SELECT p.nombre AS producto, SUM(v.cantidad) AS total_vendido
FROM ventas v
JOIN productos p ON v.producto_id = p.producto_id
GROUP BY p.nombre
ORDER BY total_vendido DESC
LIMIT 10;

-- 25. Empleados con mejor desempeño.
SELECT e.nombre, MAX(ev.puntuacion) AS puntuacion_max
FROM Evaluacion_Desempeno ev
JOIN Empleados e ON ev.empleado_id = e.empleado_id
GROUP BY e.nombre
ORDER BY puntuacion_max DESC;

-- 26. Historial de desempeño de un empleado específico.
SELECT e.nombre, ev.fecha_evaluacion, ev.puntuacion, ev.comentarios
FROM Evaluacion_Desempeno ev
JOIN Empleados e ON ev.empleado_id = e.empleado_id
WHERE e.empleado_id = 1;

-- 28. Total de cultivos sembrados por cada empleado:
SELECT e.nombre AS empleado, COUNT(c.cultivo_id) AS total_cultivos
FROM Empleados e
LEFT JOIN Cultivos c ON e.empleado_id = c.producto_id 
GROUP BY e.nombre;

-- 29. Pagos realizados a proveedores.
SELECT pr.nombre, SUM(pp.monto) AS total_pagado
FROM Pagos_Proveedores pp
JOIN Proveedores pr ON pp.proveedor_id = pr.proveedor_id
GROUP BY pr.nombre;

-- 30. Métodos de pago utilizados por los proveedores.
SELECT metodo_pago, COUNT(*) AS cantidad_pagados
FROM Pagos_Proveedores
GROUP BY metodo_pago;

-- 31. Pagos acumulados a empleados, incluyendo la fecha del último pago y la fecha actual.
SELECT e.nombre, 
       SUM(pe.monto) AS total_pagado, 
       MAX(pe.fecha_pago) AS ultima_fecha_pago, 
       NOW() AS fecha_actual
FROM Pagos_Empleados pe
JOIN Empleados e ON pe.empleado_id = e.empleado_id
GROUP BY e.nombre;

-- 32. Historial de ventas.
SELECT hv.historial_id, v.fecha_venta, p.nombre AS producto, hv.tipo_cambio, hv.valor_anterior, hv.valor_nuevo
FROM Historial_Ventas hv
JOIN Ventas v ON hv.venta_id = v.venta_id
JOIN Productos p ON v.producto_id = p.producto_id;

-- 33. Historial de cambios realizados a empleados.
SELECT he.historial_id, e.nombre, he.tipo_cambio, he.valor_anterior, he.valor_nuevo, he.fecha_cambio
FROM Historial_Empleados he
JOIN Empleados e ON he.empleado_id = e.empleado_id;

-- 34. Cultivos que han generado un rendimiento superior a 5 toneladas por hectárea:
SELECT c.cultivo_id, AVG(rc.rendimiento) AS rendimiento_promedio
FROM Cultivos c
JOIN Rendimiento_Cultivo rc ON c.cultivo_id = rc.cultivo_id
GROUP BY c.cultivo_id
HAVING AVG(rc.rendimiento) > 5;

-- 35. Cantidad total de maquinaria agrupada por tipo de maquinaria y su estado:
SELECT tipo_maquinaria, estado, COUNT(*) AS total_maquinaria
FROM Maquinaria
GROUP BY tipo_maquinaria, estado;

-- 36. Historial de mantenimiento de maquinaria.
SELECT m.nombre AS maquinaria, mm.fecha_mantenimiento, mm.tipo_mantenimiento, mm.costo
FROM Mantenimiento_Maquinaria mm
JOIN Maquinaria m ON mm.maquinaria_id = m.maquinaria_id;

-- 37. Rendimiento promedio por cultivo.
SELECT c.cultivo_id, AVG(rc.rendimiento) AS rendimiento_promedio
FROM Rendimiento_Cultivo rc
JOIN Cultivos c ON rc.cultivo_id = c.cultivo_id
GROUP BY c.cultivo_id;

-- 38. Control de calidad de productos
SELECT p.nombre, c.fecha_revision, c.resultado, c.observaciones
FROM Control_Calidad c
JOIN Productos p ON c.producto_id = p.producto_id;

-- 39. Calidad y cantidad de cosechas realizadas.
SELECT co.cosecha_id, cu.cultivo_id, cu.fecha_cosecha, co.cantidad_recolectada, co.calidad_control
FROM Cosecha co
JOIN Cultivos cu ON co.cultivo_id = cu.cultivo_id;

-- 40. Rendimiento por hectárea de cada cultivo.
SELECT c.cultivo_id, c.hectareas, SUM(r.rendimiento) / SUM(c.hectareas) AS rendimiento_por_hectarea
FROM Cultivos c
JOIN Rendimiento_Cultivo r ON c.cultivo_id = r.cultivo_id
GROUP BY c.cultivo_id, c.hectareas;

-- 41. Historial de tareas realizadas.
SELECT ta.tarea_id, ta.descripcion, a.fecha_inicio, a.fecha_fin, a.estado
FROM Tareas ta
JOIN Asignacion_Maquinaria a ON ta.tarea_id = a.tarea_id
WHERE a.fecha_fin IS NOT NULL;

-- 41. Costos de mantenimiento por maquinaria.
SELECT m.nombre, SUM(mm.costo) AS total_mantenimiento
FROM Mantenimiento_Maquinaria mm
JOIN Maquinaria m ON mm.maquinaria_id = m.maquinaria_id
GROUP BY m.nombre;

-- Consultas de Subconsultas y Agregaciones Complejas

-- 42. Total de ventas por cliente con subtotales de transacciones.
SELECT c.nombre,
    SUM(v.cantidad * v.precio_unitario) AS total_ventas,
    (SELECT COUNT(*) FROM Ventas) AS total_transacciones
FROM Ventas v
JOIN Clientes c ON v.cliente_id = c.cliente_id
GROUP BY c.nombre;

-- 43. Resumen mensual de calificaciones de empleados.
SELECT YEAR(fecha_evaluacion) AS año, MONTH(fecha_evaluacion) AS mes,
    AVG(puntuacion) AS puntuacion_promedio
FROM Evaluacion_Desempeno
GROUP BY YEAR(fecha_evaluacion), MONTH(fecha_evaluacion);

-- 44. Costo total de producción por cultivo.
SELECT c.cultivo_id, SUM(cp.monto) AS total_costos
FROM Costos_Produccion cp
JOIN Cultivos c ON cp.cultivo_id = c.cultivo_id
GROUP BY c.cultivo_id;

-- 45. Proporción de costos operativos respecto a los ingresos.
SELECT SUM(co.monto) AS total_costo,
    (SELECT SUM(v.cantidad * v.precio_unitario) FROM Ventas v) AS total_ingresos,
    (SUM(co.monto) / (SELECT SUM(v.cantidad * v.precio_unitario) FROM Ventas v)) * 100 AS porcentaje_costo
FROM Costos_Operativos co;

-- 46. Costo total por tipo de producto vendido.
SELECT p.tipo_producto, SUM(v.cantidad * v.precio_unitario) AS total_ingresos
FROM Ventas v
JOIN Productos p ON v.producto_id = p.producto_id
GROUP BY p.tipo_producto;

-- 47. Tendencia de producción por mes.
SELECT MONTH(c.fecha_siembra) AS mes, SUM(c.rendimiento_promedio) AS total_producido
FROM Cultivos c
GROUP BY MONTH(c.fecha_siembra);

-- 48. Historial de productividad por cultivo.
SELECT c.cultivo_id, AVG(rc.rendimiento) AS productividad_media
FROM Rendimiento_Cultivo rc
JOIN Cultivos c ON rc.cultivo_id = c.cultivo_id
GROUP BY c.cultivo_id;

-- 49. Comparativa de costos de producción por tipo.
SELECT tipo_costo, SUM(monto) AS total
FROM Costos_Produccion
GROUP BY tipo_costo;

-- 50. Generación de informes de ventas mensuales.
SELECT MONTH(fecha_venta) AS mes, SUM(cantidad * precio_unitario) AS total_ventas
FROM Ventas
GROUP BY MONTH(fecha_venta);

-- 51. Empleados que han recibido pagos altos.
SELECT e.nombre, SUM(pe.monto) AS total_pagado
FROM Pagos_Empleados pe
JOIN Empleados e ON pe.empleado_id = e.empleado_id
GROUP BY e.nombre
HAVING total_pagado > (SELECT AVG(monto) FROM Pagos_Empleados);

-- 52. Cultivos que necesitan atención según rendimiento.
SELECT c.cultivo_id, AVG(rc.rendimiento) AS rendimiento_promedio
FROM Rendimiento_Cultivo rc
JOIN Cultivos c ON rc.cultivo_id = c.cultivo_id
GROUP BY c.cultivo_id
HAVING AVG(rc.rendimiento) < (SELECT AVG(rendimiento) FROM Rendimiento_Cultivo);

-- 53. Cosechas que no cumplen con los estándares de calidad.
SELECT c.cultivo_id, SUM(co.cantidad_recolectada) AS total_cosechado
FROM Cosecha co
JOIN Cultivos c ON co.cultivo_id = c.cultivo_id
WHERE co.calidad_control <> 'Aprobado'
GROUP BY c.cultivo_id;

-- 54. Costo total de producción de cultivos por año.
SELECT YEAR(fecha) AS año, SUM(monto) AS total_costos
FROM Costos_Produccion
GROUP BY YEAR(fecha);

-- 55. Los empleados que más calidad aportan según sus evaluaciones.
SELECT e.nombre, SUM(ev.puntuacion) AS total_calidad
FROM Evaluacion_Desempeno ev
JOIN Empleados e ON ev.empleado_id = e.empleado_id
GROUP BY e.nombre
ORDER BY total_calidad DESC LIMIT 5;

-- 56. Cantidad de maquinaria en funcionamiento.
SELECT COUNT(*) AS total_maquinaria_activa
FROM Maquinaria
WHERE estado = 'Activo';

-- 57. Costo acumulado de maquinaria por tipo.
SELECT tipo_maquinaria, SUM(m.costo) AS total_costos
FROM Mantenimiento_Maquinaria m
JOIN Maquinaria ma ON m.maquinaria_id = ma.maquinaria_id
GROUP BY tipo_maquinaria;

-- 58. Últimas actualizaciones de inventario.
SELECT p.nombre, i.cantidad, i.fecha_actualizacion
FROM Inventarios i
JOIN Productos p ON i.producto_id = p.producto_id
ORDER BY i.fecha_actualizacion DESC
LIMIT 10;

-- 59. Proveedores con más pagos realizados.
SELECT pr.nombre, COUNT(pp.pago_id) AS total_pagos
FROM Pagos_Proveedores pp
JOIN Proveedores pr ON pp.proveedor_id = pr.proveedor_id
GROUP BY pr.nombre
ORDER BY total_pagos DESC;

-- 60. Cultivos cosechados sin calidad aprobada.
SELECT c.cultivo_id, SUM(co.cantidad_recolectada) AS cantidad_total
FROM Cosecha co
JOIN Cultivos c ON co.cultivo_id = c.cultivo_id
WHERE co.calidad_control <> 'Aprobado'
GROUP BY c.cultivo_id;

-- 61. Total de ventas por cliente.
SELECT c.nombre, SUM(v.cantidad * v.precio_unitario) AS total_ventas
FROM Ventas v
JOIN Clientes c ON v.cliente_id = c.cliente_id
GROUP BY c.nombre;

-- 62. Total de ventas por producto y por mes.
SELECT p.nombre, MONTH(v.fecha_venta) AS mes, SUM(v.cantidad * v.precio_unitario) AS total_ventas
FROM Ventas v
JOIN Productos p ON v.producto_id = p.producto_id
GROUP BY p.nombre, mes;

-- 63. Productos sin ventas en los últimos 3 meses.
SELECT p.nombre
FROM Productos p
LEFT JOIN Ventas v ON p.producto_id = v.producto_id
WHERE v.fecha_venta < DATE_SUB(CURDATE(), INTERVAL 3 MONTH) OR v.fecha_venta IS NULL;

-- 64. Total de clientes con compras en el último año.
SELECT COUNT(DISTINCT cliente_id) AS total_clientes
FROM Ventas
WHERE fecha_venta > DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

-- 65. Empleados que no han recibido evaluación en los últimos 6 meses.
SELECT e.nombre
FROM Empleados e
LEFT JOIN Evaluacion_Desempeno ed ON e.empleado_id = ed.empleado_id
WHERE ed.fecha_evaluacion < DATE_SUB(CURDATE(), INTERVAL 6 MONTH) OR ed.fecha_evaluacion IS NULL;

-- 66. Cultivos sembrados en los últimos 3 meses.
SELECT c.cultivo_id, c.fecha_siembra
FROM Cultivos c
WHERE c.fecha_siembra > DATE_SUB(CURDATE(), INTERVAL 3 MONTH);

-- 67. Costo total de mantenimiento por tipo de mantenimiento.
SELECT tipo_mantenimiento, SUM(costo) AS total_costo
FROM Mantenimiento_Maquinaria
GROUP BY tipo_mantenimiento;

-- 68. Tareas programadas para la próxima semana:
SELECT t.descripcion, t.fecha_inicio
FROM Tareas t
WHERE t.fecha_inicio BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 1 WEEK);

-- 69. Promedio de gastos operativos por tipo de costo.
SELECT tipo_costo, AVG(monto) AS promedio_gasto
FROM Costos_Operativos
GROUP BY tipo_costo;

-- 70. Productos que tienen un costo de producción superior a un valor específico.
SELECT p.nombre, SUM(cp.monto) AS total_costos
FROM Costos_Produccion cp
JOIN Cultivos c ON cp.cultivo_id = c.cultivo_id
JOIN Productos p ON c.producto_id = p.producto_id
GROUP BY p.nombre
HAVING total_costos > 1000;

-- 71. Historial de cambios en la calidad de los productos.
SELECT p.nombre AS producto, c.fecha_revision, c.resultado
FROM Control_Calidad c
JOIN Productos p ON c.producto_id = p.producto_id
WHERE c.resultado <> 'Aprobado'
ORDER BY c.fecha_revision DESC;

-- 72. Tareas programadas para el próximo mes.
SELECT t.descripcion, t.fecha_inicio
FROM Tareas t
WHERE t.fecha_inicio BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 1 MONTH);

-- 73. Maquinaria que ha tenido mantenimiento en el último año.
SELECT m.nombre, COUNT(mm.mantenimiento_id) AS total_mantenimientos
FROM Maquinaria m
JOIN Mantenimiento_Maquinaria mm ON m.maquinaria_id = mm.maquinaria_id
WHERE mm.fecha_mantenimiento > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY m.nombre;

-- 74. Total de pagos a proveedores por mes.
SELECT MONTH(fecha_pago) AS mes, SUM(monto) AS total_pagado
FROM Pagos_Proveedores
GROUP BY mes;

-- 75. Empleado con el salario más alto.
SELECT e.nombre, e.salario
FROM Empleados e
WHERE e.salario = (SELECT MAX(salario) FROM Empleados);

-- 76. Total de productos en inventario que tienen descripción.
SELECT COUNT(*) AS total_productos_con_descripcion
FROM Productos
WHERE descripcion IS NOT NULL AND descripcion <> '';

-- 77. Tareas que están pendientes de realización.
SELECT t.descripcion, t.fecha_inicio
FROM Tareas t
WHERE t.estado = 'Pendiente';

-- 78. Cultivos con rendimiento promedio superior a un valor específico.
SELECT cu.cultivo_id, AVG(rc.rendimiento) AS rendimiento_promedio
FROM Rendimiento_Cultivo rc
JOIN Cultivos cu ON rc.cultivo_id = cu.cultivo_id
GROUP BY cu.cultivo_id
HAVING rendimiento_promedio > 70.0;

-- 79. Historial de pagos a empleados en el último año.
SELECT e.nombre, SUM(pe.monto) AS total_pagado
FROM Pagos_Empleados pe
JOIN Empleados e ON pe.empleado_id = e.empleado_id
WHERE pe.fecha_pago > DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY e.nombre;

-- 80. Total de costos operativos por mes.
SELECT MONTH(fecha) AS mes, SUM(monto) AS total_costos
FROM Costos_Operativos
GROUP BY mes;

-- 81. Total de ventas por cliente y el cliente que más ha gastado.
SELECT 
    c.nombre, 
    SUM(v.cantidad * v.precio_unitario) AS total_gastado,
    CASE 
        WHEN SUM(v.cantidad * v.precio_unitario) = MAX(SUM(v.cantidad * v.precio_unitario)) OVER () 
        THEN 'Cliente que más ha gastado'
        ELSE 'Cliente regular'
    END AS categoria_cliente
FROM Clientes c
JOIN Ventas v ON c.cliente_id = v.cliente_id
GROUP BY c.nombre;

-- 82. Productos que se han vendido más que el promedio de ventas.
SELECT p.nombre
FROM Productos p
WHERE (SELECT SUM(v.cantidad) FROM Ventas v WHERE v.producto_id = p.producto_id) > 
    (SELECT AVG(total_vendido) FROM (SELECT SUM(v.cantidad) AS total_vendido FROM Ventas v GROUP BY v.producto_id) AS sub);

-- 83. Cultivos con rendimiento superior al promedio de todos los cultivos.
SELECT cu.cultivo_id, AVG(rc.rendimiento) AS rendimiento_promedio
FROM Rendimiento_Cultivo rc
JOIN Cultivos cu ON rc.cultivo_id = cu.cultivo_id
GROUP BY cu.cultivo_id
HAVING rendimiento_promedio > (SELECT AVG(rendimiento) FROM Rendimiento_Cultivo);

-- 84. Total de ventas por producto y el producto más vendido.
SELECT 
    p.nombre, 
    SUM(v.cantidad) AS total_vendido,
    CASE 
        WHEN SUM(v.cantidad) = MAX(SUM(v.cantidad)) OVER () 
        THEN 'Producto más vendido'
        ELSE 'Producto regular'
    END AS categoria_producto
FROM Productos p
JOIN Ventas v ON p.producto_id = v.producto_id
GROUP BY p.nombre;

-- 86. Total de costos operativos por mes y el mes con mayor costo.
SELECT 
    MONTH(fecha) AS mes, 
    SUM(monto) AS total_costos,
    CASE 
        WHEN SUM(monto) = MAX(SUM(monto)) OVER () 
        THEN 'Mes con mayor costo'
        ELSE 'Mes regular'
    END AS categoria_mes
FROM Costos_Operativos
GROUP BY mes;

-- 87. Productos que tienen un inventario inferior al promedio de inventario.
SELECT p.nombre
FROM Productos p
WHERE (SELECT i.cantidad FROM Inventarios i WHERE i.producto_id = p.producto_id) < 
    (SELECT AVG(cantidad) FROM Inventarios);

-- 88. Cultivos que han sido cosechados más de una vez.
SELECT c.cultivo_id
FROM Cosecha c
GROUP BY c.cultivo_id
HAVING COUNT(*) > 1;

-- 89. Clientes que han gastado más que el promedio.
SELECT c.nombre
FROM Clientes c
WHERE (SELECT SUM(v.cantidad * v.precio_unitario) FROM Ventas v WHERE v.cliente_id = c.cliente_id) >
      (SELECT AVG(total_gastado) FROM (SELECT SUM(cantidad * precio_unitario) AS total_gastado FROM Ventas GROUP BY cliente_id) AS avg_totals);

-- 90. Obtener el total de productos en stock.
SELECT SUM(i.cantidad) AS total_stock
FROM Inventarios i;

-- 91. Listar los proveedores que tienen productos en stock.
SELECT DISTINCT pr.nombre
FROM Proveedores pr
JOIN Compras co ON pr.proveedor_id = co.proveedor_id
JOIN Productos p ON co.producto_id = p.producto_id
JOIN Inventarios i ON p.producto_id = i.producto_id
WHERE i.cantidad > 0;

-- 92. Obtener el promedio de precios de productos.
SELECT AVG(precio_unitario) AS promedio_precio
FROM Ventas;

-- 93. Obtener el producto más vendido.
SELECT p.nombre, SUM(v.cantidad) AS total_vendido
FROM Productos p
JOIN Ventas v ON p.producto_id = v.producto_id
GROUP BY p.producto_id
ORDER BY total_vendido DESC
LIMIT 1;

-- 94. Obtener la suma total gastada por cada cliente.
SELECT c.nombre, SUM(v.cantidad * v.precio_unitario) AS total_gastado
FROM Clientes c
JOIN Ventas v ON c.cliente_id = v.cliente_id
GROUP BY c.cliente_id, c.nombre;

-- 95. Obtener la cantidad total de productos en inventario por producto.
SELECT p.nombre, SUM(i.cantidad) AS total_stock
FROM Productos p
JOIN Inventarios i ON p.producto_id = i.producto_id
GROUP BY p.producto_id, p.nombre;

-- 96. Obtener la cantidad total de compras realizadas a cada proveedor.
SELECT pr.nombre, SUM(co.cantidad) AS total_compras
FROM Proveedores pr
JOIN Compras co ON pr.proveedor_id = co.proveedor_id
GROUP BY pr.proveedor_id, pr.nombre;

-- 97. Listar los cultivos que han sido sembrados en los últimos 6 meses.
SELECT c.cultivo_id, c.fecha_siembra
FROM Cultivos c
WHERE c.fecha_siembra >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

-- 98. Obtener la cantidad de cultivos sembrados por mes.
SELECT MONTH(fecha_siembra) AS mes, COUNT(*) AS total_cultivos
FROM Cultivos
GROUP BY MONTH(fecha_siembra);

-- 99. Obtener el total de costos operativos por tipo de costo.
SELECT tipo_costo, SUM(monto) AS total_costos
FROM Costos_Operativos
GROUP BY tipo_costo;

-- 100. Obtener el total de pagos a proveedores agrupados por método de pago.
SELECT metodo_pago, SUM(monto) AS total_pagado
FROM Pagos_Proveedores
GROUP BY metodo_pago;



