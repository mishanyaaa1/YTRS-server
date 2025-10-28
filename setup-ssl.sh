#!/bin/bash

# Скрипт для настройки SSL сертификатов с Let's Encrypt
set -e

echo "🔒 Настройка SSL сертификатов..."

# Проверяем наличие .env файла
if [ ! -f ".env" ]; then
    echo "❌ Файл .env не найден. Сначала настройте переменные окружения."
    exit 1
fi

# Загружаем переменные из .env
source .env

# Проверяем необходимые переменные
if [ -z "$DOMAIN" ] || [ -z "$SSL_EMAIL" ]; then
    echo "❌ Ошибка: Необходимо настроить DOMAIN и SSL_EMAIL в файле .env"
    exit 1
fi

echo "🌐 Домен: $DOMAIN"
echo "📧 Email: $SSL_EMAIL"

# Создаем директории для certbot
mkdir -p ssl
mkdir -p certbot/www
mkdir -p certbot/conf

# Останавливаем nginx для получения сертификата
echo "🛑 Останавливаем nginx..."
docker-compose stop nginx

# Получаем SSL сертификат
echo "🔐 Получаем SSL сертификат от Let's Encrypt..."
docker run --rm \
    -v "$(pwd)/certbot/conf:/etc/letsencrypt" \
    -v "$(pwd)/certbot/www:/var/www/certbot" \
    certbot/certbot certonly \
    --webroot \
    --webroot-path=/var/www/certbot \
    --email "$SSL_EMAIL" \
    --agree-tos \
    --no-eff-email \
    --domains "$DOMAIN,www.$DOMAIN"

# Копируем сертификаты в директорию ssl
echo "📋 Копируем сертификаты..."
cp "certbot/conf/live/$DOMAIN/fullchain.pem" ssl/
cp "certbot/conf/live/$DOMAIN/privkey.pem" ssl/

# Обновляем nginx конфигурацию с правильным доменом
echo "⚙️  Обновляем конфигурацию nginx..."
sed -i "s/yourdomain.com/$DOMAIN/g" nginx/conf.d/default.conf

# Запускаем nginx
echo "🚀 Запускаем nginx с SSL..."
docker-compose up -d nginx

# Проверяем статус
echo "📊 Проверяем статус сервисов:"
docker-compose ps

echo "✅ SSL настроен успешно!"
echo "🔒 Сайт доступен по адресу: https://$DOMAIN"
echo "🔄 Для автоматического обновления сертификатов добавьте в crontab:"
echo "   0 12 * * * cd $(pwd) && docker run --rm -v $(pwd)/certbot/conf:/etc/letsencrypt -v $(pwd)/certbot/www:/var/www/certbot certbot/certbot renew --quiet && docker-compose restart nginx"
