# Multi-stage build для оптимизации размера
FROM node:18.19-alpine AS client-build

WORKDIR /app

# Копируем package.json для кэширования зависимостей
COPY package*.json ./

# Устанавливаем зависимости (включая dev для сборки)
RUN npm ci

# Копируем исходный код клиента
COPY . .

# Собираем клиент
RUN npm run build

# Production stage
FROM node:18.19-alpine AS production

WORKDIR /app

# Устанавливаем необходимые пакеты (sqlite3 убран, компиляция не нужна)
# RUN apk add --no-cache python3 make g++

# Копируем package.json сервера
COPY server/package*.json ./

# Устанавливаем зависимости сервера
RUN npm ci --only=production

# Копируем серверный код
COPY server/ .

# Копируем собранный клиент из предыдущего stage
COPY --from=client-build /app/dist ./public

# Создаем пользователя для безопасности
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nodejs -u 1001

# Создаем папки для загрузок с правильными правами
RUN mkdir -p /tmp/uploads /app/uploads /app/backups
RUN chown -R nodejs:nodejs /tmp/uploads /app/uploads /app/backups

# Меняем владельца файлов
RUN chown -R nodejs:nodejs /app
USER nodejs

# Открываем порт
EXPOSE 3001

# Команда запуска
CMD ["node", "index.js"]
