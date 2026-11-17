import { Home, Settings, Wallet, ClipboardList, User, CreditCard, Users } from 'lucide-react';

export const mainNav = [
  { href: '/', label: 'Home', icon: Home },
  { href: '/services', label: 'Services', icon: Settings },
  { href: '/transactions', label: 'Wallet', icon: Wallet },
  { href: '/orders', label: 'My Orders', icon: ClipboardList },
  { href: '/account', label: 'Account', icon: User },
];

export const extraNav = [
  { href: '/cards', label: 'Cards', icon: CreditCard },
  { href: '/beneficiaries', label: 'Beneficiaries', icon: Users },
];

export const isActivePath = (pathname: string, path: string) =>
  path === '/' ? pathname === '/' : pathname.startsWith(path);
