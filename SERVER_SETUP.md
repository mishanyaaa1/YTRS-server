# 🚀 Настройка сервера для YTORSWEB

## 📋 Предварительные требования

- Ubuntu 24.04 LTS
- Root доступ к серверу
- IP адрес: 89.111.168.163

## 🔧 Пошаговая настройка

### 1. Подключение к серверу

```bash
# Подключение по SSH
ssh root@89.111.168.163
```

### 2. Обновление системы

```bash
# Обновление пакетов
apt update && apt upgrade -y

# Установка необходимых пакетов
apt install -y curl wget git nano htop ufw
```

### 3. Создание пользователя для проекта

```bash
# Создание пользователя
adduser ytors
usermod -aG sudo ytors

# Создание SSH директории
mkdir -p /home/ytors/.ssh
chmod 700 /home/ytors/.ssh

# Добавление SSH ключа (замените на ваш публичный ключ)
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC4J7e79XyBgy3LyB1fwn38SIb8RUGmWCkV6IvoXPaoEW7aFt6pYTTrt3NANd8mPMMV6sy5S2mvPI1ktKmWI9U4koqP7XuH5HOEKaEdOSn94SFeHQ++SSnBw5wl7GZ1wCKutuU6h2g5vkLBp6UPgn6upKkIxhAAxJGNDh0sFmoh8IHp+CdJpIbGQzi4TcoVFlbNFX3SLfWTHT9Ic2V8HrXmImTYU4vV3g25IoIfs4SdHph0M8us41TnQnQzpdYGezfjDr9Oqy6KNno0S/igMnjBxcc8oZOKVnItXXa4Ca0qM40OMZc5aM09m+7bw43hkv35R64jMRmiTwt5OJa/ehkuvSiqu32PFhzywDl2UHpM/srDdwu4ouQCk5pR7fpwdTXHiQIv08PNDhQTqpMQxRTUUBMpLsqo3cZcEcsX1kc/cJJErBTstMhwsNV2gXMV1lM7tFCGMwwKztFEb7YmEgyfpLsyKqdlJbNcUdrWsOvAEhExZCIUWi93KTLjj6zGjL3PlTzLLuZqPVcdHE4g4YA37I+jr1jX1URR/uNyVdromvGTxOOdi7n/tsWEKWeLJwRRDYpqwE6Ozj1TdGuf+8E3XADVLm2a/2ii8sZDI9ad8kvzrN2zFKHNfgbs+fE+9kVzY/hkYc6AZdtkelttsa8tA6SRV27+2nG2kX2i1+Oovw== i.am31827@gmail.com" > /home/ytors/.ssh/authorized_keys

chmod 600 /home/ytors/.ssh/authorized_keys
chown -R ytors:ytors /home/ytors/.ssh
```

### 4. Установка Docker и Docker Compose

```bash
# Установка Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker ytors

# Установка Docker Compose
curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Проверка установки
docker --version
docker-compose --version
```

### 5. Установка PostgreSQL

```bash
# Установка PostgreSQL
apt install -y postgresql postgresql-contrib

# Запуск PostgreSQL
systemctl start postgresql
systemctl enable postgresql

# Создание базы данных и пользователя
sudo -u postgres psql
```

В PostgreSQL выполните:
```sql
CREATE DATABASE ytorsweb;
CREATE USER ytors WITH PASSWORD 'Thereisnospoon31827';
GRANT ALL PRIVILEGES ON DATABASE ytorsweb TO ytors;
ALTER USER ytors CREATEDB;
\q
```

### 6. Настройка файрвола

```bash
# Настройка UFW
ufw allow 22
ufw allow 80
ufw allow 443
ufw --force enable
```

### 7. Клонирование и деплой проекта

```bash
# Переключение на пользователя ytors
su - ytors

# Клонирование проекта
git clone https://github.com/mishanyaaa1/YTRS.git
cd YTRS

# Сделать скрипт деплоя исполняемым
chmod +x deploy-server.sh

# Запуск деплоя
./deploy-server.sh
```

## 🔍 Проверка работы

После завершения деплоя проверьте:

1. **API сервер**: http://89.111.168.163:3001/api/health
2. **Веб-сайт**: http://89.111.168.163
3. **Админ панель**: http://89.111.168.163/admin

## 📝 Полезные команды

```bash
# Просмотр логов
docker-compose logs -f

# Перезапуск сервисов
docker-compose restart

# Остановка всех сервисов
docker-compose down

# Обновление проекта
git pull origin main
./deploy-server.sh
```

## 🔧 Настройка SSL (опционально)

После настройки домена:

```bash
# Настройка SSL
./setup-ssl.sh
```

## 📊 Мониторинг

```bash
# Статус контейнеров
docker-compose ps

# Использование ресурсов
docker stats

# Логи приложения
docker-compose logs app

# Логи Nginx
docker-compose logs nginx
```

## 🆘 Устранение неполадок

### Проблема с базой данных
```bash
# Проверка подключения к PostgreSQL
docker-compose exec app node -e "require('./db_switch').run('SELECT 1').then(() => console.log('OK')).catch(console.error)"
```

### Проблема с портами
```bash
# Проверка занятых портов
netstat -tulpn | grep :3001
netstat -tulpn | grep :80
```

### Перезапуск с нуля
```bash
# Остановка и удаление всех контейнеров
docker-compose down -v
docker system prune -f

# Повторный деплой
./deploy-server.sh
```
