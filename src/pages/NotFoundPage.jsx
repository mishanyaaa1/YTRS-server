import React from 'react';
import { Link } from 'react-router-dom';
import { FaHome, FaSearch, FaArrowLeft, FaCog } from 'react-icons/fa';
import './NotFoundPage.css';

const NotFoundPage = () => {
  return (
    <div className="not-found-page">
      <div className="not-found-container">
        {/* Анимированный фон */}
        <div className="not-found-background">
          <div className="floating-shapes">
            <div className="shape shape-1"></div>
            <div className="shape shape-2"></div>
            <div className="shape shape-3"></div>
            <div className="shape shape-4"></div>
            <div className="shape shape-5"></div>
            <div className="shape shape-6"></div>
          </div>
        </div>

        {/* Основной контент */}
        <div className="not-found-content">
          {/* Большая цифра 404 */}
          <div className="error-code">
            <span className="error-number">4</span>
            <span className="error-zero">0</span>
            <span className="error-number">4</span>
          </div>

          {/* Иконка ошибки */}
          <div className="error-icon">
            <FaCog className="rotating-gear" />
            <div className="error-symbol">!</div>
          </div>

          {/* Заголовок */}
          <h1 className="error-title">
            Страница не найдена
          </h1>

          {/* Описание */}
          <p className="error-description">
            К сожалению, запрашиваемая страница не существует или была перемещена.
            <br />
            Возможно, вы ввели неправильный адрес или перешли по устаревшей ссылке.
          </p>

          {/* Кнопки действий */}
          <div className="error-actions">
            <Link to="/" className="error-button primary">
              <FaHome />
              На главную
            </Link>
            
            <Link to="/catalog" className="error-button secondary">
              <FaSearch />
              Каталог товаров
            </Link>
            
            <button 
              className="error-button tertiary"
              onClick={() => window.history.back()}
            >
              <FaArrowLeft />
              Назад
            </button>
          </div>

          {/* Дополнительная информация */}
          <div className="error-help">
            <h3>Что можно сделать:</h3>
            <ul>
              <li>Проверьте правильность URL-адреса</li>
              <li>Вернитесь на <Link to="/">главную страницу</Link></li>
              <li>Используйте <Link to="/catalog">каталог товаров</Link> для поиска</li>
              <li>Обратитесь в <Link to="/about">службу поддержки</Link></li>
            </ul>
          </div>
        </div>

        {/* Декоративные элементы */}
        <div className="decorative-elements">
          <div className="glow-effect"></div>
          <div className="particle particle-1"></div>
          <div className="particle particle-2"></div>
          <div className="particle particle-3"></div>
        </div>
      </div>
    </div>
  );
};

export default NotFoundPage;
