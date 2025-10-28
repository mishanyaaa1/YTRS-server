-- Миграция для добавления поддержки множественных типов местности
-- Выполнить этот скрипт после обновления postgres_schema.sql

-- Создаем связующую таблицу (если еще не создана через схему)
CREATE TABLE IF NOT EXISTS vehicle_terrains (
  id SERIAL PRIMARY KEY,
  vehicle_id INTEGER NOT NULL,
  terrain_name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  FOREIGN KEY (vehicle_id) REFERENCES vehicles(id) ON DELETE CASCADE,
  FOREIGN KEY (terrain_name) REFERENCES terrain_types(name) ON DELETE CASCADE,
  UNIQUE(vehicle_id, terrain_name)
);

-- Создаем индексы (если еще не созданы)
CREATE INDEX IF NOT EXISTS idx_vehicle_terrains_vehicle_id ON vehicle_terrains(vehicle_id);
CREATE INDEX IF NOT EXISTS idx_vehicle_terrains_terrain_name ON vehicle_terrains(terrain_name);

-- Переносим существующие данные из поля terrain в новую таблицу vehicle_terrains
INSERT INTO vehicle_terrains (vehicle_id, terrain_name)
SELECT id, terrain
FROM vehicles
WHERE terrain IS NOT NULL AND terrain != ''
ON CONFLICT (vehicle_id, terrain_name) DO NOTHING;

-- Поле terrain оставляем для обратной совместимости (можно будет удалить позже)

