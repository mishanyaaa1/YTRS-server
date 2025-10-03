import React, { useState } from 'react';
import { 
  FaPlus, 
  FaEdit, 
  FaTrash, 
  FaSave, 
  FaTimes,
  FaList
} from 'react-icons/fa';
import { useAdminData } from '../../context/AdminDataContext';
import DeleteConfirmationModal from '../../components/DeleteConfirmationModal';
import './CategoryManagement.css';

function CategoryManagement() {
  const { 
    products,
    categories,
    addCategory, 
    updateCategory, 
    deleteCategory,
    addSubcategory,
    updateSubcategory,
    deleteSubcategory
  } = useAdminData();

  const [newCategoryName, setNewCategoryName] = useState('');
  const [newCategorySubs, setNewCategorySubs] = useState([]);
  const [newSubInput, setNewSubInput] = useState('');
  const [editingCategory, setEditingCategory] = useState(null);
  const [editCategoryName, setEditCategoryName] = useState('');
  
  const [newSubcategoryName, setNewSubcategoryName] = useState('');
  const [editingSubcategory, setEditingSubcategory] = useState(null);
  const [editSubcategoryName, setEditSubcategoryName] = useState('');
  const [selectedCategoryForSub, setSelectedCategoryForSub] = useState('');
  const [deleteModal, setDeleteModal] = useState({
    isOpen: false,
    type: '',
    name: '',
    items: []
  });


  // Добавление новой категории
  const handleAddCategory = () => {
    if (newCategoryName.trim()) {
      const subs = (newCategorySubs || []).map(s => s.trim()).filter(Boolean);
      addCategory(newCategoryName.trim(), subs);
      setNewCategoryName('');
      setNewCategorySubs([]);
      setNewSubInput('');
    }
  };

  const handleAddNewSubToNewCategory = () => {
    const name = (newSubInput || '').trim();
    if (!name) return;
    if (newCategorySubs.includes(name)) return;
    setNewCategorySubs(prev => [...prev, name]);
    setNewSubInput('');
  };

  const handleRemoveNewSub = (idx) => {
    setNewCategorySubs(prev => prev.filter((_, i) => i !== idx));
  };

  // Начать редактирование категории
  const startEditCategory = (categoryName) => {
    setEditingCategory(categoryName);
    setEditCategoryName(categoryName);
  };

  // Сохранить изменения категории
  const saveEditCategory = () => {
    if (editCategoryName.trim() && editCategoryName !== editingCategory) {
      updateCategory(editingCategory, editCategoryName.trim());
    }
    setEditingCategory(null);
    setEditCategoryName('');
  };

  // Отменить редактирование категории
  const cancelEditCategory = () => {
    setEditingCategory(null);
    setEditCategoryName('');
  };

  // Функция для проверки использования категории в товарах
  const getProductsUsingCategory = (categoryName) => {
    return products.filter(product => product.category === categoryName);
  };

  // Функция для проверки использования подкатегории в товарах
  const getProductsUsingSubcategory = (categoryName, subcategoryName) => {
    return products.filter(product => 
      product.category === categoryName && product.subcategory === subcategoryName
    );
  };

  // Удалить категорию
  const handleDeleteCategory = (categoryName) => {
    const productsUsingCategory = getProductsUsingCategory(categoryName);
    
    if (productsUsingCategory.length > 0) {
      // Показываем модальное окно с предупреждением
      setDeleteModal({
        isOpen: true,
        type: 'категорию',
        name: categoryName,
        items: productsUsingCategory.map(product => product.title || product.name)
      });
    } else {
      // Обычное подтверждение, если категория не используется
      if (confirm(`Удалить категорию "${categoryName}"?`)) {
        deleteCategory(categoryName);
      }
    }
  };

  // Добавление новой подкатегории
  const handleAddSubcategory = () => {
    if (newSubcategoryName.trim() && selectedCategoryForSub) {
      addSubcategory(selectedCategoryForSub, newSubcategoryName.trim());
      setNewSubcategoryName('');
    }
  };

  // Начать редактирование подкатегории
  const startEditSubcategory = (categoryName, subcategoryName) => {
    setEditingSubcategory(`${categoryName}::${subcategoryName}`);
    setEditSubcategoryName(subcategoryName);
  };

  // Сохранить изменения подкатегории
  const saveEditSubcategory = () => {
    const [categoryName, oldSubName] = editingSubcategory.split('::');
    if (editSubcategoryName.trim() && editSubcategoryName !== oldSubName) {
      updateSubcategory(categoryName, oldSubName, editSubcategoryName.trim());
    }
    setEditingSubcategory(null);
    setEditSubcategoryName('');
  };

  // Отменить редактирование подкатегории
  const cancelEditSubcategory = () => {
    setEditingSubcategory(null);
    setEditSubcategoryName('');
  };

  // Удалить подкатегорию
  const handleDeleteSubcategory = (categoryName, subcategoryName) => {
    const productsUsingSubcategory = getProductsUsingSubcategory(categoryName, subcategoryName);
    
    if (productsUsingSubcategory.length > 0) {
      // Показываем модальное окно с предупреждением
      setDeleteModal({
        isOpen: true,
        type: 'подкатегорию',
        name: `${categoryName} > ${subcategoryName}`,
        items: productsUsingSubcategory.map(product => product.title || product.name)
      });
    } else {
      // Обычное подтверждение, если подкатегория не используется
      if (confirm(`Удалить подкатегорию "${subcategoryName}"?`)) {
        deleteSubcategory(categoryName, subcategoryName);
      }
    }
  };

  const handleConfirmDelete = () => {
    if (deleteModal.type === 'категорию') {
      deleteCategory(deleteModal.name);
    } else if (deleteModal.type === 'подкатегорию') {
      const [categoryName, subcategoryName] = deleteModal.name.split(' > ');
      deleteSubcategory(categoryName, subcategoryName);
    }
  };

  const closeDeleteModal = () => {
    setDeleteModal({
      isOpen: false,
      type: '',
      name: '',
      items: []
    });
  };


  return (
    <div className="category-management">
      <div className="page-header">
        <p>Добавляйте, редактируйте и удаляйте категории и подкатегории товаров</p>
      </div>

      <div className="category-content">
        {/* Добавление новой категории (+ подкатегории при создании) */}
        <div className="section">
          <h3>
            <FaPlus /> Добавить категорию
          </h3>
          <div className="add-category-form">
            <input
              type="text"
              placeholder="Название новой категории"
              value={newCategoryName}
              onChange={(e) => setNewCategoryName(e.target.value)}
              onKeyPress={(e) => e.key === 'Enter' && handleAddCategory()}
            />
            <button 
              onClick={handleAddCategory}
              disabled={!newCategoryName.trim()}
              className="add-btn"
            >
              <FaPlus /> Добавить
            </button>
          </div>

          {/* Подкатегории при создании категории */}
          <div className="add-subcategory-form" style={{ marginTop: '12px' }}>
            <input
              type="text"
              placeholder="Подкатегория (по желанию)"
              value={newSubInput}
              onChange={(e) => setNewSubInput(e.target.value)}
              onKeyPress={(e) => e.key === 'Enter' && handleAddNewSubToNewCategory()}
            />
            <button
              onClick={handleAddNewSubToNewCategory}
              className="add-btn"
              disabled={!newSubInput.trim()}
            >
              <FaPlus /> Добавить подкатегорию
            </button>
          </div>

          {newCategorySubs.length > 0 && (
            <div className="subchips">
              {newCategorySubs.map((s, idx) => (
                <span key={idx} className="subchip">
                  {s}
                  <button type="button" onClick={() => handleRemoveNewSub(idx)} aria-label="Удалить">
                    ×
                  </button>
                </span>
              ))}
            </div>
          )}
        </div>

        {/* Список категорий */}
        <div className="section">
          <h3>
            <FaList /> Категории ({Object.keys(categories).length})
          </h3>
          <div className="categories-list">
            {Object.entries(categories).map(([categoryName, subcategories]) => (
              <div key={categoryName} className="category-item">
                <div className="category-header">
                  <div className="category-info">
                    {editingCategory === categoryName ? (
                      <div className="edit-form">
                        <input
                          type="text"
                          value={editCategoryName}
                          onChange={(e) => setEditCategoryName(e.target.value)}
                          onKeyPress={(e) => e.key === 'Enter' && saveEditCategory()}
                          autoFocus
                        />
                        <button onClick={saveEditCategory} className="save-btn">
                          <FaSave />
                        </button>
                        <button onClick={cancelEditCategory} className="cancel-btn">
                          <FaTimes />
                        </button>
                      </div>
                    ) : (
                      <>
                        <h4>{categoryName}</h4>
                        <span className="subcategory-count">
                          {subcategories.length} подкатегорий
                        </span>
                      </>
                    )}
                  </div>
                  
                  {editingCategory !== categoryName && (
                    <div className="category-actions">
                      <button 
                        onClick={() => startEditCategory(categoryName)}
                        className="edit-btn"
                        title="Редактировать"
                      >
                        <FaEdit />
                      </button>
                      <button 
                        onClick={() => handleDeleteCategory(categoryName)}
                        className="delete-btn"
                        title="Удалить"
                      >
                        <FaTrash />
                      </button>
                    </div>
                  )}
                </div>

                {/* Подкатегории */}
                <div className="subcategories">
                  {subcategories.map((subcategoryName) => (
                    <div key={subcategoryName} className="subcategory-item">
                      {editingSubcategory === `${categoryName}::${subcategoryName}` ? (
                        <div className="edit-form">
                          <input
                            type="text"
                            value={editSubcategoryName}
                            onChange={(e) => setEditSubcategoryName(e.target.value)}
                            onKeyPress={(e) => e.key === 'Enter' && saveEditSubcategory()}
                            autoFocus
                          />
                          <button onClick={saveEditSubcategory} className="save-btn">
                            <FaSave />
                          </button>
                          <button onClick={cancelEditSubcategory} className="cancel-btn">
                            <FaTimes />
                          </button>
                        </div>
                      ) : (
                        <>
                          <span className="subcategory-name">{subcategoryName}</span>
                          <div className="subcategory-actions">
                            <button 
                              onClick={() => startEditSubcategory(categoryName, subcategoryName)}
                              className="edit-btn"
                              title="Редактировать"
                            >
                              <FaEdit />
                            </button>
                            <button 
                              onClick={() => handleDeleteSubcategory(categoryName, subcategoryName)}
                              className="delete-btn"
                              title="Удалить"
                            >
                              <FaTrash />
                            </button>
                          </div>
                        </>
                      )}
                    </div>
                  ))}
                </div>
              </div>
            ))}
          </div>
        </div>

      </div>

      {/* Модальное окно подтверждения удаления */}
      <DeleteConfirmationModal
        isOpen={deleteModal.isOpen}
        onClose={closeDeleteModal}
        onConfirm={handleConfirmDelete}
        title={`Удаление ${deleteModal.type}`}
        message={`Вы действительно хотите удалить ${deleteModal.type} "${deleteModal.name}"?`}
        items={deleteModal.items}
        type="товар"
      />
    </div>
  );
}

export default CategoryManagement;
