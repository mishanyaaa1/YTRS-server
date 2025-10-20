import React, { useState } from 'react';
import './ChangePasswordModal.css';

const ChangePasswordModal = ({ isOpen, onClose, onPasswordChange }) => {
  const [currentPassword, setCurrentPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [error, setError] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');

    // Валидация
    if (!currentPassword || !newPassword || !confirmPassword) {
      setError('Все поля обязательны для заполнения');
      return;
    }

    if (newPassword !== confirmPassword) {
      setError('Новый пароль и подтверждение не совпадают');
      return;
    }

    if (newPassword.length < 6) {
      setError('Новый пароль должен содержать минимум 6 символов');
      return;
    }

    if (currentPassword === newPassword) {
      setError('Новый пароль должен отличаться от текущего');
      return;
    }

    setIsLoading(true);

    try {
      // Вызываем функцию изменения пароля из родительского компонента
      const result = await onPasswordChange(currentPassword, newPassword);
      
      if (result.success) {
        // Сбрасываем форму
        setCurrentPassword('');
        setNewPassword('');
        setConfirmPassword('');
        onClose();
      } else {
        setError(result.error || 'Ошибка при смене пароля');
      }
    } catch (err) {
      setError('Произошла ошибка при смене пароля');
    } finally {
      setIsLoading(false);
    }
  };

  const handleClose = () => {
    if (!isLoading) {
      setCurrentPassword('');
      setNewPassword('');
      setConfirmPassword('');
      setError('');
      onClose();
    }
  };

  if (!isOpen) return null;

  return (
    <div className="modal-overlay" onClick={handleClose}>
      <div className="modal-content change-password-modal" onClick={(e) => e.stopPropagation()}>
        <div className="modal-header">
          <h2>Смена пароля</h2>
          <button 
            className="modal-close" 
            onClick={handleClose}
            disabled={isLoading}
          >
            ×
          </button>
        </div>

        <form onSubmit={handleSubmit} className="change-password-form">
          <div className="form-group">
            <label htmlFor="currentPassword">Текущий пароль</label>
            <input
              type="password"
              id="currentPassword"
              value={currentPassword}
              onChange={(e) => setCurrentPassword(e.target.value)}
              placeholder="Введите текущий пароль"
              required
              disabled={isLoading}
              autoComplete="current-password"
            />
          </div>

          <div className="form-group">
            <label htmlFor="newPassword">Новый пароль</label>
            <input
              type="password"
              id="newPassword"
              value={newPassword}
              onChange={(e) => setNewPassword(e.target.value)}
              placeholder="Введите новый пароль"
              required
              disabled={isLoading}
              autoComplete="new-password"
              minLength={6}
            />
          </div>

          <div className="form-group">
            <label htmlFor="confirmPassword">Подтвердите новый пароль</label>
            <input
              type="password"
              id="confirmPassword"
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
              placeholder="Подтвердите новый пароль"
              required
              disabled={isLoading}
              autoComplete="new-password"
            />
          </div>

          {error && (
            <div className="error-message">
              {error}
            </div>
          )}

          <div className="form-actions">
            <button 
              type="button" 
              className="btn-secondary"
              onClick={handleClose}
              disabled={isLoading}
            >
              Отмена
            </button>
            <button 
              type="submit" 
              className="btn-primary"
              disabled={isLoading}
            >
              {isLoading ? 'Сохранение...' : 'Изменить пароль'}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};

export default ChangePasswordModal;
