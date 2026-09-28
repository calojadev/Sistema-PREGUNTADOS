# Sistema PREGUNTADOS

## Requisitos

- Python 3
- Docker (con Docker Compose)

## Puesta en marcha

1. Levantar la base de datos MySQL (crea el contenedor y carga el esquema automáticamente la primera vez):
   ```
   docker compose up -d
   ```
2. Instalar las dependencias de Python:
   ```
   pip install -r requeriments.txt
   ```
3. Iniciar la aplicación:
   ```
   python app.py
   ```
4. Abrir [http://127.0.0.1:5000](http://127.0.0.1:5000) en el navegador.

## Notas

- La base de datos se llama `Intellecto`, corre en el contenedor `intellecto` y se expone en el puerto `3308` (usuario `root`, contraseña `admi321`).
- Los datos persisten entre reinicios gracias al volumen `db_data`. Para reiniciar la base desde cero: `docker compose down -v` y luego `docker compose up -d`.
- El esquema de la base está versionado en [db/init.sql](db/init.sql); ya no es necesario copiar el `CREATE TABLE` manualmente desde el `.docx`.
