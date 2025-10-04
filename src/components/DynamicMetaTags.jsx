import { useEffect } from 'react';
import { useAdminData } from '../context/AdminDataContext';

export default function DynamicMetaTags() {
  const { aboutContent } = useAdminData();
  
  useEffect(() => {
    // Получаем данные контактов из админки или используем дефолтные
    const phone = aboutContent.contacts?.phone || '+7 (351) 21-444-32';
    const email = aboutContent.contacts?.email || 'info@ytors.ru';
    const address = aboutContent.contacts?.address || 'Челябинск, ул. Примерная, 123, 454000';
    const workingHours = aboutContent.contacts?.workingHours || 'Пн-Пт: 9:00-18:00, Сб: 10:00-16:00';
    
    // Парсим адрес для структурированных данных (город, улица, индекс)
    const addressParts = address.split(',');
    const city = addressParts[0]?.trim() || 'Челябинск';
    const streetAddress = addressParts[1]?.trim() || 'ул. Примерная, 123';
    const postalCode = addressParts[2]?.trim() || '454000';
    
    // Конвертируем время работы в формат schema.org
    const schemaOpeningHours = convertToSchemaOpeningHours(workingHours);
    
    // Обновляем мета-теги
    updateMetaTag('description', `Качественные запчасти для вездеходов всех марок и моделей. Двигатели, гусеницы, коробки передач, амортизаторы, аккумуляторы. Быстрая доставка по России. Гарантия качества. ☎ ${phone}`);
    updateMetaTag('business:contact_data:phone_number', phone);
    updateMetaTag('business:contact_data:email', email);
    updateMetaTag('business:contact_data:street_address', address);
    
    // Обновляем Open Graph теги
    updateMetaProperty('og:description', `Качественные запчасти для вездеходов всех марок. Двигатели, гусеницы, коробки передач, амортизаторы. Быстрая доставка по России. Гарантия качества. ☎ ${phone}`);
    
    // Обновляем Twitter Card теги
    updateMetaName('twitter:description', `Качественные запчасти для вездеходов всех марок. Быстрая доставка по России. ☎ ${phone}`);
    
    // Обновляем структурированные данные
    updateStructuredData({
      telephone: phone,
      email: email,
      address: {
        streetAddress: streetAddress,
        addressLocality: city,
        postalCode: postalCode,
        addressCountry: 'RU'
      },
      openingHours: schemaOpeningHours
    });
    
    // Обновляем manifest.json данные (если нужно)
    updateManifestData({
      phone: phone,
      email: email,
      city: city
    });
    
  }, [aboutContent.contacts]);
  
  // Функция конвертации времени работы в формат schema.org
  const convertToSchemaOpeningHours = (workingHours) => {
    if (!workingHours) return "Mo-Fr 09:00-18:00, Sa 10:00-16:00";
    
    // Простая конвертация для стандартных форматов
    const hours = workingHours.toLowerCase();
    if (hours.includes('пн-пт') && hours.includes('сб')) {
      return "Mo-Fr 09:00-18:00, Sa 10:00-16:00";
    }
    if (hours.includes('понедельник-пятница')) {
      return "Mo-Fr 09:00-18:00";
    }
    if (hours.includes('ежедневно')) {
      return "Mo-Su 09:00-18:00";
    }
    
    // Возвращаем дефолтное значение
    return "Mo-Fr 09:00-18:00, Sa 10:00-16:00";
  };
  
  const updateMetaTag = (name, content) => {
    let meta = document.querySelector(`meta[name="${name}"]`);
    if (meta) {
      meta.setAttribute('content', content);
    } else {
      // Создаем новый мета-тег если его нет
      meta = document.createElement('meta');
      meta.setAttribute('name', name);
      meta.setAttribute('content', content);
      document.head.appendChild(meta);
    }
  };
  
  const updateMetaProperty = (property, content) => {
    let meta = document.querySelector(`meta[property="${property}"]`);
    if (meta) {
      meta.setAttribute('content', content);
    } else {
      meta = document.createElement('meta');
      meta.setAttribute('property', property);
      meta.setAttribute('content', content);
      document.head.appendChild(meta);
    }
  };
  
  const updateMetaName = (name, content) => {
    let meta = document.querySelector(`meta[name="${name}"]`);
    if (meta) {
      meta.setAttribute('content', content);
    } else {
      meta = document.createElement('meta');
      meta.setAttribute('name', name);
      meta.setAttribute('content', content);
      document.head.appendChild(meta);
    }
  };
  
  const updateStructuredData = (contactData) => {
    const scripts = document.querySelectorAll('script[type="application/ld+json"]');
    scripts.forEach(script => {
      try {
        const data = JSON.parse(script.textContent);
        
        // Обновляем AutoPartsStore схему
        if (data['@type'] === 'AutoPartsStore') {
          if (data.telephone) data.telephone = contactData.telephone;
          if (data.email) data.email = contactData.email;
          if (data.address && typeof contactData.address === 'object') {
            data.address.streetAddress = contactData.address.streetAddress;
            data.address.addressLocality = contactData.address.addressLocality;
            data.address.postalCode = contactData.address.postalCode;
            data.address.addressCountry = contactData.address.addressCountry;
          } else if (data.address && typeof contactData.address === 'string') {
            data.address.streetAddress = contactData.address;
          }
          if (data.openingHours) data.openingHours = contactData.openingHours;
        }
        
        // Обновляем Organization схему
        if (data['@type'] === 'Organization') {
          if (data.contactPoint && data.contactPoint.telephone) {
            data.contactPoint.telephone = contactData.telephone;
          }
        }
        
        // Обновляем WebSite схему (если есть контактная информация)
        if (data['@type'] === 'WebSite' && data.contactPoint) {
          if (data.contactPoint.telephone) {
            data.contactPoint.telephone = contactData.telephone;
          }
        }
        
        script.textContent = JSON.stringify(data, null, 2);
      } catch (e) {
        console.error('Error updating structured data:', e);
      }
    });
  };
  
  const updateManifestData = (contactData) => {
    // Обновляем данные в manifest через мета-теги
    updateMetaName('application-name', `ЮТОРС - ${contactData.city}`);
    updateMetaName('apple-mobile-web-app-title', `ЮТОРС - ${contactData.city}`);
  };
  
  return null;
}
