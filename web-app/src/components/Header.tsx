'use client';

import React, { useState, useRef, useEffect } from 'react';
import { Bell, LogOut, User, CheckCircle, AlertTriangle, Info, Moon, BadgeCheck } from 'lucide-react';
import Link from 'next/link';

interface HeaderProps {
  title: string;
  gender?: 'male' | 'female';
}

export default function Header({ title, gender = 'female' }: HeaderProps) {
  const [isDropdownOpen, setIsDropdownOpen] = useState(false);
  const [isNotificationsOpen, setIsNotificationsOpen] = useState(false);
  const [greeting, setGreeting] = useState('');

  useEffect(() => {
    const hour = new Date().getHours();
    if (hour < 12) setGreeting('Good Morning');
    else if (hour < 18) setGreeting('Good Afternoon');
    else setGreeting('Good Evening');
  }, []);
  const dropdownRef = useRef<HTMLDivElement>(null);
  const notificationsRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target as Node)) {
        setIsDropdownOpen(false);
      }
      if (notificationsRef.current && !notificationsRef.current.contains(event.target as Node)) {
        setIsNotificationsOpen(false);
      }
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => {
      document.removeEventListener("mousedown", handleClickOutside);
    };
  }, []);

  const avatarUrl = gender === 'female'
    ? 'https://randomuser.me/api/portraits/women/44.jpg'
    : 'https://randomuser.me/api/portraits/men/32.jpg';

  const notifications = [
    {
      id: 1,
      title: 'Payment Successful',
      message: 'You successfully sent ₦50,000 to John Doe.',
      time: '2 mins ago',
      type: 'success',
      read: false,
    },
    {
      id: 2,
      title: 'Security Alert',
      message: 'New login detected from a new device.',
      time: '1 hour ago',
      type: 'warning',
      read: false,
    },
    {
      id: 3,
      title: 'Bill Payment Reminder',
      message: 'Your electric bill is due tomorrow.',
      time: '5 hours ago',
      type: 'info',
      read: true,
    },
    {
      id: 4,
      title: 'Welcome to BILLY',
      message: 'Thanks for verifying your account.',
      time: '1 day ago',
      type: 'success',
      read: true,
    }
  ];

  const dropdown = (
    <div className="absolute left-0 mt-3 w-52 glass-card bg-surface rounded-2xl py-1 animate-in fade-in zoom-in-95 duration-200 z-[60]">
      <div className="px-4 py-3 border-b">
        <p className="text-sm font-semibold text-gray-800">Blessing</p>
        <p className="text-xs text-gray-500 truncate">blessing@example.com</p>
      </div>
      <div className="py-1">
        <Link
          href="/account"
          className="flex items-center gap-3 px-4 py-2 text-sm text-gray-700 hover:bg-primary/10 hover:text-primary"
          onClick={() => setIsDropdownOpen(false)}
        >
          <User size={16} />
          Account
        </Link>
        <Link
          href="/login"
          className="flex items-center gap-3 px-4 py-2 text-sm text-red-600 hover:bg-red-50"
          onClick={() => setIsDropdownOpen(false)}
        >
          <LogOut size={16} />
          Sign Out
        </Link>
      </div>
    </div>
  );

  return (
    <header className="px-4 sm:px-8 py-5 flex items-center justify-between sticky top-0 z-40 backdrop-blur-md bg-off-white/30">
      {/* Left: avatar + greeting */}
      <div className="flex items-center gap-4">
        <div className="relative" ref={dropdownRef}>
          <button
            onClick={() => setIsDropdownOpen(!isDropdownOpen)}
            className="flex items-center justify-center w-12 h-12 sm:w-14 sm:h-14 rounded-full p-[2px] bg-brand-gradient shadow-glow-sm focus:outline-none"
          >
            <img
              src={avatarUrl}
              alt="User Avatar"
              className="w-full h-full rounded-full object-cover bg-gray-100 border-2 border-off-white"
            />
          </button>
          {isDropdownOpen && dropdown}
        </div>

        <div className="flex flex-col leading-tight">
          <p className="text-sm sm:text-lg text-gray-600">{greeting},</p>
          <p className="flex items-center gap-2 text-xl sm:text-2xl font-bold text-white">
            Blessing
            <BadgeCheck size={20} className="text-primary-light fill-primary/30" />
          </p>
        </div>
      </div>

      {/* Right: notifications + theme */}
      <div className="flex items-center gap-3">
        <div className="relative z-50" ref={notificationsRef}>
          <button
            onClick={() => setIsNotificationsOpen(!isNotificationsOpen)}
            className={`relative p-3 rounded-full hover:bg-primary/10 transition-colors ${isNotificationsOpen ? 'bg-primary/10' : ''}`}
            aria-label="Notifications"
          >
            <Bell size={24} className="text-white" />
            <span className="absolute top-1 right-1 min-w-[18px] h-[18px] px-1 bg-red-500 text-white text-[10px] font-bold rounded-full flex items-center justify-center">
              {notifications.filter((n) => !n.read).length}
            </span>
          </button>

          {isNotificationsOpen && (
            <div className="absolute right-0 mt-2 w-80 md:w-96 glass-card bg-surface rounded-2xl overflow-hidden z-[60] animate-in fade-in zoom-in-95 duration-200">
              <div className="px-4 py-3 border-b flex items-center justify-between bg-primary/10">
                <h3 className="font-semibold text-gray-800">Notifications</h3>
                <button className="text-xs text-primary font-medium hover:underline">Mark all as read</button>
              </div>

              <div className="max-h-[400px] overflow-y-auto">
                {notifications.map((notification) => (
                  <div
                    key={notification.id}
                    className={`p-4 border-b last:border-0 hover:bg-primary/10 transition-colors flex gap-3 cursor-pointer ${
                      !notification.read ? 'bg-primary/5' : ''
                    }`}
                  >
                    <div className={`mt-1 shrink-0 w-8 h-8 rounded-full flex items-center justify-center ${
                      notification.type === 'success' ? 'bg-green-100 text-green-600' :
                      notification.type === 'warning' ? 'bg-orange-100 text-orange-600' :
                      'bg-blue-100 text-blue-600'
                    }`}>
                      {notification.type === 'success' ? <CheckCircle size={14} /> :
                       notification.type === 'warning' ? <AlertTriangle size={14} /> :
                       <Info size={14} />}
                    </div>
                    <div className="flex-1">
                      <div className="flex justify-between items-start gap-2">
                        <h4 className={`text-sm font-medium ${!notification.read ? 'text-gray-900' : 'text-gray-700'}`}>
                          {notification.title}
                        </h4>
                        <span className="text-[10px] text-gray-400 whitespace-nowrap">{notification.time}</span>
                      </div>
                      <p className="text-xs text-gray-500 mt-1 leading-relaxed">{notification.message}</p>
                    </div>
                    {!notification.read && (
                      <div className="mt-2 w-2 h-2 rounded-full bg-primary shrink-0"></div>
                    )}
                  </div>
                ))}
              </div>

              <div className="p-2 bg-primary/10 text-center border-t">
                <button className="text-xs text-gray-500 hover:text-gray-800 font-medium">View all activity</button>
              </div>
            </div>
          )}
        </div>

        <span className="hidden sm:block w-px h-9 bg-primary/30" />

        <button
          className="hidden sm:flex w-12 h-12 items-center justify-center rounded-xl border border-primary/40 bg-surface/60 text-white hover:bg-primary/10 transition-colors"
          aria-label="Dark theme"
          title="Dark theme"
        >
          <Moon size={22} />
        </button>
      </div>
    </header>
  );
}