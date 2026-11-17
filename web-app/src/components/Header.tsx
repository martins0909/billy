'use client';

import React, { useState, useRef, useEffect } from 'react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import {
  Bell, LogOut, User, CheckCircle, AlertTriangle, Info, Menu, X, Wallet, CircleUserRound,
} from 'lucide-react';
import ThemeToggle from './ThemeToggle';
import { mainNav, extraNav, isActivePath } from './navItems';

interface HeaderProps {
  title: string;
  gender?: 'male' | 'female';
}

const notifications = [
  { id: 1, title: 'Payment Successful', message: 'You successfully sent ₦50,000 to John Doe.', time: '2 mins ago', type: 'success', read: false },
  { id: 2, title: 'Security Alert', message: 'New login detected from a new device.', time: '1 hour ago', type: 'warning', read: false },
  { id: 3, title: 'Bill Payment Reminder', message: 'Your electric bill is due tomorrow.', time: '5 hours ago', type: 'info', read: true },
  { id: 4, title: 'Welcome to BILLY', message: 'Thanks for verifying your account.', time: '1 day ago', type: 'success', read: true },
];

export default function Header({ title }: HeaderProps) {
  const pathname = usePathname();
  const [isDropdownOpen, setIsDropdownOpen] = useState(false);
  const [isNotificationsOpen, setIsNotificationsOpen] = useState(false);
  const [isDrawerOpen, setIsDrawerOpen] = useState(false);
  const [greeting, setGreeting] = useState('Hello');
  const [items, setItems] = useState(notifications);

  const dropdownRef = useRef<HTMLDivElement>(null);
  const notificationsRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const hour = new Date().getHours();
    setGreeting(hour < 12 ? 'Good Morning' : hour < 18 ? 'Good Afternoon' : 'Good Evening');
  }, []);

  useEffect(() => {
    function onDown(e: MouseEvent) {
      if (dropdownRef.current && !dropdownRef.current.contains(e.target as Node)) setIsDropdownOpen(false);
      if (notificationsRef.current && !notificationsRef.current.contains(e.target as Node)) setIsNotificationsOpen(false);
    }
    document.addEventListener('mousedown', onDown);
    return () => document.removeEventListener('mousedown', onDown);
  }, []);

  useEffect(() => {
    setIsDrawerOpen(false);
  }, [pathname]);

  const unread = items.filter((n) => !n.read).length;

  return (
    <>
      <header className="sticky top-0 z-40 px-3 sm:px-6 pt-3 pb-1">
        <div className="mx-auto flex max-w-6xl items-center justify-between gap-2 rounded-2xl border border-edge bg-surface/90 px-3 sm:px-5 py-3 backdrop-blur shadow-[var(--card-shadow)]">
          {/* Left */}
          <div className="flex items-center gap-3 min-w-0">
            <button
              onClick={() => setIsDrawerOpen(true)}
              className="md:hidden p-1.5 text-gray-900"
              aria-label="Open menu"
            >
              <Menu size={26} />
            </button>
            <div className="logo-mask md:hidden h-9 w-14 shrink-0" role="img" aria-label="BILLY" />
            <div className="hidden md:flex flex-col leading-tight min-w-0">
              <span className="text-xs text-gray-500">{greeting},</span>
              <span className="text-lg font-bold text-gray-900 truncate">Blessing</span>
            </div>
            <span className="hidden lg:block ml-4 pl-4 border-l border-edge text-sm font-medium text-gray-500">{title}</span>
          </div>

          {/* Right */}
          <div className="flex items-center gap-1.5 sm:gap-3">
            <Link
              href="/transactions"
              className="flex items-center gap-2 rounded-full bg-primary/15 px-3 sm:px-4 py-2 text-sm font-bold text-gray-900 hover:bg-primary/25 transition-colors"
              aria-label="Wallet balance"
            >
              <Wallet size={18} className="text-primary-light" />
              <span>₦50,000.00</span>
            </Link>

            {/* Notifications */}
            <div className="relative" ref={notificationsRef}>
              <button
                onClick={() => setIsNotificationsOpen(!isNotificationsOpen)}
                className={`relative p-2 rounded-full transition-colors hover:bg-primary/10 ${isNotificationsOpen ? 'bg-primary/10' : ''}`}
                aria-label="Notifications"
              >
                <Bell size={24} className="text-gray-900" />
                {unread > 0 && (
                  <span className="absolute top-0 right-0 min-w-[18px] h-[18px] px-1 bg-red-500 text-white text-[10px] font-bold rounded-full flex items-center justify-center">
                    {unread}
                  </span>
                )}
              </button>

              {isNotificationsOpen && (
                <div className="fixed sm:absolute left-3 right-3 sm:left-auto sm:right-0 top-20 sm:top-auto sm:mt-3 sm:w-96 rounded-2xl border border-edge bg-surface shadow-2xl overflow-hidden z-[60] animate-in fade-in zoom-in-95 duration-200">
                  <div className="px-4 py-3 border-b flex items-center justify-between">
                    <h3 className="font-semibold text-gray-900">Notifications</h3>
                    <button
                      onClick={() => setItems(items.map((n) => ({ ...n, read: true })))}
                      className="text-xs text-primary-light font-medium hover:underline"
                    >
                      Mark all as read
                    </button>
                  </div>
                  <div className="max-h-[360px] overflow-y-auto">
                    {items.map((n) => (
                      <div
                        key={n.id}
                        className={`p-4 border-b last:border-0 flex gap-3 cursor-pointer transition-colors hover:bg-primary/5 ${!n.read ? 'bg-primary/5' : ''}`}
                      >
                        <div className={`mt-0.5 shrink-0 w-9 h-9 rounded-full flex items-center justify-center ${
                          n.type === 'success' ? 'bg-green-100 text-green-600' :
                          n.type === 'warning' ? 'bg-orange-100 text-orange-600' : 'bg-blue-100 text-blue-600'
                        }`}>
                          {n.type === 'success' ? <CheckCircle size={16} /> : n.type === 'warning' ? <AlertTriangle size={16} /> : <Info size={16} />}
                        </div>
                        <div className="flex-1 min-w-0">
                          <div className="flex justify-between items-start gap-2">
                            <h4 className="text-sm font-semibold text-gray-900">{n.title}</h4>
                            <span className="text-[10px] text-gray-400 whitespace-nowrap">{n.time}</span>
                          </div>
                          <p className="text-xs text-gray-500 mt-1 leading-relaxed">{n.message}</p>
                        </div>
                        {!n.read && <span className="mt-2 w-2 h-2 rounded-full bg-primary shrink-0" />}
                      </div>
                    ))}
                  </div>
                  <div className="p-2 text-center border-t">
                    <button className="text-xs text-gray-500 hover:text-gray-900 font-medium">View all activity</button>
                  </div>
                </div>
              )}
            </div>

            <ThemeToggle className="!h-10 !w-10 hidden sm:flex" />

            {/* Profile */}
            <div className="relative" ref={dropdownRef}>
              <button
                onClick={() => setIsDropdownOpen(!isDropdownOpen)}
                className="p-1 text-primary-light"
                aria-label="Profile"
              >
                <CircleUserRound size={34} strokeWidth={1.6} />
              </button>
              {isDropdownOpen && (
                <div className="absolute right-0 mt-3 w-56 rounded-2xl border border-edge bg-surface shadow-2xl py-1 z-[60] animate-in fade-in zoom-in-95 duration-200">
                  <div className="px-4 py-3 border-b">
                    <p className="text-sm font-semibold text-gray-900">Blessing</p>
                    <p className="text-xs text-gray-500 truncate">blessing@example.com</p>
                  </div>
                  <div className="py-1">
                    <Link href="/account" onClick={() => setIsDropdownOpen(false)} className="flex items-center gap-3 px-4 py-2 text-sm text-gray-700 hover:bg-primary/10">
                      <User size={16} /> Account
                    </Link>
                    <div className="sm:hidden px-4 py-2 flex items-center justify-between text-sm text-gray-700">
                      Theme <ThemeToggle className="!h-9 !w-9" />
                    </div>
                    <Link href="/login" onClick={() => setIsDropdownOpen(false)} className="flex items-center gap-3 px-4 py-2 text-sm text-red-600 hover:bg-red-50">
                      <LogOut size={16} /> Sign Out
                    </Link>
                  </div>
                </div>
              )}
            </div>
          </div>
        </div>
      </header>

      {/* Slide-in menu (mobile) */}
      <div className={`md:hidden fixed inset-0 z-[70] ${isDrawerOpen ? '' : 'pointer-events-none'}`}>
        <div
          onClick={() => setIsDrawerOpen(false)}
          className={`absolute inset-0 bg-black/60 transition-opacity duration-300 ${isDrawerOpen ? 'opacity-100' : 'opacity-0'}`}
        />
        <aside
          className={`absolute left-0 top-0 h-full w-72 max-w-[82%] bg-surface border-r border-edge p-5 flex flex-col transition-transform duration-300 ${isDrawerOpen ? 'translate-x-0' : '-translate-x-full'}`}
        >
          <div className="flex items-center justify-between mb-6">
            <div className="logo-mask h-10 w-24" role="img" aria-label="BILLY" />
            <button onClick={() => setIsDrawerOpen(false)} className="p-2 text-gray-900" aria-label="Close menu">
              <X size={24} />
            </button>
          </div>
          <nav className="space-y-1.5">
            {[...mainNav, ...extraNav].map(({ href, label, icon: Icon }) => {
              const active = isActivePath(pathname, href);
              return (
                <Link
                  key={href}
                  href={href}
                  className={`flex items-center gap-3 rounded-xl px-4 py-3 ${active ? 'btn-brand text-white font-semibold' : 'text-gray-700 hover:bg-primary/10'}`}
                >
                  <Icon size={20} /> {label}
                </Link>
              );
            })}
          </nav>
          <div className="mt-auto flex items-center justify-between rounded-xl border border-edge px-4 py-3 text-sm text-gray-700">
            Appearance <ThemeToggle className="!h-9 !w-9" />
          </div>
        </aside>
      </div>
    </>
  );
}
