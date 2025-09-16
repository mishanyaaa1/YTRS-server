# 🚀 Инструкция по деплою YTORSWEB на VPS

## 📋 Требования

### Системные требования:
- **ОС**: Ubuntu 20.04+ или CentOS 8+ (рекомендуется Ubuntu)
- **RAM**: минимум 2GB, рекомендуется 4GB+
- **CPU**: 2 ядра
- **Диск**: минимум 20GB свободного места
- **Сеть**: статический IP-адрес

### Программное обеспечение:
- Docker 20.10+
- Docker Compose 2.0+
- Git

## 🛠️ Подготовка VPS

### 1. Обновление системы
```bash
# Ubuntu/Debian
sudo apt update && sudo apt upgrade -y

# CentOS/RHEL
sudo yum update -y
```

### 2. Установка Docker
```bash
# Ubuntu/Debian
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Установка Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

### 3. Настройка файрвола
```bash
# Ubuntu (ufw)
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable

# CentOS (firewalld)
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload
```

## 📁 Развертывание приложения

### 1. Клонирование репозитория
```bash
git clone <your-repository-url>
cd YTORSWEB
```

### 2. Настройка переменных окружения
```bash
# Копируем пример конфигурации
cp env.production.example .env

# Редактируем конфигурацию
nano .env
```

**Важные переменные для изменения:**
```env
# Обязательно измените!
POSTGRES_PASSWORD=your_secure_password_here
JWT_SECRET=your_super_secure_jwt_secret_key_here
ADMIN_USERNAME=admin
ADMIN_PASSWORD=your_secure_admin_password_here
DOMAIN=yourdomain.com
SSL_EMAIL=your-email@example.com
```

### 3. Первоначальный деплой
```bash
# Делаем скрипты исполняемыми
chmod +x deploy.sh setup-ssl.sh backup.sh

# Запускаем деплой
./deploy.sh
```

### 4. Настройка SSL сертификатов
```bash
# Настраиваем SSL (только после успешного деплоя)
./setup-ssl.sh
```

## 🔧 Управление приложением

### Основные команды Docker Compose:

```bash
# Просмотр статуса
docker-compose ps

# Просмотр логов
docker-compose logs -f app
docker-compose logs -f nginx

# Перезапуск сервисов
docker-compose restart app
docker-compose restart nginx

# Остановка всех сервисов
docker-compose down

# Обновление приложения
docker-compose pull
docker-compose up -d --build
```

### Резервное копирование:
```bash
# Создание резервной копии
./backup.sh

# Резервные копии сохраняются в ./backups/
```

## 🌐 Настройка домена

### 1. DNS настройки
Настройте A-записи в DNS:
```
yourdomain.com → IP_VPS
www.yourdomain.com → IP_VPS
```

### 2. Проверка доступности
```bash
# Проверка HTTP
curl -I http://yourdomain.com

# Проверка HTTPS (после настройки SSL)
curl -I https://yourdomain.com
```

## 🔒 Безопасность

### 1. Настройка SSH
```bash
# Отключение root логина
sudo nano /etc/ssh/sshd_config
# Установите: PermitRootLogin no

# Перезапуск SSH
sudo systemctl restart sshd
```

### 2. Регулярные обновления
```bash
# Добавьте в crontab для автоматических обновлений
crontab -e

# Добавьте строку:
0 2 * * 0 cd /path/to/YTORSWEB && docker-compose pull && docker-compose up -d
```

### 3. Мониторинг
```bash
# Установка htop для мониторинга
sudo apt install htop

# Просмотр использования ресурсов
docker stats
```

## 🚨 Устранение неполадок

### Проблемы с базой данных:
```bash
# Проверка логов PostgreSQL
docker-compose logs postgres

# Подключение к базе данных
docker-compose exec postgres psql -U postgres -d ytorsweb
```

### Проблемы с SSL:
```bash
# Проверка сертификатов
docker-compose exec nginx openssl x509 -in /etc/nginx/ssl/fullchain.pem -text -noout

# Обновление сертификатов
docker run --rm -v $(pwd)/certbot/conf:/etc/letsencrypt -v $(pwd)/certbot/www:/var/www/certbot certbot/certbot renew
docker-compose restart nginx
```

### Проблемы с производительностью:
```bash
# Очистка Docker
docker system prune -a

# Проверка использования диска
df -h
docker system df
```

## 📊 Мониторинг и логи

### Просмотр логов:
```bash
# Все сервисы
docker-compose logs -f

# Конкретный сервис
docker-compose logs -f app
docker-compose logs -f nginx
docker-compose logs -f postgres
```

### Мониторинг ресурсов:
```bash
# Использование ресурсов контейнерами
docker stats

# Системная информация
htop
```

## 🔄 Обновление приложения

### Процесс обновления:
```bash
# 1. Остановка сервисов
docker-compose down

# 2. Создание резервной копии
./backup.sh

# 3. Получение обновлений
git pull origin main

# 4. Пересборка и запуск
docker-compose up -d --build

# 5. Проверка статуса
docker-compose ps
```

## 📞 Поддержка

При возникновении проблем:
1. Проверьте логи: `docker-compose logs -f`
2. Проверьте статус контейнеров: `docker-compose ps`
3. Проверьте использование ресурсов: `docker stats`
4. Создайте резервную копию: `./backup.sh`

## 🎯 Полезные команды

```bash
# Быстрый перезапуск
docker-compose restart

# Очистка неиспользуемых образов
docker image prune -a

# Проверка здоровья приложения
curl -f http://localhost/health

# Просмотр переменных окружения контейнера
docker-compose exec app env
```
