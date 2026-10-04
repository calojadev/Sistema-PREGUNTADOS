# Sistema PREGUNTADOS — Contexto del proyecto

Sistema de competencia tipo "Preguntados" para docentes. Flask (`app.py`) + MySQL 8 en Docker (`docker-compose.yml`, contenedor `ingenia`, puerto host 3308, base `Ingenia`). El panel docente está en `templates/Docente.html` con JS en `static/js/scriptDocente.js` y CSS en `static/styleDocente.css`. El juego está en `static/js/scriptJuego.js`.

Rama de trabajo: `ramab` (base: `master`). Cambios aún sin commit.

## Modelo de la competencia

Las "materias" de la BD representan el **tipo de ronda**, no un tema (la UI las llama "Categorías"):

| Materia (BD)  | Fase                    | `tipo_respuesta`   | Formato                                   |
|---------------|-------------------------|--------------------|-------------------------------------------|
| Multiple      | 1 · Cuartos de Final    | `opcion_multiple`  | 3 opciones, 1 correcta                    |
| Directa       | 2 · Semifinal           | `directa`          | 1 respuesta de referencia (juicio del presentador) |
| Pizarra       | 3 · Final               | `pizarra`          | Imagen + juicio del presentador           |

Tablas: `materias`, `preguntas` (`usada`, `estado`, `imagen_url`), `respuestas` (`es_correcta`), `equipos`, `fases` (tiempos por fase), `rondas` (preguntas por enfrentamiento), `user`.

## Cambios realizados en esta sesión

1. **Tiempo por fase fuera de su tarjeta** (`static/styleDocente.css`): `.config-section` tenía `max-height: 200px` sin `overflow`, así que el contenido se desbordaba sobre la tarjeta de Categorías. Se eliminó ese `max-height`.

2. **Edición del template** (`templates/Docente.html`, hecha por el usuario): se quitó el bloque "Grupo de Competencia" (`#grupoSelect`) y se cambió el texto "Materias" por "Categorías". Los IDs (`materias-*`, `materiaSelect`, etc.) no cambiaron.

3. **Error "Error de conexión con el servidor."** (causa raíz): `render()` en `scriptDocente.js` hacía `grupoSelect.value = ...`. Como el elemento ya no existía, lanzaba `TypeError`. El error caía en el `catch` de `loadInitialData()`, que muestra ese toast genérico, y las listas quedaban vacías aunque los datos llegaran bien. Se eliminaron `grupoSelect` y `configuracion.grupo` del JS. Verificado con `node --check`; no probado en navegador.

4. **Carga de preguntas de prueba** (`db/seed_preguntas_ampliacion.sql`, ejecutado contra el contenedor). Estado actual de la BD:
   - Multiple: 25 (5 previas + 20 nuevas)
   - Directa: 16 (6 previas + 10 nuevas)
   - Pizarra: 7

   Ojo: ejecutar el seed de nuevo duplica las preguntas.

## Estado y pendientes

- Algunas preguntas tienen `usada = 1` por pruebas anteriores. Usar "reiniciar preguntas usadas" en el panel antes de una prueba completa.
- Pregunta de Directa "Quien fue el mas papeador del 8vo semestre 2026?" (id 35) tiene 2 respuestas registradas; revisar si ambas están marcadas como correctas.
- `db/seed_preguntas_prueba.sql` tiene cambios sin commit.
- Pendiente (sugerido, no hecho): que el `catch` de `loadInitialData()` muestre el mensaje real del error en lugar de "Error de conexión", para distinguir fallos de red de errores de código.
- Credenciales de MySQL hardcodeadas en `app.py` y `db_connection.py`; revisar antes de compartir el repo.
- Prueba real de la competencia aún no realizada de punta a punta.
