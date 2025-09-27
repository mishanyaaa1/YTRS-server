import React, { createContext, useContext, useState, useEffect } from 'react';

const AuthContext = createContext();

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth должен использоваться внутри AuthProvider');
  }
  return context;
};

// Конфигурация авторизации
const AUTH_CONFIG = {
  login: 'admin',
  password: 'admin31827',
  sessionKey: 'ytors_admin_auth'
};

export const AuthProvider = ({ children }) => {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [isLoading, setIsLoading] = useState(true);

  // Проверяем авторизацию при загрузке
  useEffect(() => {
    const checkAuth = () => {
      try {
        const storedAuth = localStorage.getItem(AUTH_CONFIG.sessionKey);
        if (storedAuth) {
          const authData = JSON.parse(storedAuth);
          // Проверяем, что данные валидны и не истекли
          if (authData.authenticated && authData.timestamp) {
            const now = Date.now();
            const authTime = authData.timestamp;
            const sessionDuration = 24 * 60 * 60 * 1000; // 24 часа
            
            if (now - authTime < sessionDuration) {
              setIsAuthenticated(true);
            } else {
              // Сессия истекла
              localStorage.removeItem(AUTH_CONFIG.sessionKey);
              setIsAuthenticated(false);
            }
          } else {
            setIsAuthenticated(false);
          }
        } else {
          setIsAuthenticated(false);
        }
      } catch (error) {
        console.error('Ошибка проверки авторизации:', error);
        localStorage.removeItem(AUTH_CONFIG.sessionKey);
        setIsAuthenticated(false);
      } finally {
        setIsLoading(false);
      }
    };

    checkAuth();
  }, []);

  const login = (username, password) => {
    if (username === AUTH_CONFIG.login && password === AUTH_CONFIG.password) {
      const authData = {
        authenticated: true,
        timestamp: Date.now(),
        username: username
      };
      
      try {
        localStorage.setItem(AUTH_CONFIG.sessionKey, JSON.stringify(authData));
        setIsAuthenticated(true);
        return { success: true };
      } catch (error) {
        console.error('Ошибка сохранения авторизации:', error);
        return { success: false, error: 'Ошибка сохранения сессии' };
      }
    } else {
      return { success: false, error: 'Неверный логин или пароль' };
    }
  };

  const logout = () => {
    try {
      localStorage.removeItem(AUTH_CONFIG.sessionKey);
      setIsAuthenticated(false);
    } catch (error) {
      console.error('Ошибка выхода из системы:', error);
    }
  };

  const extendSession = () => {
    if (isAuthenticated) {
      try {
        const storedAuth = localStorage.getItem(AUTH_CONFIG.sessionKey);
        if (storedAuth) {
          const authData = JSON.parse(storedAuth);
          authData.timestamp = Date.now();
          localStorage.setItem(AUTH_CONFIG.sessionKey, JSON.stringify(authData));
        }
      } catch (error) {
        console.error('Ошибка продления сессии:', error);
      }
    }
  };

  // Продлеваем сессию при активности пользователя
  useEffect(() => {
    if (isAuthenticated) {
      const handleActivity = () => {
        extendSession();
      };

      // Продлеваем сессию при активности пользователя
      const events = ['mousedown', 'mousemove', 'keypress', 'scroll', 'touchstart'];
      events.forEach(event => {
        document.addEventListener(event, handleActivity, true);
      });

      return () => {
        events.forEach(event => {
          document.removeEventListener(event, handleActivity, true);
        });
      };
    }
  }, [isAuthenticated]);

  const value = {
    isAuthenticated,
    isLoading,
    login,
    logout,
    extendSession
  };

  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  );
};
