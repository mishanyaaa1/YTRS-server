import React, { useState } from 'react';
import { useAuth } from '../context/AuthContext';
import ChangePasswordModal from './ChangePasswordModal';
import './ChangePasswordButton.css';

const ChangePasswordButton = () => {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const { changePassword } = useAuth();

  const handlePasswordChange = async (currentPassword, newPassword) => {
    return await changePassword(currentPassword, newPassword);
  };

  return (
    <>
      <button 
        className="change-password-button"
        onClick={() => setIsModalOpen(true)}
        title="Изменить пароль"
      >
        <svg 
          width="16" 
          height="16" 
          viewBox="0 0 24 24" 
          fill="none" 
          stroke="currentColor" 
          strokeWidth="2"
        >
          <rect x="3" y="11" width="18" height="11" rx="2" ry="2"/>
          <circle cx="12" cy="16" r="1"/>
          <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
        </svg>
        Сменить пароль
      </button>

      <ChangePasswordModal
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        onPasswordChange={handlePasswordChange}
      />
    </>
  );
};

export default ChangePasswordButton;
