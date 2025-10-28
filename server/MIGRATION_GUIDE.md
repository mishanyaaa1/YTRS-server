# Руководство по миграции: Множественные типы местности для вездеходов

## Описание изменений

Эта миграция добавляет поддержку множественных типов местности для вездеходов. Теперь каждый вездеход может быть привязан к нескольким типам местности (например, "Снег", "Болото", "Горы").

## Изменения в базе данных

### Новая таблица
- `vehicle_terrain` - связующая таблица для отношения многие-ко-многим между вездеходами и типами местности

### Изменения в существующих таблицах
- `vehicles.terrain` - поле больше не обязательное (NOT NULL удален), оставлено для обратной совместимости

## Порядок применения миграции

### Вариант 1: Автоматическая миграция (рекомендуется)

1. Подключитесь к базе данных PostgreSQL:
```bash
psql -U your_username -d your_database_name
```

2. Выполните миграционный скрипт:
```bash
\i server/migration_vehicle_terrain.sql
```

### Вариант 2: Ручная миграция

Если у вас уже есть существующие вездеходы в базе данных:

1. Создайте связующую таблицу:
```sql
CREATE TABLE IF NOT EXISTS vehicle_terrain (
  id SERIAL PRIMARY KEY,
  vehicle_id INTEGER NOT NULL,
  terrain_name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  FOREIGN KEY (vehicle_id) REFERENCES vehicles(id) ON DELETE CASCADE,
  FOREIGN KEY (terrain_name) REFERENCES terrain_types(name) ON DELETE CASCADE,
  UNIQUE(vehicle_id, terrain_name)
);

CREATE INDEX IF NOT EXISTS idx_vehicle_terrain_vehicle_id ON vehicle_terrain(vehicle_id);
CREATE INDEX IF NOT EXISTS idx_vehicle_terrain_terrain_name ON vehicle_terrain(terrain_name);
```

2. Мигрируйте существующие данные:
```sql
INSERT INTO vehicle_terrain (vehicle_id, terrain_name)
SELECT id, terrain 
FROM vehicles 
WHERE terrain IS NOT NULL AND terrain != ''
ON CONFLICT (vehicle_id, terrain_name) DO NOTHING;
```

3. Сделайте поле terrain опциональным:
```sql
ALTER TABLE vehicles DROP CONSTRAINT IF EXISTS vehicles_terrain_fkey;
ALTER TABLE vehicles ALTER COLUMN terrain DROP NOT NULL;
```

4. Обновите индексы:
```sql
-- Удаляем старый индекс (если существует)
DROP INDEX IF EXISTS idx_vehicles_terrain;

-- Индексы для новой таблицы уже созданы на шаге 1
```

## Проверка миграции

После применения миграции выполните проверку:

```sql
-- Проверяем структуру новой таблицы
SELECT * FROM vehicle_terrain LIMIT 5;

-- Проверяем, что данные мигрировали корректно
SELECT 
  v.id, 
  v.name, 
  array_agg(vt.terrain_name) as terrains
FROM vehicles v
LEFT JOIN vehicle_terrain vt ON v.id = vt.vehicle_id
GROUP BY v.id, v.name;
```

## Откат миграции (если необходимо)

⚠️ **ВНИМАНИЕ**: Откат приведет к потере информации о множественных типах местности!

```sql
-- Восстанавливаем поле terrain как обязательное
UPDATE vehicles SET terrain = (
  SELECT terrain_name FROM vehicle_terrain 
  WHERE vehicle_id = vehicles.id 
  LIMIT 1
) WHERE terrain IS NULL;

ALTER TABLE vehicles ALTER COLUMN terrain SET NOT NULL;
ALTER TABLE vehicles ADD CONSTRAINT vehicles_terrain_fkey 
  FOREIGN KEY (terrain) REFERENCES terrain_types(name) ON DELETE SET NULL;

-- Удаляем связующую таблицу
DROP TABLE IF EXISTS vehicle_terrain;

-- Восстанавливаем индекс
CREATE INDEX IF NOT EXISTS idx_vehicles_terrain ON vehicles(terrain);
```

## Изменения в API

### GET /api/vehicles
Теперь возвращает массив `terrains` для каждого вездехода:
```json
{
  "id": 1,
  "name": "Буран",
  "type": "Гусеничный",
  "terrain": "Снег",  // Оставлено для обратной совместимости
  "terrains": ["Снег", "Лес", "Горы"],  // Новое поле
  ...
}
```

### POST /api/vehicles
Принимает массив `terrains`:
```json
{
  "name": "Буран",
  "type": "Гусеничный",
  "terrains": ["Снег", "Лес", "Горы"],
  ...
}
```

### PUT /api/vehicles/:id
Также принимает массив `terrains`:
```json
{
  "name": "Буран",
  "type": "Гусеничный",
  "terrains": ["Снег", "Лес"],
  ...
}
```

## Изменения в фронтенде

1. **VehiclesManagement.jsx** - добавлен множественный выбор типов местности через чекбоксы
2. **VehiclesPage.jsx** - фильтр работает с массивом типов местности (показывает вездеход, если хотя бы один тип совпадает)
3. **VehicleDetailPage.jsx** - отображаются все типы местности вездехода
4. **AdminDataContext.jsx** - обновлен для работы с массивом типов местности

## Обратная совместимость

Миграция сохраняет обратную совместимость:
- Поле `terrain` в таблице `vehicles` сохранено (но больше не обязательное)
- API возвращает как старое поле `terrain`, так и новый массив `terrains`
- Фронтенд корректно обрабатывает оба формата данных

## Рекомендации

1. Создайте резервную копию базы данных перед миграцией
2. Примените миграцию в тестовой среде перед продакшеном
3. После миграции проверьте работу фильтров на странице вездеходов
4. Убедитесь, что все существующие вездеходы отображаются корректно

## Поддержка

Если возникли проблемы с миграцией, проверьте:
1. Версию PostgreSQL (должна быть >= 9.5)
2. Наличие прав на создание таблиц и индексов
3. Логи сервера приложения
4. Консоль браузера для ошибок фронтенда

