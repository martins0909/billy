'use client';

import React from 'react';
import { Home, LayoutGrid, Wallet, ClipboardList, User } from 'lucide-react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';

// `onFundClick` is kept for backwards compatibility with existing callers; the
// redesigned bar no longer has a dedicated Fund button (funding lives on Wallet).
export default function MobileNav(_props: { onFundClick?: () => void }) {
  const pathname = usePathname();

  const isActive = (path: string) => {
    if (path === '/') return pathname === '/';
    return pathname.startsWith(path);
  };

  const items = [
    { href: '/', label: 'Home', icon: Home },
    { href: '/services', label: 'Services', icon: LayoutGrid },
    { href: '/transactions', label: 'Wallet', icon: Wallet },
    { href: '/orders', label: 'My Orders', icon: ClipboardList },
    { href: '/account', label: 'Account', icon: User },
  ];

  return (
    <div className="md:hidden fixed bottom-3 left-3 right-3 z-50">
      <nav className="glass-card bg-surface/90 rounded-[28px] border-primary/50 px-1 py-2 flex items-stretch shadow-glow-sm">
        {items.map(({ href, label, icon: Icon }, i) => {
          const active = isActive(href);
          return (
            <React.Fragment key={href}>
              {i > 0 && <span className="w-px my-2 bg-primary/25" />}
              <Link
                href={href}
                className={`relative flex-1 flex flex-col items-center gap-1 py-1.5 ${
                  active ? 'text-primary-light' : 'text-gray-900'
                }`}
              >
                <Icon size={22} className={active ? 'fill-primary/40' : ''} />
                <span className="text-[10px] font-medium">{label}</span>
                {active && (
                  <span className="absolute -bottom-2 h-[3px] w-10 rounded-full bg-brand-gradient shadow-glow-sm" />
                )}
              </Link>
            </React.Fragment>
          );
        })}
      </nav>
    </div>
  );
}
