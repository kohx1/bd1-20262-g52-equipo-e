-- =========================================================
-- 1. DATOS SEMIESTRUCTURADOS: campo perfil_usuario en usuario
-- =========================================================

-- 1.1 Agregar el campo JSONB.
ALTER TABLE usuario
    ADD COLUMN perfil_usuario JSONB;

-- 1.2 Agregar dos registros de ejemplo.
WITH usuarios_elegidos AS (
    SELECT ctid
    FROM usuario
    ORDER BY ctid
    LIMIT 2
)
UPDATE usuario AS u
SET perfil_usuario = CASE
    WHEN u.ctid = (SELECT ctid FROM usuarios_elegidos LIMIT 1) THEN
        '{"idiomas":["español","lengua de señas colombiana"],"intereses":["fotografía","tecnología"],"preferencias":{"notificaciones":true,"tema":"oscuro"}}'::JSONB
    ELSE
        '{"idiomas":["español","inglés"],"intereses":["música","deporte"],"preferencias":{"notificaciones":false,"tema":"claro"}}'::JSONB
END
WHERE u.ctid IN (SELECT ctid FROM usuarios_elegidos);

-- 1.3 Consultar la información agregada.
SELECT perfil_usuario
FROM usuario
WHERE perfil_usuario IS NOT NULL
LIMIT 2;


-- =========================================================
-- 2. DATOS SEMIESTRUCTURADOS: campo de creación propia
-- =========================================================

-- 2.1 Agregar el campo JSONB.
ALTER TABLE usuario
    ADD COLUMN preferencias_contenido JSONB;

-- 2.2 Agregar dos registros de ejemplo.
WITH usuarios_elegidos AS (
    SELECT ctid
    FROM usuario
    ORDER BY ctid
    LIMIT 2
)
UPDATE usuario AS u
SET preferencias_contenido = CASE
    WHEN u.ctid = (SELECT ctid FROM usuarios_elegidos LIMIT 1) THEN
        '{"temas_seguidos":["educación","cultura"],"accesibilidad":{"subtitulos":true,"alto_contraste":false},"frecuencia_resumen":"semanal"}'::JSONB
    ELSE
        '{"temas_seguidos":["ciencia","arte"],"accesibilidad":{"subtitulos":false,"alto_contraste":true},"frecuencia_resumen":"diario"}'::JSONB
END
WHERE u.ctid IN (SELECT ctid FROM usuarios_elegidos);

-- 2.3 Consultar la información agregada.
SELECT preferencias_contenido
FROM usuario
WHERE preferencias_contenido IS NOT NULL
LIMIT 2;
