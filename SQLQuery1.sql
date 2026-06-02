CREATE DATABASE GestionEmpresarial;
GO
USE GestionEmpresarial;
GO

CREATE TABLE dbo.Departamentos (
 DepartamentoID INT NOT NULL IDENTITY(1,1),
 Nombre VARCHAR(100) NOT NULL,
 Ubicacion VARCHAR(150) NOT NULL,
 Presupuesto DECIMAL(15,2) NOT NULL DEFAULT 0,
 CONSTRAINT PK_Departamentos PRIMARY KEY (DepartamentoID)
);
-- Tabla EMPLEADOS
CREATE TABLE dbo.Empleados (
 EmpleadoID INT NOT NULL IDENTITY(1,1),
 DepartamentoID INT NOT NULL,
 Nombres VARCHAR(100) NOT NULL,
 Apellidos VARCHAR(100) NOT NULL,
 Cargo VARCHAR(80) NOT NULL,
 Salario DECIMAL(12,2) NOT NULL,
 FechaIngreso DATE NOT NULL,
 Email VARCHAR(150) NOT NULL,
 CONSTRAINT PK_Empleados PRIMARY KEY (EmpleadoID),
 CONSTRAINT FK_Emp_Dep FOREIGN KEY (DepartamentoID)
 REFERENCES
dbo.Departamentos(DepartamentoID)
);
-- Tabla PROYECTOS
CREATE TABLE dbo.Proyectos (
 ProyectoID INT NOT NULL IDENTITY(1,1),
 DepartamentoID INT NOT NULL,
 Nombre VARCHAR(150) NOT NULL,
 FechaInicio DATE NOT NULL,
 FechaFin DATE NULL,
 Presupuesto DECIMAL(15,2) NOT NULL,
 Estado VARCHAR(20) NOT NULL
 CHECK (Estado IN
('Activo','Finalizado','Suspendido')),
 CONSTRAINT PK_Proyectos PRIMARY KEY (ProyectoID),
 CONSTRAINT FK_Proy_Dep FOREIGN KEY (DepartamentoID)
 REFERENCES
dbo.Departamentos(DepartamentoID)
);
-- Tabla ASIGNACIONES (relación N:M entre Empleados y Proyectos)
CREATE TABLE dbo.Asignaciones (
 AsignacionID INT NOT NULL IDENTITY(1,1),
 EmpleadoID INT NOT NULL,
 ProyectoID INT NOT NULL,
 HorasAsignadas INT NOT NULL DEFAULT 0,
 RolEnProyecto VARCHAR(80) NOT NULL,
 CONSTRAINT PK_Asignaciones PRIMARY KEY (AsignacionID),
 CONSTRAINT FK_Asig_Emp FOREIGN KEY (EmpleadoID)
 REFERENCES dbo.Empleados(EmpleadoID),
 CONSTRAINT FK_Asig_Proy FOREIGN KEY (ProyectoID)
 REFERENCES dbo.Proyectos(ProyectoID)
);
GO

INSERT INTO dbo.Departamentos (Nombre, Ubicacion, Presupuesto) VALUES
 ('Tecnología', 'Edificio A - Piso 3', 850000.00),
 ('Recursos Humanos', 'Edificio B - Piso 1', 320000.00),
 ('Finanzas', 'Edificio A - Piso 2', 620000.00),
 ('Operaciones', 'Edificio C - Piso 1', 480000.00),
 ('Marketing', 'Edificio B - Piso 2', 290000.00);
INSERT INTO dbo.Empleados
 (DepartamentoID, Nombres, Apellidos, Cargo, Salario, FechaIngreso,
Email) VALUES
 (1, 'Carlos', 'Medina', 'DBA Senior', 4500.00,
'2019-03-15', 'c.medina@empresa.com'),
 (1, 'Lucía', 'Ferreiro', 'Desarrolladora Full Stack', 4200.00,
'2020-07-01', 'l.ferreiro@empresa.com'),
 (1, 'Roberto', 'Solano', 'DevOps Engineer', 3900.00,
'2021-02-20', 'r.solano@empresa.com'),
 (2, 'Ana', 'Gutiérrez', 'Jefa de RRHH', 3800.00,
'2018-09-10', 'a.gutierrez@empresa.com'),
 (2, 'Miguel', 'Torres', 'Analista de RRHH', 2900.00,
'2022-01-15', 'm.torres@empresa.com'),
 (3, 'Patricia', 'Lara', 'Contadora General', 3600.00,
'2017-06-05', 'p.lara@empresa.com'),
 (3, 'Fernando', 'Castillo', 'Analista Financiero', 3100.00,
'2020-11-30', 'f.castillo@empresa.com'),
 (4, 'Daniela', 'Ríos', 'Gerente Operaciones', 4800.00,
'2016-04-01', 'd.rios@empresa.com'),
(4, 'Jorge', 'Mendoza', 'Coordinador Logístico',3200.00,
'2021-08-22', 'j.mendoza@empresa.com'),
 (5, 'Valentina', 'Cruz', 'Directora de Marketing',4300.00,
'2019-05-18', 'v.cruz@empresa.com');
INSERT INTO dbo.Proyectos
 (DepartamentoID, Nombre, FechaInicio, FechaFin, Presupuesto, Estado)
VALUES
 (1, 'Migración a la Nube', '2023-01-10', '2024-06-30',
250000.00, 'Finalizado'),
 (1, 'Sistema ERP Corporativo', '2023-07-01', NULL,
380000.00, 'Activo' ),
 (3, 'Auditoría Financiera Q4', '2023-10-01', '2023-12-31',
45000.00, 'Finalizado'),
 (4, 'Optimización de Rutas', '2024-01-15', NULL,
120000.00, 'Activo' ),
 (5, 'Campaña Digital 2024', '2024-02-01', '2024-11-30',
80000.00, 'Finalizado'),
 (1, 'Portal de Autoservicio', '2024-03-01', NULL,
150000.00, 'Activo' );
INSERT INTO dbo.Asignaciones (EmpleadoID, ProyectoID, HorasAsignadas,
RolEnProyecto) VALUES
 (1, 1, 320, 'Arquitecto de BD'),
 (2, 1, 280, 'Desarrolladora Backend'),
 (3, 1, 200, 'Ingeniero de Infraestructura'),
 (1, 2, 400, 'DBA Principal'),
 (2, 2, 360, 'Desarrolladora Frontend'),
 (3, 2, 300, 'Responsable CI/CD'),
 (6, 3, 160, 'Analista Contable'),
 (7, 3, 120, 'Revisor Financiero'),
 (8, 4, 240, 'Líder de Proyecto'),
 (9, 4, 220, 'Analista de Rutas'),
 (10, 5, 180, 'Directora de Campaña'),
 (2, 6, 200, 'Desarrolladora Full Stack'),
 (1, 6, 120, 'Consultor BD');
GO

-- ============================================================
-- 4. CREACIÓN DE SINÓNIMOS
-- ============================================================
-- Un sinónimo es un objeto de base de datos que actúa como
-- alias de otro objeto (tabla, vista, SP, función, etc.).
-- Sintaxis: CREATE SYNONYM <alias> FOR <objeto_destino>
-- Sinónimos para las tablas base
-- Permiten escribir nombres más cortos y portables entre esquemas.
CREATE SYNONYM dbo.DEP FOR dbo.Departamentos;
CREATE SYNONYM dbo.EMP FOR dbo.Empleados;
CREATE SYNONYM dbo.PRO FOR dbo.Proyectos;
CREATE SYNONYM dbo.ASG FOR dbo.Asignaciones;
-- ¡IMPORTANTE! El sinónimo no duplica datos.
-- SELECT * FROM dbo.EMP ?? SELECT * FROM dbo.Empleados
-- Ambas consultas acceden al MISMO objeto físico.
GO


-- 5. CREACIÓN DE VISTA + SINÓNIMO PARA LA VISTA
-- ============================================================
-- Vista que consolida información de empleados con su departamento
CREATE VIEW dbo.vw_EmpleadoDetalle AS
 SELECT
 E.EmpleadoID,
 E.Nombres + ' ' + E.Apellidos AS NombreCompleto,
 E.Cargo,
 E.Salario,
 E.FechaIngreso,
 D.Nombre AS Departamento,
 D.Ubicacion
 FROM dbo.Empleados E
 INNER JOIN dbo.Departamentos D
 ON E.DepartamentoID = D.DepartamentoID;
GO
-- Sinónimo para la vista
-- Permite referenciar la vista con un nombre abreviado
CREATE SYNONYM dbo.VED FOR dbo.vw_EmpleadoDetalle;
GO

-- Catálogo del sistema para sinónimos
SELECT name AS Sinonimo,
 base_object_name AS ObjetoBase,
  schema_id,
 create_date
FROM sys.synonyms
ORDER BY name;

SELECT EmpleadoID, Nombres, Apellidos, Cargo, Salario
FROM dbo.EMP
ORDER BY Apellidos, Nombres;
-- ?????????????????????????????????????????????
-- 6.2 INNER JOIN - Empleados con su departamento
-- EMP y DEP son sinónimos; SQL Server los resuelve
-- internamente a sus tablas físicas en tiempo de ejecución.
-- ?????????????????????????????????????????????
SELECT E.Nombres, E.Apellidos, E.Cargo,
 D.Nombre AS Departamento,
 E.Salario
FROM dbo.EMP E
INNER JOIN dbo.DEP D ON E.DepartamentoID = D.DepartamentoID
ORDER BY D.Nombre, E.Apellidos;

SELECT D.Nombre AS Departamento,
 COUNT(E.EmpleadoID) AS TotalEmpleados,
 AVG(E.Salario) AS SalarioPromedio,
 MAX(E.Salario) AS SalarioMaximo,
 SUM(E.Salario) AS MasaSalarial
FROM dbo.EMP E
INNER JOIN dbo.DEP D ON E.DepartamentoID = D.DepartamentoID
GROUP BY D.Nombre
ORDER BY MasaSalarial DESC;
-- ?????????????????????????????????????????????
-- 6.4 HAVING - Solo departamentos con masa salarial > 10,000
-- ?????????????????????????????????????????????
SELECT D.Nombre AS Departamento,
 COUNT(E.EmpleadoID) AS TotalEmpleados,
 SUM(E.Salario) AS MasaSalarial
FROM dbo.EMP E
INNER JOIN dbo.DEP D ON E.DepartamentoID = D.DepartamentoID
GROUP BY D.Nombre
HAVING SUM(E.Salario) > 10000
ORDER BY MasaSalarial DESC;
-- ?????????????????????????????????????????????
-- 6.5 Consulta con triple JOIN usando sinónimos
-- Muestra empleados, proyectos y horas asignadas
-- ?????????????????????????????????????????????
SELECT E.Nombres + ' ' + E.Apellidos AS Empleado,
 P.Nombre AS Proyecto,
 P.Estado,
 A.RolEnProyecto,
 A.HorasAsignadas
FROM dbo.ASG A -- Sinónimo de Asignaciones
INNER JOIN dbo.EMP E ON A.EmpleadoID = E.EmpleadoID
INNER JOIN dbo.PRO P ON A.ProyectoID = P.ProyectoID
ORDER BY E.Apellidos, P.Nombre;
-- ?????????????????????????????????????????????
-- 6.6 SUBCONSULTA - Empleados con salario superior
-- al promedio general de la empresa
-- ?????????????????????????????????????????????
SELECT Nombres, Apellidos, Cargo, Salario
FROM dbo.EMP
WHERE Salario > (SELECT AVG(Salario) FROM dbo.EMP)
ORDER BY Salario DESC;

SELECT NombreCompleto, Cargo, Salario, Departamento, Ubicacion
FROM dbo.VED
WHERE Departamento = 'Tecnología'
ORDER BY Salario DESC;
-- ?????????????????????????????????????????????
-- 6.8 Proyectos activos con total de horas asignadas
-- usando GROUP BY + WHERE sobre sinónimos
-- ?????????????????????????????????????????????
SELECT P.Nombre AS Proyecto,
 D.Nombre AS Departamento,
 P.Presupuesto,
 COUNT(A.EmpleadoID) AS Participantes,
 SUM(A.HorasAsignadas) AS TotalHoras
FROM dbo.PRO P
INNER JOIN dbo.DEP D ON P.DepartamentoID = D.DepartamentoID
INNER JOIN dbo.ASG A ON P.ProyectoID = A.ProyectoID
WHERE P.Estado = 'Activo'
GROUP BY P.Nombre, D.Nombre, P.Presupuesto
ORDER BY TotalHoras DESC;
-- ?????????????????????????????????????????????
-- 6.9 Subconsulta correlacionada
-- Empleados que participan en más de 1 proyecto
-- ?????????????????????????????????????????????
SELECT E.Nombres, E.Apellidos, E.Cargo,
 (SELECT COUNT(*)
 FROM dbo.ASG A
 WHERE A.EmpleadoID = E.EmpleadoID) AS TotalProyectos
FROM dbo.EMP E
WHERE (SELECT COUNT(*)
 FROM dbo.ASG A
 WHERE A.EmpleadoID = E.EmpleadoID) > 1
ORDER BY TotalProyectos DESC;
