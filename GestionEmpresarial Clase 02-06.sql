USE GestionEmpresarial


/* UPDATE PROYECTOS */
CREATE TRIGGER trg_proyectos_update
ON dbo.Proyectos AFTER UPDATE
AS 
BEGIN
	UPDATE Proyectos set updated_at = GETDATE()
	from Proyectos p
	INNER JOIN inserted i on p.proyectoID = i.ProyectoID
END

UPDATE Proyectos SET Presupuesto = 20000 WHERE ProyectoID = 1

SELECT * FROM Proyectos

UPDATE Proyectos set isActive = 1

/* UPDATE Departamentos*/

CREATE TABLE tblAuditoria
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UsuarioSistema VARCHAR(128) NOT NULL,
    Accion VARCHAR(100) NOT NULL,
    Hora DATETIME2 NOT NULL DEFAULT SYSDATETIME()
);
GO

CREATE TRIGGER TR_Empleados_Insert
ON dbo.Empleados
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO tblAuditoria (UsuarioSistema, Accion, Hora)
    VALUES (SUSER_SNAME(), 'INSERT en Empleados', SYSDATETIME());
END;
GO

CREATE TRIGGER TR_Empleados_Update
ON dbo.Empleados
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO tblAuditoria (UsuarioSistema, Accion, Hora)
    VALUES (SUSER_SNAME(), 'UPDATE en Empleados', SYSDATETIME());
END;
GO

CREATE TRIGGER TR_Empleados_Delete
ON dbo.Empleados
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO tblAuditoria (UsuarioSistema, Accion, Hora)
    VALUES (SUSER_SNAME(), 'DELETE en Empleados', SYSDATETIME());
END;
GO

CREATE TRIGGER TR_Empleados_Delete
ON dbo.Empleados
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO tblAuditoria (UsuarioSistema, Accion, Hora)
    VALUES (SUSER_SNAME(), 'DELETE en Empleados', SYSDATETIME());
END;
GO

CREATE OR ALTER TRIGGER TR_Departamentos_Insert
ON dbo.Departamentos
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.tblAuditoria(UsuarioSistema, Accion, Hora)
    VALUES (SUSER_SNAME(), 'INSERT en Departamentos', SYSDATETIME());
END;
GO

CREATE OR ALTER TRIGGER TR_Departamentos_Update
ON dbo.Departamentos
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.tblAuditoria(UsuarioSistema, Accion, Hora)
    VALUES (SUSER_SNAME(), 'UPDATE en Departamentos', SYSDATETIME());
END;
GO

CREATE OR ALTER TRIGGER TR_Departamentos_Delete
ON dbo.Departamentos
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.tblAuditoria(UsuarioSistema, Accion, Hora)
    VALUES (SUSER_SNAME(), 'DELETE en Departamentos', SYSDATETIME());
END;


/*Proyectos*/

CREATE OR ALTER TRIGGER TR_Proyectos_Insert
ON dbo.Proyectos
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.tblAuditoria(UsuarioSistema, Accion, Hora)
    VALUES (SUSER_SNAME(), 'INSERT en Proyectos', SYSDATETIME());
END;
GO

CREATE OR ALTER TRIGGER TR_Proyectos_Update
ON dbo.Proyectos
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.tblAuditoria(UsuarioSistema, Accion, Hora)
    VALUES (SUSER_SNAME(), 'UPDATE en Proyectos', SYSDATETIME());
END;
GO

CREATE OR ALTER TRIGGER TR_Proyectos_Delete
ON dbo.Proyectos
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.tblAuditoria(UsuarioSistema, Accion, Hora)
    VALUES (SUSER_SNAME(), 'DELETE en Proyectos', SYSDATETIME());
END;
GO

/*=====================================================
    ASIGNACIONES
=====================================================*/

CREATE OR ALTER TRIGGER TR_Asignaciones_Insert
ON dbo.Asignaciones
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.tblAuditoria(UsuarioSistema, Accion, Hora)
    VALUES (SUSER_SNAME(), 'INSERT en Asignaciones', SYSDATETIME());
END;
GO

CREATE OR ALTER TRIGGER TR_Asignaciones_Update
ON dbo.Asignaciones
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.tblAuditoria(UsuarioSistema, Accion, Hora)
    VALUES (SUSER_SNAME(), 'UPDATE en Asignaciones', SYSDATETIME());
END;
GO

CREATE OR ALTER TRIGGER TR_Asignaciones_Delete
ON dbo.Asignaciones
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.tblAuditoria(UsuarioSistema, Accion, Hora)
    VALUES (SUSER_SNAME(), 'DELETE en Asignaciones', SYSDATETIME());
END;
GO