import React, { useState } from 'react';
import { useAuth } from '../context/AuthContext';
import './LoginForm.css';

const LoginForm = ({ onSuccess }) => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const { login } = useAuth();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setIsLoading(true);

    try {
      const result = login(username, password);
      
      if (result.success) {
        if (onSuccess) {
          onSuccess();
        }
      } else {
        setError(result.error || 'Ошибка авторизации');
      }
    } catch (err) {
      setError('Произошла ошибка при авторизации');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="login-form-container">
      <div className="login-form-wrapper">
        <div className="login-form-header">
          <h2>Вход в админ-панель</h2>
          <p>Введите логин и пароль для доступа к административной панели</p>
        </div>
        
        <form className="login-form" onSubmit={handleSubmit}>
          <div className="form-group">
            <label htmlFor="username">Логин</label>
            <input
              type="text"
              id="username"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              placeholder="Введите логин"
              required
              disabled={isLoading}
              autoComplete="username"
            />
          </div>
          
          <div className="form-group">
            <label htmlFor="password">Пароль</label>
            <input
              type="password"
              id="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="Введите пароль"
              required
              disabled={isLoading}
              autoComplete="current-password"
            />
          </div>
          
          {error && (
            <div className="error-message">
              {error}
            </div>
          )}
          
          <button 
            type="submit" 
            className="login-button"
            disabled={isLoading}
          >
            {isLoading ? 'Вход...' : 'Войти'}
          </button>
        </form>
        
        <div className="login-form-footer">
          <p>Доступ к административной панели</p>
        </div>
      </div>
    </div>
  );
};

export default LoginForm;
