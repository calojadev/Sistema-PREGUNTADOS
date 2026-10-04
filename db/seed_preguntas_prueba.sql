-- Datos de prueba para verificar el funcionamiento del nuevo formato de competencia.
-- En este modelo las "materias" representan el tipo de ronda, no un tema:
--   Multiple -> Fase 1 (Cuartos de Final, selección múltiple)
--   Directa  -> Fase 2 (Semifinal, respuesta directa / juicio del presentador)
--   Pizarra  -> Fase 3 (Final, resolución en pizarra con imagen / juicio del presentador)
-- Uso: docker exec -i <container> mysql -uroot -padmi321 Ingenia < db/seed_preguntas_prueba.sql

INSERT IGNORE INTO materias (materia_nombre) VALUES ('Multiple'), ('Directa'), ('Pizarra');

-- ===================== FASE 1: MULTIPLE (selección múltiple) =====================

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Cuál es la unidad de fuerza en el Sistema Internacional?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Newton', 1),
    (@p, 'Julio', 0),
    (@p, 'Pascal', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué instrumento se utiliza para medir la masa de un objeto?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Balanza', 1),
    (@p, 'Termómetro', 0),
    (@p, 'Barómetro', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, 'Según la primera ley de Newton, un cuerpo en reposo permanece en reposo a menos que...' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Actúe sobre él una fuerza neta', 1),
    (@p, 'Se caliente lo suficiente', 0),
    (@p, 'Cambie de color', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿En qué unidad se mide la velocidad en el Sistema Internacional?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Metros por segundo (m/s)', 1),
    (@p, 'Newton (N)', 0),
    (@p, 'Vatio (W)', 0);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué tipo de energía posee un objeto en movimiento?' FROM materias WHERE materia_nombre = 'Multiple';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES
    (@p, 'Energía cinética', 1),
    (@p, 'Energía potencial', 0),
    (@p, 'Energía térmica', 0);

-- ===================== FASE 2: DIRECTA (juicio del presentador) =====================
-- Una sola respuesta registrada (la correcta): es la referencia del presentador,
-- no se muestra en pantalla. El equipo responde de palabra.

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Cuál es la unidad de temperatura en el Sistema Internacional?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Kelvin', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Qué instrumento se utiliza para medir la temperatura?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Termómetro', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, 'La primera ley de la termodinámica está relacionada con la conservación de...' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'La energía', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿En qué unidad se mide la presión en el Sistema Internacional?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Pascal', 1);

INSERT INTO preguntas (id_materia, pregunta)
SELECT id_materia, '¿Cómo se llama el proceso en el que un gas se expande sin intercambiar calor con su entorno?' FROM materias WHERE materia_nombre = 'Directa';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'Proceso adiabático', 1);

-- ===================== FASE 3: PIZARRA (imagen + juicio del presentador) =====================
-- Reutiliza imágenes de ejercicios ya subidas en static/uploads/preguntas/
-- (quedaron en disco de una sesión de prueba anterior). El texto de la pregunta
-- no se muestra cuando hay imagen, pero se guarda como referencia administrativa.

INSERT INTO preguntas (id_materia, pregunta, imagen_url)
SELECT id_materia, 'Resuelve la ecuación en la pizarra.', '/uploads/preguntas/1763382152_RESUELVE.jpg' FROM materias WHERE materia_nombre = 'Pizarra';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'x = -1', 1);

INSERT INTO preguntas (id_materia, pregunta, imagen_url)
SELECT id_materia, 'Resuelve la ecuación en la pizarra.', '/uploads/preguntas/1763382019_RESUELVE_2.jpg' FROM materias WHERE materia_nombre = 'Pizarra';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'x = 5', 1);

INSERT INTO preguntas (id_materia, pregunta, imagen_url)
SELECT id_materia, 'Evalúa el límite en la pizarra.', '/uploads/preguntas/1763331404_CALCULO-Evalua_el_limite.jpg' FROM materias WHERE materia_nombre = 'Pizarra';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, '2', 1);

INSERT INTO preguntas (id_materia, pregunta, imagen_url)
SELECT id_materia, 'Resuelve el sistema de ecuaciones en la pizarra.', '/uploads/preguntas/1763385423_PREGUNTA-1.jpg' FROM materias WHERE materia_nombre = 'Pizarra';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, '(x,y) = (3,2) o (2,3)', 1);

INSERT INTO preguntas (id_materia, pregunta, imagen_url)
SELECT id_materia, 'Simplifica la expresión en la pizarra.', '/uploads/preguntas/1763385408_PREGUNTA-2.jpg' FROM materias WHERE materia_nombre = 'Pizarra';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, '(2x + 3) / x', 1);

INSERT INTO preguntas (id_materia, pregunta, imagen_url)
SELECT id_materia, 'Calcula la derivada en la pizarra.', '/uploads/preguntas/1763385393_PREGUNTA-3.jpg' FROM materias WHERE materia_nombre = 'Pizarra';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, "f'(x) = 24x^5 - 15x^4 + 8x^3 - 3x^2 + 14x - 5", 1);

INSERT INTO preguntas (id_materia, pregunta, imagen_url)
SELECT id_materia, 'Resuelve por la fórmula cuadrática en la pizarra.', '/uploads/preguntas/1763385382_PREGUNTA-4.jpg' FROM materias WHERE materia_nombre = 'Pizarra';
SET @p := LAST_INSERT_ID();
INSERT INTO respuestas (id_pregunta, respuesta, es_correcta) VALUES (@p, 'x = 1/2 o x = -2', 1);

-- ===================== EQUIPOS DE PRUEBA =====================
-- 5 equipos -> bracket de 3 rondas completas (Cuartos con 1 bye, Semifinal, Final),
-- suficiente para recorrer las 3 fases en una sola partida de prueba.

INSERT IGNORE INTO equipos (nombre_equipo) VALUES
    ('Equipo Alfa'),
    ('Equipo Beta'),
    ('Equipo Gamma'),
    ('Equipo Delta'),
    ('Equipo Épsilon');
