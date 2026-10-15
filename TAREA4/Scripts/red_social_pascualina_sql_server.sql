-- ==============================================================
-- RED SOCIAL PASCUALINA - SCRIPT DE CREACION PARA MICROSOFT SQL SERVER
-- Basado en el diccionario fisico de datos con 41 tablas.
-- Ejecutar en SQL Server Management Studio (SSMS).
-- Este script crea la base de datos si no existe; no elimina datos.
-- ==============================================================

IF DB_ID(N'red_social_pascualina') IS NULL
BEGIN
    CREATE DATABASE [red_social_pascualina];
END;
GO
USE [red_social_pascualina];
GO

-- 1. Creacion de tablas, claves primarias y restricciones UNIQUE
IF OBJECT_ID(N'dbo.usuario', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[usuario] (
        [id_usuario] INT IDENTITY(1,1) NOT NULL,
        [nombre] VARCHAR(80) NULL,
        [apellido] VARCHAR(80) NULL,
        [correo] VARCHAR(150) NULL,
        [contrasena_hash] VARCHAR(255) NULL,
        [fecha_registro] DATETIME2 NULL,
        [estado] VARCHAR(20) NULL,
        [id_rol] INT NULL,
        [id_tipo_usuario] INT NULL,
        CONSTRAINT [PK_usuario] PRIMARY KEY ([id_usuario]),
        CONSTRAINT [UQ_usuario_correo] UNIQUE ([correo])
    );
END;
GO

IF OBJECT_ID(N'dbo.rol', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[rol] (
        [id_rol] INT IDENTITY(1,1) NOT NULL,
        [nombre_rol] VARCHAR(60) NULL,
        [descripcion] VARCHAR(255) NULL,
        CONSTRAINT [PK_rol] PRIMARY KEY ([id_rol]),
        CONSTRAINT [UQ_rol_nombre_rol] UNIQUE ([nombre_rol])
    );
END;
GO

IF OBJECT_ID(N'dbo.tipo_usuario', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[tipo_usuario] (
        [id_tipo_usuario] INT IDENTITY(1,1) NOT NULL,
        [nombre_tipo] VARCHAR(60) NULL,
        [descripcion] VARCHAR(255) NULL,
        CONSTRAINT [PK_tipo_usuario] PRIMARY KEY ([id_tipo_usuario]),
        CONSTRAINT [UQ_tipo_usuario_nombre_tipo] UNIQUE ([nombre_tipo])
    );
END;
GO

IF OBJECT_ID(N'dbo.perfil', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[perfil] (
        [id_perfil] INT IDENTITY(1,1) NOT NULL,
        [id_usuario] INT NULL,
        [area_estudio] VARCHAR(100) NULL,
        [intereses] NVARCHAR(MAX) NULL,
        [habilidades] NVARCHAR(MAX) NULL,
        [informacion_adicional] NVARCHAR(MAX) NULL,
        CONSTRAINT [PK_perfil] PRIMARY KEY ([id_perfil])
    );
END;
GO

IF OBJECT_ID(N'dbo.publicacion', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[publicacion] (
        [id_publicacion] INT IDENTITY(1,1) NOT NULL,
        [id_usuario] INT NULL,
        [contenido] NVARCHAR(MAX) NULL,
        [tipo_contenido] VARCHAR(40) NULL,
        [fecha_publicacion] DATETIME2 NULL,
        [estado] VARCHAR(20) NULL,
        CONSTRAINT [PK_publicacion] PRIMARY KEY ([id_publicacion])
    );
END;
GO

IF OBJECT_ID(N'dbo.comentario', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[comentario] (
        [id_comentario] INT IDENTITY(1,1) NOT NULL,
        [id_usuario] INT NULL,
        [id_publicacion] INT NULL,
        [contenido] NVARCHAR(MAX) NULL,
        [fecha_comentario] DATETIME2 NULL,
        [estado] VARCHAR(20) NULL,
        CONSTRAINT [PK_comentario] PRIMARY KEY ([id_comentario])
    );
END;
GO

IF OBJECT_ID(N'dbo.grupo', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[grupo] (
        [id_grupo] INT IDENTITY(1,1) NOT NULL,
        [id_usuario] INT NULL,
        [nombre_grupo] VARCHAR(100) NULL,
        [descripcion] NVARCHAR(MAX) NULL,
        [fecha_creacion] DATETIME2 NULL,
        [estado] VARCHAR(20) NULL,
        CONSTRAINT [PK_grupo] PRIMARY KEY ([id_grupo])
    );
END;
GO

IF OBJECT_ID(N'dbo.tipo_servicio', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[tipo_servicio] (
        [id_tipo_servicio] INT IDENTITY(1,1) NOT NULL,
        [nombre_tipo_servicio] VARCHAR(80) NULL,
        [descripcion] VARCHAR(255) NULL,
        [estado] VARCHAR(20) NULL,
        CONSTRAINT [PK_tipo_servicio] PRIMARY KEY ([id_tipo_servicio]),
        CONSTRAINT [UQ_tipo_servicio_nombre_tipo_servicio] UNIQUE ([nombre_tipo_servicio])
    );
END;
GO

IF OBJECT_ID(N'dbo.servicio', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[servicio] (
        [id_servicio] INT IDENTITY(1,1) NOT NULL,
        [id_usuario] INT NULL,
        [id_tipo_servicio] INT NULL,
        [nombre_servicio] VARCHAR(100) NULL,
        [descripcion] NVARCHAR(MAX) NULL,
        [precio] DECIMAL(10,2) NULL,
        [duracion] VARCHAR(50) NULL,
        [ubicacion] VARCHAR(150) NULL,
        [estado] VARCHAR(20) NULL,
        CONSTRAINT [PK_servicio] PRIMARY KEY ([id_servicio])
    );
END;
GO

IF OBJECT_ID(N'dbo.tipo_producto', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[tipo_producto] (
        [id_tipo_producto] INT IDENTITY(1,1) NOT NULL,
        [nombre_tipo_producto] VARCHAR(80) NULL,
        [descripcion] VARCHAR(255) NULL,
        [estado] VARCHAR(20) NULL,
        CONSTRAINT [PK_tipo_producto] PRIMARY KEY ([id_tipo_producto]),
        CONSTRAINT [UQ_tipo_producto_nombre_tipo_producto] UNIQUE ([nombre_tipo_producto])
    );
END;
GO

IF OBJECT_ID(N'dbo.producto', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[producto] (
        [id_producto] INT IDENTITY(1,1) NOT NULL,
        [id_usuario] INT NULL,
        [id_tipo_producto] INT NULL,
        [nombre_producto] VARCHAR(120) NULL,
        [descripcion] NVARCHAR(MAX) NULL,
        [precio] DECIMAL(10,2) NULL,
        [estado] VARCHAR(20) NULL,
        [fecha_publicacion] DATETIME2 NULL,
        CONSTRAINT [PK_producto] PRIMARY KEY ([id_producto])
    );
END;
GO

IF OBJECT_ID(N'dbo.tipo_evento', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[tipo_evento] (
        [id_tipo_evento] INT IDENTITY(1,1) NOT NULL,
        [nombre_tipo_evento] VARCHAR(80) NULL,
        [descripcion] VARCHAR(255) NULL,
        [estado] VARCHAR(20) NULL,
        CONSTRAINT [PK_tipo_evento] PRIMARY KEY ([id_tipo_evento]),
        CONSTRAINT [UQ_tipo_evento_nombre_tipo_evento] UNIQUE ([nombre_tipo_evento])
    );
END;
GO

IF OBJECT_ID(N'dbo.evento', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[evento] (
        [id_evento] INT IDENTITY(1,1) NOT NULL,
        [id_usuario] INT NULL,
        [id_tipo_evento] INT NULL,
        [nombre_evento] VARCHAR(120) NULL,
        [descripcion] NVARCHAR(MAX) NULL,
        [fecha_hora] DATETIME2 NULL,
        [ubicacion] VARCHAR(150) NULL,
        [estado] VARCHAR(20) NULL,
        CONSTRAINT [PK_evento] PRIMARY KEY ([id_evento])
    );
END;
GO

IF OBJECT_ID(N'dbo.seguimiento', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[seguimiento] (
        [id_seguimiento] INT IDENTITY(1,1) NOT NULL,
        [id_usuario_seguidor] INT NULL,
        [id_usuario_seguido] INT NULL,
        [fecha_seguimiento] DATETIME2 NULL,
        CONSTRAINT [PK_seguimiento] PRIMARY KEY ([id_seguimiento])
    );
END;
GO

IF OBJECT_ID(N'dbo.reaccion', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[reaccion] (
        [id_reaccion] INT IDENTITY(1,1) NOT NULL,
        [id_usuario] INT NULL,
        [id_publicacion] INT NULL,
        [tipo_reaccion] VARCHAR(30) NULL,
        [fecha_reaccion] DATETIME2 NULL,
        CONSTRAINT [PK_reaccion] PRIMARY KEY ([id_reaccion])
    );
END;
GO

IF OBJECT_ID(N'dbo.compra', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[compra] (
        [id_compra] INT IDENTITY(1,1) NOT NULL,
        [id_producto] INT NULL,
        [id_usuario_comprador] INT NULL,
        [fecha_compra] DATETIME2 NULL,
        [cantidad] INT NULL,
        [valor_total] DECIMAL(10,2) NULL,
        [estado] VARCHAR(20) NULL,
        CONSTRAINT [PK_compra] PRIMARY KEY ([id_compra])
    );
END;
GO

IF OBJECT_ID(N'dbo.membresia_grupo', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[membresia_grupo] (
        [id_membresia] INT IDENTITY(1,1) NOT NULL,
        [id_usuario] INT NULL,
        [id_grupo] INT NULL,
        [estado] VARCHAR(20) NULL,
        CONSTRAINT [PK_membresia_grupo] PRIMARY KEY ([id_membresia])
    );
END;
GO

IF OBJECT_ID(N'dbo.solicitud_servicio', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[solicitud_servicio] (
        [id_solicitud] INT IDENTITY(1,1) NOT NULL,
        [id_usuario] INT NULL,
        [id_servicio] INT NULL,
        [fecha_solicitud] DATETIME2 NULL,
        [descripcion_solicitud] NVARCHAR(MAX) NULL,
        [estado] VARCHAR(20) NULL,
        CONSTRAINT [PK_solicitud_servicio] PRIMARY KEY ([id_solicitud])
    );
END;
GO

IF OBJECT_ID(N'dbo.asignacion_rol', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[asignacion_rol] (
        [id_asignacion_rol] INT IDENTITY(1,1) NOT NULL,
        [id_rol] INT NULL,
        [id_usuario] INT NULL,
        CONSTRAINT [PK_asignacion_rol] PRIMARY KEY ([id_asignacion_rol])
    );
END;
GO

IF OBJECT_ID(N'dbo.clasificacion_usuario', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[clasificacion_usuario] (
        [id_clasificacion_usuario] INT IDENTITY(1,1) NOT NULL,
        [id_tipo_usuario] INT NULL,
        [id_usuario] INT NULL,
        CONSTRAINT [PK_clasificacion_usuario] PRIMARY KEY ([id_clasificacion_usuario])
    );
END;
GO

IF OBJECT_ID(N'dbo.usuario_perfil', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[usuario_perfil] (
        [id_usuario_perfil] INT IDENTITY(1,1) NOT NULL,
        [id_usuario] INT NULL,
        [id_perfil] INT NULL,
        CONSTRAINT [PK_usuario_perfil] PRIMARY KEY ([id_usuario_perfil])
    );
END;
GO

IF OBJECT_ID(N'dbo.usuario_publicacion', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[usuario_publicacion] (
        [id_usuario_publicacion] INT IDENTITY(1,1) NOT NULL,
        [id_usuario] INT NULL,
        [id_publicacion] INT NULL,
        CONSTRAINT [PK_usuario_publicacion] PRIMARY KEY ([id_usuario_publicacion])
    );
END;
GO

IF OBJECT_ID(N'dbo.usuario_comentario', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[usuario_comentario] (
        [id_usuario_comentario] INT IDENTITY(1,1) NOT NULL,
        [id_usuario] INT NULL,
        [id_comentario] INT NULL,
        CONSTRAINT [PK_usuario_comentario] PRIMARY KEY ([id_usuario_comentario])
    );
END;
GO

IF OBJECT_ID(N'dbo.publicacion_comentario', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[publicacion_comentario] (
        [id_publicacion_comentario] INT IDENTITY(1,1) NOT NULL,
        [id_publicacion] INT NULL,
        [id_comentario] INT NULL,
        CONSTRAINT [PK_publicacion_comentario] PRIMARY KEY ([id_publicacion_comentario])
    );
END;
GO

IF OBJECT_ID(N'dbo.usuario_grupo', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[usuario_grupo] (
        [id_usuario_grupo] INT IDENTITY(1,1) NOT NULL,
        [id_usuario] INT NULL,
        [id_grupo] INT NULL,
        CONSTRAINT [PK_usuario_grupo] PRIMARY KEY ([id_usuario_grupo])
    );
END;
GO

IF OBJECT_ID(N'dbo.grupo_membresia', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[grupo_membresia] (
        [id_grupo_membresia] INT IDENTITY(1,1) NOT NULL,
        [id_grupo] INT NULL,
        [id_membresia] INT NULL,
        CONSTRAINT [PK_grupo_membresia] PRIMARY KEY ([id_grupo_membresia])
    );
END;
GO

IF OBJECT_ID(N'dbo.usuario_membresia', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[usuario_membresia] (
        [id_usuario_membresia] INT IDENTITY(1,1) NOT NULL,
        [id_usuario] INT NULL,
        [id_membresia] INT NULL,
        CONSTRAINT [PK_usuario_membresia] PRIMARY KEY ([id_usuario_membresia])
    );
END;
GO

IF OBJECT_ID(N'dbo.usuario_servicio', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[usuario_servicio] (
        [id_usuario_servicio] INT IDENTITY(1,1) NOT NULL,
        [id_usuario] INT NULL,
        [id_servicio] INT NULL,
        CONSTRAINT [PK_usuario_servicio] PRIMARY KEY ([id_usuario_servicio])
    );
END;
GO

IF OBJECT_ID(N'dbo.servicio_tipo_servicio', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[servicio_tipo_servicio] (
        [id_servicio_tipo_servicio] INT IDENTITY(1,1) NOT NULL,
        [id_tipo_servicio] INT NULL,
        [id_servicio] INT NULL,
        CONSTRAINT [PK_servicio_tipo_servicio] PRIMARY KEY ([id_servicio_tipo_servicio])
    );
END;
GO

IF OBJECT_ID(N'dbo.usuario_solicitud_servicio', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[usuario_solicitud_servicio] (
        [id_usuario_solicitud] INT IDENTITY(1,1) NOT NULL,
        [id_usuario] INT NULL,
        [id_solicitud] INT NULL,
        CONSTRAINT [PK_usuario_solicitud_servicio] PRIMARY KEY ([id_usuario_solicitud])
    );
END;
GO

IF OBJECT_ID(N'dbo.servicio_solicitud', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[servicio_solicitud] (
        [id_servicio_solicitud] INT IDENTITY(1,1) NOT NULL,
        [id_servicio] INT NULL,
        [id_solicitud] INT NULL,
        CONSTRAINT [PK_servicio_solicitud] PRIMARY KEY ([id_servicio_solicitud])
    );
END;
GO

IF OBJECT_ID(N'dbo.usuario_producto', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[usuario_producto] (
        [id_usuario_producto] INT IDENTITY(1,1) NOT NULL,
        [id_usuario] INT NULL,
        [id_producto] INT NULL,
        CONSTRAINT [PK_usuario_producto] PRIMARY KEY ([id_usuario_producto])
    );
END;
GO

IF OBJECT_ID(N'dbo.producto_tipo_producto', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[producto_tipo_producto] (
        [id_producto_tipo] INT IDENTITY(1,1) NOT NULL,
        [id_tipo_producto] INT NULL,
        [id_producto] INT NULL,
        CONSTRAINT [PK_producto_tipo_producto] PRIMARY KEY ([id_producto_tipo])
    );
END;
GO

IF OBJECT_ID(N'dbo.producto_compra', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[producto_compra] (
        [id_producto_compra] INT IDENTITY(1,1) NOT NULL,
        [id_producto] INT NULL,
        [id_compra] INT NULL,
        CONSTRAINT [PK_producto_compra] PRIMARY KEY ([id_producto_compra])
    );
END;
GO

IF OBJECT_ID(N'dbo.usuario_compra', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[usuario_compra] (
        [id_usuario_compra] INT IDENTITY(1,1) NOT NULL,
        [id_usuario] INT NULL,
        [id_compra] INT NULL,
        CONSTRAINT [PK_usuario_compra] PRIMARY KEY ([id_usuario_compra])
    );
END;
GO

IF OBJECT_ID(N'dbo.usuario_evento', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[usuario_evento] (
        [id_usuario_evento] INT IDENTITY(1,1) NOT NULL,
        [id_usuario] INT NULL,
        [id_evento] INT NULL,
        CONSTRAINT [PK_usuario_evento] PRIMARY KEY ([id_usuario_evento])
    );
END;
GO

IF OBJECT_ID(N'dbo.evento_tipo_evento', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[evento_tipo_evento] (
        [id_evento_tipo] INT IDENTITY(1,1) NOT NULL,
        [id_tipo_evento] INT NULL,
        [id_evento] INT NULL,
        CONSTRAINT [PK_evento_tipo_evento] PRIMARY KEY ([id_evento_tipo])
    );
END;
GO

IF OBJECT_ID(N'dbo.usuario_seguimiento_inicia', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[usuario_seguimiento_inicia] (
        [id_usuario_seguimiento_inicia] INT IDENTITY(1,1) NOT NULL,
        [id_usuario_seguidor] INT NULL,
        [id_seguimiento] INT NULL,
        CONSTRAINT [PK_usuario_seguimiento_inicia] PRIMARY KEY ([id_usuario_seguimiento_inicia])
    );
END;
GO

IF OBJECT_ID(N'dbo.usuario_seguimiento_recibe', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[usuario_seguimiento_recibe] (
        [id_usuario_seguimiento_recibe] INT IDENTITY(1,1) NOT NULL,
        [id_usuario_seguido] INT NULL,
        [id_seguimiento] INT NULL,
        CONSTRAINT [PK_usuario_seguimiento_recibe] PRIMARY KEY ([id_usuario_seguimiento_recibe])
    );
END;
GO

IF OBJECT_ID(N'dbo.usuario_reaccion', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[usuario_reaccion] (
        [id_usuario_reaccion] INT IDENTITY(1,1) NOT NULL,
        [id_usuario] INT NULL,
        [id_reaccion] INT NULL,
        CONSTRAINT [PK_usuario_reaccion] PRIMARY KEY ([id_usuario_reaccion])
    );
END;
GO

IF OBJECT_ID(N'dbo.publicacion_reaccion', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[publicacion_reaccion] (
        [id_publicacion_reaccion] INT IDENTITY(1,1) NOT NULL,
        [id_publicacion] INT NULL,
        [id_reaccion] INT NULL,
        CONSTRAINT [PK_publicacion_reaccion] PRIMARY KEY ([id_publicacion_reaccion])
    );
END;
GO

-- 2. Creacion de claves foraneas despues de crear todas las tablas
-- Esto permite resolver las dependencias entre tablas.

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_id_rol_rol' AND parent_object_id = OBJECT_ID(N'dbo.usuario'))
BEGIN
    ALTER TABLE [dbo].[usuario] WITH CHECK ADD CONSTRAINT [FK_usuario_id_rol_rol] FOREIGN KEY ([id_rol]) REFERENCES [dbo].[rol] ([id_rol]);
    ALTER TABLE [dbo].[usuario] CHECK CONSTRAINT [FK_usuario_id_rol_rol];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_id_tipo_usuario_tipo_usuario' AND parent_object_id = OBJECT_ID(N'dbo.usuario'))
BEGIN
    ALTER TABLE [dbo].[usuario] WITH CHECK ADD CONSTRAINT [FK_usuario_id_tipo_usuario_tipo_usuario] FOREIGN KEY ([id_tipo_usuario]) REFERENCES [dbo].[tipo_usuario] ([id_tipo_usuario]);
    ALTER TABLE [dbo].[usuario] CHECK CONSTRAINT [FK_usuario_id_tipo_usuario_tipo_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_perfil_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.perfil'))
BEGIN
    ALTER TABLE [dbo].[perfil] WITH CHECK ADD CONSTRAINT [FK_perfil_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[perfil] CHECK CONSTRAINT [FK_perfil_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_publicacion_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.publicacion'))
BEGIN
    ALTER TABLE [dbo].[publicacion] WITH CHECK ADD CONSTRAINT [FK_publicacion_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[publicacion] CHECK CONSTRAINT [FK_publicacion_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_comentario_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.comentario'))
BEGIN
    ALTER TABLE [dbo].[comentario] WITH CHECK ADD CONSTRAINT [FK_comentario_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[comentario] CHECK CONSTRAINT [FK_comentario_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_comentario_id_publicacion_publicacion' AND parent_object_id = OBJECT_ID(N'dbo.comentario'))
BEGIN
    ALTER TABLE [dbo].[comentario] WITH CHECK ADD CONSTRAINT [FK_comentario_id_publicacion_publicacion] FOREIGN KEY ([id_publicacion]) REFERENCES [dbo].[publicacion] ([id_publicacion]);
    ALTER TABLE [dbo].[comentario] CHECK CONSTRAINT [FK_comentario_id_publicacion_publicacion];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_grupo_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.grupo'))
BEGIN
    ALTER TABLE [dbo].[grupo] WITH CHECK ADD CONSTRAINT [FK_grupo_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[grupo] CHECK CONSTRAINT [FK_grupo_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_servicio_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.servicio'))
BEGIN
    ALTER TABLE [dbo].[servicio] WITH CHECK ADD CONSTRAINT [FK_servicio_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[servicio] CHECK CONSTRAINT [FK_servicio_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_servicio_id_tipo_servicio_tipo_servicio' AND parent_object_id = OBJECT_ID(N'dbo.servicio'))
BEGIN
    ALTER TABLE [dbo].[servicio] WITH CHECK ADD CONSTRAINT [FK_servicio_id_tipo_servicio_tipo_servicio] FOREIGN KEY ([id_tipo_servicio]) REFERENCES [dbo].[tipo_servicio] ([id_tipo_servicio]);
    ALTER TABLE [dbo].[servicio] CHECK CONSTRAINT [FK_servicio_id_tipo_servicio_tipo_servicio];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_producto_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.producto'))
BEGIN
    ALTER TABLE [dbo].[producto] WITH CHECK ADD CONSTRAINT [FK_producto_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[producto] CHECK CONSTRAINT [FK_producto_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_producto_id_tipo_producto_tipo_producto' AND parent_object_id = OBJECT_ID(N'dbo.producto'))
BEGIN
    ALTER TABLE [dbo].[producto] WITH CHECK ADD CONSTRAINT [FK_producto_id_tipo_producto_tipo_producto] FOREIGN KEY ([id_tipo_producto]) REFERENCES [dbo].[tipo_producto] ([id_tipo_producto]);
    ALTER TABLE [dbo].[producto] CHECK CONSTRAINT [FK_producto_id_tipo_producto_tipo_producto];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_evento_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.evento'))
BEGIN
    ALTER TABLE [dbo].[evento] WITH CHECK ADD CONSTRAINT [FK_evento_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[evento] CHECK CONSTRAINT [FK_evento_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_evento_id_tipo_evento_tipo_evento' AND parent_object_id = OBJECT_ID(N'dbo.evento'))
BEGIN
    ALTER TABLE [dbo].[evento] WITH CHECK ADD CONSTRAINT [FK_evento_id_tipo_evento_tipo_evento] FOREIGN KEY ([id_tipo_evento]) REFERENCES [dbo].[tipo_evento] ([id_tipo_evento]);
    ALTER TABLE [dbo].[evento] CHECK CONSTRAINT [FK_evento_id_tipo_evento_tipo_evento];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_seguimiento_id_usuario_seguidor_usuario' AND parent_object_id = OBJECT_ID(N'dbo.seguimiento'))
BEGIN
    ALTER TABLE [dbo].[seguimiento] WITH CHECK ADD CONSTRAINT [FK_seguimiento_id_usuario_seguidor_usuario] FOREIGN KEY ([id_usuario_seguidor]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[seguimiento] CHECK CONSTRAINT [FK_seguimiento_id_usuario_seguidor_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_seguimiento_id_usuario_seguido_usuario' AND parent_object_id = OBJECT_ID(N'dbo.seguimiento'))
BEGIN
    ALTER TABLE [dbo].[seguimiento] WITH CHECK ADD CONSTRAINT [FK_seguimiento_id_usuario_seguido_usuario] FOREIGN KEY ([id_usuario_seguido]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[seguimiento] CHECK CONSTRAINT [FK_seguimiento_id_usuario_seguido_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_reaccion_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.reaccion'))
BEGIN
    ALTER TABLE [dbo].[reaccion] WITH CHECK ADD CONSTRAINT [FK_reaccion_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[reaccion] CHECK CONSTRAINT [FK_reaccion_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_reaccion_id_publicacion_publicacion' AND parent_object_id = OBJECT_ID(N'dbo.reaccion'))
BEGIN
    ALTER TABLE [dbo].[reaccion] WITH CHECK ADD CONSTRAINT [FK_reaccion_id_publicacion_publicacion] FOREIGN KEY ([id_publicacion]) REFERENCES [dbo].[publicacion] ([id_publicacion]);
    ALTER TABLE [dbo].[reaccion] CHECK CONSTRAINT [FK_reaccion_id_publicacion_publicacion];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_compra_id_producto_producto' AND parent_object_id = OBJECT_ID(N'dbo.compra'))
BEGIN
    ALTER TABLE [dbo].[compra] WITH CHECK ADD CONSTRAINT [FK_compra_id_producto_producto] FOREIGN KEY ([id_producto]) REFERENCES [dbo].[producto] ([id_producto]);
    ALTER TABLE [dbo].[compra] CHECK CONSTRAINT [FK_compra_id_producto_producto];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_compra_id_usuario_comprador_usuario' AND parent_object_id = OBJECT_ID(N'dbo.compra'))
BEGIN
    ALTER TABLE [dbo].[compra] WITH CHECK ADD CONSTRAINT [FK_compra_id_usuario_comprador_usuario] FOREIGN KEY ([id_usuario_comprador]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[compra] CHECK CONSTRAINT [FK_compra_id_usuario_comprador_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_membresia_grupo_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.membresia_grupo'))
BEGIN
    ALTER TABLE [dbo].[membresia_grupo] WITH CHECK ADD CONSTRAINT [FK_membresia_grupo_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[membresia_grupo] CHECK CONSTRAINT [FK_membresia_grupo_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_membresia_grupo_id_grupo_grupo' AND parent_object_id = OBJECT_ID(N'dbo.membresia_grupo'))
BEGIN
    ALTER TABLE [dbo].[membresia_grupo] WITH CHECK ADD CONSTRAINT [FK_membresia_grupo_id_grupo_grupo] FOREIGN KEY ([id_grupo]) REFERENCES [dbo].[grupo] ([id_grupo]);
    ALTER TABLE [dbo].[membresia_grupo] CHECK CONSTRAINT [FK_membresia_grupo_id_grupo_grupo];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_solicitud_servicio_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.solicitud_servicio'))
BEGIN
    ALTER TABLE [dbo].[solicitud_servicio] WITH CHECK ADD CONSTRAINT [FK_solicitud_servicio_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[solicitud_servicio] CHECK CONSTRAINT [FK_solicitud_servicio_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_solicitud_servicio_id_servicio_servicio' AND parent_object_id = OBJECT_ID(N'dbo.solicitud_servicio'))
BEGIN
    ALTER TABLE [dbo].[solicitud_servicio] WITH CHECK ADD CONSTRAINT [FK_solicitud_servicio_id_servicio_servicio] FOREIGN KEY ([id_servicio]) REFERENCES [dbo].[servicio] ([id_servicio]);
    ALTER TABLE [dbo].[solicitud_servicio] CHECK CONSTRAINT [FK_solicitud_servicio_id_servicio_servicio];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_asignacion_rol_id_rol_rol' AND parent_object_id = OBJECT_ID(N'dbo.asignacion_rol'))
BEGIN
    ALTER TABLE [dbo].[asignacion_rol] WITH CHECK ADD CONSTRAINT [FK_asignacion_rol_id_rol_rol] FOREIGN KEY ([id_rol]) REFERENCES [dbo].[rol] ([id_rol]);
    ALTER TABLE [dbo].[asignacion_rol] CHECK CONSTRAINT [FK_asignacion_rol_id_rol_rol];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_asignacion_rol_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.asignacion_rol'))
BEGIN
    ALTER TABLE [dbo].[asignacion_rol] WITH CHECK ADD CONSTRAINT [FK_asignacion_rol_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[asignacion_rol] CHECK CONSTRAINT [FK_asignacion_rol_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_clasificacion_usuario_id_tipo_usuario_tipo_usuario' AND parent_object_id = OBJECT_ID(N'dbo.clasificacion_usuario'))
BEGIN
    ALTER TABLE [dbo].[clasificacion_usuario] WITH CHECK ADD CONSTRAINT [FK_clasificacion_usuario_id_tipo_usuario_tipo_usuario] FOREIGN KEY ([id_tipo_usuario]) REFERENCES [dbo].[tipo_usuario] ([id_tipo_usuario]);
    ALTER TABLE [dbo].[clasificacion_usuario] CHECK CONSTRAINT [FK_clasificacion_usuario_id_tipo_usuario_tipo_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_clasificacion_usuario_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.clasificacion_usuario'))
BEGIN
    ALTER TABLE [dbo].[clasificacion_usuario] WITH CHECK ADD CONSTRAINT [FK_clasificacion_usuario_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[clasificacion_usuario] CHECK CONSTRAINT [FK_clasificacion_usuario_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_perfil_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.usuario_perfil'))
BEGIN
    ALTER TABLE [dbo].[usuario_perfil] WITH CHECK ADD CONSTRAINT [FK_usuario_perfil_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[usuario_perfil] CHECK CONSTRAINT [FK_usuario_perfil_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_perfil_id_perfil_perfil' AND parent_object_id = OBJECT_ID(N'dbo.usuario_perfil'))
BEGIN
    ALTER TABLE [dbo].[usuario_perfil] WITH CHECK ADD CONSTRAINT [FK_usuario_perfil_id_perfil_perfil] FOREIGN KEY ([id_perfil]) REFERENCES [dbo].[perfil] ([id_perfil]);
    ALTER TABLE [dbo].[usuario_perfil] CHECK CONSTRAINT [FK_usuario_perfil_id_perfil_perfil];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_publicacion_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.usuario_publicacion'))
BEGIN
    ALTER TABLE [dbo].[usuario_publicacion] WITH CHECK ADD CONSTRAINT [FK_usuario_publicacion_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[usuario_publicacion] CHECK CONSTRAINT [FK_usuario_publicacion_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_publicacion_id_publicacion_publicacion' AND parent_object_id = OBJECT_ID(N'dbo.usuario_publicacion'))
BEGIN
    ALTER TABLE [dbo].[usuario_publicacion] WITH CHECK ADD CONSTRAINT [FK_usuario_publicacion_id_publicacion_publicacion] FOREIGN KEY ([id_publicacion]) REFERENCES [dbo].[publicacion] ([id_publicacion]);
    ALTER TABLE [dbo].[usuario_publicacion] CHECK CONSTRAINT [FK_usuario_publicacion_id_publicacion_publicacion];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_comentario_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.usuario_comentario'))
BEGIN
    ALTER TABLE [dbo].[usuario_comentario] WITH CHECK ADD CONSTRAINT [FK_usuario_comentario_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[usuario_comentario] CHECK CONSTRAINT [FK_usuario_comentario_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_comentario_id_comentario_comentario' AND parent_object_id = OBJECT_ID(N'dbo.usuario_comentario'))
BEGIN
    ALTER TABLE [dbo].[usuario_comentario] WITH CHECK ADD CONSTRAINT [FK_usuario_comentario_id_comentario_comentario] FOREIGN KEY ([id_comentario]) REFERENCES [dbo].[comentario] ([id_comentario]);
    ALTER TABLE [dbo].[usuario_comentario] CHECK CONSTRAINT [FK_usuario_comentario_id_comentario_comentario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_publicacion_comentario_id_publicacion_publicacion' AND parent_object_id = OBJECT_ID(N'dbo.publicacion_comentario'))
BEGIN
    ALTER TABLE [dbo].[publicacion_comentario] WITH CHECK ADD CONSTRAINT [FK_publicacion_comentario_id_publicacion_publicacion] FOREIGN KEY ([id_publicacion]) REFERENCES [dbo].[publicacion] ([id_publicacion]);
    ALTER TABLE [dbo].[publicacion_comentario] CHECK CONSTRAINT [FK_publicacion_comentario_id_publicacion_publicacion];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_publicacion_comentario_id_comentario_comentario' AND parent_object_id = OBJECT_ID(N'dbo.publicacion_comentario'))
BEGIN
    ALTER TABLE [dbo].[publicacion_comentario] WITH CHECK ADD CONSTRAINT [FK_publicacion_comentario_id_comentario_comentario] FOREIGN KEY ([id_comentario]) REFERENCES [dbo].[comentario] ([id_comentario]);
    ALTER TABLE [dbo].[publicacion_comentario] CHECK CONSTRAINT [FK_publicacion_comentario_id_comentario_comentario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_grupo_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.usuario_grupo'))
BEGIN
    ALTER TABLE [dbo].[usuario_grupo] WITH CHECK ADD CONSTRAINT [FK_usuario_grupo_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[usuario_grupo] CHECK CONSTRAINT [FK_usuario_grupo_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_grupo_id_grupo_grupo' AND parent_object_id = OBJECT_ID(N'dbo.usuario_grupo'))
BEGIN
    ALTER TABLE [dbo].[usuario_grupo] WITH CHECK ADD CONSTRAINT [FK_usuario_grupo_id_grupo_grupo] FOREIGN KEY ([id_grupo]) REFERENCES [dbo].[grupo] ([id_grupo]);
    ALTER TABLE [dbo].[usuario_grupo] CHECK CONSTRAINT [FK_usuario_grupo_id_grupo_grupo];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_grupo_membresia_id_grupo_grupo' AND parent_object_id = OBJECT_ID(N'dbo.grupo_membresia'))
BEGIN
    ALTER TABLE [dbo].[grupo_membresia] WITH CHECK ADD CONSTRAINT [FK_grupo_membresia_id_grupo_grupo] FOREIGN KEY ([id_grupo]) REFERENCES [dbo].[grupo] ([id_grupo]);
    ALTER TABLE [dbo].[grupo_membresia] CHECK CONSTRAINT [FK_grupo_membresia_id_grupo_grupo];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_grupo_membresia_id_membresia_membresia_grupo' AND parent_object_id = OBJECT_ID(N'dbo.grupo_membresia'))
BEGIN
    ALTER TABLE [dbo].[grupo_membresia] WITH CHECK ADD CONSTRAINT [FK_grupo_membresia_id_membresia_membresia_grupo] FOREIGN KEY ([id_membresia]) REFERENCES [dbo].[membresia_grupo] ([id_membresia]);
    ALTER TABLE [dbo].[grupo_membresia] CHECK CONSTRAINT [FK_grupo_membresia_id_membresia_membresia_grupo];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_membresia_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.usuario_membresia'))
BEGIN
    ALTER TABLE [dbo].[usuario_membresia] WITH CHECK ADD CONSTRAINT [FK_usuario_membresia_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[usuario_membresia] CHECK CONSTRAINT [FK_usuario_membresia_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_membresia_id_membresia_membresia_grupo' AND parent_object_id = OBJECT_ID(N'dbo.usuario_membresia'))
BEGIN
    ALTER TABLE [dbo].[usuario_membresia] WITH CHECK ADD CONSTRAINT [FK_usuario_membresia_id_membresia_membresia_grupo] FOREIGN KEY ([id_membresia]) REFERENCES [dbo].[membresia_grupo] ([id_membresia]);
    ALTER TABLE [dbo].[usuario_membresia] CHECK CONSTRAINT [FK_usuario_membresia_id_membresia_membresia_grupo];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_servicio_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.usuario_servicio'))
BEGIN
    ALTER TABLE [dbo].[usuario_servicio] WITH CHECK ADD CONSTRAINT [FK_usuario_servicio_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[usuario_servicio] CHECK CONSTRAINT [FK_usuario_servicio_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_servicio_id_servicio_servicio' AND parent_object_id = OBJECT_ID(N'dbo.usuario_servicio'))
BEGIN
    ALTER TABLE [dbo].[usuario_servicio] WITH CHECK ADD CONSTRAINT [FK_usuario_servicio_id_servicio_servicio] FOREIGN KEY ([id_servicio]) REFERENCES [dbo].[servicio] ([id_servicio]);
    ALTER TABLE [dbo].[usuario_servicio] CHECK CONSTRAINT [FK_usuario_servicio_id_servicio_servicio];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_servicio_tipo_servicio_id_tipo_servicio_tipo_servicio' AND parent_object_id = OBJECT_ID(N'dbo.servicio_tipo_servicio'))
BEGIN
    ALTER TABLE [dbo].[servicio_tipo_servicio] WITH CHECK ADD CONSTRAINT [FK_servicio_tipo_servicio_id_tipo_servicio_tipo_servicio] FOREIGN KEY ([id_tipo_servicio]) REFERENCES [dbo].[tipo_servicio] ([id_tipo_servicio]);
    ALTER TABLE [dbo].[servicio_tipo_servicio] CHECK CONSTRAINT [FK_servicio_tipo_servicio_id_tipo_servicio_tipo_servicio];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_servicio_tipo_servicio_id_servicio_servicio' AND parent_object_id = OBJECT_ID(N'dbo.servicio_tipo_servicio'))
BEGIN
    ALTER TABLE [dbo].[servicio_tipo_servicio] WITH CHECK ADD CONSTRAINT [FK_servicio_tipo_servicio_id_servicio_servicio] FOREIGN KEY ([id_servicio]) REFERENCES [dbo].[servicio] ([id_servicio]);
    ALTER TABLE [dbo].[servicio_tipo_servicio] CHECK CONSTRAINT [FK_servicio_tipo_servicio_id_servicio_servicio];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_solicitud_servicio_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.usuario_solicitud_servicio'))
BEGIN
    ALTER TABLE [dbo].[usuario_solicitud_servicio] WITH CHECK ADD CONSTRAINT [FK_usuario_solicitud_servicio_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[usuario_solicitud_servicio] CHECK CONSTRAINT [FK_usuario_solicitud_servicio_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_solicitud_servicio_id_solicitud_solicitud_servicio' AND parent_object_id = OBJECT_ID(N'dbo.usuario_solicitud_servicio'))
BEGIN
    ALTER TABLE [dbo].[usuario_solicitud_servicio] WITH CHECK ADD CONSTRAINT [FK_usuario_solicitud_servicio_id_solicitud_solicitud_servicio] FOREIGN KEY ([id_solicitud]) REFERENCES [dbo].[solicitud_servicio] ([id_solicitud]);
    ALTER TABLE [dbo].[usuario_solicitud_servicio] CHECK CONSTRAINT [FK_usuario_solicitud_servicio_id_solicitud_solicitud_servicio];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_servicio_solicitud_id_servicio_servicio' AND parent_object_id = OBJECT_ID(N'dbo.servicio_solicitud'))
BEGIN
    ALTER TABLE [dbo].[servicio_solicitud] WITH CHECK ADD CONSTRAINT [FK_servicio_solicitud_id_servicio_servicio] FOREIGN KEY ([id_servicio]) REFERENCES [dbo].[servicio] ([id_servicio]);
    ALTER TABLE [dbo].[servicio_solicitud] CHECK CONSTRAINT [FK_servicio_solicitud_id_servicio_servicio];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_servicio_solicitud_id_solicitud_solicitud_servicio' AND parent_object_id = OBJECT_ID(N'dbo.servicio_solicitud'))
BEGIN
    ALTER TABLE [dbo].[servicio_solicitud] WITH CHECK ADD CONSTRAINT [FK_servicio_solicitud_id_solicitud_solicitud_servicio] FOREIGN KEY ([id_solicitud]) REFERENCES [dbo].[solicitud_servicio] ([id_solicitud]);
    ALTER TABLE [dbo].[servicio_solicitud] CHECK CONSTRAINT [FK_servicio_solicitud_id_solicitud_solicitud_servicio];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_producto_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.usuario_producto'))
BEGIN
    ALTER TABLE [dbo].[usuario_producto] WITH CHECK ADD CONSTRAINT [FK_usuario_producto_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[usuario_producto] CHECK CONSTRAINT [FK_usuario_producto_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_producto_id_producto_producto' AND parent_object_id = OBJECT_ID(N'dbo.usuario_producto'))
BEGIN
    ALTER TABLE [dbo].[usuario_producto] WITH CHECK ADD CONSTRAINT [FK_usuario_producto_id_producto_producto] FOREIGN KEY ([id_producto]) REFERENCES [dbo].[producto] ([id_producto]);
    ALTER TABLE [dbo].[usuario_producto] CHECK CONSTRAINT [FK_usuario_producto_id_producto_producto];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_producto_tipo_producto_id_tipo_producto_tipo_producto' AND parent_object_id = OBJECT_ID(N'dbo.producto_tipo_producto'))
BEGIN
    ALTER TABLE [dbo].[producto_tipo_producto] WITH CHECK ADD CONSTRAINT [FK_producto_tipo_producto_id_tipo_producto_tipo_producto] FOREIGN KEY ([id_tipo_producto]) REFERENCES [dbo].[tipo_producto] ([id_tipo_producto]);
    ALTER TABLE [dbo].[producto_tipo_producto] CHECK CONSTRAINT [FK_producto_tipo_producto_id_tipo_producto_tipo_producto];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_producto_tipo_producto_id_producto_producto' AND parent_object_id = OBJECT_ID(N'dbo.producto_tipo_producto'))
BEGIN
    ALTER TABLE [dbo].[producto_tipo_producto] WITH CHECK ADD CONSTRAINT [FK_producto_tipo_producto_id_producto_producto] FOREIGN KEY ([id_producto]) REFERENCES [dbo].[producto] ([id_producto]);
    ALTER TABLE [dbo].[producto_tipo_producto] CHECK CONSTRAINT [FK_producto_tipo_producto_id_producto_producto];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_producto_compra_id_producto_producto' AND parent_object_id = OBJECT_ID(N'dbo.producto_compra'))
BEGIN
    ALTER TABLE [dbo].[producto_compra] WITH CHECK ADD CONSTRAINT [FK_producto_compra_id_producto_producto] FOREIGN KEY ([id_producto]) REFERENCES [dbo].[producto] ([id_producto]);
    ALTER TABLE [dbo].[producto_compra] CHECK CONSTRAINT [FK_producto_compra_id_producto_producto];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_producto_compra_id_compra_compra' AND parent_object_id = OBJECT_ID(N'dbo.producto_compra'))
BEGIN
    ALTER TABLE [dbo].[producto_compra] WITH CHECK ADD CONSTRAINT [FK_producto_compra_id_compra_compra] FOREIGN KEY ([id_compra]) REFERENCES [dbo].[compra] ([id_compra]);
    ALTER TABLE [dbo].[producto_compra] CHECK CONSTRAINT [FK_producto_compra_id_compra_compra];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_compra_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.usuario_compra'))
BEGIN
    ALTER TABLE [dbo].[usuario_compra] WITH CHECK ADD CONSTRAINT [FK_usuario_compra_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[usuario_compra] CHECK CONSTRAINT [FK_usuario_compra_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_compra_id_compra_compra' AND parent_object_id = OBJECT_ID(N'dbo.usuario_compra'))
BEGIN
    ALTER TABLE [dbo].[usuario_compra] WITH CHECK ADD CONSTRAINT [FK_usuario_compra_id_compra_compra] FOREIGN KEY ([id_compra]) REFERENCES [dbo].[compra] ([id_compra]);
    ALTER TABLE [dbo].[usuario_compra] CHECK CONSTRAINT [FK_usuario_compra_id_compra_compra];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_evento_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.usuario_evento'))
BEGIN
    ALTER TABLE [dbo].[usuario_evento] WITH CHECK ADD CONSTRAINT [FK_usuario_evento_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[usuario_evento] CHECK CONSTRAINT [FK_usuario_evento_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_evento_id_evento_evento' AND parent_object_id = OBJECT_ID(N'dbo.usuario_evento'))
BEGIN
    ALTER TABLE [dbo].[usuario_evento] WITH CHECK ADD CONSTRAINT [FK_usuario_evento_id_evento_evento] FOREIGN KEY ([id_evento]) REFERENCES [dbo].[evento] ([id_evento]);
    ALTER TABLE [dbo].[usuario_evento] CHECK CONSTRAINT [FK_usuario_evento_id_evento_evento];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_evento_tipo_evento_id_tipo_evento_tipo_evento' AND parent_object_id = OBJECT_ID(N'dbo.evento_tipo_evento'))
BEGIN
    ALTER TABLE [dbo].[evento_tipo_evento] WITH CHECK ADD CONSTRAINT [FK_evento_tipo_evento_id_tipo_evento_tipo_evento] FOREIGN KEY ([id_tipo_evento]) REFERENCES [dbo].[tipo_evento] ([id_tipo_evento]);
    ALTER TABLE [dbo].[evento_tipo_evento] CHECK CONSTRAINT [FK_evento_tipo_evento_id_tipo_evento_tipo_evento];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_evento_tipo_evento_id_evento_evento' AND parent_object_id = OBJECT_ID(N'dbo.evento_tipo_evento'))
BEGIN
    ALTER TABLE [dbo].[evento_tipo_evento] WITH CHECK ADD CONSTRAINT [FK_evento_tipo_evento_id_evento_evento] FOREIGN KEY ([id_evento]) REFERENCES [dbo].[evento] ([id_evento]);
    ALTER TABLE [dbo].[evento_tipo_evento] CHECK CONSTRAINT [FK_evento_tipo_evento_id_evento_evento];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_seguimiento_inicia_id_usuario_seguidor_usuario' AND parent_object_id = OBJECT_ID(N'dbo.usuario_seguimiento_inicia'))
BEGIN
    ALTER TABLE [dbo].[usuario_seguimiento_inicia] WITH CHECK ADD CONSTRAINT [FK_usuario_seguimiento_inicia_id_usuario_seguidor_usuario] FOREIGN KEY ([id_usuario_seguidor]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[usuario_seguimiento_inicia] CHECK CONSTRAINT [FK_usuario_seguimiento_inicia_id_usuario_seguidor_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_seguimiento_inicia_id_seguimiento_seguimiento' AND parent_object_id = OBJECT_ID(N'dbo.usuario_seguimiento_inicia'))
BEGIN
    ALTER TABLE [dbo].[usuario_seguimiento_inicia] WITH CHECK ADD CONSTRAINT [FK_usuario_seguimiento_inicia_id_seguimiento_seguimiento] FOREIGN KEY ([id_seguimiento]) REFERENCES [dbo].[seguimiento] ([id_seguimiento]);
    ALTER TABLE [dbo].[usuario_seguimiento_inicia] CHECK CONSTRAINT [FK_usuario_seguimiento_inicia_id_seguimiento_seguimiento];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_seguimiento_recibe_id_usuario_seguido_usuario' AND parent_object_id = OBJECT_ID(N'dbo.usuario_seguimiento_recibe'))
BEGIN
    ALTER TABLE [dbo].[usuario_seguimiento_recibe] WITH CHECK ADD CONSTRAINT [FK_usuario_seguimiento_recibe_id_usuario_seguido_usuario] FOREIGN KEY ([id_usuario_seguido]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[usuario_seguimiento_recibe] CHECK CONSTRAINT [FK_usuario_seguimiento_recibe_id_usuario_seguido_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_seguimiento_recibe_id_seguimiento_seguimiento' AND parent_object_id = OBJECT_ID(N'dbo.usuario_seguimiento_recibe'))
BEGIN
    ALTER TABLE [dbo].[usuario_seguimiento_recibe] WITH CHECK ADD CONSTRAINT [FK_usuario_seguimiento_recibe_id_seguimiento_seguimiento] FOREIGN KEY ([id_seguimiento]) REFERENCES [dbo].[seguimiento] ([id_seguimiento]);
    ALTER TABLE [dbo].[usuario_seguimiento_recibe] CHECK CONSTRAINT [FK_usuario_seguimiento_recibe_id_seguimiento_seguimiento];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_reaccion_id_usuario_usuario' AND parent_object_id = OBJECT_ID(N'dbo.usuario_reaccion'))
BEGIN
    ALTER TABLE [dbo].[usuario_reaccion] WITH CHECK ADD CONSTRAINT [FK_usuario_reaccion_id_usuario_usuario] FOREIGN KEY ([id_usuario]) REFERENCES [dbo].[usuario] ([id_usuario]);
    ALTER TABLE [dbo].[usuario_reaccion] CHECK CONSTRAINT [FK_usuario_reaccion_id_usuario_usuario];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_usuario_reaccion_id_reaccion_reaccion' AND parent_object_id = OBJECT_ID(N'dbo.usuario_reaccion'))
BEGIN
    ALTER TABLE [dbo].[usuario_reaccion] WITH CHECK ADD CONSTRAINT [FK_usuario_reaccion_id_reaccion_reaccion] FOREIGN KEY ([id_reaccion]) REFERENCES [dbo].[reaccion] ([id_reaccion]);
    ALTER TABLE [dbo].[usuario_reaccion] CHECK CONSTRAINT [FK_usuario_reaccion_id_reaccion_reaccion];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_publicacion_reaccion_id_publicacion_publicacion' AND parent_object_id = OBJECT_ID(N'dbo.publicacion_reaccion'))
BEGIN
    ALTER TABLE [dbo].[publicacion_reaccion] WITH CHECK ADD CONSTRAINT [FK_publicacion_reaccion_id_publicacion_publicacion] FOREIGN KEY ([id_publicacion]) REFERENCES [dbo].[publicacion] ([id_publicacion]);
    ALTER TABLE [dbo].[publicacion_reaccion] CHECK CONSTRAINT [FK_publicacion_reaccion_id_publicacion_publicacion];
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_publicacion_reaccion_id_reaccion_reaccion' AND parent_object_id = OBJECT_ID(N'dbo.publicacion_reaccion'))
BEGIN
    ALTER TABLE [dbo].[publicacion_reaccion] WITH CHECK ADD CONSTRAINT [FK_publicacion_reaccion_id_reaccion_reaccion] FOREIGN KEY ([id_reaccion]) REFERENCES [dbo].[reaccion] ([id_reaccion]);
    ALTER TABLE [dbo].[publicacion_reaccion] CHECK CONSTRAINT [FK_publicacion_reaccion_id_reaccion_reaccion];
END;
GO

-- 3. Verificacion: debe mostrar las 41 tablas
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_SCHEMA = 'dbo'
ORDER BY TABLE_NAME;
GO

-- Para consultar las tablas de una base de datos:
-- SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE';