import React from 'react';
import { motion } from 'framer-motion';
import {
  FaMapMarkerAlt,
  FaPhone,
  FaEnvelope,
  FaClock,
  FaTools,
  FaTruck,
  FaStore,
  FaShippingFast,
  FaCreditCard,
  FaShieldAlt,
  FaFileInvoice,
  FaUniversity,
  FaCcVisa,
  FaCcMastercard,
  FaMoneyBillWave
} from 'react-icons/fa';
import { useAdminData } from '../context/AdminDataContext';
import './About.css';
import { getIconForEmoji } from '../utils/iconMap.jsx';
import Reveal from '../components/Reveal';

export default function About() {
  const { aboutContent } = useAdminData();

  // Дефолтные преимущества (если не заданы в админке)
  const defaultAdvantages = [
    {
      icon: "🚚",
      title: "Быстрая доставка",
      description: "Доставка по всей России в кратчайшие сроки. Экспресс-доставка по Москве и области."
    },
    {
      icon: "💰",
      title: "Выгодные цены",
      description: "Конкурентные цены на все товары. Скидки для постоянных клиентов и оптовых покупателей."
    },
    {
      icon: "🔧",
      title: "Широкий ассортимент",
      description: "Более 15000 наименований запчастей для всех типов и марок вездеходов."
    },
    {
      icon: "✅",
      title: "Гарантия качества",
      description: "Полная гарантия на все товары и профессиональная поддержка. Обменяем или вернем деньги в случае брака."
    }
  ];

  // Используем данные команды из админки или дефолтные данные
  const team = aboutContent.team && aboutContent.team.members && aboutContent.team.members.length > 0 
    ? aboutContent.team.members 
    : [
        {
          name: "Алексей Петров",
          position: "Генеральный директор",
          experience: "15 лет в автомобильной индустрии",
          photo: "👨‍💼",
          description: "Основатель компании, эксперт по вездеходной технике"
        },
        {
          name: "Мария Сидорова",
          position: "Технический директор",
          experience: "12 лет работы с вездеходами",
          photo: "👩‍🔧",
          description: "Отвечает за техническую экспертизу и качество продукции"
        },
        {
          name: "Дмитрий Иванов",
          position: "Менеджер по продажам",
          experience: "8 лет в сфере запчастей",
          photo: "👨‍💻",
          description: "Помогает клиентам найти нужные запчасти и решает вопросы"
        }
      ];

  // Дефолтные фичи (если не заданы в админке)
  const defaultFeatures = [
    {
      icon: "⭐",
      title: "Профессиональная консультация",
      description: "Наши эксперты помогут подобрать именно те запчасти, которые подходят вашему вездеходу."
    },
    {
      icon: "🛡️",
      title: "Официальная гарантия",
      description: "На все товары предоставляется официальная гарантия производителя от 6 месяцев до 2 лет."
    },
    {
      icon: "🎯",
      title: "Точность подбора",
      description: "Благодаря нашему опыту, мы точно определим нужную деталь по VIN-коду или фотографии."
    }
  ];

  const contactsData = aboutContent.contacts || {};
  const contacts = [
    {
      icon: <FaMapMarkerAlt />,
      title: "Адрес",
      info: contactsData.address || "40-летия Победы, 16а, Курчатовский район, Челябинск, 454100",
      link: "#"
    },
    {
      icon: <FaPhone />,
      title: "Телефон",
      info: contactsData.phone || "+7 (800) 123-45-67",
      link: `tel:${contactsData.phone || '+78001234567'}`
    },
    {
      icon: <FaEnvelope />,
      title: "Email",
      info: contactsData.email || "info@vezdehod-zapchasti.ru",
      link: `mailto:${contactsData.email || 'info@vezdehod-zapchasti.ru'}`
    },
    {
      icon: <FaClock />,
      title: "Время работы",
      info: contactsData.workingHours || "Пн-Пт: 9:00-18:00, Сб: 10:00-16:00",
      link: null
    }
  ];

  const getDeliveryIcon = (title) => {
    const lower = (title || '').toLowerCase();
    if (lower.includes('самовывоз')) return <FaStore />;
    if (lower.includes('бесплатная')) return <FaTruck />;
    if (lower.includes('россии') || lower.includes('снг') || lower.includes('доставка')) return <FaShippingFast />;
    return <FaTruck />;
  };

  return (
    <div className="about-page">
      {/* Hero секция */}
      <section className="about-hero">
        <div className="container">
          <Reveal type="up">
            <div className="hero-content">
              <h1 className="about-title">
                {(() => {
                  const title = aboutContent.title || "О компании ЮТОРС";
                  if (title.includes('\n')) {
                    return title.split('\n').map((line, index) => (
                      <span key={index} style={{ display: 'block' }}>
                        {line}
                      </span>
                    ));
                  }
                  return title;
                })()}
              </h1>
              <div className="about-description" style={{ whiteSpace: 'pre-line' }}>
                {aboutContent.description || "Мы специализируемся на поставке качественных запчастей для вездеходов всех типов и марок. Наша цель — обеспечить вас надежными комплектующими для безопасной и комфортной эксплуатации вашей техники."}
              </div>
            </div>
          </Reveal>
        </div>
      </section>

      {/* Наши преимущества */}
      <section className="advantages">
        <div className="container">
          <motion.h2 
            className="section-title"
            initial={{ opacity: 0, y: 30 }}
            whileInView={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
            viewport={{ once: true }}
          >
            Наши преимущества
          </motion.h2>
          
          <div className="advantages-grid">
            {(aboutContent.advantages && aboutContent.advantages.length > 0 ? aboutContent.advantages : defaultAdvantages).map((advantage, index) => (
              <motion.div 
                key={index}
                className="advantage-card"
                initial={{ opacity: 0, y: 30 }}
                whileInView={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.6, delay: index * 0.1 }}
                viewport={{ once: true }}
                whileHover={{ y: -5 }}
              >
                <div className="advantage-icon">
                  {typeof advantage.icon === 'string' 
                    ? getIconForEmoji(advantage.icon)
                    : defaultAdvantages[index]?.icon}
                </div>
                <h3 className="advantage-title">
                  {(() => {
                    const title = advantage.title || advantage;
                    if (title.includes('\n')) {
                      return title.split('\n').map((line, index) => (
                        <span key={index} style={{ display: 'block' }}>
                          {line}
                        </span>
                      ));
                    }
                    return title;
                  })()}
                </h3>
                <p>{advantage.description || ''}</p>
              </motion.div>
            ))}
          </div>
        </div>
      </section>

      {/* Почему выбирают нас */}
      <section className="features-section">
        <div className="container">
          <motion.h2 
            className="section-title"
            initial={{ opacity: 0, y: 30 }}
            whileInView={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
            viewport={{ once: true }}
          >
            Почему выбирают нас
          </motion.h2>
          
          <div className="features-grid">
            {(aboutContent.whyChooseUs && aboutContent.whyChooseUs.length > 0 ? aboutContent.whyChooseUs : defaultFeatures).map((feature, index) => (
              <motion.div 
                key={index}
                className="feature-item"
                initial={{ opacity: 0, x: -30 }}
                whileInView={{ opacity: 1, x: 0 }}
                transition={{ duration: 0.6, delay: index * 0.2 }}
                viewport={{ once: true }}
              >
                <div className="feature-icon">
                  {typeof feature.icon === 'string' 
                    ? getIconForEmoji(feature.icon)
                    : defaultFeatures[index]?.icon}
                </div>
                <div className="feature-content">
                  <h3 className="feature-title">
                    {(() => {
                      const title = feature.title;
                      if (title.includes('\n')) {
                        return title.split('\n').map((line, index) => (
                          <span key={index} style={{ display: 'block' }}>
                            {line}
                          </span>
                        ));
                      }
                      return title;
                    })()}
                  </h3>
                  <p>{feature.description}</p>
                </div>
              </motion.div>
            ))}
          </div>
        </div>
      </section>

      {/* Наша команда */}
      <section className="team-section">
        <div className="container">
          <motion.h2 
            className="section-title"
            initial={{ opacity: 0, y: 30 }}
            whileInView={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
            viewport={{ once: true }}
          >
            {aboutContent.team?.title || 'Наша команда'}
          </motion.h2>
          
          <div className="team-grid">
            {team.map((member, index) => (
              <motion.div 
                key={index}
                className="team-card"
                initial={{ opacity: 0, y: 30 }}
                whileInView={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.6, delay: index * 0.1 }}
                viewport={{ once: true }}
                whileHover={{ y: -5 }}
              >
                <div className="member-photo">
                  {member.photo && member.photo.startsWith('data:image') ? (
                    <img src={member.photo} alt={member.name} className="member-photo-img" />
                  ) : (
                    <span className="member-photo-emoji">{member.photo || "👤"}</span>
                  )}
                </div>
                <h3>{member.name}</h3>
                <p className="member-position">{member.position}</p>
                <p className="member-experience">{member.experience}</p>
                {member.description && (
                  <p className="member-description">{member.description}</p>
                )}
              </motion.div>
            ))}
          </div>
        </div>
      </section>

      {/* О нас подробнее */}
      <section className="company-story">
        <div className="container">
          <motion.h2 
            className="section-title"
            initial={{ opacity: 0, y: 30 }}
            whileInView={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
            viewport={{ once: true }}
          >
            {aboutContent.history?.title || "История компании"}
          </motion.h2>
          
          <motion.div 
            className="history-timeline"
            initial={{ opacity: 0, y: 50 }}
            whileInView={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8 }}
            viewport={{ once: true }}
          >
            <div className="timeline-description">
              <p>
                {aboutContent.history?.content || 
                  "Компания ЮТОРС была основана в 2013 году группой энтузиастов, увлеченных вездеходной техникой. Начав с небольшого магазина в Москве, мы постепенно расширили свою деятельность и сегодня являемся одним из ведущих поставщиков запчастей для вездеходов в России."
                }
              </p>
            </div>
            
            <div className="timeline-steps">
              {(() => {
                const milestones = aboutContent.history?.milestones && aboutContent.history.milestones.items && aboutContent.history.milestones.items.length > 0 
                  ? aboutContent.history.milestones.items 
                  : [];
                
                // Функция для определения позиции в сетке (змейка)
                const getStepPosition = (index, totalSteps) => {
                  const stepsPerRow = 3;
                  const row = Math.floor(index / stepsPerRow);
                  const col = index % stepsPerRow;
                  
                  // Если ряд четный (0, 2, 4...) - идем справа налево
                  if (row % 2 === 1) {
                    return { row: row + 1, col: stepsPerRow - col };
                  }
                  
                  // Если ряд нечетный (1, 3, 5...) - идем слева направо
                  return { row: row + 1, col: col + 1 };
                };
                
                // Функция для определения направления стрелочки (змейка)
                const getArrowDirection = (index, totalSteps) => {
                  const stepsPerRow = 3;
                  const row = Math.floor(index / stepsPerRow);
                  const col = index % stepsPerRow;
                  
                  // Если это последний пункт - стрелочки нет
                  if (index === totalSteps - 1) return 'none';
                  
                  // Если это последний пункт в ряду - стрелка вниз
                  if (col === stepsPerRow - 1) return 'down';
                  
                  // Если ряд четный (0, 2, 4...) - стрелка влево
                  if (row % 2 === 1) return 'left';
                  
                  // Если ряд нечетный (1, 3, 5...) - стрелка вправо
                  return 'right';
                };
                
                // Если нет этапов - не показываем ничего
                if (milestones.length === 0) {
                  return null;
                }
                
                return milestones.map((milestone, index) => {
                  const isLastStep = index === milestones.length - 1;
                  const position = getStepPosition(index, milestones.length);
                  const arrowDirection = getArrowDirection(index, milestones.length);
                  
                  return (
                    <motion.div 
                      key={index}
                      className={`timeline-step step-${index + 1} ${isLastStep ? 'last-step' : ''} arrow-${arrowDirection}`}
                      style={{
                        gridColumn: position.col,
                        gridRow: position.row
                      }}
                      initial={{ opacity: 0, scale: 0.8 }}
                      whileInView={{ opacity: 1, scale: 1 }}
                      transition={{ duration: 0.6, delay: index * 0.2 }}
                      viewport={{ once: true }}
                      whileHover={{ scale: 1.05 }}
                    >
                      <div className="step-number">{index + 1}</div>
                      <div className="step-content">
                        <div className="step-year">{milestone.year}</div>
                        <h3 className="step-title">{milestone.title}</h3>
                        <p className="step-description">{milestone.description}</p>
                      </div>
                    </motion.div>
                  );
                });
              })()}
            </div>
          </motion.div>
        </div>
      </section>

      {/* Доставка и оплата */}
      <section className="delivery-payment" id="delivery">
        <div className="container">
          <motion.h2
            className="section-title"
            initial={{ opacity: 0, y: 30 }}
            whileInView={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
            viewport={{ once: true }}
          >
            Доставка и оплата
          </motion.h2>

          {/* Шаги получения товара */}
          <div className="steps-grid">
            {(aboutContent.deliveryAndPayment?.steps || []).map((step, index) => (
              <motion.div
                key={index}
                className="step-card"
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.5, delay: index * 0.1 }}
                viewport={{ once: true }}
                whileHover={{ y: -4 }}
              >
                <div className="step-number">{index + 1}</div>
                <h3 className="step-title">{step.title}</h3>
                <p className="step-text">{step.description}</p>
              </motion.div>
            ))}
          </div>

          {/* Способы доставки */}
          {aboutContent.deliveryAndPayment?.deliveryMethods && (
            <div className="delivery-methods">
              <h3>Способы доставки</h3>
              <div className="methods-grid advantages-grid">
                {aboutContent.deliveryAndPayment.deliveryMethods.map((method, i) => (
                  <motion.div
                    key={i}
                    className="advantage-card method-card"
                    initial={{ opacity: 0, y: 20 }}
                    whileInView={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.5, delay: i * 0.1 }}
                    viewport={{ once: true }}
                    whileHover={{ y: -4 }}
                  >
                    <div className="advantage-icon">{getDeliveryIcon(method.title)}</div>
                    <h4>{method.title}</h4>
                    {method.description && (
                      <p className="method-description">{method.description}</p>
                    )}
                    {Array.isArray(method.items) && method.items.length > 0 && (
                      <ul className="method-list">
                        {method.items.map((it, idx) => (
                          <li key={idx}>{it}</li>
                        ))}
                      </ul>
                    )}
                  </motion.div>
                ))}
              </div>
              {aboutContent.deliveryAndPayment.deliveryNote && (
                <p className="delivery-note">{aboutContent.deliveryAndPayment.deliveryNote}</p>
              )}
            </div>
          )}

          {/* Оплата */}
          {aboutContent.deliveryAndPayment?.payment && (
            <div className="payment-section">
              <h3>Оплата</h3>
              <div className="payment-cards advantages-grid">
                <div className="advantage-card payment-card">
                  <div className="advantage-icon"><FaMoneyBillWave /></div>
                  <h4>Почему предоплата</h4>
                  <p>{aboutContent.deliveryAndPayment.payment.whyPrepay}</p>
                  {aboutContent.deliveryAndPayment.payment.whyPrepayExtra && (
                    <p>{aboutContent.deliveryAndPayment.payment.whyPrepayExtra}</p>
                  )}
                </div>
                <div className="advantage-card payment-card">
                  <div className="advantage-icon"><FaShieldAlt /></div>
                  <h4>Гарантии честной сделки</h4>
                  <p>{aboutContent.deliveryAndPayment.payment.trust}</p>
                  {aboutContent.deliveryAndPayment.payment.trustExtra && (
                    <p>{aboutContent.deliveryAndPayment.payment.trustExtra}</p>
                  )}
                </div>
                <div className="advantage-card payment-card">
                  <div className="advantage-icon"><FaFileInvoice /></div>
                  <h4>Реквизиты</h4>
                  <p className="requisites-text">{aboutContent.deliveryAndPayment.payment.requisites}</p>
                </div>
              </div>
              <div className="payment-logos" aria-hidden>
                <span className="logo"><FaCcVisa /></span>
                <span className="logo"><FaCcMastercard /></span>
                <span className="logo"><FaUniversity /></span>
                <span className="logo"><FaCreditCard /></span>
              </div>
            </div>
          )}
        </div>
      </section>

      {/* Контакты */}
      <section className="contacts-section" id="contacts">
        <div className="container">
          <motion.h2 
            className="section-title"
            initial={{ opacity: 0, y: 30 }}
            whileInView={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
            viewport={{ once: true }}
          >
            Контакты
          </motion.h2>
          
          <div className="contacts-grid">
            {contacts.map((contact, index) => (
              <motion.div 
                key={index}
                className="contact-card"
                initial={{ opacity: 0, y: 30 }}
                whileInView={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.6, delay: index * 0.1 }}
                viewport={{ once: true }}
                whileHover={{ y: -5 }}
                onClick={() => {
                  if (contact.title === "Адрес") {
                    window.open('https://yandex.ru/maps/org/yutors/164193756613/?indoorLevel=1&ll=61.295870%2C55.187646&z=17', '_blank');
                  } else if (contact.link) {
                    window.open(contact.link, '_blank');
                  }
                }}
                style={{ cursor: contact.link || contact.title === "Адрес" ? 'pointer' : 'default' }}
              >
                <div className="contact-icon">
                  {contact.icon}
                </div>
                <h3>{contact.title}</h3>
                <p className="contact-info">{contact.info}</p>
              </motion.div>
            ))}
          </div>
        </div>
      </section>
    </div>
  );
}