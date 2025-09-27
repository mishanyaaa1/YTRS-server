import React from 'react';
import './LoadingSpinner.css';

// Компонент спиннера с различными вариантами
export const LoadingSpinner = ({ size = 'medium', className = '', style = {} }) => {
  const sizeClass = size === 'large' ? 'spinner-large' : size === 'small' ? 'spinner-small' : '';
  
  return (
    <div className={`spinner ${sizeClass} ${className}`} style={style} />
  );
};

// Компонент загрузки с текстом
export const LoadingWithText = ({ text = 'Загрузка...', size = 'medium', className = '' }) => {
  return (
    <div className={`loading-spinner ${className}`}>
      <LoadingSpinner size={size} />
      <span className="loading-text">{text}</span>
    </div>
  );
};

// Компонент загрузки с точками
export const LoadingDots = ({ className = '' }) => {
  return (
    <div className={`loading-dots ${className}`}>
      <div className="loading-dot"></div>
      <div className="loading-dot"></div>
      <div className="loading-dot"></div>
    </div>
  );
};

// Компонент загрузки с волной
export const LoadingWave = ({ className = '' }) => {
  return (
    <div className={`wave-loading ${className}`}>
      <div className="wave-bar"></div>
      <div className="wave-bar"></div>
      <div className="wave-bar"></div>
      <div className="wave-bar"></div>
      <div className="wave-bar"></div>
    </div>
  );
};

// Компонент прогресс-бара загрузки
export const LoadingProgress = ({ className = '' }) => {
  return (
    <div className={`loading-progress ${className}`}>
      <div className="loading-progress-bar"></div>
    </div>
  );
};

// Компонент для кнопки во время загрузки
export const LoadingButton = ({ 
  children, 
  isLoading, 
  loadingText = 'Загрузка...', 
  className = '', 
  disabled = false,
  ...props 
}) => {
  return (
    <button 
      className={`submit-btn ${isLoading ? 'loading' : ''} ${className}`}
      disabled={disabled || isLoading}
      {...props}
    >
      {isLoading ? (
        <LoadingWithText text={loadingText} size="small" />
      ) : (
        children
      )}
    </button>
  );
};

// Компонент для отображения этапов загрузки заказа
export const OrderLoadingSteps = ({ currentStep = 0, isLoading = false, message = '' }) => {
  const steps = [
    { id: 1, text: 'Создание заказа', icon: '📝' },
    { id: 2, text: 'Отправка уведомления', icon: '📱' },
    { id: 3, text: 'Завершение', icon: '✅' }
  ];

  if (!isLoading) return null;

  return (
    <div className="order-loading-steps">
      <div className="loading-progress"></div>
      {message && (
        <div className="loading-message">
          <LoadingWave />
          <span>{message}</span>
        </div>
      )}
      <div className="loading-steps-list">
        {steps.map((step, index) => (
          <div 
            key={step.id} 
            className={`loading-step ${currentStep >= step.id ? 'active' : ''}`}
          >
            <span className="step-icon">
              {currentStep > step.id ? '✅' : currentStep === step.id ? '⏳' : step.icon}
            </span>
            <span className="step-text">{step.text}</span>
            {currentStep === step.id && <LoadingDots />}
          </div>
        ))}
      </div>
    </div>
  );
};

export default LoadingSpinner;
