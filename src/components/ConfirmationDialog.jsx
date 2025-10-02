import React from 'react';
import './ConfirmationDialog.css';

const ConfirmationDialog = ({ 
  isOpen, 
  title, 
  message, 
  onConfirm, 
  onCancel, 
  confirmText = "Да", 
  cancelText = "Отмена",
  type = "warning" // warning, danger, info
}) => {
  if (!isOpen) return null;

  return (
    <div className="confirmation-overlay">
      <div className="confirmation-dialog">
        <div className="confirmation-header">
          <h3 className="confirmation-title">{title}</h3>
        </div>
        
        <div className="confirmation-body">
          <div className={`confirmation-icon confirmation-icon-${type}`}>
            {type === 'warning' && '⚠️'}
            {type === 'danger' && '🗑️'}
            {type === 'info' && 'ℹ️'}
          </div>
          <p className="confirmation-message">{message}</p>
        </div>
        
        <div className="confirmation-actions">
          <button 
            className="confirmation-btn confirmation-btn-cancel"
            onClick={onCancel}
          >
            {cancelText}
          </button>
          <button 
            className={`confirmation-btn confirmation-btn-confirm confirmation-btn-${type}`}
            onClick={onConfirm}
          >
            {confirmText}
          </button>
        </div>
      </div>
    </div>
  );
};

export default ConfirmationDialog;
