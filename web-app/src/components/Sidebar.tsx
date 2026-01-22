'use client';

import React from 'react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { 
  Users, 
  Wallet, 
  LayoutDashboard, 
  Smartphone, 
  CreditCard, 
  Settings
} from 'lucide-react';

export default function Sidebar() {
  const pathname = usePathname();

  const isActive = (path: string) => {
    if (path === '/' && pathname === '/') return true;
    if (path !== '/' && pathname.startsWith(path)) return true;
    return false;
  };

  return (
    <aside className="w-64 bg-white border-r border-gray-200 text-gray-900 hidden md:flex flex-col h-screen sticky top-0 transition-colors duration-300">
      <div className="p-6">
        <h1 className="text-2xl font-bold tracking-wider text-[#1D6A4A]">BILLY</h1>
      </div>
      <nav className="flex-1 px-4 space-y-2">
        <SidebarItem 
          href="/" 
          icon={<LayoutDashboard size={20} />} 
          label="Dashboard" 
          active={isActive('/')} 
        />
        <SidebarItem 
          href="/transactions" 
          icon={<Wallet size={20} />} 
          label="Transactions" 
          active={isActive('/transactions')} 
        />
        <SidebarItem 
          href="/services" 
          icon={<Smartphone size={20} />} 
          label="Services" 
          active={isActive('/services')} 
        />
        <SidebarItem 
          href="/cards" 
          icon={<CreditCard size={20} />} 
          label="Cards" 
          active={isActive('/cards')} 
        />
        <SidebarItem 
          href="/beneficiaries" 
          icon={<Users size={20} />} 
          label="Beneficiaries" 
          active={isActive('/beneficiaries')} 
        />
        <SidebarItem 
          href="/account" 
          icon={<Settings size={20} />} 
          label="Account settings" 
          active={isActive('/account')} 
        />
      </nav>
      <div className="p-6">
        <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
          <div className="w-8 h-8 rounded-full bg-gray-200 flex items-center justify-center text-gray-700">
            <span className="font-bold text-xs">JD</span>
          </div>
          <div>
            <p className="text-sm font-medium">John Doe</p>
            <p className="text-xs text-gray-500">Tier 1 Account</p>
          </div>
        </div>
      </div>
    </aside>
  );
}

function SidebarItem({ icon, label, href, active = false }: { icon: React.ReactNode, label: string, href: string, active?: boolean }) {
  return (
    <Link 
      href={href} 
      className={`w-full flex items-center gap-3 px-4 py-3 rounded-lg transition-colors ${
        active 
          ? 'bg-[#1D6A4A] text-white font-semibold' 
          : 'text-gray-600 hover:bg-gray-100'
      }`}
    >
      {icon}
      <span>{label}</span>
    </Link>
  );
}
