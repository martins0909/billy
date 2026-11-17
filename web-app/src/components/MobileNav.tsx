'use client';

import React from 'react';
import { Home, LayoutGrid, ClipboardList, Menu, Plus } from 'lucide-react';
import Link from 'next/link';
import { usePathname, useRouter } from 'next/navigation';
import { isActivePath } from './navItems';

export const FUND_FLAG = 'billy-open-fund';

/**
 * Bottom bar for small screens: Home, Services, raised "+" (fund wallet),
 * My Orders and More (account).
 */
export default function MobileNav({ onFundClick }: { onFundClick?: () => void }) {
  const pathname = usePathname();
  const router = useRouter();

  const handleFund = () => {
    if (onFundClick) return onFundClick();
    try {
      sessionStorage.setItem(FUND_FLAG, '1');
    } catch {}
    router.push('/');
  };

  return (
    <nav className="md:hidden fixed bottom-0 left-0 right-0 z-50 bg-surface/95 backdrop-blur border-t border-edge px-3 pt-2 pb-3 flex items-end justify-between">
      <Item href="/" label="Home" icon={<Home size={24} />} active={isActivePath(pathname, '/')} />
      <Item href="/services" label="Services" icon={<LayoutGrid size={24} />} active={isActivePath(pathname, '/services')} />

      <button
        onClick={handleFund}
        aria-label="Fund wallet"
        className="-mt-8 flex h-16 w-16 items-center justify-center rounded-full bg-primary text-white shadow-glow ring-4 ring-off-white"
      >
        <Plus size={32} strokeWidth={2.5} />
      </button>

      <Item href="/orders" label="Orders" icon={<ClipboardList size={24} />} active={isActivePath(pathname, '/orders')} />
      <Item
        href="/account"
        label="More"
        icon={<Menu size={24} />}
        active={isActivePath(pathname, '/account') || isActivePath(pathname, '/cards') || isActivePath(pathname, '/beneficiaries')}
      />
    </nav>
  );
}

function Item({ href, label, icon, active }: { href: string; label: string; icon: React.ReactNode; active: boolean }) {
  return (
    <Link
      href={href}
      className={`flex w-16 flex-col items-center gap-1 py-1 ${active ? 'text-primary-light' : 'text-gray-500'}`}
    >
      {icon}
      <span className="text-[12px] font-medium">{label}</span>
    </Link>
  );
}
