-- Миграция для поддержки множественного выбора типов местности
-- Выполните этот скрипт на вашей базе данных для обновления схемы

-- 1. Удаляем внешний ключ для terrain (если существует)
ALTER TABLE vehicles 
  DROP CONSTRAINT IF EXISTS vehicles_terrain_fkey;

-- 2. Изменяем тип поля terrain с VARCHAR(255) на TEXT для хранения JSON массива
ALTER TABLE vehicles 
  ALTER COLUMN terrain TYPE TEXT USING terrain::TEXT;

-- 3. Конвертируем существующие строковые значения в JSON массивы
-- Это преобразует 'Снег' в '["Снег"]'
UPDATE vehicles 
SET terrain = '["' || terrain || '"]'
WHERE terrain IS NOT NULL 
  AND terrain != '' 
  AND NOT (terrain LIKE '[%' AND terrain LIKE '%]');

-- 4. Обновляем индекс (если он существует, он все еще будет работать для TEXT)
-- Индекс idx_vehicles_terrain остается, но теперь будет индексировать JSON строки

-- Примечание: Если у вас есть данные в БД, они будут автоматически преобразованы
-- Новые записи должны использовать JSON формат: '["Снег", "Болото"]'
