// PostgreSQL подключение
const DB_POSTGRES = 'postgres';

console.log(`Используется база данных: ${DB_POSTGRES}`);

// Экспортируем модуль PostgreSQL
module.exports = require('./db_postgres');
module.exports.dbType = DB_POSTGRES;

module.exports.DB_TYPES = {
  POSTGRES: DB_POSTGRES
};
