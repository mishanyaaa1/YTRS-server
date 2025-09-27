import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { createBrowserRouter, RouterProvider } from 'react-router-dom'
import { IconContext } from 'react-icons'
import './index.css'
import './global-input-styles.css'
import App from './App.jsx'
import Home from './pages/Home.jsx'
import CatalogPage from './pages/CatalogPage.jsx'
import ProductPage from './pages/ProductPage.jsx'
import Cart from './pages/Cart.jsx'
// Removed CartTest page
import About from './pages/About.jsx'
import Promotions from './pages/Promotions.jsx'
import VehiclesPage from './pages/VehiclesPage.jsx'
import VehicleDetailPage from './pages/VehicleDetailPage.jsx'
import SimpleAdminDashboard from './pages/admin/SimpleAdminDashboard.jsx'
import AdvancedAdminDashboard from './pages/admin/AdvancedAdminDashboard.jsx'
import { CartProvider } from './context/CartContext.jsx'
import { AdminDataProvider } from './context/AdminDataContext.jsx'
// Removed WishlistProvider
import { OrdersProvider } from './context/OrdersContext.jsx'

const router = createBrowserRouter([
  {
    path: "/",
    element: (
      <AdminDataProvider>
        <App />
      </AdminDataProvider>
    ),
    children: [
      {
        index: true,
        element: <Home />
      },
      {
        path: "catalog",
        element: <CatalogPage />
      },
      {
        path: "product/:id",
        element: <ProductPage />
      },
      {
        path: "cart",
        element: <Cart />
      },
      // Removed cart-test route
      // Removed wishlist route
      {
        path: "about",
        element: <About />
      },
      {
        path: "promotions",
        element: <Promotions />
      },
      {
        path: "vehicles",
        element: <VehiclesPage />
      },
      {
        path: "vehicle/:id",
        element: <VehicleDetailPage />
      }
    ]
  },
  {
    path: "/admin",
    element: (
      <AdminDataProvider>
        <SimpleAdminDashboard />
      </AdminDataProvider>
    )
  },
  {
    path: "/admin/dashboard",
    element: (
      <AdminDataProvider>
        <SimpleAdminDashboard />
      </AdminDataProvider>
    )
  },
  {
    path: "/admin/advanced",
    element: (
      <AdminDataProvider>
        <AdvancedAdminDashboard />
      </AdminDataProvider>
    )
  }
]);

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <OrdersProvider>
      <CartProvider>
        <IconContext.Provider value={{ color: '#e6a34a' }}>
          <RouterProvider router={router} />
        </IconContext.Provider>
      </CartProvider>
    </OrdersProvider>
  </StrictMode>,
)
