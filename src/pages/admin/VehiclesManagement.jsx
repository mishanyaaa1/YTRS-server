import React, { useState } from 'react';
import { useAdminData } from '../../context/AdminDataContext';
import { FaPlus, FaEdit, FaTrash, FaEye } from 'react-icons/fa';
import MultiImageUpload from '../../components/MultiImageUpload';
import { migrateProductImages, getMainImage } from '../../utils/imageHelpers';
import './VehiclesManagement.css';

function VehiclesManagement() {
  const { vehicles, addVehicle, updateVehicle, deleteVehicle } = useAdminData();
  const [isAddingVehicle, setIsAddingVehicle] = useState(false);
  const [editingVehicle, setEditingVehicle] = useState(null);
  const [formData, setFormData] = useState({
    name: '',
    type: 'Гусеничный',
    terrain: [], // Изменено на массив для множественного выбора
    price: '',
    description: '',
    engine: '',
    weight: '',
    capacity: '',
    maxSpeed: '',
    available: true,
    quantity: 1,
    images: []
  });

  const { vehicleTypes, terrainTypes } = useAdminData();

  const handleInputChange = (e) => {
    const { name, value, type, checked } = e.target;
    
    // Обработка множественного выбора типов местности
    if (name === 'terrain') {
      setFormData(prev => {
        const currentTerrain = Array.isArray(prev.terrain) ? prev.terrain : [];
        let newTerrain;
        
        if (checked) {
          // Добавляем выбранный тип местности (если еще нет)
          if (!currentTerrain.includes(value)) {
            newTerrain = [...currentTerrain, value];
          } else {
            newTerrain = currentTerrain;
          }
        } else {
          // Удаляем тип местности из массива
          newTerrain = currentTerrain.filter(t => t !== value);
        }
        
        console.log('Terrain changed:', { value, checked, currentTerrain, newTerrain });
        
        return {
          ...prev,
          terrain: newTerrain
        };
      });
      return;
    }
    
    setFormData(prev => ({
      ...prev,
      [name]: type === 'checkbox' ? checked : value
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    
    console.log('Saving vehicle:', { formData, editingVehicle });
    
    // Валидация обязательных полей
    if (!formData.name) {
      alert('Заполните обязательное поле: название вездехода!');
      return;
    }

    if (!Array.isArray(formData.terrain) || formData.terrain.length === 0) {
      alert('Выберите хотя бы один тип местности!');
      return;
    }

    const price = parseInt(formData.price);
    if (isNaN(price) || price < 0) {
      alert('Укажите корректную цену вездехода!');
      return;
    }

    if (!formData.engine) {
      alert('Заполните обязательное поле: двигатель!');
      return;
    }

    if (!formData.weight) {
      alert('Заполните обязательное поле: вес!');
      return;
    }

    if (!formData.capacity) {
      alert('Заполните обязательное поле: вместимость!');
      return;
    }

    if (!formData.maxSpeed) {
      alert('Заполните обязательное поле: максимальная скорость!');
      return;
    }

    try {
      // Берем первое изображение из массива images
      const mainImage = formData.images && formData.images.length > 0 ? formData.images[0].data : null;
      
      // Формируем vehicleData, убирая лишние поля и сохраняя terrain как массив
      const vehicleData = {
        name: formData.name,
        type: formData.type,
        terrain: Array.isArray(formData.terrain) ? formData.terrain : [], // Явно сохраняем массив
        price: price,
        quantity: parseInt(formData.quantity) || 1,
        image: mainImage,
        description: formData.description || '',
        available: formData.available !== undefined ? formData.available : true,
        specs: {
          engine: formData.engine,
          weight: formData.weight,
          capacity: formData.capacity,
          maxSpeed: formData.maxSpeed
        }
      };

      console.log('Saving vehicle data:', JSON.stringify(vehicleData, null, 2));
      console.log('Terrain array:', vehicleData.terrain);

      if (editingVehicle) {
        console.log('Updating existing vehicle:', editingVehicle.id, vehicleData);
        updateVehicle(editingVehicle.id, vehicleData);
        alert('Вездеход обновлен!');
        setEditingVehicle(null);
      } else {
        console.log('Creating new vehicle:', vehicleData);
        addVehicle(vehicleData);
        alert('Вездеход создан!');
      }

      resetForm();
      setIsAddingVehicle(false);
    } catch (error) {
      console.error('Error saving vehicle:', error);
      alert('Ошибка при сохранении вездехода!');
    }
  };

  const handleEdit = (vehicle) => {
    setEditingVehicle(vehicle);
    
    // Для вездеходов создаем массив images из поля image
    const images = vehicle.image ? [{ data: vehicle.image, isMain: true }] : [];
    
    // Нормализуем terrain: если это массив - используем его, если строка - конвертируем в массив
    const terrainArray = Array.isArray(vehicle.terrain) 
      ? vehicle.terrain 
      : (vehicle.terrain ? [vehicle.terrain] : []);
    
    setFormData({
      name: vehicle.name,
      type: vehicle.type,
      terrain: terrainArray,
      price: vehicle.price.toString(),
      description: vehicle.description,
      engine: vehicle.specs?.engine || '',
      weight: vehicle.specs?.weight || '',
      capacity: vehicle.specs?.capacity || '',
      maxSpeed: vehicle.specs?.maxSpeed || '',
      available: vehicle.available,
      quantity: vehicle.quantity,
      images: images
    });
    setIsAddingVehicle(true);
  };

  const handleDelete = (id) => {
    if (window.confirm('Вы уверены, что хотите удалить этот вездеход?')) {
      deleteVehicle(id);
    }
  };

  const resetForm = () => {
    setFormData({
      name: '',
      type: 'Гусеничный',
      terrain: [], // Изменено на пустой массив
      price: '',
      description: '',
      engine: '',
      weight: '',
      capacity: '',
      maxSpeed: '',
      available: true,
      quantity: 1,
      images: []
    });
  };

  const formatPrice = (price) => {
    return new Intl.NumberFormat('ru-RU').format(price);
  };

  return (
    <div className="vehicles-management">
      <div className="vehicles-header">
        <h1>🚗 Управление вездеходами</h1>
        <button 
          className="add-vehicle-btn"
          onClick={() => setIsAddingVehicle(true)}
        >
          <FaPlus /> Добавить вездеход
        </button>
      </div>

      {/* Форма добавления/редактирования */}
      {isAddingVehicle && (
        <div className="vehicle-form-container">
          <div className="vehicle-form">
            <div className="form-header">
              <h3>{editingVehicle ? 'Редактировать вездеход' : 'Добавить вездеход'}</h3>
              <button 
                className="close-btn"
                onClick={() => {
                  setIsAddingVehicle(false);
                  setEditingVehicle(null);
                  resetForm();
                }}
              >
                ✕
              </button>
            </div>
            
            <form onSubmit={handleSubmit}>
              <div className="form-row">
                <div className="form-group">
                  <label>Название</label>
                  <input
                    type="text"
                    name="name"
                    value={formData.name}
                    onChange={handleInputChange}
                    placeholder="Вездеход 'Буран'"
                  />
                </div>
                <div className="form-group">
                  <label>Тип</label>
                  <select name="type" value={formData.type} onChange={handleInputChange}>
                    {vehicleTypes.map(type => (
                      <option key={type} value={type}>{type}</option>
                    ))}
                  </select>
                </div>
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label>Типы местности (можно выбрать несколько)</label>
                  <div className="terrain-checkboxes" style={{ 
                    display: 'grid', 
                    gridTemplateColumns: 'repeat(auto-fill, minmax(150px, 1fr))', 
                    gap: '10px',
                    padding: '10px',
                    border: '1px solid #ddd',
                    borderRadius: '4px',
                    maxHeight: '200px',
                    overflowY: 'auto'
                  }}>
                    {terrainTypes.map(terrain => (
                      <label key={terrain} style={{ display: 'flex', alignItems: 'center', cursor: 'pointer' }}>
                        <input
                          type="checkbox"
                          name="terrain"
                          value={terrain}
                          checked={Array.isArray(formData.terrain) && formData.terrain.includes(terrain)}
                          onChange={handleInputChange}
                          style={{ marginRight: '8px', cursor: 'pointer' }}
                        />
                        <span>{terrain}</span>
                      </label>
                    ))}
                  </div>
                  {formData.terrain.length === 0 && (
                    <small style={{ color: '#ff6b6b', marginTop: '5px', display: 'block' }}>
                      Выберите хотя бы один тип местности
                    </small>
                  )}
                </div>
                <div className="form-group">
                  <label>Цена (₽)</label>
                  <input
                    type="number"
                    name="price"
                    value={formData.price}
                    onChange={handleInputChange}
                    placeholder="2500000"
                  />
                </div>
              </div>

              <div className="form-group">
                <label>Описание</label>
                <textarea
                  name="description"
                  value={formData.description}
                  onChange={handleInputChange}
                  placeholder="Описание вездехода. Для переноса строк и создания отступов используйте Enter."
                  rows="3"
                  style={{ whiteSpace: 'pre-wrap' }}
                />
              </div>

              <div className="form-group form-group-full">
                <label>Изображения вездехода</label>
                <MultiImageUpload
                  value={formData.images}
                  onChange={(images) => setFormData(prev => ({ ...prev, images }))}
                  maxImages={5}
                  placeholder="Добавить изображения вездехода"
                />
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label>Двигатель</label>
                  <input
                    type="text"
                    name="engine"
                    value={formData.engine}
                    onChange={handleInputChange}
                    placeholder="Дизель 150 л.с."
                  />
                </div>
                <div className="form-group">
                  <label>Вес</label>
                  <input
                    type="text"
                    name="weight"
                    value={formData.weight}
                    onChange={handleInputChange}
                    placeholder="2.5 тонны"
                  />
                </div>
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label>Вместимость</label>
                  <input
                    type="text"
                    name="capacity"
                    value={formData.capacity}
                    onChange={handleInputChange}
                    placeholder="6 человек"
                  />
                </div>
                <div className="form-group">
                  <label>Максимальная скорость</label>
                  <input
                    type="text"
                    name="maxSpeed"
                    value={formData.maxSpeed}
                    onChange={handleInputChange}
                    placeholder="45 км/ч"
                  />
                </div>
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label>Количество в наличии</label>
                  <input
                    type="number"
                    name="quantity"
                    value={formData.quantity}
                    onChange={handleInputChange}
                    min="0"
                  />
                </div>
                <div className="form-group checkbox-group">
                  <label>
                    <input
                      type="checkbox"
                      name="available"
                      checked={formData.available}
                      onChange={handleInputChange}
                    />
                    Доступен для заказа
                  </label>
                </div>
              </div>

              <div className="form-actions">
                <button type="submit" className="submit-btn">
                  {editingVehicle ? 'Обновить' : 'Добавить'}
                </button>
                <button 
                  type="button" 
                  className="cancel-btn"
                  onClick={() => {
                    setIsAddingVehicle(false);
                    setEditingVehicle(null);
                    resetForm();
                  }}
                >
                  Отмена
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* Список вездеходов */}
      <div className="vehicles-list">
        <h2>Список вездеходов ({vehicles.length})</h2>
        
        {vehicles.length === 0 ? (
          <div className="no-vehicles">
            <p>Вездеходы не найдены. Добавьте первый вездеход!</p>
          </div>
        ) : (
          <div className="vehicles-table">
            <table>
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Название</th>
                  <th>Тип</th>
                  <th>Местность</th>
                  <th>Цена</th>
                  <th>Двигатель</th>
                  <th>Вместимость</th>
                  <th>Наличие</th>
                  <th>Действия</th>
                </tr>
              </thead>
              <tbody>
                {vehicles.map(vehicle => (
                  <tr key={vehicle.id}>
                    <td>{vehicle.id}</td>
                    <td>
                      <div className="vehicle-title">
                        {(() => {
                          if (vehicle.image && 
                              typeof vehicle.image === 'string' && 
                              (vehicle.image.startsWith('data:image') || 
                               vehicle.image.startsWith('http') || 
                               vehicle.image.startsWith('/img/vehicles/') ||
                               vehicle.image.startsWith('/uploads/'))) {
                            return <img src={vehicle.image} alt={vehicle.name} className="vehicle-image" />;
                          }
                          return (
                            <div className="vehicle-icon">
                              🚗
                            </div>
                          );
                        })()}
                        {vehicle.name}
                      </div>
                    </td>
                    <td>
                      <span className="vehicle-type-badge">{vehicle.type}</span>
                    </td>
                    <td>
                      {Array.isArray(vehicle.terrain) 
                        ? vehicle.terrain.join(', ') 
                        : (vehicle.terrain || '-')}
                    </td>
                    <td>{formatPrice(vehicle.price)} ₽</td>
                    <td>{vehicle.specs?.engine || '-'}</td>
                    <td>{vehicle.specs?.capacity || '-'}</td>
                    <td>
                      <span className={vehicle.available ? 'status-available' : 'status-unavailable'}>
                        {vehicle.available ? 'В наличии' : 'Нет в наличии'}
                      </span>
                    </td>
                    <td>
                      <div className="action-buttons">
                        <button 
                          onClick={() => handleEdit(vehicle)}
                          className="btn-edit"
                          title="Редактировать"
                        >
                          <FaEdit />
                        </button>
                        <button 
                          onClick={() => handleDelete(vehicle.id)}
                          className="btn-delete"
                          title="Удалить"
                        >
                          <FaTrash />
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  );
}

export default VehiclesManagement;
