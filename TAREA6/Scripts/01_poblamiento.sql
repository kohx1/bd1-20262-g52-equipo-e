-- RED SOCIAL PASCUALINA - 1.1 y 1.2 POBLAMIENTO
-- Ejecutar DESPUES de scripts-crea.sql. Este script agrega catálogos y datos de prueba.

-- 1.1 Catalogos base
INSERT INTO rol(nombre_rol, descripcion) VALUES
('Administrador','Administración de la plataforma'),('Usuario','Usuario general'),('Moderador','Moderación de contenido')
ON CONFLICT (nombre_rol) DO NOTHING;

INSERT INTO tipo_usuario(nombre_tipo, descripcion) VALUES
('Estudiante','Estudiante activo'),('Docente','Docente institucional'),('Egresado','Graduado de la institución'),('Empleado','Empleado institucional'),('Empresario','Usuario empresario'),('Ex-Empleado','Antiguo empleado'),('Ex-Estudiante','Antiguo estudiante'),('Ex-Docente','Antiguo docente'),('Guess','Usuario invitado')
ON CONFLICT (nombre_tipo) DO NOTHING;

INSERT INTO tipo_servicio(nombre_tipo_servicio, descripcion, estado) VALUES
('Asesoría académica','Acompañamiento académico','Activo'),('Tutoría','Tutorías y refuerzos','Activo'),('Soporte tecnológico','Ayuda tecnológica','Activo'),('Préstamo de espacios','Uso de espacios institucionales','Activo')
ON CONFLICT (nombre_tipo_servicio) DO NOTHING;

INSERT INTO tipo_producto(nombre_tipo_producto, descripcion, estado) VALUES
('Libros','Libros y material académico','Activo'),('Tecnología/Computadores','Equipos y accesorios tecnológicos','Activo'),('Papelería','Útiles y papelería','Activo'),('Otros','Otros productos','Activo')
ON CONFLICT (nombre_tipo_producto) DO NOTHING;

INSERT INTO tipo_evento(nombre_tipo_evento, descripcion, estado) VALUES
('Congreso','Congresos académicos','Activo'),('Conferencia','Conferencias','Activo'),('Taller','Talleres prácticos','Activo'),('Seminario','Seminarios académicos','Activo')
ON CONFLICT (nombre_tipo_evento) DO NOTHING;

-- 1.2 Poblamiento masivo automatizado de usuarios: 18.550 registros.
-- Se asigna una categoría por rangos para respetar las cantidades solicitadas.
INSERT INTO usuario(nombre, apellido, correo, contrasena, fecha_registro, estado, id_rol, id_tipo_usuario)
SELECT
  'Usuario' || gs,
  'Prueba' || gs,
  'usuario' || gs || '@redpb.edu.co',
  'hash_demo_no_usar_en_produccion',
  TIMESTAMP '2020-01-01' + (random() * INTERVAL '2200 days'),
  'Activo',
  COALESCE((SELECT id_rol FROM rol WHERE nombre_rol='Usuario'),1),
  CASE
    WHEN gs <= 7000 THEN 1
    WHEN gs <= 7500 THEN 2
    WHEN gs <= 17500 THEN 3
    WHEN gs <= 18000 THEN 4
    WHEN gs <= 18050 THEN 5
    WHEN gs <= 18100 THEN 6
    WHEN gs <= 18400 THEN 7
    WHEN gs <= 18500 THEN 8
    ELSE 9
  END
FROM generate_series(1,18550) gs
ON CONFLICT (correo) DO NOTHING;

-- Perfiles asociados a los usuarios existentes (JSONB inicial vacío).
INSERT INTO perfil(id_usuario, area_estudio, intereses, habilidades, informacion_adicional)
SELECT u.id_usuario, 'Área académica', 'Tecnología y aprendizaje', 'Trabajo en equipo', '{}'::jsonb
FROM usuario u
ON CONFLICT (id_usuario) DO NOTHING;

-- 3.000 servicios, productos y eventos relacionados con usuarios y catálogos.
INSERT INTO servicio(id_usuario,id_tipo_servicio,nombre,descripcion,precio,duracion,ubicacion,estado)
SELECT u.id_usuario, ts.id_tipo_servicio,
       'Servicio '||g, 'Servicio académico generado automáticamente',
       round((5000 + random()*95000)::numeric,2), '60 minutos','Campus Pascual Bravo','Activo'
FROM generate_series(1,3000) g
JOIN usuario u ON u.id_usuario = 1 + ((g-1) % (SELECT max(id_usuario) FROM usuario))
JOIN tipo_servicio ts ON ts.id_tipo_servicio = 1 + ((g-1) % (SELECT max(id_tipo_servicio) FROM tipo_servicio));

INSERT INTO producto(id_usuario,id_tipo_producto,nombre_producto,descripcion,precio,estado,fecha_publicacion)
SELECT u.id_usuario, tp.id_tipo_producto,
       'Producto '||g, 'Producto generado automaticamente',
       round((50000 + random()*450000)::numeric,2),
       CASE WHEN g % 5=0 THEN 'Vendido' ELSE 'Disponible' END,
       TIMESTAMP '2025-01-01' + random()*INTERVAL '600 days'
FROM generate_series(1,3000) g
JOIN usuario u ON u.id_usuario = 1 + ((g-1) % (SELECT max(id_usuario) FROM usuario))
JOIN tipo_producto tp ON tp.id_tipo_producto = 1 + ((g-1) % (SELECT max(id_tipo_producto) FROM tipo_producto));

INSERT INTO evento(id_usuario,id_tipo_evento,nombre_evento,descripcion,fecha_hora,ubicacion,estado)
SELECT u.id_usuario, te.id_tipo_evento,
       'Evento académico '||g, 'Evento generado automáticamente',
       TIMESTAMP '2024-01-01' + random()*INTERVAL '730 days',
       'Institución Universitaria Pascual Bravo','Programado'
FROM generate_series(1,3000) g
JOIN usuario u ON u.id_usuario = 1 + ((g-1) % (SELECT max(id_usuario) FROM usuario))
JOIN tipo_evento te ON te.id_tipo_evento = 1 + ((g-1) % (SELECT max(id_tipo_evento) FROM tipo_evento));

-- Tablas puente / transaccionales equivalentes al modelo físico implementado.
-- evento_usuario se agrega porque el ejercicio 10 requiere registrar participantes.
CREATE TABLE IF NOT EXISTS evento_usuario (
  id_evento_usuario SERIAL PRIMARY KEY,
  id_evento INT NOT NULL REFERENCES evento(id_evento),
  id_usuario INT NOT NULL REFERENCES usuario(id_usuario),
  estado VARCHAR(20) NOT NULL DEFAULT 'Confirmado',
  fecha_inscripcion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(id_evento,id_usuario)
);

INSERT INTO evento_usuario(id_evento,id_usuario,estado)
SELECT e.id_evento, u.id_usuario, 'Confirmado'
FROM generate_series(1,5000) g
JOIN evento e ON e.id_evento = 1 + ((g-1) % (SELECT max(id_evento) FROM evento))
JOIN usuario u ON u.id_usuario = 1 + ((g*7-1) % (SELECT max(id_usuario) FROM usuario))
ON CONFLICT (id_evento,id_usuario) DO NOTHING;

INSERT INTO solicitud_servicio(id_usuario,id_servicio,fecha_solicitud,descripcion_solicitud,estado)
SELECT u.id_usuario, s.id_servicio, CURRENT_TIMESTAMP - random()*INTERVAL '500 days',
       'Solicitud generada automáticamente',
       CASE WHEN g%3=0 THEN 'Completado' WHEN g%3=1 THEN 'Pendiente' ELSE 'Cancelado' END
FROM generate_series(1,5000) g
JOIN servicio s ON s.id_servicio = 1 + ((g-1) % (SELECT max(id_servicio) FROM servicio))
JOIN usuario u ON u.id_usuario = 1 + ((g*11-1) % (SELECT max(id_usuario) FROM usuario));

INSERT INTO compra(id_producto,id_usuario_comprador,fecha_compra,cantidad,valor_total,estado)
SELECT p.id_producto, u.id_usuario, CURRENT_TIMESTAMP-random()*INTERVAL '400 days', 1,
       p.precio, CASE WHEN g%4=0 THEN 'Pendiente' ELSE 'Completado' END
FROM generate_series(1,5000) g
JOIN producto p ON p.id_producto = 1 + ((g-1) % (SELECT max(id_producto) FROM producto))
JOIN usuario u ON u.id_usuario = 1 + ((g*13-1) % (SELECT max(id_usuario) FROM usuario));

-- Verificación rápida de cantidades
SELECT 'usuario' tabla, count(*) total FROM usuario
UNION ALL SELECT 'producto',count(*) FROM producto
UNION ALL SELECT 'servicio',count(*) FROM servicio
UNION ALL SELECT 'evento',count(*) FROM evento
UNION ALL SELECT 'compra',count(*) FROM compra
UNION ALL SELECT 'solicitud_servicio',count(*) FROM solicitud_servicio;
