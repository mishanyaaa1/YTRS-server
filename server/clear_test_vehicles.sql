-- Скрипт для удаления всех вездеходов (тестовых данных)
-- Выполните этот скрипт, если хотите очистить базу от тестовых вездеходов

-- Удаляем все связи типов местности с вездеходами
DELETE FROM vehicle_terrain;

-- Удаляем все вездеходы
DELETE FROM vehicles;

-- Сбрасываем счетчик ID (опционально, если хотите начать с ID=1)
ALTER SEQUENCE vehicles_id_seq RESTART WITH 1;

-- Проверяем результат
SELECT COUNT(*) as vehicles_count FROM vehicles;
SELECT COUNT(*) as terrain_relations_count FROM vehicle_terrain;

