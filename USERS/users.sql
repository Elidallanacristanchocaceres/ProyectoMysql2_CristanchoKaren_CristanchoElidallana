CREATE USER 'admin'@'localhost' IDENTIFIED BY 'adminpassword';
GRANT ALL PRIVILEGES ON Finca_Agricola.* TO 'admin'@'localhost';
SHOW GRANTS FOR 'admin'@'localhost';
FLUSH PRIVILEGES;

CREATE USER 'vendedor'@'localhost' IDENTIFIED BY 'vendedorpassword';
GRANT SELECT, INSERT, UPDATE ON Finca_Agricola.Ventas TO 'vendedor'@'localhost';
GRANT SELECT, UPDATE ON Finca_Agricola.Inventarios TO 'vendedor'@'localhost';
SHOW GRANTS FOR 'vendedor'@'localhost';
FLUSH PRIVILEGES;

CREATE USER 'contador'@'localhost' IDENTIFIED BY 'contadorpassword';
GRANT SELECT, INSERT, UPDATE ON Finca_Agricola.Costos_Operativos TO 'contador'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Finca_Agricola.Pagos_Proveedores TO 'contador'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Finca_Agricola.Pagos_Empleados TO 'contador'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Finca_Agricola.Pagos_Vendedores TO 'contador'@'localhost';
SHOW GRANTS FOR 'contador'@'localhost';
FLUSH PRIVILEGES;

CREATE USER 'operativo'@'localhost' IDENTIFIED BY 'operativopassword';
GRANT SELECT, INSERT, UPDATE ON Finca_Agricola.Tareas TO 'operativo'@'localhost';
GRANT SELECT, UPDATE ON Finca_Agricola.Maquinaria TO 'operativo'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Finca_Agricola.Cultivos TO 'operativo'@'localhost';
SHOW GRANTS FOR 'operativo'@'localhost';
FLUSH PRIVILEGES;

CREATE USER 'gestor_maquinaria'@'localhost' IDENTIFIED BY 'gestormaqpassword';
GRANT SELECT, INSERT, UPDATE ON Finca_Agricola.Maquinaria TO 'gestor_maquinaria'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Finca_Agricola.Mantenimiento_Maquinaria TO 'gestor_maquinaria'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Finca_Agricola.Tareas_Mantenimiento TO 'gestor_maquinaria'@'localhost';
SHOW GRANTS FOR 'gestor_maquinaria'@'localhost';
FLUSH PRIVILEGES;
