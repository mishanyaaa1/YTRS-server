import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    host: true,
    port: 5174,
    strictPort: true,
    proxy: {
      '/api': {
        target: 'http://83.166.247.112:3001',
        changeOrigin: true,
        ws: false
      },
      '/uploads': {
        target: 'http://83.166.247.112:3001',
        changeOrigin: true
      }
    }
  }
})
