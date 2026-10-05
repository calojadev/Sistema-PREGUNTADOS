# Sistema PREGUNTADOS — Contexto del proyecto

Sistema de competencia tipo "Preguntados" para docentes. Flask (`app.py`) + MySQL 8 en Docker (`docker-compose.yml`, contenedor `ingenia`, puerto host 3308, base `Ingenia`). El panel docente está en `templates/Docente.html` con JS en `static/js/scriptDocente.js` y CSS en `static/styleDocente.css`. El juego está en `static/js/scriptJuego.js`.

Habrá una botonera externa al sistema la cual servira para designar que equipo tiene derecho a responder

Rama de trabajo: `ramab` (base: `master`). Cambios ya comprometidos en la misma rama.

## Modelo de la competencia

Las "materias" de la BD representan el **tipo de ronda**, no un tema (la UI las llama "Categorías"):

| Materia (BD) | Fase                 | `tipo_respuesta`  | Formato                                            |
| ------------ | -------------------- | ----------------- | -------------------------------------------------- |
| Multiple     | 1 · Cuartos de Final | `opcion_multiple` | 3 opciones, 1 correcta                             |
| Directa      | 2 · Semifinal        | `directa`         | 1 respuesta de referencia (juicio del presentador) |
| Pizarra      | 3 · Final            | `pizarra`         | Imagen + juicio del presentador                    |
| Desempate    | (solo en empates)    | — (usa `directa`) | 1 respuesta de referencia, solo Correcto/Incorrecto |

"Desempate" no pertenece a ninguna fase: sus preguntas solo salen en desempates (mejor de 3, gana quien llegue a 2) y nunca en Cuartos/Semifinal/Final. La Final no tiene desempate (decide el jurado).

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

5. **Flujo del juego: botonera, temporizadores y transferir turno** (`static/js/scriptJuego.js`, `templates/Juego.html`, `static/styleJuego.css`). Solo frontend; verificado con `node --check`, no probado en navegador.
   - **Opciones visibles en Multiple:** `mostrarResultado()` deja `#opciones-respuesta` visible desde que sale la pregunta (botones deshabilitados hasta que un equipo gana el derecho a responder). Si la pregunta de Multiple tiene imagen, ahora se muestra también el enunciado.
   - **Temporizador de botonera:** constante `TIEMPO_BOTONERA = 10`. Se inicia en `habilitarBotoneras()`; si ningún equipo es seleccionado, `botoneraSinRespuesta()` avisa y pasa a la siguiente pregunta vía `avanzarTrasResolucion()` (respeta el desempate).
   - **Temporizador de respuesta:** `iniciarTemporizadorRespuesta()` usa `fases.tiempo_segundos` (Cuartos 10 s, Semifinal 10 s, **Final 60 s**), tanto para el equipo inicial como para el turno cedido.
   - **Transferir turno manual:** `iniciarTemporizador(segundos, onFin, icono)` ahora recibe callback. Al agotarse el tiempo de respuesta (`tiempoRespuestaAgotado()`) ya no se transfiere solo: se muestra "Tiempo agotado" y el botón `#btn-transferir-turno`, y las opciones/botones de juicio siguen activos. El botón llama `resolverRespuesta(equipoActivo, false)` (primer fallo cede el turno; segundo cierra la pregunta sin punto) y se rotula "Siguiente pregunta" si el otro equipo ya intentó. `detenerTemporizador()` también oculta el botón.

6. **Final (Pizarra) con dinámica propia** (`scriptJuego.js`, `Juego.html`, `styleJuego.css`). Solo frontend; verificado con `node --check`, no probado en navegador. `esFinal()` = fase con `tipo_respuesta === "pizarra"`.
   - Ambos equipos resuelven a la vez, sin botonera ni equipo activo. Siempre **3 enunciados** (`PREGUNTAS_FINAL`, ignora `configDB.cantidad`) y **120 s** por enunciado (`TIEMPO_FINAL`, ignora `fases.tiempo_segundos`). La ruleta sigue girando antes de cada enunciado.
   - `#btn-habilitar-botoneras` se rotula "INICIAR TIEMPO" en la Final y arranca el temporizador de 120 s.
   - Mientras corre el tiempo hay un botón "DETENER TIEMPO" (`#btn-detener-tiempo`) para cortarlo si un equipo ya resolvió; lleva al mismo panel del jurado (`tiempoFinalAgotado(true)`, rótulo "Tiempo detenido").
   - Al agotarse el tiempo (`tiempoFinalAgotado()`): panel `#panel-jurado-final` con un botón por equipo (toggle de acierto, suma/resta en `puntosEnfrentamiento`) y "SIGUIENTE ENUNCIADO" (en el 3.º, "VER RESULTADO FINAL").
   - Tras el 3.º, `mostrarSeleccionGanadorFinal()` ("¿Quién ganó la Final?", con marcador de referencia); el equipo elegido pasa por `mostrarGanadorDelEnfrentamiento()` y se llega al modal de campeón. En la Final no hay desempate.

7. **Categoría "Desempate"** (`scriptJuego.js`, `db/seed_desempate.sql` ejecutado: 10 preguntas). Verificado con `node --check`; no probado en navegador.
   - `runGame` separa `preguntasDisponibles` (sin Desempate) de `preguntasDesempate`. `esDesempate()` y `tipoRondaActual()` (devuelve `"directa"` en desempate) deciden el panel: botonera 10 s → Correcto/Incorrecto → transferir turno, sin opciones múltiples.
   - Si no quedan preguntas de Desempate se usa una de Directa (toast de aviso).
   - La ruleta añade un 4.º sector "Desempate" (rojo) solo mientras hay desempate (`sectoresRuleta()`); la modalidad mostrada es "Desempate".
   - Re-ejecutar el seed duplica las preguntas (la categoría no, `INSERT IGNORE`). Se gestiona desde "Categorías" del panel docente como cualquier otra.

8. **Estilo de las opciones de Multiple** (`static/styleJuego.css`, solo CSS). Las opciones `.btn-opcion` ya se ven junto a la pregunta: deshabilitadas se leen con claridad (texto oscuro, borde punteado gris, `cursor: not-allowed`, sin hover) y al habilitarse pasan a borde azul sólido con hover. Cada opción lleva letra A/B/C con `counter` CSS (`::before`). No probado en navegador.

## Estado y pendientes

- Algunas preguntas tienen `usada = 1` por pruebas anteriores. Usar "reiniciar preguntas usadas" en el panel antes de una prueba completa.
- Pregunta de Directa "Quien fue el mas papeador del 8vo semestre 2026?" (id 35) tiene 2 respuestas registradas; revisar si ambas están marcadas como correctas.
- `db/seed_preguntas_prueba.sql` tiene cambios sin commit.
- Pendiente (sugerido, no hecho): que el `catch` de `loadInitialData()` muestre el mensaje real del error en lugar de "Error de conexión", para distinguir fallos de red de errores de código.
- Credenciales de MySQL hardcodeadas en `app.py` y `db_connection.py`; revisar antes de compartir el repo.
- Prueba real de la competencia aún no realizada de punta a punta; los cambios del punto 5 deben probarse en navegador (nadie presiona botonera, tiempo agotado + responder, transferir turno, desempate, Directa/Pizarra).
- El tiempo de la Final en la tabla `fases` (60 s) ya no se usa: el juego usa 120 s fijos en JS. Evaluar si el panel docente debe seguir mostrándolo.
- Los cambios de los puntos 5 al 8 están sin commit y deben probarse en navegador (Final con 2 y 4 equipos; forzar un empate para ver el desempate con la ruleta de 4 sectores).
- Estado de la BD: Multiple 25, Directa 16, Pizarra 7, Desempate 10.
