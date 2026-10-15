--
-- Scripts de Modificación de la Base de Datos - SGBD PostgreSQL
-- Proyecto: Red Social Pascualina
-- Ejecutar todas las instrucciones en secuencia, sin saltarse pasos.
--

-- 1. Crear una tabla inicial coherente con el sistema.
-- Se crea con un campo inicial para después agregar la PK y otros campos.
CREATE TABLE actividad_comunidad (
    id_actividad INTEGER
);

-- 2. Agregar clave primaria y otros tres campos:
--    un campo de texto, uno numérico y otro de texto.
ALTER TABLE actividad_comunidad
    ADD CONSTRAINT pk_actividad_comunidad PRIMARY KEY (id_actividad);

ALTER TABLE actividad_comunidad
    ADD COLUMN titulo VARCHAR(80),
    ADD COLUMN cupo INTEGER,
    ADD COLUMN descripcion TEXT;

-- 3. Quitar uno de los campos creados.
ALTER TABLE actividad_comunidad
    DROP COLUMN descripcion;

-- 4. Cambiar el nombre de la tabla.
ALTER TABLE actividad_comunidad
    RENAME TO convocatoria_comunidad_extra;

-- Todas las operaciones siguientes se hacen sobre la tabla renombrada.

-- 5. Agregar un campo con valores únicos.
ALTER TABLE convocatoria_comunidad_extra
    ADD COLUMN codigo VARCHAR(20) UNIQUE;

-- 6. Agregar fechas de inicio y fin y controlar su orden.
ALTER TABLE convocatoria_comunidad_extra
    ADD COLUMN fecha_inicio DATE,
    ADD COLUMN fecha_fin DATE;

ALTER TABLE convocatoria_comunidad_extra
    ADD CONSTRAINT ck_convocatoria_fechas
    CHECK (
        fecha_inicio IS NULL
        OR fecha_fin IS NULL
        OR fecha_fin >= fecha_inicio
    );

-- 7. Agregar un campo entero que no permita valores negativos.
ALTER TABLE convocatoria_comunidad_extra
    ADD COLUMN asistentes INTEGER NOT NULL DEFAULT 0;

ALTER TABLE convocatoria_comunidad_extra
    ADD CONSTRAINT ck_asistentes_no_negativos
    CHECK (asistentes >= 0);

-- 8. Modificar el tamaño de un campo de texto.
ALTER TABLE convocatoria_comunidad_extra
    ALTER COLUMN titulo TYPE VARCHAR(120);

-- 9. Modificar un campo numérico y controlar su rango.
-- cupo pasa a SMALLINT y solo podrá estar entre 1 y 500.
ALTER TABLE convocatoria_comunidad_extra
    ALTER COLUMN cupo TYPE SMALLINT
    USING cupo::SMALLINT;

ALTER TABLE convocatoria_comunidad_extra
    ADD CONSTRAINT ck_cupo_rango
    CHECK (cupo BETWEEN 1 AND 500);

-- 10. Agregar un índice a un campo.
CREATE INDEX idx_convocatoria_titulo
    ON convocatoria_comunidad_extra (titulo);

-- 11. Eliminar una de las fechas.
-- Primero se elimina la restricción que depende de ambas fechas.
ALTER TABLE convocatoria_comunidad_extra
    DROP CONSTRAINT ck_convocatoria_fechas;

ALTER TABLE convocatoria_comunidad_extra
    DROP COLUMN fecha_fin;

-- 12. Borrar todos los datos de la tabla sin eliminar su estructura.
-- TRUNCATE elimina todas las filas de la tabla seleccionada.
-- La tabla creada por este ejercicio no incluye datos de otras tablas.
TRUNCATE TABLE convocatoria_comunidad_extra;

-- Verificación final: consultar la estructura y comprobar que no hay filas.
SELECT * FROM convocatoria_comunidad_extra;
