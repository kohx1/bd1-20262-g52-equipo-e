--
-- Scripts de Modificación de la Base de Datos - SGBD PostgreSQL
-- Proyecto: Red Social Pascualina
-- Datos semiestructurados para Big Data / IoT
-- Ejecutar en la base de datos que contiene la tabla usuarios.
--

-- =========================================================
-- 1. DATOS SEMIESTRUCTURADOS: campo perfil_usuario en usuarios
-- =========================================================

-- 1.1 Agregar el campo JSONB.
-- Si ya existe, PostgreSQL mostrará un error; en ese caso,
-- no repitas este ALTER TABLE y continúa con las consultas.
ALTER TABLE usuarios
    ADD COLUMN perfil_usuario JSONB;

-- 1.2 Agregar dos registros de ejemplo.
-- Se actualizan usuarios existentes para no inventar columnas
-- obligatorias ni claves primarias que dependan del modelo.
-- El WHERE limita la actualización a dos usuarios que tengan ID.
WITH usuarios_elegidos AS (
    SELECT ctid
    FROM usuarios
    ORDER BY ctid
    LIMIT 2
)
UPDATE usuarios AS u
SET perfil_usuario = CASE
    WHEN u.ctid = (SELECT ctid FROM usuarios_elegidos LIMIT 1) THEN
        '{"idiomas":["español","lengua de señas colombiana"],"intereses":["fotografía","tecnología"],"preferencias":{"notificaciones":true,"tema":"oscuro"}}'::JSONB
    ELSE
        '{"idiomas":["español","inglés"],"intereses":["música","deporte"],"preferencias":{"notificaciones":false,"tema":"claro"}}'::JSONB
END
WHERE u.ctid IN (SELECT ctid FROM usuarios_elegidos);

-- 1.3 Consultar la información agregada.
SELECT perfil_usuario
FROM usuarios
WHERE perfil_usuario IS NOT NULL
LIMIT 2;

-- 1.4 Descripción y propósito:
-- perfil_usuario guarda datos flexibles del usuario en formato JSONB,
-- por ejemplo idiomas, intereses y preferencias. JSONB permite consultar
-- y filtrar atributos sin crear una columna relacional para cada atributo.


-- =========================================================
-- 2. DATOS SEMIESTRUCTURADOS: campo de creación propia
-- =========================================================

-- Campo elegido: preferencias_contenido, en la tabla usuarios.
-- Guarda preferencias de contenido, temas seguidos y ajustes de accesibilidad.

ALTER TABLE usuarios
    ADD COLUMN preferencias_contenido JSONB;

-- 2.2 Agregar un par de registros de información.
-- Se asignan los dos ejemplos a los primeros dos usuarios disponibles.
WITH usuarios_elegidos AS (
    SELECT ctid
    FROM usuarios
    ORDER BY ctid
    LIMIT 2
)
UPDATE usuarios AS u
SET preferencias_contenido = CASE
    WHEN u.ctid = (SELECT ctid FROM usuarios_elegidos LIMIT 1) THEN
        '{"temas_seguidos":["educación","cultura"],"accesibilidad":{"subtitulos":true,"alto_contraste":false},"frecuencia_resumen":"semanal"}'::JSONB
    ELSE
        '{"temas_seguidos":["ciencia","arte"],"accesibilidad":{"subtitulos":false,"alto_contraste":true},"frecuencia_resumen":"diario"}'::JSONB
END
WHERE u.ctid IN (SELECT ctid FROM usuarios_elegidos);

-- 2.3 Consultar la información agregada.
SELECT preferencias_contenido
FROM usuarios
WHERE preferencias_contenido IS NOT NULL
LIMIT 2;

-- 2.4 Descripción y propósito:
-- preferencias_contenido almacena temas de interés y opciones de accesibilidad
-- en formato JSONB. Es útil para analizar preferencias de muchos usuarios
-- (Big Data) y personalizar contenidos sin alterar el esquema por cada opción.

-- NOTA:
-- Las instrucciones UPDATE de ejemplo modifican los dos primeros usuarios
-- existentes. Si la tabla usuarios está vacía, no se actualizarán registros;
-- inserta primero usuarios válidos usando las columnas y restricciones reales
-- definidas en tu modelo.
