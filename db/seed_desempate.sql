-- Categoría "Desempate": preguntas de respuesta directa (el presentador solo
-- marca Correcto / Incorrecto). Solo se usan cuando hay empate en un enfrentamiento.
-- Uso: docker exec -i ingenia mysql -uroot -padmi321 Ingenia < db/seed_desempate.sql
-- Ojo: ejecutar el seed de nuevo duplica las preguntas (la categoría no se duplica).

SET NAMES utf8mb4;

INSERT IGNORE INTO materias (materia_nombre) VALUES ('Desempate');

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Cuál es el símbolo químico del oro?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Au', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Cuántos bits tiene un byte?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, '8', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué ley relaciona voltaje, corriente y resistencia?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Ley de Ohm', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Cuál es el resultado de 12 × 12?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, '144', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Cómo se llama la unidad de frecuencia en el Sistema Internacional?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Hercio (Hz)', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué gas es el más abundante en la atmósfera terrestre?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Nitrógeno', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Cuál es la raíz cuadrada de 169?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, '13', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué número binario equivale al 5 decimal?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, '101', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Cómo se llama el proceso por el cual las plantas producen su alimento usando luz?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Fotosíntesis', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué componente de un computador se considera su "cerebro"?' FROM materias WHERE materia_nombre = 'Desempate';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'CPU (procesador)', 1);
