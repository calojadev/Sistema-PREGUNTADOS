# Sistema PREGUNTADOS

## Requisitos

- Python 3
- Docker (con Docker Compose)

## Puesta en marcha

1. Levantar la base de datos MySQL (crea el contenedor y carga el esquema automáticamente la primera vez):
   ```
   docker compose up -d
   ```
2. Cargar las preguntas y los equipos (ver [Cargar los datos](#cargar-los-datos-preguntas-y-equipos)).
3. Instalar las dependencias de Python:
   ```
   pip install -r requeriments.txt
   ```
4. Iniciar la aplicación:
   ```
   python app.py
   ```
5. Abrir [http://127.0.0.1:5000](http://127.0.0.1:5000) en el navegador y registrar el usuario docente (las cuentas no vienen incluidas en los seeds).

## Cargar los datos (preguntas y equipos)

Al crear la base solo se carga el esquema ([db/init.sql](db/init.sql)). Para desplegar en otro dispositivo hay que cargar además las preguntas. Hacerlo **después** de `docker compose up -d`, cuando el contenedor `ingenia` esté listo (`docker compose ps` debe mostrarlo como `healthy`).

Los comandos usan `docker cp` + `docker exec` para funcionar igual en Windows (PowerShell/CMD), Linux y macOS, sin depender de la redirección `<`.

### Opción A: todos los datos (recomendada)

[db/seed_completo.sql](db/seed_completo.sql) es una copia de lo que hay en la base: las categorías, las 68 preguntas de Física con sus respuestas (Multiple 20, Directa 10, Pizarra 3, Desempate 35), los 8 equipos y la configuración de rondas y fases. Desde la raíz del proyecto:

```
docker cp db/seed_completo.sql ingenia:/tmp/seed_completo.sql
docker exec ingenia sh -c "mysql -uroot -padmi321 --default-character-set=utf8mb4 Ingenia < /tmp/seed_completo.sql"
```

Es idempotente (usa `REPLACE INTO`): ejecutarlo de nuevo no duplica datos y restablece esos registros a su valor original.

### Opción B: solo las preguntas de Física

Si se quieren las preguntas pero **no** los equipos, usar [db/seed_preguntas_fisica.sql](db/seed_preguntas_fisica.sql):

```
docker cp db/seed_preguntas_fisica.sql ingenia:/tmp/seed_preguntas_fisica.sql
docker exec ingenia sh -c "mysql -uroot -padmi321 --default-character-set=utf8mb4 Ingenia < /tmp/seed_preguntas_fisica.sql"
```

> Este seed **no** es idempotente: ejecutarlo dos veces duplica las preguntas. Si pasa, reiniciar la base con `docker compose down -v` y `docker compose up -d`.

### Verificar la carga

```
docker exec ingenia mysql -uroot -padmi321 Ingenia -e "SELECT m.materia_nombre, COUNT(*) AS preguntas FROM preguntas p JOIN materias m USING (id_materia) GROUP BY m.materia_nombre;"
```

Debe mostrar Multiple 20, Directa 10, Pizarra 3 y Desempate 35.

### Notas sobre los seeds

- Las respuestas de referencia de Directa, Pizarra y Desempate no venían en el PDF original: las redactó el asistente. Conviene revisarlas antes de la competencia (se pueden editar desde el panel docente).
- No cargar [db/seed_preguntas_prueba.sql](db/seed_preguntas_prueba.sql), [db/seed_preguntas_ampliacion.sql](db/seed_preguntas_ampliacion.sql) ni [db/seed_desempate.sql](db/seed_desempate.sql): son preguntas de prueba y mezclarían datos con los anteriores.
- Después de una prueba, usar "reiniciar preguntas usadas" en el panel docente para que todas las preguntas vuelvan a estar disponibles.

## Notas

- La base de datos se llama `Ingenia`, corre en el contenedor `ingenia` y se expone en el puerto `3308` (usuario `root`, contraseña `admi321`).
- Los datos persisten entre reinicios gracias al volumen `db_data`. Para reiniciar la base desde cero: `docker compose down -v` y luego `docker compose up -d`.
- El esquema de la base está versionado en [db/init.sql](db/init.sql); ya no es necesario copiar el `CREATE TABLE` manualmente desde el `.docx`.
