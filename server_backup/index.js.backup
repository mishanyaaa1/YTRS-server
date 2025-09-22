/* eslint-disable */
// Загружаем переменные окружения
require('./load_env');

const express = require('express');
const cors = require('cors');
const path = require('path');
const { run, get, all, dbType } = require('./db_switch');
const fs = require('fs');
const multer = require('multer');
const helmet = require('helmet');
const cookieParser = require('cookie-parser');
const jwt = require('jsonwebtoken');
const rateLimit = require('express-rate-limit');
const bcrypt = require('bcryptjs');
const crypto = require('crypto');

const app = express();
const PORT = process.env.PORT || 3001;
const NODE_ENV = process.env.NODE_ENV || 'development';
const JWT_SECRET = process.env.JWT_SECRET;

app.set('trust proxy', 1);

// Security headers
app.use(
  helmet({
    contentSecurityPolicy: false,
  })
);

// CORS (ограничим источники)
const allowedOrigins = new Set([
  'http://localhost:5174',
  'http://127.0.0.1:5174',
  'http://localhost:3001', // через прокси changeOrigin
  'https://yourdomain.com',
  'https://www.yourdomain.com',
  process.env.DOMAIN ? `https://${process.env.DOMAIN}` : '',
  process.env.DOMAIN ? `https://www.${process.env.DOMAIN}` : '',
  process.env.DOMAIN ? `http://${process.env.DOMAIN}` : '',
].filter(Boolean));

app.use(
  cors({
    origin(origin, callback) {
      if (!origin) return callback(null, true);
      if (allowedOrigins.has(origin)) return callback(null, true);
      // В продакшене разрешаем только HTTPS
      if (NODE_ENV === 'production' && origin.startsWith('https://')) {
        return callback(null, true);
      }
      return callback(null, false);
    },
    credentials: true,
  })
);

app.use(cookieParser());
app.use(express.json({ limit: '25mb' }));
// Статическая раздача загруженных файлов
const uploadsDir = path.join(__dirname, 'uploads');
const backupsDir = path.join(__dirname, 'backups');
if (!fs.existsSync(uploadsDir)) {
  fs.mkdirSync(uploadsDir, { recursive: true });
}
if (!fs.existsSync(backupsDir)) {
  fs.mkdirSync(backupsDir, { recursive: true });
}
app.use('/uploads', express.static(uploadsDir));

// В продакшене раздаем статические файлы клиента
if (NODE_ENV === 'production') {
  const publicDir = path.join(__dirname, 'public');
  app.use(express.static(publicDir));
  
  // Fallback для SPA - все маршруты кроме API возвращают index.html
  app.get('*', (req, res, next) => {
    // Пропускаем API маршруты
    if (req.path.startsWith('/api/')) {
      return next();
    }
    res.sendFile(path.join(publicDir, 'index.html'));
  });
}

// Настройка загрузки изображений
const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, uploadsDir),
  filename: (req, file, cb) => {
    const ext = path.extname(file.originalname) || '.png';
    const name = `${Date.now()}-${Math.round(Math.random() * 1e9)}${ext}`;
    cb(null, name);
  }
});
const upload = multer({
  storage,
  fileFilter: (req, file, cb) => {
    const ok = (file.mimetype || '').startsWith('image/');
    cb(ok ? null : new Error('Only image uploads are allowed'), ok);
  },
  limits: { fileSize: 10 * 1024 * 1024 },
});

// --- Auth helpers удалены - авторизация отключена ---

// Создаем таблицу для настроек бота
async function ensureBotSettingsTable() {
  await run(
    `CREATE TABLE IF NOT EXISTS bot_settings (
      id SERIAL PRIMARY KEY,
      bot_token VARCHAR(255),
      chat_id VARCHAR(255),
      enabled INTEGER DEFAULT 1,
      created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )`
  );
  
  // Проверяем, есть ли уже настройки
  const row = await get(`SELECT COUNT(1) as cnt FROM bot_settings`);
  if (!row || !row.cnt) {
    // Вставляем дефолтные настройки (текущий токен из кода)
    await run(
      `INSERT INTO bot_settings (bot_token, chat_id, enabled) VALUES ($1, $2, $3)`,
      ['8220911923:AAHOV3xvBPioSoBh53bPfceJBBkFYk1aqu0', '', 1]
    );
    console.log('Created default bot settings');
  }
}



// Healthcheck

// Admin me endpoint

// Admin filter-settings endpoint
app.get("/api/admin/filter-settings", (req, res) => {
  res.json({});
});
app.get("/api/admin/me", (req, res) => {
  res.json({ username: "admin", id: 1 });
});
app.get('/api/health', (req, res) => {
  res.json({ ok: true });
});

// Backup DB (download) - DISABLED for PostgreSQL
// app.get('/api/_debug/backup' (req, res) => {
//   try {
//     const dbPath = require('./db').DB_FILE;
//     const stamp = new Date().toISOString().replace(/[:.]/g, '-');
//     const dst = path.join(backupsDir, `db-${stamp}.sqlite3`);
//     fs.copyFileSync(dbPath, dst);
//     res.json({ ok: true, file: `/api/_debug/download?f=${encodeURIComponent(path.basename(dst))}` });
//   } catch (e) {
//     res.status(500).json({ error: String(e) });
//   }
// });

app.get('/api/_debug/download', (req, res) => {
  const file = req.query.f;
  if (!file) return res.status(400).send('Missing f');
  const full = path.join(backupsDir, file);
  if (!fs.existsSync(full)) return res.status(404).send('Not found');
  res.download(full);
});

// Upload image (admin only)
app.post('/api/upload/image', upload.single('image'), (req, res) => {
  if (!req.file) return res.status(400).json({ error: 'No file' });
  
  try {
    const fs = require('fs');
    const path = require('path');
    
    // Создаем папку public/img/vehicles если её нет
    const publicVehiclesDir = path.join(__dirname, '..', 'public', 'img', 'vehicles');
    if (!fs.existsSync(publicVehiclesDir)) {
      fs.mkdirSync(publicVehiclesDir, { recursive: true });
    }
    
    // Копируем файл в public/img/vehicles
    const sourcePath = req.file.path;
    const targetPath = path.join(publicVehiclesDir, req.file.filename);
    fs.copyFileSync(sourcePath, targetPath);
    
    // Возвращаем URL для public папки
    const url = `/img/vehicles/${req.file.filename}`;
    res.status(201).json({ url });
  } catch (error) {
    console.error('Error copying image to public folder:', error);
    // Fallback на старый URL
    const url = `/uploads/${req.file.filename}`;
    res.status(201).json({ url });
  }
});

// Brands
app.get('/api/brands', async (req, res) => {
  try {
    const rows = await all(`SELECT id, name FROM brands ORDER BY name ASC`);
    res.json(rows.map(r => r.name));
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch brands' });
  }
});
app.post('/api/brands', async (req, res) => {
  try {
    const { name } = req.body;
    await ensureBrandByName(name);
    res.status(201).json({ ok: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to create brand' });
  }
});
app.delete('/api/brands/:name', async (req, res) => {
  try {
    const { name } = req.params;
    await run( `DELETE FROM brands WHERE name=$1`, [name]);
    res.json({ ok: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to delete brand' });
  }
});

// Categories and subcategories as structure
app.get('/api/categories', async (req, res) => {
  try {
    const cats = await all(`SELECT id, name FROM categories ORDER BY name ASC`);
    const sub = await all(`SELECT id, category_id, name FROM subcategories ORDER BY name ASC`);
    const idToName = new Map(cats.map(c => [c.id, c.name]));
    const result = {};
    for (const c of cats) {
      result[c.name] = [];
    }
    for (const s of sub) {
      const catName = idToName.get(s.category_id);
      if (!catName) continue;
      result[catName].push(s.name);
    }
    res.json(result);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch categories' });
  }
});
// Categories CRUD by name
app.post('/api/categories', async (req, res) => {
  try {
    const { name, subcategories = [] } = req.body;
    const catId = await ensureCategoryByName(name);
    for (const s of subcategories) {
      await ensureSubcategoryByName(catId, s);
    }
    res.status(201).json({ ok: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to create category' });
  }
});
app.put('/api/categories/:name', async (req, res) => {
  try {
    const oldName = req.params.name;
    const { newName } = req.body;
    await run( `UPDATE categories SET name=$1 WHERE name=$2`, [newName, oldName]);
    res.json({ ok: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to rename category' });
  }
});
app.delete('/api/categories/:name', async (req, res) => {
  try {
    const name = req.params.name;
    await run( `DELETE FROM categories WHERE name=$1`, [name]);
    res.json({ ok: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to delete category' });
  }
});
app.put('/api/categories/:name/subcategories', async (req, res) => {
  try {
    const name = req.params.name;
    const { subcategories = [] } = req.body;
    const cat = await get( `SELECT id FROM categories WHERE name=$1`, [name]);
    if (!cat) return res.status(404).json({ error: 'Category not found' });
    await run( `DELETE FROM subcategories WHERE category_id=$1`, [cat.id]);
    for (const s of subcategories) {
      await ensureSubcategoryByName(cat.id, s);
    }
    res.json({ ok: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to set subcategories' });
  }
});

// API для типов местности
app.get('/api/terrain-types', async (req, res) => {
  try {
    const rows = await all(`SELECT id, name FROM terrain_types ORDER BY name ASC`);
    res.json(rows.map(r => r.name));
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch terrain types' });
  }
});

app.post('/api/terrain-types', async (req, res) => {
  try {
    const { name } = req.body;
    if (!name || !name.trim()) {
      return res.status(400).json({ error: 'Terrain type name is required' });
    }
    
    const trimmedName = name.trim();
    await run( `INSERT INTO terrain_types (name) VALUES ($1)`, [trimmedName]);
    res.status(201).json({ ok: true, name: trimmedName });
  } catch (err) {
    if (err.message && err.message.includes('UNIQUE constraint failed')) {
      res.status(409).json({ error: 'Terrain type already exists' });
    } else {
      console.error(err);
      res.status(500).json({ error: 'Failed to create terrain type' });
    }
  }
});

app.delete('/api/terrain-types/:name', async (req, res) => {
  try {
    const name = req.params.name;
    const result = await run( `DELETE FROM terrain_types WHERE name = $1`, [name]);
    
    if (result.changes === 0) {
      return res.status(404).json({ error: 'Terrain type not found' });
    }
    
    res.json({ ok: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to delete terrain type' });
  }
});

// API для типов вездеходов
app.get('/api/vehicle-types', async (req, res) => {
  try {
    const rows = await all(`SELECT id, name FROM vehicle_types ORDER BY name ASC`);
    res.json(rows.map(r => r.name));
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch vehicle types' });
  }
});

app.post('/api/vehicle-types', async (req, res) => {
  try {
    const { name } = req.body;
    if (!name || !name.trim()) {
      return res.status(400).json({ error: 'Vehicle type name is required' });
    }
    
    const trimmedName = name.trim();
    await run( `INSERT INTO vehicle_types (name) VALUES ($1)`, [trimmedName]);
    res.status(201).json({ ok: true, name: trimmedName });
  } catch (err) {
    if (err.message && err.message.includes('UNIQUE constraint failed')) {
      res.status(409).json({ error: 'Vehicle type already exists' });
    } else {
      console.error(err);
      res.status(500).json({ error: 'Failed to create vehicle type' });
    }
  }
});

app.delete('/api/vehicle-types/:name', async (req, res) => {
  try {
    const name = req.params.name;
    const result = await run( `DELETE FROM vehicle_types WHERE name = $1`, [name]);
    
    if (result.changes === 0) {
      return res.status(404).json({ error: 'Vehicle type not found' });
    }
    
    res.json({ ok: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to delete vehicle type' });
  }
});

// Products
app.get('/api/products', async (req, res) => {
  try {
    const rows = await all(
      `SELECT p.*, 
              c.name AS category_name, 
              s.name AS subcategory_name, 
              b.name AS brand_name
       FROM products p
       LEFT JOIN categories c ON p.category_id = c.id
       LEFT JOIN subcategories s ON p.subcategory_id = s.id
       LEFT JOIN brands b ON p.brand_id = b.id
       ORDER BY c.name ASC, s.name ASC, p.title ASC`
    );

    // Добавляем изображения
    const productIds = rows.map(r => r.id);
    console.log('🔍 Загружаем изображения для товаров:', productIds);
    
    let images = [];
    if (productIds.length > 0) {
      images = await all(
        `SELECT * FROM product_images WHERE product_id IN (${productIds.map((_, i) => '$' + (i + 1)).join(',')})`,
        productIds
      );
      console.log('📸 Найдено изображений:', images.length);
    }
    
    const productIdToImages = new Map();
    for (const img of images) {
      if (!productIdToImages.has(img.product_id)) productIdToImages.set(img.product_id, []);
      productIdToImages.get(img.product_id).push({ id: img.id, data: img.image_data, isMain: !!img.is_main });
      console.log(`🖼️ Товар ${img.product_id}: изображение ${img.id}, главное: ${img.is_main}, данные: ${img.image_data.substring(0, 50)}...`);
    }

    const result = rows.map(r => {
      const productImages = productIdToImages.get(r.id) || [];
      console.log(`📦 Товар ${r.id} "${r.title}": ${productImages.length} изображений`);
      if (productImages.length > 0) {
        console.log(`  🖼️ Изображения:`, productImages.map(img => ({ id: img.id, isMain: img.isMain, dataLength: img.data.length })));
      }
      
      return {
        id: r.id,
        title: r.title,
        price: r.price,
        category: r.category_name,
        subcategory: r.subcategory_name,
        brand: r.brand_name,
        available: !!r.available,
        quantity: r.quantity,
        description: r.description,
        specifications: r.specifications_json ? JSON.parse(r.specifications_json) : undefined,
        features: r.features_json ? JSON.parse(r.features_json) : undefined,
        images: productImages,
        createdAt: r.created_at,
        updatedAt: r.updated_at
      };
    });

    res.json(result);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch products' });
  }
});

// Helpers to ensure catalog entities
async function ensureCategoryByName(name) {
  if (!name) return null;
  const row = await get( `SELECT id FROM categories WHERE name = $1`, [name]);
  if (row) return row.id;
  const r = await run( `INSERT INTO categories (name) VALUES ($1)`, [name]);
  return r.lastID;
}

async function ensureSubcategoryByName(categoryId, name) {
  if (!name || !categoryId) return null;
  const row = await get( `SELECT id FROM subcategories WHERE category_id = $1 AND name = $2`, [categoryId, name]);
  if (row) return row.id;
  const r = await run( `INSERT INTO subcategories (category_id, name) VALUES ($1, $2)`, [categoryId, name]);
  return r.lastID;
}

async function ensureBrandByName(name) {
  if (!name) return null;
  const row = await get( `SELECT id FROM brands WHERE name = $1`, [name]);
  if (row) return row.id;
  const r = await run( `INSERT INTO brands (name) VALUES ($1)`, [name]);
  return r.lastID;
}

// Create product
app.post('/api/products', async (req, res) => {
  try {
    const { title, price, category, subcategory, brand, available = true, quantity = 0, description = null, specifications, features, images } = req.body;

    const categoryId = await ensureCategoryByName(category);
    const subcategoryId = await ensureSubcategoryByName(categoryId, subcategory);
    const brandId = await ensureBrandByName(brand);

    const specJson = specifications ? JSON.stringify(specifications) : null;
    const featJson = features ? JSON.stringify(features) : null;

    const r = await run(
      `INSERT INTO products (title, price, category_id, subcategory_id, brand_id, available, quantity, description, specifications_json, features_json)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)`,
      [title, price, categoryId, subcategoryId, brandId, available ? 1 : 0, quantity, description, specJson, featJson]
    );

    const productId = r.lastID;
    if (Array.isArray(images)) {
      for (const img of images) {
        await run( `INSERT INTO product_images (product_id, image_data, is_main) VALUES ($1, $2, $3)`, [productId, img.data, img.isMain ? 1 : 0]);
      }
    }

    res.status(201).json({ id: productId });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to create product' });
  }
});

// Update product
app.put('/api/products/:id', async (req, res) => {
  try {
    const id = Number(req.params.id);
    const { title, price, category, subcategory, brand, available = true, quantity = 0, description = null, specifications, features, images } = req.body;

    const categoryId = await ensureCategoryByName(category);
    const subcategoryId = await ensureSubcategoryByName(categoryId, subcategory);
    const brandId = await ensureBrandByName(brand);

    const specJson = specifications ? JSON.stringify(specifications) : null;
    const featJson = features ? JSON.stringify(features) : null;

    await run(
      `UPDATE products SET title=$1, price=$2, category_id=$3, subcategory_id=$4, brand_id=$5, available=$6, quantity=$7, description=$8, specifications_json=$9, features_json=$10, updated_at = CURRENT_TIMESTAMP WHERE id=$11`,
      [title, price, categoryId, subcategoryId, brandId, available ? 1 : 0, quantity, description, specJson, featJson, id]
    );

    // replace images
    if (Array.isArray(images)) {
      await run( `DELETE FROM product_images WHERE product_id = $1`, [id]);
      for (const img of images) {
        await run( `INSERT INTO product_images (product_id, image_data, is_main) VALUES ($1, $2, $3)`, [id, img.data, img.isMain ? 1 : 0]);
      }
    }

    res.json({ ok: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to update product' });
  }
});

// Delete product
app.delete('/api/products/:id', async (req, res) => {
  try {
    const id = Number(req.params.id);
    await run( `DELETE FROM products WHERE id=$1`, [id]);
    res.json({ ok: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to delete product' });
  }
});

// Promotions
app.get('/api/promotions', async (req, res) => {
  try {
    const rows = await all(
      `SELECT p.*, c.name AS category_name FROM promotions p
       LEFT JOIN categories c ON p.category_id = c.id
       ORDER BY p.featured DESC, p.id DESC`
    );
    const result = rows.map(r => ({
      id: r.id,
      title: r.title,
      description: r.description,
      discount: r.discount,
      category: r.category_name,
      validUntil: r.valid_until,
      active: !!r.active,
      featured: !!r.featured,
      minPurchase: r.min_purchase
    }));
    res.json(result);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch promotions' });
  }
});

// Promotions CRUD (минимум)
app.post('/api/promotions', async (req, res) => {
  try {
    const { title, description, discount, category, validUntil, active = true, featured = false, minPurchase } = req.body;
    const catId = category ? (await get( `SELECT id FROM categories WHERE name = $1`, [category]))?.id : null;
    const r = await run(
      `INSERT INTO promotions (title, description, discount, category_id, valid_until, active, featured, min_purchase)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8)`,
      [title, description ?? null, discount, catId ?? null, validUntil ?? null, active ? 1 : 0, featured ? 1 : 0, minPurchase ?? null]
    );
    res.status(201).json({ id: r.lastID });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to create promotion' });
  }
});

app.put('/api/promotions/:id', async (req, res) => {
  try {
    const id = Number(req.params.id);
    const { title, description, discount, category, validUntil, active, featured, minPurchase } = req.body;
    const catId = category ? (await get( `SELECT id FROM categories WHERE name = $1`, [category]))?.id : null;
    await run(
      `UPDATE promotions SET title=$1, description=$2, discount=$3, category_id=$4, valid_until=$5, active=$6, featured=$7, min_purchase=$8 WHERE id=$9`,
      [title, description ?? null, discount, catId ?? null, validUntil ?? null, active ? 1 : 0, featured ? 1 : 0, minPurchase ?? null, id]
    );
    res.json({ ok: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to update promotion' });
  }
});

app.delete('/api/promotions/:id', async (req, res) => {
  try {
    const id = Number(req.params.id);
    await run( `DELETE FROM promotions WHERE id=$1`, [id]);
    res.json({ ok: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to delete promotion' });
  }
});

// Orders
app.get('/api/orders', async (req, res) => {
  try {
    const orders = await all(`SELECT * FROM orders ORDER BY created_at DESC`);
    const orderIds = orders.map(o => o.id);
    let items = [];
    if (orderIds.length) {
      items = await all(`SELECT * FROM order_items WHERE order_id IN (${orderIds.map((_, i) => `$${i + 1}`).join(',')})`, orderIds);
    }
    const orderIdToItems = new Map();
    for (const it of items) {
      if (!orderIdToItems.has(it.order_id)) orderIdToItems.set(it.order_id, []);
      orderIdToItems.get(it.order_id).push({
        id: it.id,
        productId: it.product_id,
        title: it.title,
        price: it.price,
        quantity: it.quantity
      });
    }

    // notes
    let notes = [];
    if (orderIds.length) {
      notes = await all(`SELECT * FROM order_notes WHERE order_id IN (${orderIds.map((_, i) => `$${i + 1}`).join(',')}) ORDER BY timestamp ASC`, orderIds);
    }
    const orderIdToNotes = new Map();
    for (const n of notes) {
      if (!orderIdToNotes.has(n.order_id)) orderIdToNotes.set(n.order_id, []);
      orderIdToNotes.get(n.order_id).push({
        id: n.id,
        text: n.text,
        type: n.type,
        timestamp: n.timestamp
      });
    }

    const result = [];
    for (const o of orders) {
      const customer = o.customer_id ? await get( `SELECT * FROM customers WHERE id = $1`, [o.customer_id]) : null;
      result.push({
        id: o.id,
        orderNumber: o.order_number,
        status: o.status,
        pricing: JSON.parse(o.pricing_json),
        items: orderIdToItems.get(o.id) || [],
        customerInfo: customer || { name: '', phone: '', email: null, address: null },
        notes: orderIdToNotes.get(o.id) || [],
        createdAt: o.created_at,
        updatedAt: o.updated_at
      });
    }
    res.json(result);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch orders' });
  }
});

app.post('/api/orders', async (req, res) => {
  try {
    const { orderForm, cartItems, priceCalculation, orderNumber } = req.body;

    // customer
    let customerId = null;
    if (orderForm) {
      const r = await run(
        `INSERT INTO customers (name, phone, email, address) VALUES ($1, $2, $3, $4)`,
        [orderForm.name, orderForm.phone, orderForm.email ?? null, orderForm.address ?? null]
      );
      customerId = r.lastID;
    }

    const id = String(orderNumber);
    await run(
      `INSERT INTO orders (id, order_number, customer_id, status, pricing_json) VALUES ($1, $2, $3, 'new', $4)` ,
      [id, String(orderNumber), customerId, JSON.stringify(priceCalculation)]
    );

    if (Array.isArray(cartItems)) {
      for (const it of cartItems) {
        await run(
          `INSERT INTO order_items (order_id, product_id, title, price, quantity) VALUES ($1, $2, $3, $4, $5)`,
          [id, it.id ?? null, it.title, it.price, it.quantity]
        );
      }
    }

    res.status(201).json({ ok: true, id, orderNumber });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to create order' });
  }
});

// Orders: update status
app.patch('/api/orders/:id/status', async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;
    await run( `UPDATE orders SET status=$1, updated_at = CURRENT_TIMESTAMP WHERE id=$2`, [status, id]);
    res.json({ ok: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to update status' });
  }
});

// Orders: add note
app.post('/api/orders/:id/notes', async (req, res) => {
  try {
    const { id } = req.params;
    const { text, type = 'note' } = req.body;
    const r = await run( `INSERT INTO order_notes (order_id, text, type) VALUES ($1, $2, $3)`, [id, text, type]);
    res.status(201).json({ id: r.lastID });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to add note' });
  }
});

// Orders: hard delete (used for cancelled orders cleanup)
app.delete('/api/orders/:id', async (req, res) => {
  try {
    const { id } = req.params;
    // Удаляем связанные записи явно, чтобы не зависеть от PRAGMA foreign_keys
    await run( `DELETE FROM order_items WHERE order_id = $1`, [id]);
    await run( `DELETE FROM order_notes WHERE order_id = $1`, [id]);
    await run( `DELETE FROM orders WHERE id = $1`, [id]);
    res.json({ ok: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to delete order' });
  }
});

// Admin: normalize product IDs to be sequential starting from 1
app.post('/api/_admin/normalize/products', async (req, res) => {
  try {
    await run( 'PRAGMA foreign_keys = OFF');
    await run( 'BEGIN TRANSACTION');

    // Create temp table with same schema as products
    await run(
      `CREATE TABLE IF NOT EXISTS products_tmp (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        price INTEGER NOT NULL,
        category_id INTEGER,
        subcategory_id INTEGER,
        brand_id INTEGER,
        available INTEGER NOT NULL DEFAULT 1,
        quantity INTEGER NOT NULL DEFAULT 0,
        description TEXT,
        specifications_json TEXT,
        features_json TEXT,
        created_at TEXT NOT NULL DEFAULT (CURRENT_TIMESTAMP),
        updated_at TEXT NOT NULL DEFAULT (CURRENT_TIMESTAMP),
        FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL,
        FOREIGN KEY (subcategory_id) REFERENCES subcategories(id) ON DELETE SET NULL,
        FOREIGN KEY (brand_id) REFERENCES brands(id) ON DELETE SET NULL
      )`
    );

    const products = await all(`SELECT * FROM products ORDER BY id ASC`);
    const idMap = new Map();
    for (const p of products) {
      const r = await run(
        `INSERT INTO products_tmp (title, price, category_id, subcategory_id, brand_id, available, quantity, description, specifications_json, features_json, created_at, updated_at)
         VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)`,
        [
          p.title,
          p.price,
          p.category_id,
          p.subcategory_id,
          p.brand_id,
          p.available,
          p.quantity,
          p.description,
          p.specifications_json,
          p.features_json,
          p.created_at,
          p.updated_at,
        ]
      );
      idMap.set(p.id, r.lastID);
    }

    // Update references in product_images
    const imgs = await all(`SELECT id, product_id FROM product_images`);
    for (const img of imgs) {
      const newId = idMap.get(img.product_id);
      if (newId) {
        await run( `UPDATE product_images SET product_id=$1 WHERE id=$2`, [newId, img.id]);
      }
    }

    // Update references in order_items
    const orderItems = await all(`SELECT id, product_id FROM order_items WHERE product_id IS NOT NULL`);
    for (const it of orderItems) {
      const newId = idMap.get(it.product_id);
      if (newId) {
        await run( `UPDATE order_items SET product_id=$1 WHERE id=$2`, [newId, it.id]);
      }
    }

    // Replace products table
    await run( `DROP TABLE products`);
    await run( `ALTER TABLE products_tmp RENAME TO products`);
    await run( 'COMMIT');
    await run( 'PRAGMA foreign_keys = ON');

    res.json({ ok: true, remapped: products.length });
  } catch (err) {
    try { await run( 'ROLLBACK'); } catch {}
    await run( 'PRAGMA foreign_keys = ON');
    console.error(err);
    res.status(500).json({ error: 'Failed to normalize product IDs' });
  }
});

// Advertising API endpoints
app.get('/api/admin/advertising', async (req, res) => {
  try {
    const rows = await all(`SELECT platform, enabled, settings_json FROM advertising_settings ORDER BY platform ASC`);
    const result = {};
    
    for (const row of rows) {
      try {
        result[row.platform] = {
          enabled: Boolean(row.enabled),
          ...JSON.parse(row.settings_json)
        };
      } catch (e) {
        console.error(`Failed to parse settings for ${row.platform}:`, e);
        result[row.platform] = { enabled: Boolean(row.enabled) };
      }
    }
    
    res.json(result);
  } catch (err) {
    console.error('Failed to fetch advertising settings:', err);
    res.status(500).json({ error: 'Failed to fetch advertising settings' });
  }
});

app.post('/api/admin/advertising', async (req, res) => {
  try {
    const { yandexDirect, googleAds, facebookPixel, vkPixel, telegramPixel, customScripts } = req.body;
    
    const platforms = [
      { name: 'yandexDirect', data: yandexDirect },
      { name: 'googleAds', data: googleAds },
      { name: 'facebookPixel', data: facebookPixel },
      { name: 'vkPixel', data: vkPixel },
      { name: 'telegramPixel', data: telegramPixel },
      { name: 'customScripts', data: customScripts }
    ];
    
    for (const platform of platforms) {
      if (platform.data) {
        const { enabled, ...settings } = platform.data;
        const settingsJson = JSON.stringify(settings);
        
        await run(
          `UPDATE advertising_settings SET enabled = $1, settings_json = $2, updated_at = CURRENT_TIMESTAMP WHERE platform = $3`,
          [enabled ? 1 : 0, settingsJson, platform.name]
        );
      }
    }
    
    res.json({ ok: true });
  } catch (err) {
    console.error('Failed to save advertising settings:', err);
    res.status(500).json({ error: 'Failed to save advertising settings' });
  }
});

// Debug endpoint to check database content
app.get('/api/admin/debug/db', async (req, res) => {
  try {
    console.log('🔍 Проверяем содержимое базы данных...');
    
    const categories = await all(`SELECT COUNT(*) as count FROM categories`);
    const subcategories = await all(`SELECT COUNT(*) as count FROM subcategories`);
    const brands = await all(`SELECT COUNT(*) as count FROM brands`);
    const products = await all(`SELECT COUNT(*) as count FROM products`);
    const vehicles = await all(`SELECT COUNT(*) as count FROM vehicles`);
    const promotions = await all(`SELECT COUNT(*) as count FROM promotions`);
    
    console.log('📊 Статистика базы данных:');
    console.log(`- Категории: ${categories[0].count}`);
    console.log(`- Подкатегории: ${subcategories[0].count}`);
    console.log(`- Бренды: ${brands[0].count}`);
    console.log(`- Товары: ${products[0].count}`);
    console.log(`- Вездеходы: ${vehicles[0].count}`);
    console.log(`- Акции: ${promotions[0].count}`);
    
    res.json({
      categories: categories[0].count,
      subcategories: subcategories[0].count,
      brands: brands[0].count,
      products: products[0].count,
      vehicles: vehicles[0].count,
      promotions: promotions[0].count
    });
  } catch (err) {
    console.error('❌ Ошибка проверки базы данных:', err);
    res.status(500).json({ error: 'Failed to check database' });
  }
});

// Public endpoint for getting advertising scripts (for frontend)
app.get('/api/advertising/scripts', async (req, res) => {
  try {
    const rows = await all(`SELECT platform, enabled, settings_json FROM advertising_settings WHERE enabled = true`);
    const scripts = {
      head: [],
      body: []
    };
    
    for (const row of rows) {
      try {
        const settings = JSON.parse(row.settings_json);
        
        switch (row.platform) {
          case 'yandexDirect':
            if (settings.counterId) {
              scripts.head.push(`
<!-- Yandex.Metrika counter -->
<script type="text/javascript" >
   (function(m,e,t,r,i,k,a){m[i]=m[i]||function(){(m[i].a=m[i].a||[]).push(arguments)};
   m[i].l=1*new Date();
   for (var j = 0; j < document.scripts.length; j++) {if (document.scripts[j].src === r) { return; }}
   k=e.createElement(t),a=e.getElementsByTagName(t)[0],k.async=1,k.src=r,a.parentNode.insertBefore(k,a)})
   (window, document, "script", "https://mc.yandex.ru/metrika/tag.js", "ym");

   ym(${settings.counterId}, "init", {
        clickmap:true,
        trackLinks:true,
        accurateTrackBounce:true
   });
</script>
<noscript><div><img src="https://mc.yandex.ru/watch/${settings.counterId}" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
<!-- /Yandex.Metrika counter -->`);
            }
            if (settings.remarketingCode) {
              scripts.head.push(settings.remarketingCode);
            }
            break;
            
          case 'googleAds':
            if (settings.gtagCode) {
              scripts.head.push(`
<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=${settings.gtagCode}"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', '${settings.gtagCode}');
</script>`);
            }
            if (settings.conversionId && settings.conversionLabel) {
              scripts.head.push(`
<!-- Google Ads Conversion Tracking -->
<script>
  gtag('event', 'conversion', {
    'send_to': '${settings.conversionId}/${settings.conversionLabel}'
  });
</script>`);
            }
            break;
            
          case 'facebookPixel':
            if (settings.pixelId) {
              scripts.head.push(`
<!-- Facebook Pixel Code -->
<script>
!function(f,b,e,v,n,t,s)
{if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};
if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];
s.parentNode.insertBefore(t,s)}(window, document,'script',
'https://connect.facebook.net/en_US/fbevents.js');
fbq('init', '${settings.pixelId}');
fbq('track', 'PageView');
</script>
<noscript><img height="1" width="1" style="display:none"
src="https://www.facebook.com/tr?id=${settings.pixelId}&ev=PageView&noscript=1"
/></noscript>
<!-- End Facebook Pixel Code -->`);
            }
            break;
            
          case 'vkPixel':
            if (settings.pixelId) {
              scripts.head.push(`
<!-- VK Pixel Code -->
<script>
!function(){var t=document.createElement("script");t.type="text/javascript",t.async=!0,t.src="https://vk.com/js/api/openapi.js?169";var e=document.getElementsByTagName("script")[0];e.parentNode.insertBefore(t,e)}();
window.vkAsyncInit=function(){VK.init({apiId:${settings.pixelId}});};
</script>`);
            }
            if (settings.conversionCode) {
              scripts.head.push(settings.conversionCode);
            }
            break;
            
          case 'telegramPixel':
            if (settings.botToken && settings.chatId) {
              scripts.head.push(`
<!-- Telegram Pixel Code -->
<script>
window.telegramPixel = {
  botToken: '${settings.botToken}',
  chatId: '${settings.chatId}'
};
</script>`);
            }
            break;
            
          case 'customScripts':
            if (settings.headScripts) {
              scripts.head.push(settings.headScripts);
            }
            if (settings.bodyScripts) {
              scripts.body.push(settings.bodyScripts);
            }
            break;
        }
      } catch (e) {
        console.error(`Failed to parse settings for ${row.platform}:`, e);
      }
    }
    
    res.json(scripts);
  } catch (err) {
    console.error('Failed to fetch advertising scripts:', err);
    res.status(500).json({ error: 'Failed to fetch advertising scripts' });
  }
});

// Vehicles API endpoints
console.log('Loading vehicles API endpoints...');
app.get('/api/vehicles', async (req, res) => {
  try {
    const rows = await all(
      `SELECT v.*, vt.name AS vehicle_type_name, tt.name AS terrain_type_name
       FROM vehicles v
       LEFT JOIN vehicle_types vt ON v.type = vt.name
       LEFT JOIN terrain_types tt ON v.terrain = tt.name
       ORDER BY v.name ASC`
    );
    
    const result = rows.map(r => ({
      id: r.id,
      name: r.name,
      type: r.type,
      terrain: r.terrain,
      price: r.price,
      image: r.image,
      description: r.description,
      specs: r.specs_json ? JSON.parse(r.specs_json) : {},
      available: !!r.available,
      quantity: r.quantity,
      createdAt: r.created_at,
      updatedAt: r.updated_at
    }));
    
    res.json(result);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch vehicles' });
  }
});

app.post('/api/vehicles', async (req, res) => {
  try {
    const { name, type, terrain, price, image, description, specs, available = true, quantity = 0 } = req.body;
    
    const specsJson = specs ? JSON.stringify(specs) : null;
    
    const r = await run(
      `INSERT INTO vehicles (name, type, terrain, price, image, description, specs_json, available, quantity)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)`,
      [name, type, terrain, price, image, description, specsJson, available ? 1 : 0, quantity]
    );
    
    res.status(201).json({ id: r.lastID });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to create vehicle' });
  }
});

app.put('/api/vehicles/:id', async (req, res) => {
  try {
    const id = Number(req.params.id);
    const { name, type, terrain, price, image, description, specs, available = true, quantity = 0 } = req.body;
    
    const specsJson = specs ? JSON.stringify(specs) : null;
    
    await run(
      `UPDATE vehicles SET name=$1, type=$2, terrain=$3, price=$4, image=$5, description=$6, specs_json=$7, available=$8, quantity=$9, updated_at = CURRENT_TIMESTAMP WHERE id=$10`,
      [name, type, terrain, price, image, description, specsJson, available ? 1 : 0, quantity, id]
    );
    
    res.json({ ok: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to update vehicle' });
  }
});

app.delete('/api/vehicles/:id', async (req, res) => {
  try {
    const id = Number(req.params.id);
    await run( `DELETE FROM vehicles WHERE id=$1`, [id]);
    res.json({ ok: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to delete vehicle' });
  }
});

// Site content API endpoints
app.get('/api/content', async (req, res) => {
  try {
    const rows = await all(`SELECT content_key, content_data FROM site_content ORDER BY content_key ASC`);
    const result = {};
    
    for (const row of rows) {
      try {
        result[row.content_key] = JSON.parse(row.content_data);
      } catch (e) {
        console.error(`Failed to parse content for key ${row.content_key}:`, e);
        result[row.content_key] = {};
      }
    }
    
    res.json(result);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch content' });
  }
});

app.get('/api/content/:key', async (req, res) => {
  try {
    const { key } = req.params;
    const row = await get( `SELECT content_data FROM site_content WHERE content_key = $1`, [key]);
    
    if (!row) {
      return res.status(404).json({ error: 'Content not found' });
    }
    
    try {
      const content = JSON.parse(row.content_data);
      res.json(content);
    } catch (e) {
      console.error(`Failed to parse content for key ${key}:`, e);
      res.status(500).json({ error: 'Failed to parse content' });
    }
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch content' });
  }
});

app.post('/api/content', async (req, res) => {
  try {
    const { key, data } = req.body;
    
    if (!key || !data) {
      return res.status(400).json({ error: 'Key and data are required' });
    }
    
    const contentData = JSON.stringify(data);
    
    await run(
      `INSERT INTO site_content (content_key, content_data, updated_at) VALUES ($1, $2, CURRENT_TIMESTAMP)`,
      [key, contentData]
    );
    
    res.status(201).json({ ok: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to save content' });
  }
});

app.put('/api/content/:key', async (req, res) => {
  try {
    const { key } = req.params;
    const { data } = req.body;
    
    if (!data) {
      return res.status(400).json({ error: 'Data is required' });
    }
    
    const contentData = JSON.stringify(data);
    
    const result = await run(
      `UPDATE site_content SET content_data = $1, updated_at = CURRENT_TIMESTAMP WHERE content_key = $2`,
      [contentData, key]
    );
    
    if (result.changes === 0) {
      return res.status(404).json({ error: 'Content not found' });
    }
    
    res.json({ ok: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to update content' });
  }
});

app.delete('/api/content/:key', async (req, res) => {
  try {
    const { key } = req.params;
    const result = await run( `DELETE FROM site_content WHERE content_key = $1`, [key]);
    
    if (result.changes === 0) {
      return res.status(404).json({ error: 'Content not found' });
    }
    
    res.json({ ok: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to delete content' });
  }
});

// Промокоды API
app.get('/api/promocodes', async (req, res) => {
  try {
    const promocodes = await all(`SELECT * FROM promocodes ORDER BY created_at DESC`);
    res.json(promocodes);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch promocodes' });
  }
});

app.post('/api/promocodes', async (req, res) => {
  try {
    const { code, description, discount_type, discount_value, min_purchase, max_uses, valid_from, valid_until, active } = req.body;
    
    const result = await run( `
      INSERT INTO promocodes (code, description, discount_type, discount_value, min_purchase, max_uses, valid_from, valid_until, active)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
    `, [code, description, discount_type || 'percentage', discount_value, min_purchase || 0, max_uses, valid_from, valid_until, active !== undefined ? active : 1]);
    
    const newPromocode = await get( `SELECT * FROM promocodes WHERE id = $1`, [result.lastID]);
    res.status(201).json(newPromocode);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to create promocode' });
  }
});

app.put('/api/promocodes/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { code, description, discount_type, discount_value, min_purchase, max_uses, valid_from, valid_until, active } = req.body;
    
    const result = await run( `
      UPDATE promocodes 
      SET code = $1, description = $2, discount_type = $3, discount_value = $4, min_purchase = $5, max_uses = $6, valid_from = $7, valid_until = $8, active = $9, updated_at = CURRENT_TIMESTAMP
      WHERE id = $10
    `, [code, description, discount_type, discount_value, min_purchase, max_uses, valid_from, valid_until, active, id]);
    
    if (result.changes === 0) {
      return res.status(404).json({ error: 'Promocode not found' });
    }
    
    const updatedPromocode = await get( `SELECT * FROM promocodes WHERE id = $1`, [id]);
    res.json(updatedPromocode);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to update promocode' });
  }
});

app.delete('/api/promocodes/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const result = await run( `DELETE FROM promocodes WHERE id = $1`, [id]);
    
    if (result.changes === 0) {
      return res.status(404).json({ error: 'Promocode not found' });
    }
    
    res.json({ ok: true });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to delete promocode' });
  }
});

app.post('/api/promocodes/:id/toggle', async (req, res) => {
  try {
    const { id } = req.params;
    const result = await run( `UPDATE promocodes SET active = NOT active, updated_at = CURRENT_TIMESTAMP WHERE id = $1`, [id]);
    
    if (result.changes === 0) {
      return res.status(404).json({ error: 'Promocode not found' });
    }
    
    const updatedPromocode = await get( `SELECT * FROM promocodes WHERE id = $1`, [id]);
    res.json(updatedPromocode);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to toggle promocode' });
  }
});

// Test endpoint to check if server is working
app.get('/api/test', (req, res) => {
  res.json({ 
    message: 'Сервер работает!', 
    timestamp: new Date().toISOString(),

  });
});

// Bot management endpoints
app.get('/api/admin/bot', async (req, res) => {
  try {
    const settings = await get( `SELECT bot_token, chat_id, enabled FROM bot_settings ORDER BY id DESC LIMIT 1`);
    if (!settings) {
      return res.json({ bot_token: '', chat_id: '', enabled: false });
    }
    res.json({
      bot_token: settings.bot_token || '',
      chat_id: settings.chat_id || '',
      enabled: Boolean(settings.enabled)
    });
  } catch (err) {
    console.error('Failed to fetch bot settings:', err);
    res.status(500).json({ error: 'Failed to fetch bot settings' });
  }
});

app.post('/api/admin/bot', async (req, res) => {
  try {
    const { bot_token, enabled } = req.body;
    
    // Проверяем, есть ли уже настройки
    const existing = await get( `SELECT id, chat_id FROM bot_settings ORDER BY id DESC LIMIT 1`);
    
    if (existing) {
      // Обновляем существующие настройки, сохраняя текущий chat_id
      await run(
        `UPDATE bot_settings SET bot_token = $1, enabled = $2, updated_at = CURRENT_TIMESTAMP WHERE id = $3`,
        [bot_token, enabled ? 1 : 0, existing.id]
      );
    } else {
      // Создаем новые настройки с пустым chat_id
      await run(
        `INSERT INTO bot_settings (bot_token, chat_id, enabled) VALUES ($1, $2, $3)`,
        [bot_token, '', enabled ? 1 : 0]
      );
    }
    
    res.json({ ok: true });
  } catch (err) {
    console.error('Failed to save bot settings:', err);
    res.status(500).json({ error: 'Failed to save bot settings' });
  }
});

// Test bot connection
app.post('/api/admin/bot/test', async (req, res) => {
  try {
    const { bot_token } = req.body;
    
    if (!bot_token) {
      return res.status(400).json({ error: 'Bot token обязателен для тестирования' });
    }
    
    // Получаем настройки бота из базы данных
    const botSettings = await get( `SELECT chat_id FROM bot_settings ORDER BY id DESC LIMIT 1`);
    
    if (!botSettings || !botSettings.chat_id) {
      return res.status(400).json({ error: 'Chat ID не настроен. Сначала настройте бота через админку.' });
    }
    
    const testMessage = `🧪 <b>Тестовое сообщение</b>\n\nЭто тестовое сообщение для проверки настроек бота.\n\n📅 Время: ${new Date().toLocaleString('ru-RU')}\n✅ Бот работает корректно!`;
    
    const response = await fetch(`https://api.telegram.org/bot${bot_token}/sendMessage`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        chat_id: botSettings.chat_id,
        text: testMessage,
        parse_mode: 'HTML'
      }),
    });
    
    const data = await response.json();
    
    if (data.ok) {
      res.json({ success: true, message: 'Тестовое сообщение успешно отправлено!' });
    } else {
      res.json({ success: false, error: data.description || 'Ошибка отправки сообщения' });
    }
  } catch (err) {
    console.error('Failed to test bot:', err);
    res.status(500).json({ error: 'Failed to test bot connection' });
  }
});

// Удален дублирующийся endpoint /api/orders - используется только защищенный версия выше

// Popular products API endpoints
app.get('/api/admin/popular-products', async (req, res) => {
  try {
    const rows = await all(`
      SELECT pp.*, p.title, p.price, p.category_id, p.brand_id, p.available, p.quantity
      FROM popular_products pp
      LEFT JOIN products p ON pp.product_id = p.id
      ORDER BY pp.sort_order ASC
    `);
    
    const popularProducts = rows.map(row => ({
      id: row.product_id,
      title: row.title,
      price: row.price,
      category: row.category,
      brand: row.brand,
      available: Boolean(row.available),
      quantity: row.quantity,
      sortOrder: row.sort_order
    }));
    
    res.json(popularProducts);
  } catch (err) {
    console.error('Failed to fetch popular products:', err);
    res.status(500).json({ error: 'Failed to fetch popular products' });
  }
});

app.post('/api/admin/popular-products', async (req, res) => {
  try {
    const { productIds } = req.body;
    
    if (!Array.isArray(productIds)) {
      return res.status(400).json({ error: 'productIds must be an array' });
    }
    
    // Удаляем все существующие популярные товары
    await run( `DELETE FROM popular_products`);
    
    // Добавляем новые популярные товары с порядком сортировки
    for (let i = 0; i < productIds.length; i++) {
      const productId = productIds[i];
      await run( `
        INSERT INTO popular_products (product_id, sort_order) 
        VALUES ($1, $2)
      `, [productId, i]);
    }
    
    res.json({ ok: true });
  } catch (err) {
    console.error('Failed to update popular products:', err);
    res.status(500).json({ error: 'Failed to update popular products' });
  }
});

// Filter settings API endpoints
app.get('/api/admin/filter-settings', async (req, res) => {
  try {
    const rows = await all(`SELECT key, setting_value FROM filter_settings`);
    
    const settings = {};
    rows.forEach(row => {
      settings[row.key] = Boolean(row.setting_value);
    });
    
    res.json(settings);
  } catch (err) {
    console.error('Failed to fetch filter settings:', err);
    res.status(500).json({ error: 'Failed to fetch filter settings' });
  }
});

app.post('/api/admin/filter-settings', async (req, res) => {
  try {
    const settings = req.body;
    
    for (const [key, value] of Object.entries(settings)) {
      await run( `
        UPDATE filter_settings 
        SET setting_value = $1, updated_at = CURRENT_TIMESTAMP 
        WHERE key = $2
      `, [value ? 1 : 0, key]);
    }
    
    res.json({ ok: true });
  } catch (err) {
    console.error('Failed to update filter settings:', err);
    res.status(500).json({ error: 'Failed to update filter settings' });
  }
});

// Debug: list registered routes (admin only)
app.get('/api/_debug/routes', (req, res) => {
  try {
    const routes = [];
    app._router.stack.forEach((m) => {
      if (m.route && m.route.path) {
        routes.push({ path: m.route.path, methods: m.route.methods });
      }
      if (m.name === 'router' && m.handle && m.handle.stack) {
        m.handle.stack.forEach((h) => {
          if (h.route && h.route.path) {
            routes.push({ path: h.route.path, methods: h.route.methods });
          }
        });
      }
    });
    res.json(routes);
  } catch (e) {
    res.status(500).json({ error: String(e) });
  }
});





// Test import endpoint - импортируем только одну строку для отладки






console.log('Starting server initialization...');
Promise.all([
  ensureBotSettingsTable()
])
  .then(() => {
    console.log('Tables initialized successfully');
    app.listen(PORT, () => {
      console.log(`API server listening on http://localhost:${PORT}`);
      console.log(`Database type: ${dbType}`);
    });
  })
  .catch((e) => {
    console.error('Failed to initialize tables', e);
    process.exit(1);
  });

