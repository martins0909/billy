'use client';

import React from 'react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { Gift, ArrowRight, ShieldCheck } from 'lucide-react';
import { mainNav, extraNav, isActivePath } from './navItems';

export default function Sidebar() {
  const pathname = usePathname();

  return (
    <aside className="w-64 hidden md:flex flex-col h-screen sticky top-0 shrink-0 text-gray-900 border-r border-edge bg-surface">
      {/* Brand */}
      <div className="pt-8 pb-6 px-6 flex flex-col items-center">
        <div className="logo-mask h-14 w-40" role="img" aria-label="BILLY" />
        <p className="mt-2 text-[11px] text-gray-500 tracking-wide">Secure &bull; Fast &bull; Reliable</p>
      </div>

      {/* Navigation */}
      <nav className="px-4 space-y-2">
        {mainNav.map(({ href, label, icon: Icon }) => (
          <SidebarItem key={href} href={href} icon={<Icon size={20} />} label={label} active={isActivePath(pathname, href)} />
        ))}

        <div className="my-3 mx-3 h-px bg-edge" />

        {extraNav.map(({ href, label, icon: Icon }) => (
          <SidebarItem key={href} href={href} icon={<Icon size={20} />} label={label} active={isActivePath(pathname, href)} />
        ))}
      </nav>

      <div className="flex-1" />

      {/* Refer & Earn */}
      <div className="px-4 pb-4">
        <div className="rounded-2xl p-4 text-center bg-card-gradient border border-primary/30">
          <div className="mx-auto mb-2 w-14 h-14 rounded-2xl bg-white/15 flex items-center justify-center">
            <Gift size={30} className="text-amber-300" />
          </div>
          <p className="text-lg font-bold text-white">Refer &amp; Earn</p>
          <p className="text-xs text-white/70 mt-1 leading-snug">Get rewarded for referring friends.</p>
          <button className="mt-3 inline-flex items-center gap-2 bg-white text-primary-dark text-sm font-semibold px-5 py-2 rounded-full">
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
          : 'text-gray-600 hover:bg-primary/10 hover:text-gray-900'
      }`}
    >
      {icon}
      <span>{label}</span>
    </Link>
  );
}
