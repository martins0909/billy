'use client';

import React from 'react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import {
  Home,
  Settings,
  Wallet,
  ClipboardList,
  User,
  CreditCard,
  Users,
  Gift,
  ArrowRight,
  ShieldCheck,
} from 'lucide-react';

export default function Sidebar() {
  const pathname = usePathname();

  const isActive = (path: string) => {
    if (path === '/') return pathname === '/';
    return pathname.startsWith(path);
  };

  return (
    <aside className="w-64 hidden md:flex flex-col h-screen sticky top-0 shrink-0 text-gray-900 border-r border-primary/20 bg-gradient-to-b from-[#12062b] via-[#0b0418] to-[#07030f]">
      {/* Brand */}
      <div className="pt-8 pb-6 px-6 flex flex-col items-center">
        <img src="/billylogo.png" alt="BILLY" className="h-14 w-auto object-contain drop-shadow-[0_0_14px_rgba(138,43,255,0.6)]" />
        <p className="mt-2 text-[11px] text-gray-500 tracking-wide">Secure &bull; Fast &bull; Reliable</p>
      </div>

      {/* Navigation */}
      <nav className="px-4 space-y-2">
        <SidebarItem href="/" icon={<Home size={20} />} label="Home" active={isActive('/')} />
        <SidebarItem href="/services" icon={<Settings size={20} />} label="Services" active={isActive('/services')} />
        <SidebarItem href="/transactions" icon={<Wallet size={20} />} label="Wallet" active={isActive('/transactions')} />
        <SidebarItem href="/orders" icon={<ClipboardList size={20} />} label="My Orders" active={isActive('/orders')} />
        <SidebarItem href="/account" icon={<User size={20} />} label="Account" active={isActive('/account')} />

        <div className="my-3 mx-3 h-px bg-primary/20" />

        <SidebarItem href="/cards" icon={<CreditCard size={20} />} label="Cards" active={isActive('/cards')} />
        <SidebarItem href="/beneficiaries" icon={<Users size={20} />} label="Beneficiaries" active={isActive('/beneficiaries')} />
      </nav>

      <div className="flex-1" />

      {/* Refer & Earn */}
      <div className="px-4 pb-4">
        <div className="glass-card rounded-2xl p-4 text-center">
          <div className="mx-auto mb-2 w-16 h-16 rounded-2xl bg-brand-gradient flex items-center justify-center shadow-glow-sm">
            <Gift size={34} className="text-amber-300" />
          </div>
          <p className="text-lg font-bold text-white">Refer &amp; Earn</p>
          <p className="text-xs text-gray-500 mt-1 leading-snug">Get rewarded for referring friends.</p>
          <button className="mt-3 inline-flex items-center gap-2 btn-brand text-white text-sm font-semibold px-5 py-2 rounded-full">
            Learn More <ArrowRight size={14} />
          </button>
        </div>
      </div>

      {/* Footer */}
      <div className="px-6 pb-6 flex items-center gap-3 text-[11px] text-gray-500 leading-tight">
        <ShieldCheck size={26} className="text-primary shrink-0" />
        <span>&copy; 2026 BILLY<br />All rights reserved.</span>
      </div>
    </aside>
  );
}

function SidebarItem({ icon, label, href, active = false }: { icon: React.ReactNode, label: string, href: string, active?: boolean }) {
  return (
    <Link
      href={href}
      className={`w-full flex items-center gap-3 px-4 py-3 rounded-xl transition-all ${
        active
          ? 'btn-brand text-white font-semibold'
          : 'text-gray-600 hover:bg-primary/10 hover:text-white'
      }`}
    >
      {icon}
      <span>{label}</span>
    </Link>
  );
}
