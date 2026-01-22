'use client';

import React from 'react';
import { 
  LayoutDashboard, 
  LayoutGrid, 
  PlusCircle, 
  FileText, 
  User 
} from 'lucide-react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';

export default function MobileNav({ onFundClick }: { onFundClick?: () => void }) {
  const pathname = usePathname();
  
  const isActive = (path: string) => {
    if (path === '/' && pathname === '/') return true;
    if (path !== '/' && pathname.startsWith(path)) return true;
    return false;
  };

  return (
    <div className="md:hidden fixed bottom-0 left-0 right-0 bg-white border-t px-4 py-2 flex justify-between items-center z-50">
      <MobileNavItem href="/" icon={<LayoutDashboard size={20} />} label="Home" active={isActive('/')} />
      <MobileNavItem href="/services" icon={<LayoutGrid size={20} />} label="Services" active={isActive('/services')} />
      <MobileNavItem 
        href="/fund" 
        icon={<PlusCircle size={24} />} 
        label="Fund" 
        primary 
        onClick={(e) => {
          if (onFundClick) {
            e.preventDefault();
            onFundClick();
          }
        }}
      />
      <MobileNavItem href="/orders" icon={<FileText size={20} />} label="My Orders" active={isActive('/orders')} />
      <MobileNavItem href="/account" icon={<User size={20} />} label="Account" active={isActive('/account')} />
    </div>
  );
}

function MobileNavItem({ 
  icon, 
  label, 
  href, 
  active = false, 
  primary = false,
  onClick
}: { 
  icon: React.ReactNode, 
  label: String, 
  href: string,
  active?: boolean, 
  primary?: boolean,
  onClick?: (e: React.MouseEvent) => void
}) {
  if (primary) {
    return (
      <Link href={href} onClick={onClick} className="flex flex-col items-center gap-1 -mt-8">
        <div className="w-12 h-12 bg-[#1D6A4A] rounded-full flex items-center justify-center text-white shadow-lg">
          {icon}
        </div>
        <span className="text-[10px] font-medium text-[#1D6A4A]">{label}</span>
      </Link>
    );
  }
  return (
    <Link href={href} onClick={onClick} className={`flex flex-col items-center gap-1 ${active ? 'text-[#1D6A4A]' : 'text-gray-400'}`}>
      {icon}
      <span className="text-[10px] font-medium">{label}</span>
    </Link>
  );
}
