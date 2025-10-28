-- Миграция: Добавление поддержки множественных типов местности для вездеходов
-- Дата: 2025-10-28

-- Шаг 1: Создаем связующую таблицу для отношения многие-ко-многим
CREATE TABLE IF NOT EXISTS vehicle_terrain (
  id SERIAL PRIMARY KEY,
  vehicle_id INTEGER NOT NULL,
  terrain_name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  FOREIGN KEY (vehicle_id) REFERENCES vehicles(id) ON DELETE CASCADE,
  FOREIGN KEY (terrain_name) REFERENCES terrain_types(name) ON DELETE CASCADE,
  UNIQUE(vehicle_id, terrain_name)
);

-- Создаем индексы для оптимизации запросов
CREATE INDEX IF NOT EXISTS idx_vehicle_terrain_vehicle_id ON vehicle_terrain(vehicle_id);
CREATE INDEX IF NOT EXISTS idx_vehicle_terrain_terrain_name ON vehicle_terrain(terrain_name);

-- Шаг 2: Мигрируем существующие данные
-- Переносим данные из поля terrain в новую таблицу vehicle_terrain
INSERT INTO vehicle_terrain (vehicle_id, terrain_name)
SELECT id, terrain 
FROM vehicles 
WHERE terrain IS NOT NULL AND terrain != ''
ON CONFLICT (vehicle_id, terrain_name) DO NOTHING;

-- Шаг 3: Удаляем старое поле terrain и его внешний ключ
-- Сначала удаляем внешний ключ
ALTER TABLE vehicles DROP CONSTRAINT IF EXISTS vehicles_terrain_fkey;

-- Теперь можем удалить само поле terrain
-- НО! Делаем это опционально - можно оставить для совместимости
-- ALTER TABLE vehicles DROP COLUMN IF EXISTS terrain;

-- Вместо удаления, можно сделать поле terrain опциональным и убрать ограничение NOT NULL
ALTER TABLE vehicles ALTER COLUMN terrain DROP NOT NULL;

-- Комментарии к таблицам
COMMENT ON TABLE vehicle_terrain IS 'Связующая таблица для отношения многие-ко-многим между вездеходами и типами местности';
COMMENT ON COLUMN vehicle_terrain.vehicle_id IS 'ID вездехода';
COMMENT ON COLUMN vehicle_terrain.terrain_name IS 'Название типа местности';

-- Проверяем результат миграции
-- SELECT v.id, v.name, array_agg(vt.terrain_name) as terrains
-- FROM vehicles v
-- LEFT JOIN vehicle_terrain vt ON v.id = vt.vehicle_id
-- GROUP BY v.id, v.name;

