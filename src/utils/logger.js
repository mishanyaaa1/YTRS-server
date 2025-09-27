// Система логирования для отладки на мобильных устройствах
class Logger {
  constructor() {
    this.logs = [];
    this.maxLogs = 1000; // Максимум логов в памяти
    this.isVisible = false;
    this.init();
  }

  init() {
    // Перехватываем console.log, console.error, console.warn
    const originalLog = console.log;
    const originalError = console.error;
    const originalWarn = console.warn;

    console.log = (...args) => {
      this.addLog('LOG', ...args);
      originalLog.apply(console, args);
    };

    console.error = (...args) => {
      this.addLog('ERROR', ...args);
      originalError.apply(console, args);
    };

    console.warn = (...args) => {
      this.addLog('WARN', ...args);
      originalWarn.apply(console, args);
    };

    // Перехватываем fetch для логирования API запросов
    const originalFetch = window.fetch;
    window.fetch = async (...args) => {
      const url = args[0];
      const options = args[1] || {};
      
      this.addLog('FETCH', `→ ${options.method || 'GET'} ${url}`);
      
      try {
        const response = await originalFetch.apply(window, args);
        this.addLog('FETCH', `← ${response.status} ${response.statusText} ${url}`);
        return response;
      } catch (error) {
        this.addLog('FETCH', `✗ ERROR ${url}: ${error.message}`);
        throw error;
      }
    };
  }

  addLog(level, ...args) {
    const timestamp = new Date().toISOString();
    const message = args.map(arg => 
      typeof arg === 'object' ? JSON.stringify(arg, null, 2) : String(arg)
    ).join(' ');
    
    this.logs.push({
      timestamp,
      level,
      message
    });

    // Ограничиваем количество логов
    if (this.logs.length > this.maxLogs) {
      this.logs = this.logs.slice(-this.maxLogs);
    }

    // Обновляем UI если он видим
    if (this.isVisible) {
      this.updateUI();
    }
  }

  show() {
    this.isVisible = true;
    this.createUI();
  }

  hide() {
    this.isVisible = false;
    this.removeUI();
  }

  createUI() {
    if (document.getElementById('debug-logger')) return;

    const container = document.createElement('div');
    container.id = 'debug-logger';
    container.style.cssText = `
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0, 0, 0, 0.9);
      z-index: 10000;
      font-family: 'Courier New', monospace;
      font-size: 12px;
      color: #fff;
      overflow: hidden;
      display: flex;
      flex-direction: column;
    `;

    const header = document.createElement('div');
    header.style.cssText = `
      background: #333;
      padding: 10px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-bottom: 1px solid #555;
    `;

    const title = document.createElement('h3');
    title.textContent = 'Debug Logger';
    title.style.margin = '0';
    title.style.color = '#fff';

    const controls = document.createElement('div');
    controls.style.cssText = 'display: flex; gap: 10px;';

    const clearBtn = document.createElement('button');
    clearBtn.textContent = 'Clear';
    clearBtn.style.cssText = `
      background: #ff4444;
      color: white;
      border: none;
      padding: 5px 10px;
      border-radius: 3px;
      cursor: pointer;
    `;
    clearBtn.onclick = () => this.clear();

    const copyBtn = document.createElement('button');
    copyBtn.textContent = 'Copy All';
    copyBtn.style.cssText = `
      background: #4444ff;
      color: white;
      border: none;
      padding: 5px 10px;
      border-radius: 3px;
      cursor: pointer;
    `;
    copyBtn.onclick = () => this.copyAll();

    const closeBtn = document.createElement('button');
    closeBtn.textContent = 'Close';
    closeBtn.style.cssText = `
      background: #666;
      color: white;
      border: none;
      padding: 5px 10px;
      border-radius: 3px;
      cursor: pointer;
    `;
    closeBtn.onclick = () => this.hide();

    controls.appendChild(clearBtn);
    controls.appendChild(copyBtn);
    controls.appendChild(closeBtn);

    header.appendChild(title);
    header.appendChild(controls);

    const logContainer = document.createElement('div');
    logContainer.id = 'debug-log-content';
    logContainer.style.cssText = `
      flex: 1;
      overflow-y: auto;
      padding: 10px;
      background: #000;
    `;

    container.appendChild(header);
    container.appendChild(logContainer);
    document.body.appendChild(container);

    this.updateUI();
  }

  updateUI() {
    const container = document.getElementById('debug-log-content');
    if (!container) return;

    container.innerHTML = this.logs.map(log => {
      const levelColor = {
        'LOG': '#00ff00',
        'ERROR': '#ff0000',
        'WARN': '#ffff00',
        'FETCH': '#00ffff'
      }[log.level] || '#ffffff';

      return `
        <div style="margin-bottom: 5px; border-left: 3px solid ${levelColor}; padding-left: 10px;">
          <div style="color: #888; font-size: 10px;">${log.timestamp}</div>
          <div style="color: ${levelColor}; font-weight: bold;">[${log.level}]</div>
          <div style="color: #fff; white-space: pre-wrap; word-break: break-all;">${log.message}</div>
        </div>
      `;
    }).join('');

    // Прокручиваем вниз
    container.scrollTop = container.scrollHeight;
  }

  removeUI() {
    const container = document.getElementById('debug-logger');
    if (container) {
      container.remove();
    }
  }

  clear() {
    this.logs = [];
    this.updateUI();
  }

  copyAll() {
    const text = this.logs.map(log => 
      `[${log.timestamp}] [${log.level}] ${log.message}`
    ).join('\n');
    
    navigator.clipboard.writeText(text).then(() => {
      alert('Логи скопированы в буфер обмена!');
    }).catch(() => {
      // Fallback для старых браузеров
      const textarea = document.createElement('textarea');
      textarea.value = text;
      document.body.appendChild(textarea);
      textarea.select();
      document.execCommand('copy');
      document.body.removeChild(textarea);
      alert('Логи скопированы в буфер обмена!');
    });
  }

  getLogs() {
    return this.logs;
  }
}

// Создаем глобальный экземпляр
const logger = new Logger();

// Добавляем в window для доступа из консоли
window.debugLogger = logger;

export default logger;
