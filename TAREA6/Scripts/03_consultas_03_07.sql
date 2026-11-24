-- 3. SELECT sin JOIN: productos disponibles entre 50.000 y 500.000
SELECT id_producto AS codigo_producto,
       nombre_producto AS titulo_descriptivo,
       precio AS precio_base,
       ROUND(precio*1.05,2) AS precio_con_recargo_5,
       estado AS disponibilidad
FROM producto
WHERE precio BETWEEN 50000 AND 500000
  AND estado='Disponible'
ORDER BY precio DESC
LIMIT 20;

-- 4. Un JOIN: censo de usuarios por categoría
SELECT tu.nombre_tipo AS categoria_institucional,
       COUNT(u.id_usuario) AS total_usuarios
FROM tipo_usuario tu
LEFT JOIN usuario u ON u.id_tipo_usuario=tu.id_tipo_usuario
GROUP BY tu.id_tipo_usuario,tu.nombre_tipo
ORDER BY total_usuarios DESC;

-- 5. Dos JOINs: eventos y organizadores (años 2024 y 2025)
SELECT e.nombre_evento AS evento,
       te.nombre_tipo_evento AS tipo_evento,
       e.fecha_hora,
       u.nombre||' '||u.apellido AS organizador,
       u.correo
FROM evento e
JOIN tipo_evento te ON te.id_tipo_evento=e.id_tipo_evento
JOIN usuario u ON u.id_usuario=e.id_usuario
WHERE e.fecha_hora >= DATE '2024-01-01'
  AND e.fecha_hora < DATE '2026-01-01'
ORDER BY e.fecha_hora;

-- 6. Tres JOINs: solicitudes de servicios de estudiantes activos
SELECT u.nombre||' '||u.apellido AS estudiante,
       s.nombre AS servicio,
       ts.nombre_tipo_servicio AS categoria_servicio,
       ss.fecha_solicitud,
       ss.estado
FROM solicitud_servicio ss
JOIN servicio s ON s.id_servicio=ss.id_servicio
JOIN tipo_servicio ts ON ts.id_tipo_servicio=s.id_tipo_servicio
JOIN usuario u ON u.id_usuario=ss.id_usuario
WHERE u.id_tipo_usuario=1
  AND ss.estado='Completado'
ORDER BY ss.fecha_solicitud DESC;

-- 7. Cuatro JOINs: reporte de compras / ventas
SELECT p.nombre_producto,
       tp.nombre_tipo_producto AS categoria_producto,
       c.valor_total AS precio_pagado,
       u.nombre||' '||u.apellido AS comprador,
       tu.nombre_tipo AS tipo_usuario
FROM compra c
JOIN producto p ON p.id_producto=c.id_producto
JOIN tipo_producto tp ON tp.id_tipo_producto=p.id_tipo_producto
JOIN usuario u ON u.id_usuario=c.id_usuario_comprador
JOIN tipo_usuario tu ON tu.id_tipo_usuario=u.id_tipo_usuario
WHERE tu.nombre_tipo IN ('Egresado','Estudiante')
  AND c.valor_total>100000
ORDER BY c.valor_total DESC;
