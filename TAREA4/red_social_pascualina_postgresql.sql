-- Red Social Pascualina
-- Punto 5: Scripts DDL de CREACION
-- PostgreSQL / pgAdmin 4
-- Ejecutar todo el archivo en orden, dentro de la base de datos creada.
-- Se crean primero las tablas independientes y luego las dependientes.

CREATE TABLE rol (
    id_rol SERIAL PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE tipo_usuario (
    id_tipo_usuario SERIAL PRIMARY KEY,
    nombre_tipo VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE tipo_servicio (
    id_tipo_servicio SERIAL PRIMARY KEY,
    nombre_tipo_servicio VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    estado VARCHAR(20) NOT NULL
);

CREATE TABLE tipo_producto (
    id_tipo_producto SERIAL PRIMARY KEY,
    nombre_tipo_producto VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    estado VARCHAR(20) NOT NULL
);

CREATE TABLE tipo_evento (
    id_tipo_evento SERIAL PRIMARY KEY,
    nombre_tipo_evento VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    estado VARCHAR(20) NOT NULL
);

CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) NOT NULL,
    id_rol INT NOT NULL REFERENCES rol(id_rol),
    id_tipo_usuario INT NOT NULL REFERENCES tipo_usuario(id_tipo_usuario)
);

CREATE TABLE perfil (
    id_perfil SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL UNIQUE REFERENCES usuario(id_usuario),
    area_estudio VARCHAR(150),
    intereses TEXT,
    habilidades TEXT,
    informacion_adicional JSONB
);

CREATE TABLE publicacion (
    id_publicacion SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES usuario(id_usuario),
    contenido TEXT NOT NULL,
    tipo_contenido VARCHAR(50) NOT NULL,
    fecha_publicacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) NOT NULL
);

CREATE TABLE grupo (
    id_grupo SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES usuario(id_usuario),
    nombre_grupo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) NOT NULL
);

CREATE TABLE servicio (
    id_servicio SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES usuario(id_usuario),
    id_tipo_servicio INT NOT NULL REFERENCES tipo_servicio(id_tipo_servicio),
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT NOT NULL,
    precio NUMERIC(10,2) NOT NULL,
    duracion VARCHAR(50),
    ubicacion VARCHAR(150),
    estado VARCHAR(20) NOT NULL
);

CREATE TABLE producto (
    id_producto SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES usuario(id_usuario),
    id_tipo_producto INT NOT NULL REFERENCES tipo_producto(id_tipo_producto),
    nombre_producto VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio NUMERIC(10,2) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    fecha_publicacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE evento (
    id_evento SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES usuario(id_usuario),
    id_tipo_evento INT NOT NULL REFERENCES tipo_evento(id_tipo_evento),
    nombre_evento VARCHAR(150) NOT NULL,
    descripcion TEXT,
    fecha_hora TIMESTAMP NOT NULL,
    ubicacion VARCHAR(150),
    estado VARCHAR(20) NOT NULL
);

CREATE TABLE seguimiento (
    id_seguimiento SERIAL PRIMARY KEY,
    id_usuario_seguidor INT NOT NULL REFERENCES usuario(id_usuario),
    id_usuario_seguido INT NOT NULL REFERENCES usuario(id_usuario),
    fecha_seguimiento TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_seguimiento_usuario UNIQUE (id_usuario_seguidor, id_usuario_seguido),
    CONSTRAINT ck_seguimiento_no_autoseguimiento CHECK (id_usuario_seguidor <> id_usuario_seguido)
);

CREATE TABLE comentario (
    id_comentario SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES usuario(id_usuario),
    id_publicacion INT NOT NULL REFERENCES publicacion(id_publicacion),
    contenido TEXT NOT NULL,
    fecha_comentario TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) NOT NULL
);

CREATE TABLE reaccion (
    id_reaccion SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES usuario(id_usuario),
    id_publicacion INT NOT NULL REFERENCES publicacion(id_publicacion),
    tipo_reaccion VARCHAR(30) NOT NULL,
    fecha_reaccion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_reaccion_usuario_publicacion UNIQUE (id_usuario, id_publicacion)
);

CREATE TABLE compra (
    id_compra SERIAL PRIMARY KEY,
    id_producto INT NOT NULL REFERENCES producto(id_producto),
    id_usuario_comprador INT NOT NULL REFERENCES usuario(id_usuario),
    fecha_compra TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    cantidad INT NOT NULL CHECK (cantidad >= 1),
    valor_total NUMERIC(10,2) NOT NULL CHECK (valor_total >= 0),
    estado VARCHAR(20) NOT NULL
);

CREATE TABLE membresia_grupo (
    id_membresia SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES usuario(id_usuario),
    id_grupo INT NOT NULL REFERENCES grupo(id_grupo),
    estado VARCHAR(20) NOT NULL,
    CONSTRAINT uq_membresia_usuario_grupo UNIQUE (id_usuario, id_grupo)
);

CREATE TABLE solicitud_servicio (
    id_solicitud SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES usuario(id_usuario),
    id_servicio INT NOT NULL REFERENCES servicio(id_servicio),
    fecha_solicitud TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    descripcion_solicitud TEXT,
    estado VARCHAR(20) NOT NULL
);

-- Fin del script de creación.
