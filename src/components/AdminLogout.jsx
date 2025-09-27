import React from 'react';
import { useAuth } from '../context/AuthContext';
import { useNavigate } from 'react-router-dom';
import './AdminLogout.css';

const AdminLogout = () => {
  const { logout } = useAuth();
  const navigate = useNavigate();

  const handleLogout = () => {
    if (window.confirm('Вы уверены, что хотите выйти из админ-панели?')) {
      logout();
      navigate('/');
    }
  };

  return (
    <button 
      className="admin-logout-button"
      onClick={handleLogout}
      title="Выйти из админ-панели"
    >
      <svg 
        width="16" 
        height="16" 
        viewBox="0 0 24 24" 
        fill="none" 
        stroke="currentColor" 
        strokeWidth="2"
      >
        <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
        <polyline points="16,17 21,12 16,7"/>
        <line x1="21" y1="12" x2="9" y2="12"/>
      </svg>
      Выйти
    </button>
  );
};

export default AdminLogout;
