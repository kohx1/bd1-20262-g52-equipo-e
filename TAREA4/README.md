# TAREA 4

Esta carpeta contiene los scripts de creación y modificación de la base de datos **Red Social Pascualina** para distintos gestores.

## Scripts de creación

- **`red_social_pascualina_mysql.sql`**: crea la base de datos y sus tablas en MySQL 8.0 o superior. Incluye catálogos, usuarios y perfiles, publicaciones, grupos, servicios, productos, eventos y sus relaciones.
- **`red_social_pascualina_postgresql.sql`**: crea las tablas principales y sus relaciones en PostgreSQL. Incluye datos JSONB para la información adicional del perfil.
- **`red_social_pascualina_sql_server.sql`**: crea la base de datos y el esquema de Red Social Pascualina en Microsoft SQL Server. Está preparado para ejecutarse desde SQL Server Management Studio (SSMS).

## Scripts de modificación para PostgreSQL

- **`scripts-modifica-red_social_pascualina_postgresql.sql`**: practica operaciones DDL sobre una tabla de convocatorias: agrega y elimina columnas, cambia nombres y tipos, define restricciones e índices y vacía la tabla al final. **La instrucción `TRUNCATE` elimina todas las filas de `convocatoria_comunidad_extra`**; ejecútalo solo en una base de datos de prueba o después de respaldar los datos.
- **`scripts-modifica-jsonb-red_social_pascualina_postgresql.sql`**: agrega a `usuarios` dos campos JSONB de ejemplo (`perfil_usuario` y `preferencias_contenido`), actualiza hasta dos registros y consulta los valores. Requiere que exista la tabla `usuarios` y que tenga registros para ver los ejemplos; si el esquema usa otro nombre de tabla, ajusta el script.

## Entregables

- **`20262-bd1-ea4-E-E-informe.docx.pdf`**: informe de la Tarea 4 en formato PDF.
- **`20262-bd1-ea4-E-E-resultados (1).xlsx`**: libro de Excel con los resultados de la Tarea 4.

Ejecuta cada archivo únicamente en el gestor indicado por su nombre y revisa las instrucciones y dependencias del script antes de correrlo en una base de datos con información importante.
