#!/bin/bash

# YTORSWEB Auto Deploy Script
# Этот скрипт автоматически развертывает проект на сервере

set -e  # Остановить при ошибке

echo "🚀 Начинаем деплой YTORSWEB..."

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Функция для вывода сообщений
log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

success() {
    echo -e "${GREEN}✅ $1${NC}"
}

warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

error() {
    echo -e "${RED}❌ $1${NC}"
}

# Проверка, что мы в правильной директории
if [ ! -f "package.json" ]; then
    error "Файл package.json не найден. Убедитесь, что вы находитесь в корне проекта."
    exit 1
fi

log "Обновляем код из Git репозитория..."
git pull origin main

log "Останавливаем существующие контейнеры..."
docker-compose down || true

log "Создаем необходимые директории..."
mkdir -p server/uploads
mkdir -p server/backups
mkdir -p ssl

log "Копируем файл окружения..."
if [ ! -f ".env" ]; then
    cp .env.production .env
    success "Создан файл .env из .env.production"
else
    warning "Файл .env уже существует, пропускаем копирование"
fi

log "Собираем и запускаем контейнеры..."
docker-compose up -d --build

log "Ждем запуска базы данных..."
sleep 10

log "Проверяем подключение к базе данных..."
# Ждем пока PostgreSQL будет готов
for i in {1..30}; do
    if docker-compose exec -T app node -e "
        const { run } = require('./db_switch');
        run('SELECT 1').then(() => {
            console.log('DB connected');
            process.exit(0);
        }).catch(() => process.exit(1));
    " 2>/dev/null; then
        success "База данных подключена"
        break
    fi
    if [ $i -eq 30 ]; then
        error "Не удалось подключиться к базе данных"
        exit 1
    fi
    sleep 2
done

log "Создаем таблицы в базе данных..."
docker-compose exec -T app node -e "
    const fs = require('fs');
    const { run } = require('./db_switch');
    const sql = fs.readFileSync('./postgres_schema.sql', 'utf8');
    const statements = sql.split(';').filter(s => s.trim());
    
    async function createTables() {
        for (const statement of statements) {
            if (statement.trim()) {
                try {
                    await run(statement);
                    console.log('✓ Table created/updated');
                } catch (err) {
                    console.log('⚠ Table might already exist:', err.message);
                }
            }
        }
        console.log('✅ Database schema created successfully');
        process.exit(0);
    }
    
    createTables().catch(err => {
        console.error('❌ Error creating tables:', err);
        process.exit(1);
    });
"

log "Проверяем статус контейнеров..."
docker-compose ps

log "Проверяем доступность приложения..."
sleep 5
if curl -f http://localhost:3001/api/health >/dev/null 2>&1; then
    success "API сервер работает на порту 3001"
else
    warning "API сервер не отвечает, проверьте логи: docker-compose logs app"
fi

if curl -f http://localhost:80 >/dev/null 2>&1; then
    success "Nginx работает на порту 80"
else
    warning "Nginx не отвечает, проверьте логи: docker-compose logs nginx"
fi

success "🎉 Деплой завершен!"
echo ""
echo "📋 Информация о деплое:"
echo "   • API: http://89.111.168.163:3001"
echo "   • Сайт: http://89.111.168.163"
echo "   • Админка: http://89.111.168.163/admin"
echo ""
echo "🔧 Полезные команды:"
echo "   • Просмотр логов: docker-compose logs -f"
echo "   • Перезапуск: docker-compose restart"
echo "   • Остановка: docker-compose down"
echo "   • Обновление: ./deploy-server.sh"
echo ""
echo "📝 Следующие шаги:"
echo "   1. Настройте домен и SSL: ./setup-ssl.sh"
echo "   2. Импортируйте данные из старой БД"
echo "   3. Настройте Telegram бота в админке"
