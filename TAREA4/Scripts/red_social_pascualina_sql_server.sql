-- ==============================================================
-- RED SOCIAL PASCUALINA - SCRIPT DE CREACION PARA MICROSOFT SQL SERVER
-- Esquema simplificado con las 18 tablas principales.[cite: 3]
-- Ejecutar en SQL Server Management Studio (SSMS).[cite: 3]
-- ==============================================================

IF DB_ID(N'red_social_pascualina') IS NULL
BEGIN
    CREATE DATABASE [red_social_pascualina];
END;
GO
USE [red_social_pascualina];
GO

-- 1. CREACION DE LAS 18 TABLAS PRINCIPALES[cite: 3]

-- 1.1 Rol[cite: 3]
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

-- 1.2 Tipo de Usuario[cite: 3]
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

-- 1.3 Tipo de Servicio[cite: 3]
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

-- 1.4 Tipo de Producto[cite: 3]
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

-- 1.5 Tipo de Evento[cite: 3]
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

-- 1.6 Usuario[cite: 3]
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

-- 1.7 Perfil[cite: 3]
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

-- 1.8 Publicacion[cite: 3]
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

-- 1.9 Comentario[cite: 3]
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

-- 1.10 Grupo[cite: 3]
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

-- 1.11 Servicio[cite: 3]
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

-- 1.12 Producto[cite: 3]
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

-- 1.13 Evento[cite: 3]
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

-- 1.14 Seguimiento[cite: 3]
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

-- 1.15 Reaccion[cite: 3]
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

-- 1.16 Compra[cite: 3]
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

-- 1.17 Membresia Grupo[cite: 3]
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

-- 1.18 Solicitud Servicio[cite: 3]
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

-- 2. CLAVES FORANEAS ENTRE LAS 18 TABLAS PRINCIPALES[cite: 3]

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

-- 3. VERIFICACION: Muestra exactamente las 18 tablas principales[cite: 3]
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_SCHEMA = 'dbo'
ORDER BY TABLE_NAME;
GO