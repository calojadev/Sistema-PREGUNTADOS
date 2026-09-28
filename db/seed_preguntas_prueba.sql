-- Preguntas de prueba para verificar el funcionamiento del sistema.
-- 5 preguntas por categoria, cada una con 1 respuesta correcta y 2 incorrectas.
-- Requiere que las categorias ya existan en la tabla `materias`:
--   Mecanica (id 3), Termodinamica (id 4), Elegtromagnetismo (id 5)

-- ===================== MECANICA CLASICA =====================

INSERT INTO preguntas (id_materia, pregunta) VALUES
    (3, '¿Cuál es la unidad de fuerza en el Sistema Internacional?');
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Newton', 1),
    (@p, 'Julio', 0),
    (@p, 'Pascal', 0);

INSERT INTO preguntas (id_materia, pregunta) VALUES
    (3, '¿Qué instrumento se utiliza para medir la masa de un objeto?');
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Balanza', 1),
    (@p, 'Termómetro', 0),
    (@p, 'Barómetro', 0);

INSERT INTO preguntas (id_materia, pregunta) VALUES
    (3, 'Según la primera ley de Newton, un cuerpo en reposo permanece en reposo a menos que...');
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Actúe sobre él una fuerza neta', 1),
    (@p, 'Se caliente lo suficiente', 0),
    (@p, 'Cambie de color', 0);

INSERT INTO preguntas (id_materia, pregunta) VALUES
    (3, '¿En qué unidad se mide la velocidad en el Sistema Internacional?');
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Metros por segundo (m/s)', 1),
    (@p, 'Newton (N)', 0),
    (@p, 'Vatio (W)', 0);

INSERT INTO preguntas (id_materia, pregunta) VALUES
    (3, '¿Qué tipo de energía posee un objeto en movimiento?');
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Energía cinética', 1),
    (@p, 'Energía potencial', 0),
    (@p, 'Energía térmica', 0);

-- ===================== TERMODINAMICA =====================

INSERT INTO preguntas (id_materia, pregunta) VALUES
    (4, '¿Cuál es la unidad de temperatura en el Sistema Internacional?');
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Kelvin', 1),
    (@p, 'Newton', 0),
    (@p, 'Pascal', 0);

INSERT INTO preguntas (id_materia, pregunta) VALUES
    (4, '¿Qué instrumento se utiliza para medir la temperatura?');
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Termómetro', 1),
    (@p, 'Barómetro', 0),
    (@p, 'Amperímetro', 0);

INSERT INTO preguntas (id_materia, pregunta) VALUES
    (4, 'La primera ley de la termodinámica está relacionada con la conservación de...');
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'La energía', 1),
    (@p, 'La masa', 0),
    (@p, 'La carga eléctrica', 0);

INSERT INTO preguntas (id_materia, pregunta) VALUES
    (4, '¿En qué unidad se mide la presión en el Sistema Internacional?');
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Pascal', 1),
    (@p, 'Kelvin', 0),
    (@p, 'Vatio', 0);

INSERT INTO preguntas (id_materia, pregunta) VALUES
    (4, '¿Cómo se llama el proceso en el que un gas se expande sin intercambiar calor con su entorno?');
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Proceso adiabático', 1),
    (@p, 'Proceso isotérmico', 0),
    (@p, 'Proceso isobárico', 0);

-- ===================== ELECTROMAGNETISMO =====================

INSERT INTO preguntas (id_materia, pregunta) VALUES
    (5, '¿Cuál es la unidad de carga eléctrica en el Sistema Internacional?');
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Coulomb', 1),
    (@p, 'Newton', 0),
    (@p, 'Vatio', 0);

INSERT INTO preguntas (id_materia, pregunta) VALUES
    (5, '¿Qué instrumento se utiliza para medir la corriente eléctrica?');
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Amperímetro', 1),
    (@p, 'Voltímetro', 0),
    (@p, 'Termómetro', 0);

INSERT INTO preguntas (id_materia, pregunta) VALUES
    (5, '¿Cuál es la unidad de resistencia eléctrica?');
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Ohm', 1),
    (@p, 'Faradio', 0),
    (@p, 'Henrio', 0);

INSERT INTO preguntas (id_materia, pregunta) VALUES
    (5, '¿Qué partícula subatómica tiene carga eléctrica negativa?');
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Electrón', 1),
    (@p, 'Protón', 0),
    (@p, 'Neutrón', 0);

INSERT INTO preguntas (id_materia, pregunta) VALUES
    (5, '¿Cuál es la unidad de campo magnético en el Sistema Internacional?');
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Tesla', 1),
    (@p, 'Voltio', 0),
    (@p, 'Amperio', 0);
