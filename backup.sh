#!/bin/bash

# Скрипт для резервного копирования базы данных
set -e

BACKUP_DIR="./backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="ytorsweb_backup_$TIMESTAMP.sql"

echo "💾 Создание резервной копии базы данных..."

# Создаем директорию для бэкапов
mkdir -p "$BACKUP_DIR"

# Загружаем переменные из .env
if [ -f ".env" ]; then
    source .env
else
    echo "⚠️  Файл .env не найден, используем значения по умолчанию"
    POSTGRES_PASSWORD="password"
fi

# Создаем бэкап базы данных
echo "📋 Создаем дамп базы данных..."
docker-compose exec -T postgres pg_dump -U postgres -d ytorsweb > "$BACKUP_DIR/$BACKUP_FILE"

# Сжимаем бэкап
echo "🗜️  Сжимаем резервную копию..."
gzip "$BACKUP_DIR/$BACKUP_FILE"

# Удаляем старые бэкапы (старше 30 дней)
echo "🧹 Удаляем старые резервные копии..."
find "$BACKUP_DIR" -name "ytorsweb_backup_*.sql.gz" -mtime +30 -delete

echo "✅ Резервная копия создана: $BACKUP_DIR/$BACKUP_FILE.gz"
echo "📊 Размер файла: $(du -h "$BACKUP_DIR/$BACKUP_FILE.gz" | cut -f1)"

# Опционально: загружаем бэкап в облачное хранилище
read -p "☁️  Загрузить бэкап в облачное хранилище? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "☁️  Функция загрузки в облако не реализована."
    echo "   Вы можете настроить автоматическую загрузку в AWS S3, Google Cloud Storage и т.д."
fi
