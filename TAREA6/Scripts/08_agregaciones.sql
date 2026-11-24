-- 8.1 COUNT: solicitudes agrupadas por estado
SELECT estado, COUNT(*) AS total_solicitudes
FROM solicitud_servicio
GROUP BY estado
ORDER BY total_solicitudes DESC;

-- 8.2 SUM: recaudo por categorías Libros y Tecnología/Computadores
SELECT tp.nombre_tipo_producto AS categoria,
       SUM(c.valor_total) AS recaudo_total
FROM compra c
JOIN producto p ON p.id_producto=c.id_producto
JOIN tipo_producto tp ON tp.id_tipo_producto=p.id_tipo_producto
WHERE tp.nombre_tipo_producto IN ('Libros','Tecnología/Computadores')
  AND c.estado='Completado'
GROUP BY tp.nombre_tipo_producto
ORDER BY recaudo_total DESC;
