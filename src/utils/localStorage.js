// Утилиты для надежной работы с localStorage

const STORAGE_KEYS = {
  CART: 'cart',
  USER_PREFERENCES: 'user_preferences'
};

// Проверка доступности localStorage
const isLocalStorageAvailable = () => {
  try {
    const test = '__localStorage_test__';
    localStorage.setItem(test, test);
    localStorage.removeItem(test);
    return true;
  } catch (e) {
    return false;
  }
};

// Безопасное сохранение данных
export const safeSetItem = (key, value) => {
  if (!isLocalStorageAvailable()) {
    console.warn('localStorage недоступен');
    return false;
  }
  
  try {
    console.log(`localStorage: Сохраняем ${key}:`, value);
    localStorage.setItem(key, JSON.stringify(value));
    return true;
  } catch (error) {
    console.error(`Ошибка при сохранении в localStorage (${key}):`, error);
    return false;
  }
};

// Безопасное получение данных
export const safeGetItem = (key, defaultValue = null) => {
  if (!isLocalStorageAvailable()) {
    console.warn('localStorage недоступен');
    return defaultValue;
  }
  
  try {
    const item = localStorage.getItem(key);
    console.log(`localStorage: Читаем ${key}:`, item);
    
    // Проверяем на null, undefined и строку "undefined"
    if (item === null || item === undefined || item === 'undefined' || item === 'null') {
      return defaultValue;
    }
    
    const parsed = JSON.parse(item);
    console.log(`localStorage: Распарсено ${key}:`, parsed);
    return parsed;
  } catch (error) {
    console.error(`Ошибка при чтении из localStorage (${key}):`, error);
    // Удаляем поврежденные данные
    localStorage.removeItem(key);
    return defaultValue;
  }
};

// Безопасное удаление данных
export const safeRemoveItem = (key) => {
  if (!isLocalStorageAvailable()) {
    return false;
  }
  
  try {
    localStorage.removeItem(key);
    return true;
  } catch (error) {
    console.error(`Ошибка при удалении из localStorage (${key}):`, error);
    return false;
  }
};

// Очистка всех данных приложения
export const clearAppData = () => {
  Object.values(STORAGE_KEYS).forEach(key => {
    safeRemoveItem(key);
  });
};

// Очистка поврежденных данных из localStorage
export const cleanupCorruptedData = () => {
  if (!isLocalStorageAvailable()) {
    return;
  }
  
  const adminKeys = [
    'adminProducts',
    'adminCategories', 
    'adminBrands',
    'adminPromotions',
    'adminPromocodes',
    'adminVehicles',
    'adminTerrainTypes',
    'adminVehicleTypes',
    'adminAboutContent',
    'adminFilterSettings',
    'adminPopularProducts',
    'admin_token',
    'auth_session'
  ];
  
  adminKeys.forEach(key => {
    try {
      const item = localStorage.getItem(key);
      if (item === 'undefined' || item === 'null') {
        localStorage.removeItem(key);
        console.log(`Очищен поврежденный ключ: ${key}`);
      } else if (item) {
        // Проверяем, можно ли распарсить
        JSON.parse(item);
      }
    } catch (error) {
      localStorage.removeItem(key);
      console.log(`Очищен поврежденный ключ: ${key} (${error.message})`);
    }
  });
};

// Получение размера данных в localStorage
export const getStorageSize = () => {
  if (!isLocalStorageAvailable()) {
    return 0;
  }
  
  let total = 0;
  for (let key in localStorage) {
    if (localStorage.hasOwnProperty(key)) {
      total += localStorage[key].length + key.length;
    }
  }
  return total;
};

// Проверка, не превышен ли лимит localStorage
export const checkStorageLimit = () => {
  const size = getStorageSize();
  const limit = 5 * 1024 * 1024; // 5MB
  return size < limit;
};

export { STORAGE_KEYS };
