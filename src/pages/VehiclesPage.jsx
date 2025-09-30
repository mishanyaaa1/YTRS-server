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
  const { vehicles, filterSettings } = useAdminData();
  const navigate = useNavigate();
  const { addToCartWithNotification } = useCartActions();
  const [selectedType, setSelectedType] = useState('Все');
  const [selectedTerrain, setSelectedTerrain] = useState('Все');
  const [priceRange, setPriceRange] = useState([0, 0]);
  const [minPriceInput, setMinPriceInput] = useState('');
  const [maxPriceInput, setMaxPriceInput] = useState('');
  const [inStock, setInStock] = useState(false);


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

  const minPrice = 0;
  const maxPrice = 1000000000; // верхняя граница по умолчанию (1 млрд)

  const clamp = (value, min, max) => Math.max(min, Math.min(max, value));

  const handleMinPriceChange = (e) => {
    const raw = e.target.value.replace(/\D/g, '');
    setMinPriceInput(raw);
    const num = raw === '' ? 0 : parseInt(raw, 10);
    setPriceRange(([_, r]) => [clamp(num, 0, r || maxPrice), r]);
  };

  const handleMaxPriceChange = (e) => {
    const raw = e.target.value.replace(/\D/g, '');
    setMaxPriceInput(raw);
    const num = raw === '' ? 0 : parseInt(raw, 10);
    setPriceRange(([l, _]) => [l, clamp(num, l || 0, maxPrice)]);
  };

  const normalizeMinOnBlur = () => {
    if (minPriceInput === '') {
      // Если поле пустое, устанавливаем 0 для отключения нижней границы
      setPriceRange(([_, r]) => [0, r]);
      return;
    }
    const num = parseInt(minPriceInput, 10);
    const clamped = clamp(isNaN(num) ? 0 : num, 0, priceRange[1] || maxPrice);
    setMinPriceInput(String(clamped));
    setPriceRange(([_, r]) => [clamped, r]);
  };

  const normalizeMaxOnBlur = () => {
    if (maxPriceInput === '') {
      // Если поле пустое, устанавливаем 0 для отключения верхней границы
      setPriceRange(([l, _]) => [l, 0]);
      return;
    }
    const num = parseInt(maxPriceInput, 10);
    const clamped = clamp(isNaN(num) ? 0 : num, priceRange[0], maxPrice);
    setMaxPriceInput(String(clamped));
    setPriceRange(([l, _]) => [l, clamped]);
  };

  // Фильтрация вездеходов
  const filteredVehicles = vehicles.filter(vehicle => {
    const matchesType = !filterSettings.showCategoryFilter || selectedType === 'Все' || vehicle.type === selectedType;
    const matchesTerrain = !filterSettings.showSubcategoryFilter || selectedTerrain === 'Все' || vehicle.terrain === selectedTerrain;
    const matchesPrice = !filterSettings.showPriceFilter || (vehicle.price >= priceRange[0] && (priceRange[1] === 0 || vehicle.price <= priceRange[1]));
    const matchesStock = !filterSettings.showStockFilter || !inStock || vehicle.available;
    
    // Скрываем вездеходы без остатков на складе
    const hasStock = vehicle.quantity === undefined || vehicle.quantity === null || vehicle.quantity > 0;
    
    return matchesType && matchesTerrain && matchesPrice && matchesStock && hasStock;
  });

  const ITEMS_PER_PAGE = 6;
  const totalPages = Math.ceil(filteredVehicles.length / ITEMS_PER_PAGE);
  const startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
  const paginatedVehicles = filteredVehicles.slice(startIndex, startIndex + ITEMS_PER_PAGE);

  const resetFilters = () => {
    if (filterSettings.showCategoryFilter) {
      setSelectedType('Все');
    }
    if (filterSettings.showSubcategoryFilter) {
      setSelectedTerrain('Все');
    }
    if (filterSettings.showPriceFilter) {
      setPriceRange([0, 0]);
      setMinPriceInput('');
      setMaxPriceInput('');
    }
    if (filterSettings.showStockFilter) {
      setInStock(false);
    }
    setCurrentPage(1);
  };

  const formatPrice = (price) => {
    return new Intl.NumberFormat('ru-RU').format(price);
  };

  // Сброс на первую страницу при изменении фильтров
  useEffect(() => {
    setCurrentPage(1);
  }, [selectedType, selectedTerrain, priceRange, inStock]);

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
            


            {filterSettings.showCategoryFilter && (
              <div className="filter-group">
                <label>Тип вездехода</label>
                <select 
                  value={selectedType} 
                  onChange={(e) => setSelectedType(e.target.value)}
                >
                  {vehicleTypes.map(type => (
                    <option key={type} value={type}>{type}</option>
                  ))}
                </select>
              </div>
            )}

            {filterSettings.showSubcategoryFilter && (
              <div className="filter-group">
                <label>Тип местности</label>
                <select 
                  value={selectedTerrain} 
                  onChange={(e) => setSelectedTerrain(e.target.value)}
                >
                  {terrainTypes.map(terrain => (
                    <option key={terrain} value={terrain}>{terrain}</option>
                  ))}
                </select>
              </div>
            )}

            {filterSettings.showPriceFilter && (
              <div className="filter-group">
                <label>Цена, ₽</label>
                <div className="price-range" role="group" aria-label="Диапазон цены">
                  <input
                    type="text"
                    inputMode="numeric"
                    pattern="[0-9]*"
                    value={minPriceInput}
                    placeholder="От"
                    onChange={handleMinPriceChange}
                    onBlur={normalizeMinOnBlur}
                  />
                  <span>-</span>
                  <input
                    type="text"
                    inputMode="numeric"
                    pattern="[0-9]*"
                    value={maxPriceInput}
                    placeholder="До"
                    onChange={handleMaxPriceChange}
                    onBlur={normalizeMaxOnBlur}
                  />
                </div>
              </div>
            )}

            {filterSettings.showStockFilter && (
              <div className="filter-group">
                <label>
                  <input
                    type="checkbox"
                    checked={inStock}
                    onChange={e => setInStock(e.target.checked)}
                  />
                  Только в наличии
                </label>
              </div>
            )}

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
                           vehicle.image.startsWith('/uploads/'))) {
                        
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
                        
                        // Показываем реальное изображение вездехода с fallback
                        return (
                          <>
                            <img 
                              src={vehicle.image} 
                              alt={vehicle.name} 
                              className="catalog-product-image" 
                              onClick={(e) => handleImageClick(vehicle, e)}
                              style={{ cursor: 'pointer' }}
                              onError={(e) => {
                                console.log('🚫 Ошибка загрузки изображения для вездехода:', vehicle.name, vehicle.image);
                                e.target.style.display = 'none';
                                e.target.nextElementSibling.style.display = 'flex';
                              }}
                            />
                            <span 
                              className="catalog-card-icon brand-mark-fallback" 
                              style={{ display: 'none', alignItems: 'center', justifyContent: 'center' }}
                            >
                              <BrandMark alt={vehicle.name} style={{ height: viewMode === 'list' ? 48 : 64 }} />
                            </span>
                          </>
                        );
                      }
                      
                      // Если нет изображения, показываем логотип компании
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
                          {vehicle.description && (
                            <h4 className="catalog-card-description">{vehicle.description}</h4>
                          )}
                        </div>
                        
                        <div className="catalog-card-price-section">
                          <div className="catalog-card-price">{formatPrice(vehicle.price)} ₽</div>
                        </div>
                      </>
                    ) : (
                      <div className="catalog-card-header">
                        <h3>{vehicle.name}</h3>
                        {vehicle.description && (
                          <h4 className="catalog-card-description">{vehicle.description}</h4>
                        )}
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
