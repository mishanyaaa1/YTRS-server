# 🚀 Быстрый старт - Деплой YTORSWEB на VPS

## 📋 Что нужно сделать

### 1. Подготовка VPS (Ubuntu 20.04+)
```bash
# Обновление системы
sudo apt update && sudo apt upgrade -y

# Установка Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Установка Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Настройка файрвола
sudo ufw allow 22,80,443/tcp
sudo ufw enable

# Перелогиниться для применения группы docker
exit
# Войти заново в SSH
```

### 2. Клонирование и настройка проекта
```bash
# Клонирование репозитория
git clone <your-repository-url>
cd YTORSWEB

# Настройка переменных окружения
cp env.production.example .env
nano .env  # Отредактировать переменные
```

**Обязательно измените в .env:**
- `POSTGRES_PASSWORD` - надежный пароль для БД
- `JWT_SECRET` - уникальный секретный ключ
- `ADMIN_PASSWORD` - пароль для админки
- `DOMAIN` - ваш домен (например: mysite.com)
- `SSL_EMAIL` - ваш email для SSL

### 3. Запуск приложения
```bash
# Делаем скрипты исполняемыми
chmod +x deploy.sh setup-ssl.sh backup.sh

# Первый запуск
./deploy.sh

# Настройка SSL (после успешного запуска)
./setup-ssl.sh
```

### 4. Настройка DNS
В панели управления доменом добавьте A-записи:
```
yourdomain.com → IP_VPS
www.yourdomain.com → IP_VPS
```

## ✅ Проверка работы

```bash
# Проверка статуса
docker-compose ps

# Проверка логов
docker-compose logs -f app

# Проверка доступности
curl -I http://yourdomain.com
curl -I https://yourdomain.com
```

## 🔧 Основные команды

```bash
# Просмотр логов
docker-compose logs -f

# Перезапуск
docker-compose restart

# Остановка
docker-compose down

# Создание бэкапа
./backup.sh

# Обновление приложения
git pull
docker-compose up -d --build
```

## 🚨 Если что-то пошло не так

1. **Проверьте логи:** `docker-compose logs -f`
2. **Проверьте статус:** `docker-compose ps`
3. **Проверьте переменные:** `cat .env`
4. **Проверьте файрвол:** `sudo ufw status`

## 📞 Админка

После успешного запуска:
- Админка: `https://yourdomain.com/admin`
- Логин: из переменной `ADMIN_USERNAME` (по умолчанию: admin)
- Пароль: из переменной `ADMIN_PASSWORD`

## 🎯 Готово!

Ваш сайт теперь доступен по адресу `https://yourdomain.com`

Для подробной инструкции см. [DEPLOYMENT.md](DEPLOYMENT.md)
