import React from 'react';
import { FaExclamationTriangle, FaTimes, FaTrash } from 'react-icons/fa';
import './DeleteConfirmationModal.css';

function DeleteConfirmationModal({ 
  isOpen, 
  onClose, 
  onConfirm, 
  title, 
  message, 
  items = [], 
  type = 'item' 
}) {
  if (!isOpen) return null;

  console.log('DeleteConfirmationModal props:', { title, message, items, type });

  const handleBackdropClick = (e) => {
    if (e.target === e.currentTarget) {
      onClose();
    }
  };

  const handleConfirm = () => {
    onConfirm();
    onClose();
  };

  return (
    <div className="delete-modal-overlay" onClick={handleBackdropClick}>
      <div className="delete-modal">
        <div className="delete-modal-header">
          <div className="delete-modal-icon">
            <FaExclamationTriangle />
          </div>
          <h3 className="delete-modal-title">{title}</h3>
          <button 
            className="delete-modal-close"
            onClick={onClose}
            title="Закрыть"
          >
            <FaTimes />
          </button>
        </div>
        
        <div className="delete-modal-body">
          <p className="delete-modal-message">{message}</p>
          
          {items.length > 0 && (
            <div className="delete-modal-items">
              <h4>Связанные {type === 'item' ? 'товары' : 'элементы'}:</h4>
              <div className="items-list">
                {items.map((item, index) => {
                  console.log('Отображаем элемент:', item, 'индекс:', index);
                  return (
                    <div key={index} className="item-chip">
                      {item}
                    </div>
                  );
                })}
              </div>
            </div>
          )}
          
          <div className="delete-modal-warning">
            <FaExclamationTriangle />
            <span>Это действие нельзя отменить!</span>
          </div>
        </div>
        
        <div className="delete-modal-footer">
          <button 
            className="delete-modal-cancel"
            onClick={onClose}
          >
            Отмена
          </button>
          <button 
            className="delete-modal-confirm"
            onClick={handleConfirm}
          >
            <FaTrash />
            Удалить
          </button>
        </div>
      </div>
    </div>
  );
}

export default DeleteConfirmationModal;
