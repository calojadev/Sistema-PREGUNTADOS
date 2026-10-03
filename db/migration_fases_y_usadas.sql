-- Migración manual para aplicar los cambios de esquema de esta reforma
-- SIN recrear el volumen de Docker (es decir, conservando los datos actuales).
-- Uso: docker exec -i <container> mysql -uroot -padmi321 <basededatos> < db/migration_fases_y_usadas.sql
-- (si ya hiciste `docker compose down -v` y `up -d` con el init.sql actualizado, no la necesitás)

ALTER TABLE preguntas ADD COLUMN IF NOT EXISTS usada TINYINT(1) NOT NULL DEFAULT 0;

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
    (3, 'Final',            'pizarra',         60)
ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);
