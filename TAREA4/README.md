# TAREA 4

Esta carpeta organiza los entregables de la base de datos **Red Social Pascualina** por categoría:

```text
TAREA4/
├── Informe/
├── Diccionarios/
├── Scripts/
└── Video/
```

## Informe

- **`Informe/20262-bd1-ea4-E-E-informe.docx.pdf`**: informe detallado de la Tarea 4.

## Diccionarios

- **`Diccionarios/20262-bd1-ea4-E-E-resultados (1).xlsx`**: libro de Excel con los resultados y el diccionario de datos físico.

## Scripts

- **`Scripts/red_social_pascualina_postgresql.sql`**: crea las tablas principales y sus relaciones en PostgreSQL, incluido el campo JSONB del perfil.
- **`Scripts/red_social_pascualina_mysql.sql`**: crea la base de datos y las tablas de Red Social Pascualina en MySQL 8.0 o superior.
- **`Scripts/red_social_pascualina_sql_server.sql`**: crea la base de datos y el esquema para Microsoft SQL Server; está preparado para SQL Server Management Studio (SSMS).
- **`Scripts/scripts-modifica-red_social_pascualina_postgresql.sql`**: practica modificaciones DDL en una tabla de convocatorias. **Incluye `TRUNCATE`, que elimina todas las filas de `convocatoria_comunidad_extra`**; ejecútalo solo en una base de datos de prueba o tras respaldar los datos.
- **`Scripts/scripts-modifica-jsonb-red_social_pascualina_postgresql.sql`**: agrega campos JSONB de ejemplo a `usuarios`, actualiza hasta dos registros y consulta los valores. Requiere que exista esa tabla y que tenga registros; ajusta el script si tu esquema usa otro nombre.

## Video

La carpeta **`Video/`** está destinada al enlace de YouTube del video de sustentación (5–10 minutos) con la participación de todos los miembros del equipo. Agrega el enlace cuando esté disponible.

Ejecuta cada script únicamente en el gestor indicado y revisa sus instrucciones antes de usarlo en una base de datos con información importante.
