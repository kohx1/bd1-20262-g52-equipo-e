-- 9. VIEW con 4 JOINs, GROUP BY y HAVING
CREATE OR REPLACE VIEW vista_reporte_ventas AS
SELECT p.nombre_producto,
       tp.nombre_tipo_producto AS categoria_producto,
       u.nombre||' '||u.apellido AS comprador,
       tu.nombre_tipo AS categoria_comprador,
       COUNT(c.id_compra) AS cantidad_compras,
       SUM(c.valor_total) AS total_pagado
FROM compra c
JOIN producto p ON p.id_producto=c.id_producto
JOIN tipo_producto tp ON tp.id_tipo_producto=p.id_tipo_producto
JOIN usuario u ON u.id_usuario=c.id_usuario_comprador
JOIN tipo_usuario tu ON tu.id_tipo_usuario=u.id_tipo_usuario
WHERE tu.nombre_tipo IN ('Egresado','Estudiante')
  AND c.valor_total>100000
GROUP BY p.id_producto,p.nombre_producto,tp.nombre_tipo_producto,
         u.id_usuario,u.nombre,u.apellido,tu.nombre_tipo
HAVING SUM(c.valor_total)>100000;

SELECT * FROM vista_reporte_ventas ORDER BY total_pagado DESC;

-- 10. PREPARE / EXECUTE: requiere tabla puente evento_usuario creada en 01_poblamiento.sql
PREPARE stmt_analisis_participacion_eventos (INT, DATE) AS
SELECT u.nombre||' '||u.apellido AS organizador,
       tu.nombre_tipo AS categoria_organizador,
       te.nombre_tipo_evento AS tipo_evento,
       COUNT(eu.id_usuario) AS total_participantes
FROM evento_usuario eu
JOIN evento e ON e.id_evento=eu.id_evento
JOIN tipo_evento te ON te.id_tipo_evento=e.id_tipo_evento
JOIN usuario u ON u.id_usuario=e.id_usuario
JOIN tipo_usuario tu ON tu.id_tipo_usuario=u.id_tipo_usuario
WHERE te.id_tipo_evento=$1
  AND e.fecha_hora >= $2
  AND eu.estado='Confirmado'
GROUP BY u.id_usuario,u.nombre,u.apellido,tu.nombre_tipo,te.nombre_tipo_evento
HAVING COUNT(eu.id_usuario)>=10
ORDER BY total_participantes DESC;

EXECUTE stmt_analisis_participacion_eventos(1, DATE '2024-01-01');
DEALLOCATE stmt_analisis_participacion_eventos;

-- 11. Rendimiento: tablas de prueba 1.000 y 100.000 filas
DROP TABLE IF EXISTS usuario_1000;
DROP TABLE IF EXISTS usuario_100000;
CREATE TABLE usuario_1000(id_usuario INT PRIMARY KEY,fecha_registro DATE NOT NULL,id_tipo_usuario INT NOT NULL);
INSERT INTO usuario_1000
SELECT n, DATE '2020-01-01'+FLOOR(RANDOM()*2192)::INT, 1+FLOOR(RANDOM()*5)::INT
FROM generate_series(1,1000) n;
CREATE TABLE usuario_100000(id_usuario INT PRIMARY KEY,fecha_registro DATE NOT NULL,id_tipo_usuario INT NOT NULL);
INSERT INTO usuario_100000
SELECT n, DATE '2020-01-01'+FLOOR(RANDOM()*2192)::INT, 1+FLOOR(RANDOM()*5)::INT
FROM generate_series(1,100000) n;
ANALYZE usuario_1000;
ANALYZE usuario_100000;

-- Consultas comparables antes de índices
EXPLAIN (ANALYZE, BUFFERS)
SELECT id_tipo_usuario,COUNT(*) AS total_usuarios
FROM usuario_1000
WHERE fecha_registro BETWEEN DATE '2024-01-01' AND DATE '2024-01-31'
GROUP BY id_tipo_usuario;
EXPLAIN (ANALYZE, BUFFERS)
SELECT id_tipo_usuario,COUNT(*) AS total_usuarios
FROM usuario_100000
WHERE fecha_registro BETWEEN DATE '2024-01-01' AND DATE '2024-01-31'
GROUP BY id_tipo_usuario;

-- Crear índices y repetir; el plan elegido depende del optimizador
CREATE INDEX idx_usuario_1000_fecha ON usuario_1000(fecha_registro);
CREATE INDEX idx_usuario_100000_fecha ON usuario_100000(fecha_registro);
ANALYZE usuario_1000;
ANALYZE usuario_100000;
EXPLAIN (ANALYZE, BUFFERS)
SELECT id_tipo_usuario,COUNT(*) AS total_usuarios
FROM usuario_1000
WHERE fecha_registro BETWEEN DATE '2024-01-01' AND DATE '2024-01-31'
GROUP BY id_tipo_usuario;
EXPLAIN (ANALYZE, BUFFERS)
SELECT id_tipo_usuario,COUNT(*) AS total_usuarios
FROM usuario_100000
WHERE fecha_registro BETWEEN DATE '2024-01-01' AND DATE '2024-01-31'
GROUP BY id_tipo_usuario;

-- 12. ACID
-- 12.1 Atomicidad: ejecutar BEGIN + UPDATE + INSERT por separado.
-- El INSERT debe fallar por FK; luego ejecutar ROLLBACK en otra ejecución.
-- No ejecutar ROLLBACK hasta haber observado el error de FK.
-- BEGIN;
-- SAVEPOINT inicio_compra;
-- UPDATE producto SET precio=precio+1000 WHERE id_producto=(SELECT MIN(id_producto) FROM producto);
-- INSERT INTO compra(id_producto,id_usuario_comprador,fecha_compra,cantidad,valor_total,estado)
-- VALUES ((SELECT MIN(id_producto) FROM producto),-999999,CURRENT_DATE,1,10000,'Completado');
-- Tras error: ROLLBACK;

-- 12.2 Consistencia: CHECK precio >= 0
ALTER TABLE producto DROP CONSTRAINT IF EXISTS chk_producto_precio_no_negativo;
ALTER TABLE producto ADD CONSTRAINT chk_producto_precio_no_negativo CHECK(precio>=0);
-- Ejecutar por separado para observar error 23514:
-- UPDATE producto SET precio=-5000 WHERE id_producto=(SELECT MIN(id_producto) FROM producto);

-- 12.3 Aislamiento (opcional): realizar en DOS sesiones diferentes.
-- Sesión 1: BEGIN; SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
--          SELECT precio FROM producto WHERE id_producto=1;
-- Sesión 2: BEGIN; UPDATE producto SET precio=precio+1000 WHERE id_producto=1; COMMIT;
-- Sesión 1: repetir SELECT; COMMIT;
-- Si se realizó el incremento, restaurar manualmente el precio si corresponde.

-- 12.4 Durabilidad: inserta compra y confirma. Ejecutar una sola vez.
BEGIN;
INSERT INTO compra(id_producto,id_usuario_comprador,fecha_compra,cantidad,valor_total,estado)
SELECT p.id_producto,u.id_usuario,CURRENT_DATE,1,p.precio,'Completado'
FROM producto p CROSS JOIN usuario u
WHERE p.id_producto=(SELECT MIN(id_producto) FROM producto)
  AND u.id_usuario=(SELECT MIN(id_usuario) FROM usuario)
RETURNING *;
COMMIT;
SELECT * FROM compra ORDER BY id_compra DESC LIMIT 5;
