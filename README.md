# 🌾 **Gestión de una Finca de Producción Agrícola**  
### BASE DE DATOS
El proyecto de **"Gestión de una Finca de Producción Agrícola"** se centra en el diseño e implementación de una base de datos para administrar de manera eficiente los procesos operativos, productivos y administrativos de una finca agrícola. Este sistema organiza y centraliza información en áreas clave como recursos humanos, cultivos, inventarios, ventas, costos y logística.  

---

## 🎯 **Propósito de la Base de Datos**  

El propósito principal es mejorar la gestión integral de la finca ofreciendo una solución tecnológica que permita:  

### 👩‍🌾 **Administrar Recursos Humanos y Materiales**  
- 📋 Mantener registros estructurados de empleados, proveedores, clientes y maquinaria.  
- ✅ Facilitar el monitoreo de tareas, asignaciones y mantenimientos.  

### 🌱 **Optimizar la Producción Agrícola**  
- 🌾 Gestionar el ciclo completo de cultivos: siembra, cosecha y análisis de rendimientos.  
- 📊 Evaluar y mejorar la productividad agrícola.  

### 📦 **Controlar Inventarios y Ventas**  
- 📈 Supervisar la disponibilidad de productos en inventarios.  
- 🛒 Registrar y analizar transacciones de ventas y compras.  

### 💰 **Gestionar Costos Operativos y Financieros**  
- 💵 Controlar gastos de operación, producción y pagos.  
- 🔍 Realizar análisis financieros para optimizar los recursos.  

### 🏆 **Garantizar Calidad y Desempeño**  
- 🔎 Asegurar la calidad de los productos agrícolas mediante controles.  
- 📝 Evaluar el desempeño de empleados para fomentar mejoras.  

### 🔐 **Proporcionar Auditorías y Seguridad**  
- 📂 Registrar detalladamente las acciones de los usuarios.  
- 🚦 Ofrecer diferentes niveles de acceso según los roles.  

---

## 🗂️ **Estructura de la Base de Datos**  

### 1️⃣ **Recursos Humanos**  
- 👨‍💼 **`Empleados`**: Datos personales, tipo de empleado, salario y más.  
- 📜 **`Historial_Empleados`**: Cambios en salarios y valores laborales.  
- 💵 **`Pagos_Empleados`**: Pagos realizados al personal.  
- 🏅 **`Evaluacion_Desempeno`**: Puntuaciones y comentarios sobre el desempeño.  

### 2️⃣ **Producción Agrícola**  
- 🌾 **`Productos`**: Información sobre productos cultivados.  
- 🗓️ **`Cultivos`**: Ciclos de cultivo, fechas, hectáreas y rendimientos.  
- 🧺 **`Cosecha`**: Cantidades recolectadas, calidad y destino.  
- 🌍 **`Ubicacion_Cultivo`**: Gestión de zonas de cultivo dentro de la finca.  
- 📊 **`Rendimiento_Cultivo`**: Datos para evaluar y planificar la producción.  

### 3️⃣ **Inventarios y Comercialización**  
- 📦 **`Inventarios`**: Registro de existencias.  
- 🛍️ **`Ventas`**: Transacciones con detalles de cantidad, precio y clientes.  
- 📜 **`Historial_Ventas`**: Cambios en ventas como precios o cantidades.  
- 🧪 **`Control_Calidad`**: Inspecciones y resultados de calidad.  

### 4️⃣ **Logística y Mantenimiento**  
- 🚜 **`Maquinaria`**: Información sobre maquinaria, estado y mantenimientos.  
- 🗂️ **`Tareas`**: Actividades en la finca con fechas y estado actual.  
- 🛠️ **`Asignacion_Maquinaria`**: Relación de maquinaria con tareas específicas.  
- 🔧 **`Mantenimiento_Maquinaria`**: Registros de mantenimientos realizados.  
- 📋 **`Tareas_Mantenimiento`**: Seguimiento de mantenimientos programados.  

### 5️⃣ **Finanzas**  
- 💰 **`Costos_Operativos`**: Gastos generales de la finca.  
- 🌾 **`Costos_Produccion`**: Costos específicos por cultivo.  
- 💳 **`Pagos_Proveedores`**: Detalles de pagos a proveedores.  

### 6️⃣ **Auditorías y Seguridad**  
- 🔒 **`Roles`**: Niveles de acceso por rol (administrador, auditor, etc.).  
- 👤 **`Usuarios`**: Información de acceso de usuarios.  
- 🕵️ **`Auditoria_Accessos`**: Registro de acciones realizadas por usuarios.  

---

## 🌟 **Impacto del Proyecto**  

La implementación de esta base de datos ofrece:  
- 🚀 **Eficiencia Operativa**: Automatiza tareas administrativas y organiza datos.  
- 📊 **Mejor Toma de Decisiones**: Proporciona análisis precisos sobre costos y productividad.  
- 🗂️ **Trazabilidad Completa**: Historial detallado de acciones y cambios.  
- 🌱 **Sostenibilidad**: Optimiza recursos y mejora la planificación agrícola.  

---


# 🌾 Sistema de Gestión Integral para la Finca 🌱

Este sistema está diseñado para administrar todos los aspectos operativos de una finca, incluyendo el manejo de proveedores, productos, clientes, empleados, maquinaria, cultivos, inventarios, ventas, compras, mantenimiento y costos operativos. A continuación, se describe la estructura de la base de datos y las funciones de cada tabla.

---

### INSERCIONES

## 1. 🏢 **Proveedores**
**Función:**  
Gestiona la información sobre los proveedores que suministran productos o servicios a la finca, como insumos agrícolas, maquinaria y otros productos necesarios para las operaciones.

**Inserciones (50 registros):**  
Campos: `proveedor_id`, `nombre`, `direccion`, `telefono`, `email`.  
**Impacto:**  
Con estos datos, el sistema permite registrar y rastrear las compras de productos y servicios, generar reportes de pagos a proveedores, y evaluar la relación comercial con cada uno de ellos.

---

## 2. 🌾 **Productos**
**Función:**  
Contiene información sobre los productos agrícolas que se cultivan en la finca. Esta tabla facilita el seguimiento de inventarios y la gestión de las ventas.

**Inserciones (50 registros):**  
Campos: `producto_id`, `nombre`, `tipo_producto`, `unidad_medida`, `descripcion`.  
**Impacto:**  
La base de datos puede hacer seguimiento al inventario, identificar tendencias de venta de productos, y calcular los rendimientos de cada cultivo.

---

## 3. 👥 **Clientes**
**Función:**  
Almacena los detalles de los clientes que compran productos de la finca, ya sean distribuidores o consumidores finales.

**Inserciones (50 registros):**  
Campos: `cliente_id`, `nombre`, `direccion`, `telefono`, `email`.  
**Impacto:**  
Permite llevar un registro de las ventas a clientes, gestionar la facturación y los pagos, y generar reportes de ventas segmentados por cliente.

---

## 4. 👨‍🌾 **Empleados**
**Función:**  
Registra la información de todos los empleados que trabajan en la finca, tanto operativos como administrativos.

**Inserciones (50 registros):**  
Campos: `empleado_id`, `nombre`, `tipo_empleado`, `salario`, `fecha_ingreso`, `estado`.  
**Impacto:**  
Facilita el seguimiento de la fuerza laboral, el cálculo de salarios, la asignación de tareas y la gestión del estado laboral de cada empleado.

---

## 5. 🚜 **Maquinaria**
**Función:**  
Gestiona los equipos y máquinas utilizados en la finca, como tractores y cosechadoras.

**Inserciones (50 registros):**  
Campos: `maquinaria_id`, `nombre`, `tipo_maquinaria`, `estado`, `fecha_adquisicion`, `fecha_ultimo_mantenimiento`.  
**Impacto:**  
Permite llevar el control del mantenimiento de la maquinaria, gestionar su estado de operatividad, y planificar las inversiones en nuevas adquisiciones de equipos.

---

## 6. 📝 **Tareas**
**Función:**  
Esta tabla contiene las tareas que se realizan en la finca, desde la siembra hasta la cosecha, incluyendo actividades de mantenimiento de maquinaria.

**Inserciones (50 registros):**  
Campos: `tarea_id`, `descripcion`, `fecha_inicio`, `fecha_fin`, `estado`.  
**Impacto:**  
Ayuda a gestionar el cronograma de trabajo, asignar tareas a empleados y maquinaria, y realizar un seguimiento del progreso de las actividades.

---

## 7. 🌱 **Cultivos**
**Función:**  
Registra los cultivos sembrados en la finca, incluyendo los detalles del tipo de cultivo, la cantidad sembrada y los rendimientos estimados.

**Inserciones (50 registros):**  
Campos: `cultivo_id`, `producto_id`, `fecha_siembra`, `fecha_cosecha`, `hectareas`, `rendimiento_promedio`.  
**Impacto:**  
Permite hacer un seguimiento detallado de cada cultivo, controlar el ciclo de vida del producto y calcular los rendimientos de las cosechas.

---

## 8. 📦 **Inventarios**
**Función:**  
Gestiona los inventarios de los productos en la finca, incluyendo tanto los productos cultivados como aquellos comprados de proveedores.

**Inserciones (50 registros):**  
Campos: `inventario_id`, `producto_id`, `cantidad`, `fecha_actualizacion`.  
**Impacto:**  
Permite realizar un seguimiento de las existencias, prever las necesidades de reabastecimiento y controlar el flujo de productos dentro y fuera de la finca.

---

## 9. 💰 **Ventas**
**Función:**  
Esta tabla registra las ventas realizadas de los productos a los clientes, permitiendo gestionar el flujo de ingresos de la finca.

**Inserciones (50 registros):**  
Campos: `venta_id`, `producto_id`, `cantidad`, `precio_unitario`, `fecha_venta`, `cliente_id`.  
**Impacto:**  
Facilita la gestión de las ventas, el seguimiento de la facturación y el control de pagos por cliente. Además, puede generar reportes de ventas por producto, cliente o periodo.

---

## 10. 🛒 **Compras**
**Función:**  
Registra las compras de productos a los proveedores, permitiendo llevar un control de los insumos necesarios para las actividades agrícolas.

**Inserciones (50 registros):**  
Campos: `compra_id`, `producto_id`, `cantidad`, `precio_unitario`, `fecha_compra`, `proveedor_id`.  
**Impacto:**  
Contribuye al control de los costos operativos, la gestión de inventarios y la relación con los proveedores.

---

## 11. 📝 **Historial_Empleados**
**Función:**  
Registra los cambios realizados en los datos de los empleados, como aumentos salariales, cambios de puesto, o alteraciones en su estado laboral.

**Inserciones (50 registros):**  
Campos: `historial_id`, `empleado_id`, `tipo_cambio`, `valor_anterior`, `valor_nuevo`, `fecha_cambio`.  
**Impacto:**  
Facilita la auditoría y el seguimiento de los cambios en las condiciones laborales de los empleados, ayudando en la gestión de recursos humanos.

---

## 12. 🛠️ **Asignacion_Maquinaria**
**Función:**  
Registra las asignaciones de maquinaria a tareas específicas, permitiendo un mejor control sobre la utilización de los equipos.

**Inserciones (50 registros):**  
Campos: `empleado_id`, `asignacion_id`, `maquinaria_id`, `tarea_id`, `fecha_inicio`, `fecha_fin`, `estado`.  
**Impacto:**  
Permite un control preciso de la maquinaria en uso y la asignación de recursos para tareas agrícolas, optimizando su utilización.

---

## 13. 🧰 **Mantenimiento_Maquinaria**
**Función:**  
Registra el mantenimiento realizado en la maquinaria, incluyendo los costos y tipos de mantenimiento.

**Inserciones (50 registros):**  
Campos: `mantenimiento_id`, `maquinaria_id`, `fecha_mantenimiento`, `tipo_mantenimiento`, `costo`, `descripcion`.  
**Impacto:**  
Facilita la gestión preventiva del mantenimiento de las máquinas y equipos, ayudando a evitar fallos inesperados y optimizando la vida útil de la maquinaria.

---

## 14. 💸 **Costos_Operativos**
**Función:**  
Almacena los costos relacionados con la operación de la finca, como gastos en insumos, personal, mantenimiento, etc.

**Inserciones (50 registros):**  
Campos: `costo_id`, `tipo_costo`, `monto`, `fecha`.  
**Impacto:**  
Proporciona información clave para la toma de decisiones sobre la rentabilidad de las operaciones y permite realizar análisis de costos y presupuestos.

---

## 15. 💳 **Pagos_Proveedores**
**Función:**  
Registra los pagos realizados a los proveedores por productos y servicios adquiridos.

**Inserciones (50 registros):**  
Campos: `pago_id`, `proveedor_id`, `monto`, `fecha_pago`, `metodo_pago`.  
**Impacto:**  
Facilita la gestión de pagos y la relación con los proveedores, asegurando que las obligaciones financieras se cumplan a tiempo.

---

## 16. 💼 **Pagos_Empleados**
**Función:**  
Almacena los pagos realizados a los empleados, incluyendo el monto y el método de pago.

**Inserciones (50 registros):**  
Campos: `pago_id`, `empleado_id`, `monto`, `fecha_pago`, `metodo_pago`.  
**Impacto:**  
Ayuda en la gestión de la nómina, asegurando que los empleados reciban sus pagos a tiempo y de forma correcta.

---

## 17. 🛡️ **Roles**
**Función:**  
Define los roles de los usuarios en el sistema, especificando los permisos y accesos que cada uno tiene.

**Inserciones (50 registros):**  
Campos: `rol_id`, `nombre_rol`, `descripcion`.  
**Impacto:**  
Mejora la seguridad del sistema al restringir el acceso a ciertas funcionalidades según el rol de cada usuario.

---

## 18. 👤 **Usuarios**
**Función:**  
Contiene los detalles de los usuarios del sistema, como los administradores y operarios que interactúan con la base de datos.

**Inserciones (50 registros):**  
Campos: `usuario_id`, `nombre_usuario`, `contrasena`, `rol_id`.  
**Impacto:**  
Gestiona el acceso al sistema, asegurando que solo los usuarios autorizados puedan modificar datos sensibles.

---

## 📌 **Conclusión**
Este sistema de gestión integral es crucial para optimizar las operaciones de la finca, desde la administración de los productos y el personal hasta el control de inventarios y la gestión financiera. ¡Con él, las decisiones agrícolas y empresariales serán más informadas y eficientes! 🌱💻

## PROCEDIMIENTOS
Este proyecto está diseñado para gestionar la información de ventas, inventarios, proveedores, empleados, maquinaria, y más, mediante procedimientos almacenados en una base de datos SQL. A continuación se describen los procedimientos que permiten interactuar con las distintas tablas y manejar las operaciones clave de este sistema.

Procedimientos:
## 1. Registrar Nueva Venta
Este procedimiento permite registrar una nueva venta, verificando si el producto existe en el inventario y si hay suficiente cantidad disponible. En caso afirmativo, se realiza la venta y se actualiza el inventario en consecuencia.

## 2. Registrar Nuevo Proveedor
Permite agregar un nuevo proveedor al sistema, registrando su nombre, dirección, teléfono y correo electrónico en la tabla correspondiente.

## 3. Registrar Nuevo Empleado
Este procedimiento registra un nuevo empleado en el sistema, incluyendo su nombre, tipo de empleado, salario, fecha de ingreso y estado (activo o inactivo).

## 4. Actualizar Estado de Maquinaria
Este procedimiento permite actualizar el estado de una maquinaria (por ejemplo, marcarla como en mantenimiento o en funcionamiento) en la base de datos.

## 5. Registrar Mantenimiento de Maquinaria
Permite registrar el mantenimiento de una maquinaria, almacenando detalles como el tipo de mantenimiento realizado, el costo y una descripción. Además, actualiza el estado de la maquinaria a "En mantenimiento".

## 6. Actualizar Inventario
Este procedimiento actualiza la cantidad de productos en el inventario. Si el producto ya existe, simplemente se ajusta la cantidad; si no, se agrega el producto a la base de datos.

## 7. Registrar Nueva Compra
Este procedimiento registra una nueva compra de productos, almacenando los detalles de la transacción, como el proveedor, la cantidad adquirida, el precio unitario y la fecha de compra. También actualiza el inventario con la nueva cantidad.

## 8. Actualizar Estado de Tarea
Permite actualizar el estado de una tarea en el sistema, como cambiar su estado de "Pendiente" a "Completada" o cualquier otro estado que se considere necesario.

## 9. Registrar Nueva Tarea
Este procedimiento se utiliza para crear nuevas tareas en el sistema, definiendo su descripción, fecha de inicio y fin, y estado inicial.

## 10. Registrar Historial de Cambios de Empleado
Este procedimiento registra cualquier cambio en los datos de un empleado, como el ajuste de su salario, para mantener un historial de cambios en el sistema.

## 11. Registrar Historial de Cambios en Inventario
Permite registrar cualquier ajuste en la cantidad de productos en el inventario, como una corrección de cantidad debido a un error, asegurando que se mantenga un historial de todos los cambios.

## 12. Actualizar Rendimiento de Cultivo
Este procedimiento permite actualizar el rendimiento promedio de un cultivo en la base de datos, lo que facilita el seguimiento del desempeño de los cultivos.

## 13. Registrar Control de Calidad
Permite registrar la información sobre las revisiones de calidad de los productos, incluyendo el resultado de la revisión y cualquier observación relevante.

## 14. Registrar Cosecha
Este procedimiento permite registrar una cosecha, almacenando detalles como la cantidad recolectada, la fecha de cosecha, el destino y el control de calidad asociado.

## 15. Actualizar Fecha de Actualización de Producto
Este procedimiento actualiza la fecha de última actualización de un producto en el inventario, lo que permite un mejor seguimiento de los cambios en los productos.

## 16. Registrar Pago a Proveedor
Permite registrar el pago realizado a un proveedor, especificando el monto y la fecha del pago.

## 17. Registrar Ingreso de Empleado
Este procedimiento actualiza la fecha de ingreso de un empleado en el sistema, en caso de que se necesite modificar o ajustar esta fecha.

## 18. Registrar Devolución de Venta
Este procedimiento permite manejar la devolución de productos de una venta, asegurándose de que la cantidad devuelta no exceda la cantidad original de la venta. También actualiza el inventario y la venta correspondiente.

## 19. Generar Informe de Ventas
Genera un informe con todas las ventas realizadas entre dos fechas específicas, proporcionando una visión clara de las transacciones en ese rango de tiempo.

## 20. Generar Informe de Mantenimiento
Este procedimiento genera un informe detallado de las actividades de mantenimiento realizadas en las maquinarias en un rango de fechas determinado.


## **FUNCIONES**
Este sistema tiene como objetivo optimizar la gestión de una finca agrícola mediante la implementación de diversas funciones que permiten calcular, monitorear y gestionar aspectos clave del cultivo, la maquinaria, el inventario, las ventas, el personal y los costos operativos. A través de funciones SQL implementadas, los usuarios pueden obtener información detallada sobre el rendimiento de los cultivos, el costo operativo, el mantenimiento de maquinaria, el estado del inventario, y otros aspectos importantes para la toma de decisiones.

## 1. Funcionalidades Implementadas:
Rendimiento Promedio por Hectárea 📊🌾
Permite calcular el rendimiento promedio de un cultivo específico en relación con la cantidad de hectáreas plantadas, facilitando el análisis de la productividad por área de cultivo.

## 2. Costo Operativo Total en un Período 💰📅
Permite calcular el costo total de los costos operativos registrados entre dos fechas, lo que ayuda a controlar los gastos de operación de la finca en un intervalo de tiempo específico.

## 3. Porcentaje de Maquinaria en Mantenimiento 🛠️🚜
Proporciona el porcentaje de la maquinaria que se encuentra en mantenimiento, lo cual es crucial para la planificación de la producción y el uso eficiente de los recursos.

## 4. Ingreso Total de Ventas por Cliente 💸🛍️
Permite calcular el total de ingresos obtenidos por cada cliente, considerando el monto de ventas y los productos adquiridos.

## 5. Salario Promedio por Tipo de Empleado 💼💵
Calcula el salario promedio de los empleados según su tipo de puesto (por ejemplo, gerentes, trabajadores, etc.), lo que ayuda a gestionar la remuneración de manera más eficiente.

## 6. Productos No Disponibles en Inventario 📦❌
Calcula la cantidad de productos que están actualmente fuera de inventario, lo cual permite gestionar mejor las compras y evitar la escasez de productos.

## 7. Rotación de Inventario de un Producto 🔄📦
Mide la rotación del inventario de un producto específico, ayudando a gestionar las existencias y prever la reposición de productos.

## 8. Cantidad de Tareas Completadas ✔️📝
Permite conocer cuántas tareas han sido completadas en la finca, lo que ayuda a hacer un seguimiento del progreso de las operaciones y tareas agrícolas.

## 9. Costo Total de Producción por Cultivo 💰🌱
Calcula el costo total de producción de un cultivo específico, ayudando a determinar la rentabilidad de los cultivos y la asignación eficiente de recursos.

## 10. Cantidad de Hectáreas Asignadas por Zona 🌍📏
Permite calcular el total de hectáreas asignadas a cada zona específica de la finca, lo cual es útil para la planificación de cultivos y gestión territorial.

## 11. Costo Promedio de Mantenimiento por Maquinaria 💵🔧
Calcula el costo promedio de mantenimiento de la maquinaria, lo que permite gestionar mejor los recursos y planificar el mantenimiento de manera eficiente.

## 12. Total de Ventas de un Producto Específico 🛒📊
Permite conocer el total de ventas de un producto específico, lo que ayuda a analizar la demanda de productos y ajustar la producción o compras.

## 13. Tiempo Promedio de Respuesta en Tareas ⏱️📈
Calcula el tiempo promedio de respuesta entre la fecha de inicio y fin de las tareas completadas, permitiendo analizar la eficiencia operativa.

## 14. Cantidad Total de Maquinaria en Uso 🚜🔧
Permite calcular cuántas unidades de maquinaria están actualmente en uso, lo que ayuda a gestionar la disponibilidad de maquinaria y planificar su uso.

## 15. Número Total de Clientes 🧑‍🤝‍🧑📊
Calcula el total de clientes registrados, proporcionando una visión general del alcance de la finca o empresa.

## 16. Número Total de Tareas Pendientes 🕒📝
Permite conocer cuántas tareas pendientes están en espera de ser completadas, lo cual es útil para la planificación operativa.

## 17. Porcentaje de Empleados Activos 👩‍🌾👨‍🌾
Permite conocer el porcentaje de empleados activos dentro de la finca, lo que ayuda a gestionar la plantilla laboral.

## 18. Total de Ventas de un Cliente Específico 💳🛒
Calcula el total de ventas realizadas a un cliente específico, ayudando a realizar análisis de comportamiento y preferencia del cliente.

## 19. Promedio de Ventas por Producto 💰📦
Permite calcular el promedio de ventas de un producto, lo que ayuda a realizar predicciones sobre la demanda futura.

## 20. Inventario Total de un Producto 📦🔢
Calcula el inventario total disponible de un producto, ayudando a gestionar mejor las existencias y evitar escasez.


## **TRIGGERS**
Funcionalidades Implementadas
Rendimiento de los Cultivos:

## 1. Calcular el rendimiento promedio por hectárea de cada cultivo, permitiendo a los usuarios obtener un análisis del desempeño de las cosechas.
Costos Operativos:

## 2. Estimar el costo operativo total de la finca en un período específico, facilitando la gestión financiera y la toma de decisiones.
Ventas:

## 3. Calcular el total de ventas realizadas a cada cliente, brindando una visión clara de la facturación y la relación con los clientes.
Compras:

## 4. Calcular el total de compras realizadas a cada proveedor, ayudando a controlar los gastos en insumos y materiales.
Salarios y Pagos:

## 5. Obtener el salario promedio de los empleados y calcular el total de pagos realizados a los empleados y proveedores en un período determinado.
Inventario:

## 6. Calcular el total de inventario de un producto, lo que facilita el control de existencias y las decisiones de reabastecimiento.
Mantenimiento de Maquinaria:

## 7. Calcular el costo total de mantenimiento de la maquinaria, y obtener el total de tareas de mantenimiento programadas y pendientes.
Evaluaciones de Desempeño:

## 8. Calcular el promedio de puntuaciones de evaluación de desempeño de los empleados, ayudando a gestionar el rendimiento del personal.
Control de Calidad:

## 9. Obtener el porcentaje de calidad de un producto basado en las aprobaciones de las inspecciones de calidad.
Cosechas:

## 10. Calcular el total de cosechas realizadas de un cultivo, facilitando el seguimiento del ciclo de producción.
Tareas:

## 11. Contar el número de tareas pendientes, permitiendo una gestión eficiente de las tareas por realizar.
Ingreso y Producción:

## 12. Obtener el total de ingresos por ventas en un período y calcular el costo total de producción de un cultivo.

### **Descripción Técnica**
Las funcionalidades de este sistema se implementan a través de funciones almacenadas (funciones SQL) que permiten realizar cálculos como el rendimiento de cultivos, costos operativos, ventas, compras, salarios, entre otros. Estas funciones permiten consultar y procesar la información almacenada en las bases de datos de forma eficiente.

Cada función está diseñada para manejar distintos aspectos de la finca, lo que facilita la toma de decisiones y la planificación agrícola.