-- Preguntas de Física (PDF "Preguntas de selección multiple").
-- Multiple: 1-20 (4 opciones, 1 correcta) | Directa: 21-30 | Pizarra: 31-33 | Desempate: 1-35.
-- El número del PDF va al inicio del enunciado. Las opciones se guardan sin letra
-- (el juego las mezcla y les pone A/B/C/D por posición).
-- Las respuestas de referencia de Directa, Pizarra y Desempate no venían en el PDF:
-- las redactó el asistente; revisar antes de la competencia.
-- Uso: docker exec -i ingenia mysql -uroot -padmi321 Ingenia < db/seed_preguntas_fisica.sql
-- Ojo: ejecutar el seed de nuevo duplica las preguntas.

SET NAMES utf8mb4;

INSERT IGNORE INTO materias (materia_nombre) VALUES ('Multiple'), ('Directa'), ('Pizarra'), ('Desempate');

-- ===== MULTIPLE =====

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '1. Vectores. Una fuerza de 12 N actúa hacia el este y otra de 5 N hacia el oeste. ¿Cuál es la resultante?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
  (@p, '17 N al este', 0),
  (@p, '7 N al este', 1),
  (@p, '7 N al oeste', 0),
  (@p, '0 N', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '2. MRU. Un móvil recorre 180 m en 12 s con velocidad constante. ¿Cuál es su velocidad?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
  (@p, '12 m/s', 0),
  (@p, '15 m/s', 1),
  (@p, '18 m/s', 0),
  (@p, '21,6 m/s', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '3. Magnitudes. ¿A cuántos metros por segundo equivalen 54 km/h?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
  (@p, '10 m/s', 0),
  (@p, '15 m/s', 1),
  (@p, '19,4 m/s', 0),
  (@p, '54 m/s', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '4. Movimiento vertical. En el punto más alto de un lanzamiento vertical, la velocidad instantánea del objeto es:' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
  (@p, '0 m/s', 1),
  (@p, '10 m/s', 0),
  (@p, 'máxima hacia arriba', 0),
  (@p, 'igual a su velocidad inicial', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '5. Magnitudes. ¿Cuántos metros equivalen a 2,75 km?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
  (@p, '275 m', 0),
  (@p, '2 750 m', 1),
  (@p, '27 500 m', 0),
  (@p, '0,275 m', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '6. MRUV. Un automóvil parte del reposo con aceleración de 3 m/s². ¿Qué velocidad alcanza en 4 s?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
  (@p, '7 m/s', 0),
  (@p, '10 m/s', 0),
  (@p, '12 m/s', 1),
  (@p, '24 m/s', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '7. Vectores. Una persona camina 6 m al norte y luego 8 m al este. ¿Cuál es el módulo de su desplazamiento?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
  (@p, '2 m', 0),
  (@p, '10 m', 1),
  (@p, '14 m', 0),
  (@p, '48 m', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '8. MRUV. La velocidad de un móvil cambia de 5 m/s a 17 m/s en 4 s. ¿Cuál es su aceleración?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
  (@p, '3 m/s²', 1),
  (@p, '4 m/s²', 0),
  (@p, '5,5 m/s²', 0),
  (@p, '12 m/s²', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '9. Caída libre. Se deja caer un objeto desde el reposo. Despreciando el aire, después de 2 s su velocidad es:' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
  (@p, '5 m/s hacia abajo', 0),
  (@p, '10 m/s hacia abajo', 0),
  (@p, '20 m/s hacia abajo', 1),
  (@p, '40 m/s hacia abajo', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '10. MRU. La gráfica posición tiempo de un MRU es una línea recta. Su pendiente representa:' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
  (@p, 'la aceleración', 0),
  (@p, 'la velocidad', 1),
  (@p, 'el tiempo', 0),
  (@p, 'la masa', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '11. Magnitudes. ¿Cuál es una magnitud fundamental del Sistema Internacional?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
  (@p, 'fuerza', 0),
  (@p, 'velocidad', 0),
  (@p, 'tiempo', 1),
  (@p, 'densidad', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '12. Vectores. Dos vectores de 9 N tienen igual dirección y sentidos opuestos. Su resultante es:' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
  (@p, '0 N', 1),
  (@p, '9 N', 0),
  (@p, '18 N', 0),
  (@p, '81 N', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '13. MRUV. Un móvil tiene v₀ = 4 m/s y a = 2 m/s². ¿Cuál es su velocidad a los 6 s?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
  (@p, '8 m/s', 0),
  (@p, '12 m/s', 0),
  (@p, '16 m/s', 1),
  (@p, '24 m/s', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '14. Vectores. ¿Cuál de las siguientes magnitudes es vectorial?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
  (@p, 'temperatura', 0),
  (@p, 'masa', 0),
  (@p, 'desplazamiento', 1),
  (@p, 'energía', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '15. Movimiento vertical. Una pelota se lanza hacia arriba. Mientras asciende, su velocidad:' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
  (@p, 'aumenta uniformemente', 0),
  (@p, 'disminuye uniformemente', 1),
  (@p, 'permanece constante', 0),
  (@p, 'es siempre cero', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '16. Magnitudes. ¿Cuántos segundos equivalen a 3,5 minutos?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
  (@p, '180 s', 0),
  (@p, '200 s', 0),
  (@p, '210 s', 1),
  (@p, '350 s', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '17. MRU. Un ciclista se desplaza a 7 m/s durante 40 s. ¿Qué distancia recorre?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
  (@p, '47 m', 0),
  (@p, '280 m', 1),
  (@p, '320 m', 0),
  (@p, '420 m', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '18. MRUV. Un vehículo reduce su velocidad de 25 m/s a 5 m/s en 4 s. ¿Cuál es su aceleración?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
  (@p, '−5 m/s²', 1),
  (@p, '−4 m/s²', 0),
  (@p, '5 m/s²', 0),
  (@p, '7,5 m/s²', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '19. Caída libre. En ausencia de resistencia del aire, dos objetos de distinta masa soltados desde la misma altura:' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
  (@p, 'caen con la misma aceleración', 1),
  (@p, 'cae primero el más pesado', 0),
  (@p, 'cae primero el más liviano', 0),
  (@p, 'mantienen velocidad constante', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '20. MRU. Un bus viaja a 72 km/h durante 30 s. ¿Qué distancia recorre?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
  (@p, '216 m', 0),
  (@p, '600 m', 1),
  (@p, '2 160 m', 0),
  (@p, '6 000 m', 0);

-- ===== DIRECTA =====

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '21. Astrónomo y matemático alemán que formuló las tres leyes del movimiento planetario. ¿Quién fue?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Johannes Kepler', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '22. Científico italiano que estudió la caída libre y el movimiento de los cuerpos e impulsó el uso experimental de las matemáticas en la Física. ¿Quién fue?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Galileo Galilei', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '23. Físico y matemático inglés que formuló las tres leyes del movimiento y la ley de gravitación universal. ¿Quién fue?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Isaac Newton', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '24. Físico británico que investigó los agujeros negros y la cosmología, y predijo que los agujeros negros pueden emitir radiación. ¿Quién fue?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Stephen Hawking', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '25. Físico nacido en Alemania que desarrolló las teorías de la relatividad y estableció la equivalencia entre masa y energía, E = mc². ¿Quién fue?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Albert Einstein', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '26. Sistema estandarizado de unidades utilizado internacionalmente para expresar mediciones físicas. ¿Qué es?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Sistema Internacional de Unidades (SI)', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '27. Movimiento en línea recta con velocidad constante y aceleración igual a cero. ¿Qué es?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Movimiento rectilíneo uniforme (MRU)', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '28. Movimiento de un cuerpo sometido únicamente a la gravedad, despreciando la resistencia del aire. ¿Qué es?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Caída libre', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '29. Aceleración que experimentan los cuerpos por la atracción gravitatoria terrestre, cuyo valor aproximado cerca de la superficie es 9,8 m/s². ¿Qué es?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Aceleración de la gravedad (g)', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '30. Segmento orientado que representa una magnitud mediante módulo, dirección y sentido. ¿Qué es?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Vector', 1);

-- ===== PIZARRA =====

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '31. Recorrido del robot. Un robot recorre 15 m al norte, 9 m al este, 7 m al sur y 3 m al oeste. Determine la distancia total, las componentes del desplazamiento, el módulo de la resultante y su dirección. Grafique el recorrido y el desplazamiento.' FROM materias WHERE materia_nombre = 'Pizarra';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Distancia total = 34 m. Componentes: 8 m al norte y 6 m al este. Módulo de la resultante = 10 m. Dirección: 53,13° al norte del este (N 36,87° E).', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '32. Ángulo entre dos vectores. Dos vectores A y B tienen módulos de 5 u y 8 u. Su suma tiene módulo de 7 u. Determine el ángulo entre los vectores.' FROM materias WHERE materia_nombre = 'Pizarra';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'θ = 120° (cos θ = −1/2)', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '33. Vectores con módulos en relación uno a dos. Los módulos de dos vectores están en la relación 1:2. El módulo de su suma es el triple del módulo del vector menor. Determine el ángulo entre ellos.' FROM materias WHERE materia_nombre = 'Pizarra';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'θ = 0° (los vectores tienen la misma dirección y sentido)', 1);

-- ===== DESEMPATE =====

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '1. Mencione tres aplicaciones del electromagnetismo en ingeniería.' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Ejemplos: motores eléctricos, transformadores, generadores, telecomunicaciones, resonancia magnética', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '2. Mencione tres tecnologías basadas en principios físicos.' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Ejemplos: láser, radar, GPS, fibra óptica, paneles solares', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '3. Mencione tres unidades de tiempo.' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Ejemplos: segundo, minuto, hora, día, año', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '4. Mencione tres unidades de longitud.' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Ejemplos: metro, kilómetro, centímetro, milla, pulgada', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '5. Mencione las tres características de un vector.' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Módulo, dirección y sentido', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '6. Mencione tres ramas de la Física.' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Ejemplos: mecánica, termodinámica, óptica, electromagnetismo, acústica', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '7. Mencione tres instrumentos de medición física.' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Ejemplos: regla, cronómetro, balanza, termómetro, voltímetro', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '8. Mencione tres ejemplos de movimiento circular.' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Ejemplos: ruedas, aspas de un ventilador, manecillas del reloj, rotación de la Tierra, noria', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '9. Mencione tres fenómenos relacionados con la luz.' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Ejemplos: reflexión, refracción, difracción, dispersión, arcoíris', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '10. Mencione tres magnitudes fundamentales del Sistema Internacional.' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Ejemplos: longitud, masa, tiempo, temperatura, corriente eléctrica', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '11. Mencione las unidades del SI para longitud, masa y tiempo, en ese orden.' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Metro, kilogramo, segundo', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '12. ¿Cuántos metros equivalen a 0,6 kilómetros?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, '600 m', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '13. ¿Cuántos segundos hay en dos minutos y medio?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, '150 s', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '14. Convierta 36 kilómetros por hora a metros por segundo.' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, '10 m/s', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '15. Convierta 5 metros por segundo a kilómetros por hora.' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, '18 km/h', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '16. Dos fuerzas actúan en el mismo sentido: una de 4 newtons y otra de 6 newtons. ¿Cuál es el módulo de la resultante?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, '10 N', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '17. Un móvil regresa a su punto de partida después de recorrer 20 metros. ¿Cuánto vale su desplazamiento?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, '0 m', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '18. Un móvil recorre 60 metros en 10 segundos con velocidad constante. ¿Cuál es su rapidez?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, '6 m/s', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '19. Una pelota se lanza verticalmente hacia arriba. En el punto más alto, ¿cuánto vale su aceleración?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, '9,8 m/s² hacia abajo (la aceleración de la gravedad)', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '20. En el vacío, se sueltan simultáneamente una pluma y una piedra desde la misma altura. ¿Cuál llega primero al suelo?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Llegan al mismo tiempo', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '21. ¿Quién desarrolló las teorías de la relatividad especial y general?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Albert Einstein', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '22. ¿Qué científica recibió premios Nobel en Física y en Química por investigaciones relacionadas con la radiactividad?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Marie Curie', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '23. ¿Qué físico predijo que los agujeros negros pueden emitir radiación debido a efectos cuánticos?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Stephen Hawking', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '24. ¿Cómo se llama el primer satélite paraguayo?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'GuaraniSat-1', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '25. ¿Qué forma de energía del agua almacenada aprovecha inicialmente Itaipú para generar electricidad?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Energía potencial (gravitatoria)', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '26. ¿Qué científico formuló la ley de elasticidad según la cual la deformación de un resorte es proporcional a la fuerza aplicada, dentro de su límite elástico?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Robert Hooke (ley de Hooke)', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '27. ¿Cuál es la unidad de energía y trabajo en el Sistema Internacional?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Joule (julio)', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '28. ¿Qué instrumento se utiliza para medir la temperatura?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Termómetro', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '29. ¿Qué instrumento permite medir la presión atmosférica?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Barómetro', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '30. ¿Qué científico inventó la pila voltaica?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Alessandro Volta', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '31. ¿Qué instrumento permite observar objetos muy pequeños mediante lentes?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Microscopio', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '32. ¿Qué instrumento indica direcciones mediante una aguja que responde al campo magnético terrestre?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Brújula', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '33. ¿Qué invento permite detectar objetos mediante ondas de radio y sus ecos?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Radar', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '34. ¿Qué aparato transforma señales eléctricas en sonido audible?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Altavoz (parlante)', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '35. ¿Qué tecnología transporta señales luminosas por filamentos transparentes?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();

INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Fibra óptica', 1);
