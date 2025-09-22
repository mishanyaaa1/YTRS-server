-- Исправление таблицы bot_settings
DROP TABLE IF EXISTS bot_settings;

CREATE TABLE bot_settings (
  id SERIAL PRIMARY KEY,
  bot_token VARCHAR(255),
  chat_id VARCHAR(255),
  enabled INTEGER DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Вставляем дефолтные настройки
INSERT INTO bot_settings (bot_token, chat_id, enabled) VALUES 
('8220911923:AAHOV3xvBPioSoBh53bPfceJBBkFYk1aqu0', '', 1);
