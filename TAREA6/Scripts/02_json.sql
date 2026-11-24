-- 2. Manipulación de información semiestructurada JSONB
-- Actualiza el perfil del primer usuario; ajustar id_usuario si se desea.
UPDATE perfil
SET informacion_adicional = jsonb_build_object(
  'resumen_profesional','Estudiante interesado en tecnología y desarrollo de software',
  'skills',jsonb_build_array('SQL','Programación','Trabajo en equipo'),
  'areas_interes',jsonb_build_array('Bases de datos','Desarrollo de software','Inteligencia artificial'),
  'idiomas',jsonb_build_array('Español','Inglés'),
  'proyectos',jsonb_build_array('Red Social Pascualina','Proyecto académico de software')
)
WHERE id_usuario = (SELECT MIN(id_usuario) FROM usuario);

-- Consultar campos específicos del documento JSONB
SELECT id_usuario,
       informacion_adicional->>'resumen_profesional' AS resumen_profesional,
       informacion_adicional->'skills' AS habilidades,
       informacion_adicional->'areas_interes' AS areas_interes,
       informacion_adicional->'idiomas' AS idiomas,
       informacion_adicional->'proyectos' AS proyectos
FROM perfil
WHERE informacion_adicional IS NOT NULL
ORDER BY id_usuario
LIMIT 10;
