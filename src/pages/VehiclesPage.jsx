import React, { useState, useEffect } from 'react';
import { motion } from 'framer-motion';
import { useNavigate } from 'react-router-dom';
import { FaTruck, FaCog, FaSnowflake, FaMountain, FaWater, FaRoad, FaFilter, FaTimes, FaCheckCircle, FaTimesCircle, FaShoppingBasket } from 'react-icons/fa';
import Reveal from '../components/Reveal';
import ImageModal from '../components/ImageModal';
import { useAdminData } from '../context/AdminDataContext';
import { useCartActions } from '../hooks/useCartActions';
import { migrateProductImages, getMainImage, isImageUrl } from '../utils/imageHelpers';
import BrandMark from '../components/BrandMark';
import './VehiclesPage.css';
import '../Catalog.css';

function VehiclesPage() {
  const { vehicles } = useAdminData();
  const navigate = useNavigate();
  const { addToCartWithNotification } = useCartActions();
  const [selectedType, setSelectedType] = useState('Все');
  const [selectedTerrain, setSelectedTerrain] = useState('Все');
  const [priceRange, setPriceRange] = useState([0, 0]);

  const [currentPage, setCurrentPage] = useState(1);
  const [showFilters, setShowFilters] = useState(false);
  const [viewMode, setViewMode] = useState('grid'); // 'grid' или 'list'
  
  // Состояние для модального окна изображений
  const [isImageModalOpen, setIsImageModalOpen] = useState(false);
  const [modalImages, setModalImages] = useState([]);
  const [currentImageIndex, setCurrentImageIndex] = useState(0);

  // Автоматическое переключение режимов просмотра
  useEffect(() => {
    const updateViewMode = () => {
      if (window.innerWidth <= 768) {
        setViewMode('list');
      } else {
        setViewMode('grid');
      }
    };
    
    updateViewMode();
    window.addEventListener('resize', updateViewMode);
    
    return () => window.removeEventListener('resize', updateViewMode);
  }, []);

  const handleVehicleClick = (vehicle) => {
    navigate(`/vehicle/${vehicle.id}`);
  };

  // Функции для работы с модальным окном изображений
  const handleImageClick = (vehicle, e) => {
    e.stopPropagation(); // Предотвращаем переход на страницу вездехода
    
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

  const handleAddToCart = (vehicle, e) => {
    e.stopPropagation(); // Предотвращаем всплытие события клика по карточке
    
    // Мигрируем изображения вездехода
    const migratedVehicle = migrateProductImages(vehicle);
    const mainImage = getMainImage(migratedVehicle);
    
    const cartItem = {
      id: vehicle.id,
      title: vehicle.name,
      price: vehicle.price,
      image: mainImage?.data || vehicle.image || null, // Основное изображение
      images: migratedVehicle.images || vehicle.images || null, // Массив изображений
      type: 'vehicle',
      brand: vehicle.type,
      available: vehicle.available,
      category: vehicle.category || 'Вездеходы',
      subcategory: vehicle.subcategory,
      description: vehicle.description,
      specifications: vehicle.specs || vehicle.specifications,
      features: vehicle.features
    };
    addToCartWithNotification(cartItem, 1);
  };

  const { vehicleTypes: adminVehicleTypes, terrainTypes: adminTerrainTypes } = useAdminData();
  const vehicleTypes = ['Все', ...adminVehicleTypes];
  const terrainTypes = ['Все', ...adminTerrainTypes];

  // Фильтрация вездеходов
  const filteredVehicles = vehicles.filter(vehicle => {
    const matchesType = selectedType === 'Все' || vehicle.type === selectedType;
    const matchesTerrain = selectedTerrain === 'Все' || vehicle.terrain === selectedTerrain;
    const matchesPrice = vehicle.price >= priceRange[0] && (priceRange[1] === 0 || vehicle.price <= priceRange[1]);
    return matchesType && matchesTerrain && matchesPrice;
  });

  const ITEMS_PER_PAGE = 6;
  const totalPages = Math.ceil(filteredVehicles.length / ITEMS_PER_PAGE);
  const startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
  const paginatedVehicles = filteredVehicles.slice(startIndex, startIndex + ITEMS_PER_PAGE);

  const resetFilters = () => {
    setSelectedType('Все');
    setSelectedTerrain('Все');
    setPriceRange([0, 0]);
    setCurrentPage(1);
  };

  const formatPrice = (price) => {
    return new Intl.NumberFormat('ru-RU').format(price);
  };

  return (
    <div className="vehicles-page">
      <div className="container">
        <Reveal type="up">
          <div className="vehicles-header">
            <h1>Готовые вездеходы</h1>
            <p>Профессиональные вездеходы для любых условий эксплуатации</p>
          </div>
        </Reveal>

        <div className="catalog-wrapper">
          <aside className="catalog-filters">
            <h3>Фильтры</h3>
            


            <div className="filter-group">
              <label>Тип вездехода</label>
              <select 
                value={selectedType} 
                onChange={(e) => {
                  setSelectedType(e.target.value);
                  setCurrentPage(1);
                }}
              >
                {vehicleTypes.map(type => (
                  <option key={type} value={type}>{type}</option>
                ))}
              </select>
            </div>

            <div className="filter-group">
              <label>Тип местности</label>
              <select 
                value={selectedTerrain} 
                onChange={(e) => {
                  setSelectedTerrain(e.target.value);
                  setCurrentPage(1);
                }}
              >
                {terrainTypes.map(terrain => (
                  <option key={terrain} value={terrain}>{terrain}</option>
                ))}
              </select>
            </div>

            <div className="filter-group">
              <label>Цена, ₽</label>
              <div className="price-range">
                <input
                  type="text"
                  inputMode="numeric"
                  pattern="[0-9]*"
                  placeholder="От"
                  value={priceRange[0] || ''}
                  onChange={(e) => {
                    const value = e.target.value.replace(/\D/g, '');
                    setPriceRange([parseInt(value) || 0, priceRange[1]]);
                    setCurrentPage(1);
                  }}
                />
                <span>-</span>
                                 <input
                   type="text"
                   inputMode="numeric"
                   pattern="[0-9]*"
                   placeholder="До"
                   value={priceRange[1] || ''}
                   onChange={(e) => {
                     const value = e.target.value.replace(/\D/g, '');
                     setPriceRange([priceRange[0], parseInt(value) || 0]);
                     setCurrentPage(1);
                   }}
                 />
              </div>
            </div>

            <div className="filter-actions">
              <button onClick={resetFilters} className="catalog-reset-btn">
                Сбросить фильтры
              </button>
            </div>
          </aside>

          <main className="catalog-main">
            <div className={`catalog-container ${viewMode === 'list' ? 'catalog-list' : 'catalog-grid'}`}>
            {paginatedVehicles.length > 0 ? (
              paginatedVehicles.map((vehicle, index) => (
                <div
                  key={vehicle.id}
                  className={`catalog-card ${viewMode === 'list' ? 'catalog-card-list' : 'catalog-card-grid'}`}
                  onClick={() => handleVehicleClick(vehicle)}
                  style={{ cursor: 'pointer' }}
                >
                  <div className="catalog-card-image">
                    {(() => {
                      // Для вездеходов используем поле image напрямую
                      if (vehicle.image && 
                          typeof vehicle.image === 'string' && 
                          (vehicle.image.startsWith('data:image') || 
                           vehicle.image.startsWith('http') || 
                           vehicle.image.startsWith('/img/vehicles/') ||
                           vehicle.image.startsWith('/uploads/')) &&
                           isImageUrl(vehicle.image)) {
                        
                        // Проверяем, что это НЕ изображение "фотография отсутствует"
                        const imageData = vehicle.image.toLowerCase();
                        if (imageData.includes('фотография отсутствует') || 
                            imageData.includes('фото отсутствует') || 
                            imageData.includes('нет фото') ||
                            imageData.includes('no-image') ||
                            imageData.includes('placeholder') ||
                            imageData.includes('отсутствует')) {
                          console.log('🚫 Пропускаем изображение "фотография отсутствует" для вездехода:', vehicle.name);
                          return (
                            <span className="catalog-card-icon" style={{ display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                              <BrandMark alt={vehicle.name} style={{ height: viewMode === 'list' ? 48 : 64 }} />
                            </span>
                          );
                        }
                        
                        return (
                          <img 
                            src={vehicle.image} 
                            alt={vehicle.name} 
                            className="catalog-product-image" 
                            onClick={(e) => handleImageClick(vehicle, e)}
                            style={{ cursor: 'pointer' }}
                          />
                        );
                      }
                      
                      // Если нет изображения или оно невалидное, показываем логотип компании
                      return (
                        <span className="catalog-card-icon" style={{ display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                          <BrandMark alt={vehicle.name} style={{ height: viewMode === 'list' ? 48 : 64 }} />
                        </span>
                      );
                    })()}

                  </div>
                  
                  <div className="catalog-card-info">
                    {viewMode === 'grid' ? (
                      <>
                        <div className="catalog-card-header">
                          <h3>{vehicle.name}</h3>
                        </div>
                        
                        <div className="catalog-card-price-section">
                          <div className="catalog-card-price">{formatPrice(vehicle.price)} ₽</div>
                        </div>
                      </>
                    ) : (
                      <div className="catalog-card-header">
                        <h3>{vehicle.name}</h3>
                        <div className="catalog-card-price">{formatPrice(vehicle.price)} ₽</div>
                      </div>
                    )}
                    
                    <div className="catalog-card-actions">
                      <div className="catalog-card-meta">
                        <span className={vehicle.available ? 'in-stock' : 'out-of-stock'}>
                          {vehicle.available ? <FaCheckCircle /> : <FaTimesCircle />} {vehicle.available ? 'В наличии' : 'Нет в наличии'}
                        </span>
                      </div>
                      
                      <button 
                        className="catalog-card-btn"
                        onClick={(e) => handleAddToCart(vehicle, e)}
                        disabled={!vehicle.available}
                      >
                        <FaShoppingBasket /> В корзину
                      </button>
                    </div>
                  </div>
                </div>
              ))
            ) : (
              <div className="no-vehicles">
                <FaTruck />
                <h3>Вездеходы не найдены</h3>
                <p>Попробуйте изменить параметры фильтрации</p>
                <button onClick={resetFilters} className="catalog-reset-btn">
                  Сбросить фильтры
                </button>
              </div>
            )}
            </div>

            {filteredVehicles.length > 0 && (
            <div className="catalog-pagination">
              <div className="pagination-info">
                Показано {startIndex + 1}-{Math.min(startIndex + ITEMS_PER_PAGE, filteredVehicles.length)} из {filteredVehicles.length} вездеходов
              </div>
              
              {totalPages > 1 && (
                <div className="pagination-controls">
                  <button 
                    className="pagination-btn prev-btn"
                    onClick={() => setCurrentPage(currentPage - 1)}
                    disabled={currentPage === 1}
                    aria-label="Предыдущая страница"
                  >
                    ←
                  </button>
                  
                  <div className="pagination-pages">
                    {Array.from({ length: totalPages }, (_, index) => {
                      const pageNumber = index + 1;
                      // Показываем первые 3 страницы, последние 3 страницы и текущую страницу с соседними
                      if (
                        pageNumber === 1 ||
                        pageNumber === totalPages ||
                        (pageNumber >= currentPage - 1 && pageNumber <= currentPage + 1)
                      ) {
                        return (
                          <button
                            key={pageNumber}
                            className={`pagination-page ${pageNumber === currentPage ? 'active' : ''}`}
                            onClick={() => setCurrentPage(pageNumber)}
                          >
                            {pageNumber}
                          </button>
                        );
                      } else if (
                        pageNumber === currentPage - 2 ||
                        pageNumber === currentPage + 2
                      ) {
                        return <span key={pageNumber} className="pagination-ellipsis">...</span>;
                      }
                      return null;
                    })}
                  </div>
                  
                  <button 
                    className="pagination-btn next-btn"
                    onClick={() => setCurrentPage(currentPage + 1)}
                    disabled={currentPage === totalPages}
                  >
                    →
                  </button>
                </div>
              )}
            </div>
          )}
          </main>
        </div>
      </div>

      {/* Модальное окно для просмотра изображений */}
      <ImageModal
        isOpen={isImageModalOpen}
        onClose={closeImageModal}
        images={modalImages}
        currentIndex={currentImageIndex}
        onPrevious={goToPreviousImage}
        onNext={goToNextImage}
        productTitle="Вездеход"
      />
      
    </div>
  );
}

export default VehiclesPage;
