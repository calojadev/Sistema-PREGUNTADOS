-- Esquema de la base de datos Ingenia.
-- Se ejecuta automáticamente por MySQL solo la primera vez que se crea el
-- volumen de datos del contenedor (docker-entrypoint-initdb.d).

CREATE TABLE IF NOT EXISTS user (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(80) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS materias (
    id_materia INT AUTO_INCREMENT PRIMARY KEY,
    materia_nombre VARCHAR(120) UNIQUE NOT NULL,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS equipos (
    id_equipo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_equipo VARCHAR(120) UNIQUE NOT NULL,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS preguntas (
    id_pregunta INT AUTO_INCREMENT PRIMARY KEY,
    id_materia INT NOT NULL,
    pregunta TEXT NOT NULL,
    imagen_url VARCHAR(255) DEFAULT NULL,
    estado TINYINT NOT NULL DEFAULT 1,
    usada TINYINT(1) NOT NULL DEFAULT 0,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_materia) REFERENCES materias(id_materia)
);

CREATE TABLE IF NOT EXISTS respuestas (
    id_respuesta INT AUTO_INCREMENT PRIMARY KEY,
    id_pregunta INT NOT NULL,
    respuesta TEXT NOT NULL,
    es_correcta TINYINT(1) NOT NULL DEFAULT 0,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_pregunta) REFERENCES preguntas(id_pregunta)
);

CREATE TABLE IF NOT EXISTS rondas (
    id_rondas INT PRIMARY KEY,
    cantidad INT NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Reglas por fase del torneo: tipo de validación de respuesta y tiempo límite.
-- id_fase 1 = Cuartos de Final, 2 = Semifinal, 3 = Final.
CREATE TABLE IF NOT EXISTS fases (
    id_fase INT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    tipo_respuesta ENUM('opcion_multiple','directa','pizarra') NOT NULL,
    tiempo_segundos INT NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO fases (id_fase, nombre, tipo_respuesta, tiempo_segundos) VALUES
    (1, 'Cuartos de Final', 'opcion_multiple', 10),
    (2, 'Semifinal',        'directa',         10),
    (3, 'Final',            'pizarra',         60);
