-- Ampliación de preguntas para la prueba de competencia:
--   +20 preguntas de Multiple (Fase 1, Cuartos de Final, 3 opciones, 1 correcta)
--   +10 preguntas de Directa  (Fase 2, Semifinal, 1 respuesta de referencia)
-- Uso: docker exec -i ingenia mysql -uroot -padmi321 Ingenia < db/seed_preguntas_ampliacion.sql

SET NAMES utf8mb4;

-- ===================== FASE 1: MULTIPLE (+20) =====================

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué magnitud física mide un amperímetro?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Intensidad de corriente', 1), (@p, 'Voltaje', 0), (@p, 'Resistencia', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Cuál es la unidad de energía en el Sistema Internacional?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Julio (J)', 1), (@p, 'Watt (W)', 0), (@p, 'Pascal (Pa)', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Cuál es la unidad de potencia en el Sistema Internacional?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Vatio (W)', 1), (@p, 'Julio (J)', 0), (@p, 'Newton (N)', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué instrumento se utiliza para medir la presión atmosférica?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Barómetro', 1), (@p, 'Termómetro', 0), (@p, 'Dinamómetro', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué instrumento se utiliza para medir fuerzas?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Dinamómetro', 1), (@p, 'Amperímetro', 0), (@p, 'Higrómetro', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué ley establece que a toda acción corresponde una reacción de igual magnitud y sentido contrario?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Tercera ley de Newton', 1), (@p, 'Primera ley de Newton', 0), (@p, 'Ley de Ohm', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Cuál es la fórmula de la segunda ley de Newton?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'F = m · a', 1), (@p, 'E = m · c²', 0), (@p, 'P = V · I', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué tipo de energía almacena un resorte comprimido?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Energía potencial elástica', 1), (@p, 'Energía cinética', 0), (@p, 'Energía térmica', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Cuál es la unidad de carga eléctrica en el Sistema Internacional?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Coulomb (C)', 1), (@p, 'Ampere (A)', 0), (@p, 'Voltio (V)', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Cuál es la unidad de resistencia eléctrica en el Sistema Internacional?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Ohm (Ω)', 1), (@p, 'Henrio (H)', 0), (@p, 'Faradio (F)', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, 'Según la ley de Ohm, si el voltaje se duplica y la resistencia se mantiene constante, la corriente...' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Se duplica', 1), (@p, 'Se reduce a la mitad', 0), (@p, 'No cambia', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué fuerza se opone al movimiento entre dos superficies en contacto?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Fuerza de rozamiento', 1), (@p, 'Fuerza centrípeta', 0), (@p, 'Fuerza de empuje', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Cómo se llama la aceleración debida a la gravedad en la superficie terrestre, aproximadamente?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, '9,8 m/s²', 1), (@p, '3,0 × 10⁸ m/s', 0), (@p, '1,6 × 10⁻¹⁹ C', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué magnitud relaciona la masa de un cuerpo con su volumen?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Densidad', 1), (@p, 'Peso', 0), (@p, 'Presión', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué tipo de onda necesita un medio material para propagarse?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Onda mecánica', 1), (@p, 'Onda electromagnética', 0), (@p, 'Rayo gamma', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Cuál es la velocidad de la luz en el vacío, aproximadamente?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, '3 × 10⁸ m/s', 1), (@p, '3 × 10⁶ m/s', 0), (@p, '340 m/s', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué principio explica por qué un objeto sumergido recibe un empuje hacia arriba?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Principio de Arquímedes', 1), (@p, 'Principio de Pascal', 0), (@p, 'Principio de Bernoulli', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué sustancia se utiliza como referencia en la escala Celsius para el punto de congelación?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Agua', 1), (@p, 'Mercurio', 0), (@p, 'Alcohol', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué tipo de lente es más gruesa en el centro que en los bordes?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Convergente', 1), (@p, 'Divergente', 0), (@p, 'Plana', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué magnitud vectorial describe el cambio de velocidad en el tiempo?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Aceleración', 1), (@p, 'Desplazamiento', 0), (@p, 'Rapidez', 0);

-- ===================== FASE 2: DIRECTA (+10) =====================
-- Una sola respuesta registrada (la correcta): referencia del presentador, no se muestra.

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Cuál es la unidad de presión en el Sistema Internacional?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Pascal (Pa)', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué magnitud mide un termómetro?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Temperatura', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Cómo se llama el cambio directo de estado de sólido a gas?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Sublimación', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué ley establece que la presión aplicada a un fluido encerrado se transmite íntegramente a todos sus puntos?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Principio de Pascal', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Cuál es la unidad de corriente eléctrica en el Sistema Internacional?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Amperio (A)', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué propiedad de un cuerpo es la medida de su resistencia a cambiar su estado de movimiento?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Inercia', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Cómo se llama la energía que se transfiere entre cuerpos por diferencia de temperatura?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Calor', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué instrumento se utiliza para medir la intensidad de corriente eléctrica?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Amperímetro', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Cuál es la unidad de masa en el Sistema Internacional?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Kilogramo (kg)', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué fenómeno describe la desviación de la luz al pasar de un medio a otro?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Refracción', 1);
