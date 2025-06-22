import { Outlet } from 'react-router-dom';
import Navbar from './Navbar';
import Sidebar from './Sidebar';

const Layout = () => {
  return (
    <div className="flex h-screen bg-gray-50">
      <Sidebar />
      <div className="flex flex-col flex-1 overflow-hidden">
        <Navbar />
        <main className="flex-1 overflow-y-auto p-4 md:p-6">
          <Outlet />
        </main>
        <footer className="bg-white p-4 border-t text-center text-sm text-gray-500">
          <p>© {new Date().getFullYear()} SSHR Platform - HIPAA Compliant</p>
        </footer>
      </div>
    </div>
  );
};

export default Layout;
