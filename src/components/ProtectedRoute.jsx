import React from 'react';
import { useAuth } from '../context/AuthContext';
import LoginForm from './LoginForm';
import './ProtectedRoute.css';

const ProtectedRoute = ({ children }) => {
  const { isAuthenticated, isLoading } = useAuth();

  // Показываем загрузку пока проверяем авторизацию
  if (isLoading) {
    return (
      <div className="auth-loading">
        <div className="auth-loading-spinner"></div>
        <p>Проверка авторизации...</p>
      </div>
    );
  }

  // Если пользователь авторизован, показываем защищенный контент
  if (isAuthenticated) {
    return children;
  }

  // Если не авторизован, показываем форму входа
  return (
    <div className="protected-route">
      <LoginForm />
    </div>
  );
};

export default ProtectedRoute;
