import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { FaArrowLeft, FaShoppingCart, FaCheckCircle, FaTimesCircle, FaChevronLeft, FaChevronRight, FaTruck, FaCog, FaSnowflake, FaMountain, FaWater, FaRoad } from 'react-icons/fa';
import { motion } from 'framer-motion';
import Reveal from '../components/Reveal';
import ImageModal from '../components/ImageModal';
import { useCartActions } from '../hooks/useCartActions';
import { useAdminData } from '../context/AdminDataContext';
import { migrateProductImages, getMainImage } from '../utils/imageHelpers';
import BrandMark from '../components/BrandMark';
import './VehicleDetailPage.css';

function VehicleDetailPage() {
  const { id } = useParams();
  const navigate = useNavigate();
  const { vehicles } = useAdminData();
  const { addToCartWithNotification } = useCartActions();
  
  const [selectedImageIndex, setSelectedImageIndex] = useState(0);
  const [quantity, setQuantity] = useState(1);
  
  // Состояние для модального окна изображений
  const [isImageModalOpen, setIsImageModalOpen] = useState(false);
  const [modalImages, setModalImages] = useState([]);
  const [currentImageIndex, setCurrentImageIndex] = useState(0);

  // Находим вездеход по ID
  const vehicle = vehicles.find(v => v.id === parseInt(id));

  useEffect(() => {
    if (!vehicle) {
      navigate('/vehicles');
    }
  }, [vehicle, navigate]);

  if (!vehicle) {
    return null;
  }

  const handleAddToCart = () => {
    // Создаем объект товара для корзины с полной информацией об изображениях
    const cartItem = {
      id: vehicle.id,
      title: vehicle.name,
      price: vehicle.price,
      image: vehicle.image || null, // Основное изображение
      images: vehicle.images || null, // Массив изображений
      type: 'vehicle',
      brand: vehicle.type,
      available: vehicle.available,
      // Добавляем дополнительные поля для корректного отображения
      category: vehicle.category || 'Вездеходы',
      subcategory: vehicle.subcategory,
      description: vehicle.description,
      specifications: vehicle.specs || vehicle.specifications,
      features: vehicle.features
    };
    addToCartWithNotification(cartItem, quantity);
  };

  // Функции для работы с модальным окном изображений
  const handleImageClick = () => {
    // Подготавливаем изображения для модального окна
    const images = [];
    if (vehicle.image && typeof vehicle.image === 'string') {
      images.push({
        data: vehicle.image,
        isMain: true
      });
    }
    
    if (images.length > 0) {
      setModalImages(images);
      setCurrentImageIndex(0);
      setIsImageModalOpen(true);
    }
  };

  const closeImageModal = () => {
    setIsImageModalOpen(false);
    setModalImages([]);
    setCurrentImageIndex(0);
  };

  const goToPreviousImage = () => {
    setCurrentImageIndex((prevIndex) => 
      prevIndex === 0 ? modalImages.length - 1 : prevIndex - 1
    );
  };

  const goToNextImage = () => {
    setCurrentImageIndex((prevIndex) => 
      prevIndex === modalImages.length - 1 ? 0 : prevIndex + 1
    );
  };

  const handleBuyNow = () => {
    try {
      const migratedVehicle = migrateProductImages(vehicle);
      const mainImage = getMainImage(migratedVehicle);
      const cartItem = {
        id: vehicle.id,
        title: vehicle.name,
        price: vehicle.price,
        image: mainImage?.data || vehicle.image || null,
        images: migratedVehicle.images || vehicle.images || null,
        type: 'vehicle',
        brand: vehicle.type,
        available: vehicle.available,
        category: vehicle.category || 'Вездеходы',
        subcategory: vehicle.subcategory,
        description: vehicle.description,
        specifications: vehicle.specs || vehicle.specifications,
        features: vehicle.features
      };
      addToCartWithNotification(cartItem, quantity);
      setTimeout(() => {
        navigate('/cart');
      }, 100);
    } catch (error) {
      console.error('Error in handleBuyNow:', error);
      alert('Ошибка при покупке вездехода');
    }
  };

  const getTerrainIcon = (terrain) => {
    switch (terrain) {
      case 'Снег':
        return <FaSnowflake />;
      case 'Болото':
      case 'Вода':
        return <FaWater />;
      case 'Горы':
      case 'Лес':
        return <FaMountain />;
      case 'Пустыня':
        return <FaRoad />;
      default:
        return <FaTruck />;
    }
  };

  const formatPrice = (price) => {
    return new Intl.NumberFormat('ru-RU').format(price);
  };

  // Проверка наличия валидного изображения
  const hasValidImage = (() => {
    if (!vehicle.image || typeof vehicle.image !== 'string' || vehicle.image.trim() === '') {
      console.log('🚫 Нет изображения для вездехода:', vehicle.name);
      return false;
    }
    
    // Проверяем, что это не строка-заглушка
    const imageData = vehicle.image.toLowerCase();
    if (imageData.includes('фотография отсутствует') || 
        imageData.includes('фото отсутствует') || 
        imageData.includes('нет фото') ||
        imageData.includes('no-image') ||
        imageData.includes('placeholder') ||
        imageData.includes('отсутствует')) {
      console.log('🚫 Изображение-заглушка для вездехода:', vehicle.name);
      return false;
    }
    
    // Проверяем валидные форматы
    const isValid = vehicle.image.startsWith('data:image') || 
                    vehicle.image.startsWith('http') || 
                    vehicle.image.startsWith('/img/vehicles/') ||
                    vehicle.image.startsWith('/uploads/');
    
    if (!isValid) {
      console.log('🚫 Невалидный формат изображения для вездехода:', vehicle.name, vehicle.image);
    }
    
    return isValid;
  })();

  return (
    <motion.div 
      className="vehicle-detail-page"
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      transition={{ duration: 0.5 }}
    >
      <div className="container">
        <button 
          onClick={() => navigate(-1)} 
          className="back-button"
        >
          <FaArrowLeft /> Назад
        </button>

        <div className="vehicle-content">
          <div className="vehicle-images">
            <div className="main-image">
              <motion.div 
                className={`image-container ${!hasValidImage ? 'has-placeholder' : ''}`}
                whileHover={{ scale: 1.05 }}
                transition={{ duration: 0.3 }}
              >
                {hasValidImage ? (
                  <img 
                    src={vehicle.image} 
                    alt={vehicle.name} 
                    className="vehicle-detail-image"
                    onClick={handleImageClick}
                    style={{
                      maxWidth: '100%',
                      width: 'auto',
                      height: 'auto',
                      objectFit: 'contain',
                      borderRadius: '14px',
                      cursor: 'pointer'
                    }}
                  />
                ) : (
                  <div className="vehicle-placeholder-large">
                    <BrandMark alt={vehicle.name} style={{ height: 200, width: 'auto', maxWidth: '70%', display: 'block', margin: '0 auto' }} />
                  </div>
                )}
              </motion.div>
            </div>
          </div>

          <div className="vehicle-info">
            <div className="vehicle-header">
              <h1>{vehicle.name}</h1>
            </div>

            <div className="vehicle-meta">
              <span className="type">{vehicle.type}</span>
              {(() => {
                // Получаем массив типов местности
                const terrains = Array.isArray(vehicle.terrains) && vehicle.terrains.length > 0
                  ? vehicle.terrains
                  : (vehicle.terrain ? [vehicle.terrain] : []);
                
                if (terrains.length === 0) return null;
                
                return terrains.map((terrain, index) => (
                  <span key={index} className="terrain">
                    {getTerrainIcon(terrain)}
                    {terrain}
                  </span>
                ));
              })()}
              <span className={`availability ${vehicle.available ? 'in-stock' : 'out-of-stock'}`}>
                {vehicle.available ? <FaCheckCircle /> : <FaTimesCircle />}
                {vehicle.available ? `В наличии: ${vehicle.quantity || 0} шт` : 'Нет в наличии'}
              </span>
            </div>

            <Reveal type="up">
              <div className="vehicle-price">
                <span className="current-price">{formatPrice(vehicle.price)} ₽</span>
              </div>
            </Reveal>

            <Reveal type="up" delay={0.05}>
              <div className="vehicle-description" style={{ whiteSpace: 'pre-line' }}>
                <h4>{vehicle.description || ''}</h4>
              </div>
            </Reveal>

            <Reveal type="up" delay={0.1}>
              <div className="vehicle-actions">
                <div className="quantity-selector">
                  <label>Количество:</label>
                  <div className="quantity-controls">
                    <button 
                      onClick={() => setQuantity(Math.max(1, quantity - 1))}
                      disabled={quantity <= 1}
                    >
                      -
                    </button>
                    <input 
                      type="text" 
                      value={quantity} 
                      onChange={(e) => {
                        const inputValue = e.target.value.replace(/[^0-9]/g, '');
                        if (inputValue === '') {
                          return;
                        }
                        const value = parseInt(inputValue);
                        if (!isNaN(value) && value >= 1) {
                          setQuantity(Math.min(value, vehicle.quantity || 999));
                        }
                      }}
                      onBlur={(e) => {
                        const cleanValue = e.target.value.replace(/[^0-9]/g, '');
                        if (cleanValue === '' || parseInt(cleanValue) < 1) {
                          setQuantity(1);
                        }
                      }}
                      onFocus={(e) => e.target.select()}
                      placeholder="1"
                      className="quantity-input"
                    />
                    <button 
                      onClick={() => setQuantity(Math.min(quantity + 1, vehicle.quantity || 999))}
                      disabled={quantity >= (vehicle.quantity || 999)}
                    >
                      +
                    </button>
                  </div>
                </div>

                <div className="action-buttons">
                  <motion.button 
                    className="add-to-cart-btn"
                    onClick={handleAddToCart}
                    disabled={!vehicle.available}
                    whileHover={{ scale: 1.02 }}
                    whileTap={{ scale: 0.98 }}
                  >
                    <FaShoppingCart /> В корзину
                  </motion.button>

                  <motion.button 
                    className="buy-now-btn"
                    onClick={handleBuyNow}
                    disabled={!vehicle.available}
                    whileHover={{ scale: 1.02 }}
                    whileTap={{ scale: 0.98 }}
                  >
                    Купить сейчас
                  </motion.button>
                </div>
              </div>
            </Reveal>
          </div>
        </div>

        <Reveal type="up">
          <div className="vehicle-specifications">
            <h3>Технические характеристики</h3>
            <div className="specs-grid">
              <div className="spec-item">
                <span className="spec-label">Двигатель:</span>
                <span className="spec-value">{vehicle.specs.engine}</span>
              </div>
              <div className="spec-item">
                <span className="spec-label">Вес:</span>
                <span className="spec-value">{vehicle.specs.weight}</span>
              </div>
              <div className="spec-item">
                <span className="spec-label">Вместимость:</span>
                <span className="spec-value">{vehicle.specs.capacity}</span>
              </div>
              <div className="spec-item">
                <span className="spec-label">Максимальная скорость:</span>
                <span className="spec-value">{vehicle.specs.maxSpeed}</span>
              </div>
            </div>
          </div>
        </Reveal>
      </div>

      {/* Модальное окно для просмотра изображений */}
      <ImageModal
        isOpen={isImageModalOpen}
        onClose={closeImageModal}
        images={modalImages}
        currentIndex={currentImageIndex}
        onPrevious={goToPreviousImage}
        onNext={goToNextImage}
        productTitle={vehicle.name}
      />
    </motion.div>
  );
}

export default VehicleDetailPage;
