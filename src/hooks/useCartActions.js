import { useCart } from '../context/CartContext';
import toast from 'react-hot-toast';

export const useCartActions = () => {
  const { addToCart } = useCart();

  const addToCartWithNotification = (product, quantity = 1) => {
    try {
      // Валидация количества
      if (quantity < 1) {
        toast.error('Количество не может быть меньше 1');
        return;
      }
      
      if (quantity > 999999) {
        toast.error('Максимальное количество товара: 999,999 штук');
        return;
      }
      
      // Проверка наличия товара на складе
      if (product.quantity !== undefined && product.quantity !== null) {
        if (quantity > product.quantity) {
          toast.error(`В наличии только ${product.quantity} штук. Недостаточно товара на складе.`);
          return;
        }
      }
      
      addToCart(product, quantity);
      const title = product?.title || 'Товар';
      const formattedPrice = product?.price != null ? product.price.toLocaleString('ru-RU') : '';
      const price = formattedPrice ? ` — ${formattedPrice} ₽` : '';
      
      // Небольшая задержка для корректного отображения уведомления
      setTimeout(() => {
        toast.success(`${title} добавлен в корзину${price}`);
      }, 100);
    } catch (error) {
      console.error('Error adding to cart:', error);
      toast.error('Ошибка при добавлении товара в корзину');
    }
  };

  return {
    addToCartWithNotification
  };
};
