--
-- RED SOCIAL PASCUALINA
-- Script de creación adaptado de PostgreSQL a MySQL 8.0+
-- Ejecutar en MySQL Workbench o phpMyAdmin.
-- Las tablas se crean en orden para respetar las claves foráneas.
-- Recomendado: MySQL 8.0.16 o superior para aplicar CHECK.
--

CREATE DATABASE IF NOT EXISTS red_social_pascualina
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE red_social_pascualina;

SET FOREIGN_KEY_CHECKS = 1;

-- 1. Tablas catálogo e independientes
CREATE TABLE IF NOT EXISTS rol (
    id_rol BIGINT NOT NULL AUTO_INCREMENT,
    nombre_rol VARCHAR(60) NOT NULL,
    descripcion TEXT,
    PRIMARY KEY (id_rol),
    UNIQUE KEY uq_rol_nombre (nombre_rol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS tipo_usuario (
    id_tipo_usuario BIGINT NOT NULL AUTO_INCREMENT,
    nombre_tipo VARCHAR(60) NOT NULL,
    descripcion TEXT,
    PRIMARY KEY (id_tipo_usuario),
    UNIQUE KEY uq_tipo_usuario_nombre (nombre_tipo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS tipo_servicio (
    id_tipo_servicio BIGINT NOT NULL AUTO_INCREMENT,
    nombre_tipo_servicio VARCHAR(80) NOT NULL,
    descripcion TEXT,
    estado VARCHAR(20) NOT NULL DEFAULT 'activo',
    PRIMARY KEY (id_tipo_servicio),
    UNIQUE KEY uq_tipo_servicio_nombre (nombre_tipo_servicio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS tipo_producto (
    id_tipo_producto BIGINT NOT NULL AUTO_INCREMENT,
    nombre_tipo_producto VARCHAR(80) NOT NULL,
    descripcion TEXT,
    estado VARCHAR(20) NOT NULL DEFAULT 'activo',
    PRIMARY KEY (id_tipo_producto),
    UNIQUE KEY uq_tipo_producto_nombre (nombre_tipo_producto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS tipo_evento (
    id_tipo_evento BIGINT NOT NULL AUTO_INCREMENT,
    nombre_tipo_evento VARCHAR(80) NOT NULL,
    descripcion TEXT,
    estado VARCHAR(20) NOT NULL DEFAULT 'activo',
    PRIMARY KEY (id_tipo_evento),
    UNIQUE KEY uq_tipo_evento_nombre (nombre_tipo_evento)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. Usuario y perfil
CREATE TABLE IF NOT EXISTS usuario (
    id_usuario BIGINT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(80) NOT NULL,
    apellido VARCHAR(80) NOT NULL,
    correo VARCHAR(150) NOT NULL,
    contrasena_hash VARCHAR(255) NOT NULL,
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(30) NOT NULL DEFAULT 'activo',
    id_rol BIGINT NOT NULL,
    id_tipo_usuario BIGINT NOT NULL,
    telefono VARCHAR(20),
    PRIMARY KEY (id_usuario),
    UNIQUE KEY uq_usuario_correo (correo),
    KEY idx_usuario_rol (id_rol),
    KEY idx_usuario_tipo (id_tipo_usuario),
    CONSTRAINT fk_usuario_rol
        FOREIGN KEY (id_rol) REFERENCES rol(id_rol),
    CONSTRAINT fk_usuario_tipo
        FOREIGN KEY (id_tipo_usuario) REFERENCES tipo_usuario(id_tipo_usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS perfil (
    id_perfil BIGINT NOT NULL AUTO_INCREMENT,
    id_usuario BIGINT NOT NULL,
    area_estudio VARCHAR(100),
    intereses TEXT,
    habilidades TEXT,
    informacion_adicional JSON,
    PRIMARY KEY (id_perfil),
    UNIQUE KEY uq_perfil_usuario (id_usuario),
    CONSTRAINT fk_perfil_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. Publicaciones y contenido
CREATE TABLE IF NOT EXISTS publicacion (
    id_publicacion BIGINT NOT NULL AUTO_INCREMENT,
    id_usuario BIGINT NOT NULL,
    contenido TEXT NOT NULL,
    tipo_contenido VARCHAR(40) NOT NULL,
    fecha_publicacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) NOT NULL DEFAULT 'activa',
    PRIMARY KEY (id_publicacion),
    KEY idx_publicacion_usuario (id_usuario),
    CONSTRAINT fk_publicacion_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS comentario (
    id_comentario BIGINT NOT NULL AUTO_INCREMENT,
    id_usuario BIGINT NOT NULL,
    id_publicacion BIGINT NOT NULL,
    contenido TEXT NOT NULL,
    fecha_comentario TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) NOT NULL DEFAULT 'activo',
    PRIMARY KEY (id_comentario),
    KEY idx_comentario_usuario (id_usuario),
    KEY idx_comentario_publicacion (id_publicacion),
    CONSTRAINT fk_comentario_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    CONSTRAINT fk_comentario_publicacion
        FOREIGN KEY (id_publicacion) REFERENCES publicacion(id_publicacion)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS grupo (
    id_grupo BIGINT NOT NULL AUTO_INCREMENT,
    id_usuario BIGINT NOT NULL,
    nombre_grupo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) NOT NULL DEFAULT 'activo',
    PRIMARY KEY (id_grupo),
    KEY idx_grupo_usuario (id_usuario),
    CONSTRAINT fk_grupo_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Servicios, productos y eventos
CREATE TABLE IF NOT EXISTS servicio (
    id_servicio BIGINT NOT NULL AUTO_INCREMENT,
    id_usuario BIGINT NOT NULL,
    id_tipo_servicio BIGINT NOT NULL,
    nombre_servicio VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2),
    duracion VARCHAR(50),
    ubicacion VARCHAR(150),
    estado VARCHAR(20) NOT NULL DEFAULT 'disponible',
    PRIMARY KEY (id_servicio),
    KEY idx_servicio_usuario (id_usuario),
    KEY idx_servicio_tipo (id_tipo_servicio),
    CONSTRAINT chk_servicio_precio CHECK (precio IS NULL OR precio >= 0),
    CONSTRAINT fk_servicio_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    CONSTRAINT fk_servicio_tipo
        FOREIGN KEY (id_tipo_servicio) REFERENCES tipo_servicio(id_tipo_servicio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS producto (
    id_producto BIGINT NOT NULL AUTO_INCREMENT,
    id_usuario BIGINT NOT NULL,
    id_tipo_producto BIGINT NOT NULL,
    nombre_producto VARCHAR(120) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'disponible',
    fecha_publicacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_producto),
    KEY idx_producto_usuario (id_usuario),
    KEY idx_producto_tipo (id_tipo_producto),
    CONSTRAINT chk_producto_precio CHECK (precio >= 0),
    CONSTRAINT fk_producto_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    CONSTRAINT fk_producto_tipo
        FOREIGN KEY (id_tipo_producto) REFERENCES tipo_producto(id_tipo_producto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS evento (
    id_evento BIGINT NOT NULL AUTO_INCREMENT,
    id_usuario BIGINT NOT NULL,
    id_tipo_evento BIGINT NOT NULL,
    nombre_evento VARCHAR(120) NOT NULL,
    descripcion TEXT,
    fecha_hora DATETIME NOT NULL,
    ubicacion VARCHAR(150),
    estado VARCHAR(20) NOT NULL DEFAULT 'programado',
    PRIMARY KEY (id_evento),
    KEY idx_evento_usuario (id_usuario),
    KEY idx_evento_tipo (id_tipo_evento),
    CONSTRAINT fk_evento_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    CONSTRAINT fk_evento_tipo
        FOREIGN KEY (id_tipo_evento) REFERENCES tipo_evento(id_tipo_evento)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Tablas asociativas para relaciones N:M
CREATE TABLE IF NOT EXISTS seguimiento (
    id_seguimiento BIGINT NOT NULL AUTO_INCREMENT,
    id_usuario_seguidor BIGINT NOT NULL,
    id_usuario_seguido BIGINT NOT NULL,
    fecha_seguimiento TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_seguimiento),
    UNIQUE KEY uq_seguimiento (id_usuario_seguidor, id_usuario_seguido),
    KEY idx_seguimiento_seguido (id_usuario_seguido),
    CONSTRAINT chk_seguimiento_distinto CHECK (id_usuario_seguidor <> id_usuario_seguido),
    CONSTRAINT fk_seguimiento_seguidor
        FOREIGN KEY (id_usuario_seguidor) REFERENCES usuario(id_usuario)
        ON DELETE CASCADE,
    CONSTRAINT fk_seguimiento_seguido
        FOREIGN KEY (id_usuario_seguido) REFERENCES usuario(id_usuario)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS reaccion (
    id_reaccion BIGINT NOT NULL AUTO_INCREMENT,
    id_usuario BIGINT NOT NULL,
    id_publicacion BIGINT NOT NULL,
    tipo_reaccion VARCHAR(30) NOT NULL,
    fecha_reaccion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_reaccion),
    UNIQUE KEY uq_reaccion_usuario_publicacion (id_usuario, id_publicacion),
    KEY idx_reaccion_publicacion (id_publicacion),
    CONSTRAINT fk_reaccion_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
        ON DELETE CASCADE,
    CONSTRAINT fk_reaccion_publicacion
        FOREIGN KEY (id_publicacion) REFERENCES publicacion(id_publicacion)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS compra (
    id_compra BIGINT NOT NULL AUTO_INCREMENT,
    id_producto BIGINT NOT NULL,
    id_usuario_comprador BIGINT NOT NULL,
    fecha_compra TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    cantidad INT NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'pendiente',
    PRIMARY KEY (id_compra),
    KEY idx_compra_producto (id_producto),
    KEY idx_compra_comprador (id_usuario_comprador),
    CONSTRAINT chk_compra_cantidad CHECK (cantidad > 0),
    CONSTRAINT chk_compra_valor CHECK (valor_total >= 0),
    CONSTRAINT fk_compra_producto
        FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    CONSTRAINT fk_compra_comprador
        FOREIGN KEY (id_usuario_comprador) REFERENCES usuario(id_usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS membresia_grupo (
    id_membresia BIGINT NOT NULL AUTO_INCREMENT,
    id_usuario BIGINT NOT NULL,
    id_grupo BIGINT NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'activa',
    PRIMARY KEY (id_membresia),
    UNIQUE KEY uq_membresia_usuario_grupo (id_usuario, id_grupo),
    KEY idx_membresia_grupo (id_grupo),
    CONSTRAINT fk_membresia_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
        ON DELETE CASCADE,
    CONSTRAINT fk_membresia_grupo
        FOREIGN KEY (id_grupo) REFERENCES grupo(id_grupo)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS solicitud_servicio (
    id_solicitud BIGINT NOT NULL AUTO_INCREMENT,
    id_usuario BIGINT NOT NULL,
    id_servicio BIGINT NOT NULL,
    fecha_solicitud TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descripcion_solicitud TEXT,
    estado VARCHAR(20) NOT NULL DEFAULT 'pendiente',
    PRIMARY KEY (id_solicitud),
    KEY idx_solicitud_servicio_usuario (id_usuario),
    KEY idx_solicitud_servicio_servicio (id_servicio),
    CONSTRAINT fk_solicitud_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    CONSTRAINT fk_solicitud_servicio
        FOREIGN KEY (id_servicio) REFERENCES servicio(id_servicio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 6. Tabla adicional del trabajo de modificación.
-- Se deja incorporada en el esquema final, sin la columna fecha_fin
-- porque esa columna se eliminaba al final del script de modificación.
CREATE TABLE IF NOT EXISTS convocatoria_comunidad (
    id_actividad BIGINT NOT NULL AUTO_INCREMENT,
    nombre_actividad VARCHAR(150) NOT NULL,
    cupo INT NOT NULL,
    codigo VARCHAR(30) NOT NULL,
    fecha_inicio DATE NOT NULL,
    cantidad_inscritos INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id_actividad),
    UNIQUE KEY uq_convocatoria_codigo (codigo),
    CONSTRAINT chk_convocatoria_cupo CHECK (cupo BETWEEN 1 AND 100000),
    CONSTRAINT chk_convocatoria_inscritos CHECK (cantidad_inscritos >= 0),
    CONSTRAINT chk_convocatoria_inscritos_cupo CHECK (cantidad_inscritos <= cupo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Verificación final: debe mostrar las tablas del esquema.
SHOW TABLES;
