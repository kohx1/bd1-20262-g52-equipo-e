-- Red Social Pascualina
-- Punto 6: Scripts DDL de MODIFICACION
-- PostgreSQL / pgAdmin 4
-- Ejecutar en secuencia, después de ejecutar correctamente scripts-crea.txt.

-- 1.1 Agregar un campo a la tabla usuario.
ALTER TABLE usuario
ADD COLUMN telefono VARCHAR(20);

-- 1.2 Modificar un campo de la tabla usuario.
-- Se amplía el tamaño de estado de 20 a 30 caracteres.
ALTER TABLE usuario
ALTER COLUMN estado TYPE VARCHAR(30);

-- 1.3.1 Crear una tabla nueva relacionada con el sistema.
CREATE TABLE actividad_comunidad (
    id_actividad SERIAL,
    nombre_actividad VARCHAR(100),
    cupo INT,
    observacion TEXT
);

-- 1.3.2 Agregar una clave primaria y otros tres campos.
-- La tabla ya tiene los tres campos; aquí se agrega la clave primaria.
ALTER TABLE actividad_comunidad
ADD CONSTRAINT pk_actividad_comunidad PRIMARY KEY (id_actividad);

-- 1.3.3 Quitar uno de los campos de la tabla nueva.
ALTER TABLE actividad_comunidad
DROP COLUMN observacion;

-- 1.3.4 Cambiar el nombre de la tabla.
ALTER TABLE actividad_comunidad
RENAME TO convocatoria_comunidad;

-- 1.3.5 Agregar un campo único a la tabla renombrada.
ALTER TABLE convocatoria_comunidad
ADD COLUMN codigo VARCHAR(30);

ALTER TABLE convocatoria_comunidad
ADD CONSTRAINT uq_convocatoria_codigo UNIQUE (codigo);

-- 1.3.6 Agregar dos fechas y controlar su orden.
ALTER TABLE convocatoria_comunidad
ADD COLUMN fecha_inicio DATE,
ADD COLUMN fecha_fin DATE;

ALTER TABLE convocatoria_comunidad
ADD CONSTRAINT ck_convocatoria_fechas
CHECK (fecha_fin IS NULL OR fecha_inicio IS NULL OR fecha_fin >= fecha_inicio);

-- 1.3.7 Agregar un campo entero que no permita valores negativos.
ALTER TABLE convocatoria_comunidad
ADD COLUMN cantidad_inscritos INT NOT NULL DEFAULT 0;

ALTER TABLE convocatoria_comunidad
ADD CONSTRAINT ck_convocatoria_cantidad_no_negativa
CHECK (cantidad_inscritos >= 0);

-- 1.3.8 Modificar el tamaño de un campo de texto.
ALTER TABLE convocatoria_comunidad
ALTER COLUMN nombre_actividad TYPE VARCHAR(150);

-- Modificar un campo numérico y establecer un rango permitido.
-- Se establece que el cupo debe estar entre 1 y 100000.
ALTER TABLE convocatoria_comunidad
ADD CONSTRAINT ck_convocatoria_cupo_rango
CHECK (cupo BETWEEN 1 AND 100000);

-- Agregar un índice a uno de los campos.
CREATE INDEX idx_convocatoria_fecha_inicio
ON convocatoria_comunidad (fecha_inicio);

-- Eliminar una de las fechas (fecha_fin).
ALTER TABLE convocatoria_comunidad
DROP CONSTRAINT ck_convocatoria_fechas;

ALTER TABLE convocatoria_comunidad
DROP COLUMN fecha_fin;

-- Borrar todos los datos de una tabla sin eliminar su estructura.
-- TRUNCATE elimina todos los registros existentes de convocatoria_comunidad.
TRUNCATE TABLE convocatoria_comunidad RESTART IDENTITY;

-- Fin del script de modificación.
