'use client';

import React, { useState, useRef, useEffect } from 'react';
import { Search, Bell, LogOut, User, CheckCircle, AlertTriangle, Info, X, ChevronDown } from 'lucide-react';
import Link from 'next/link';

interface HeaderProps {
  title: string;
  gender?: 'male' | 'female';
}

export default function Header({ title, gender = 'male' }: HeaderProps) {
  const [isDropdownOpen, setIsDropdownOpen] = useState(false);
  const [isNotificationsOpen, setIsNotificationsOpen] = useState(false);
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
      message: 'Thanks for verify your account.',
      time: '1 day ago',
      type: 'success',
      read: true,
    }
  ];

  return (
    <header className="bg-white border-b px-8 py-5 flex items-center justify-between sticky top-0 z-40 transition-colors duration-300">
      <h2 className="text-xl font-bold text-gray-800 lg:hidden">{title}</h2>
      <div className="flex items-center gap-6">
        <div className="relative hidden lg:block">
          <Search className="absolute left-3 top-2.5 text-gray-400" size={18} />
          <input 
            type="text" 
            placeholder="Search..."
            className="pl-10 pr-4 py-2 border rounded-full text-sm w-64 focus:outline-none focus:ring-2 focus:ring-[#1D6A4A] bg-gray-50 transtion-colors"
          />
        </div>
        
        <div className="flex items-center gap-4">
          
          {/* Notifications */}
          <div className="relative" ref={notificationsRef}>
            <button 
              onClick={() => setIsNotificationsOpen(!isNotificationsOpen)}
              className={`relative p-2 rounded-full hover:bg-gray-100 transition-colors ${isNotificationsOpen ? 'bg-gray-100' : ''}`}
            >
              <Bell size={20} className="text-gray-600" />
              <span className="absolute top-1 right-2 w-2 h-2 bg-red-500 rounded-full animate-pulse"></span>
            </button>

            {isNotificationsOpen && (
              <div className="absolute right-0 mt-2 w-80 md:w-96 bg-white rounded-xl shadow-xl border border-gray-100 overflow-hidden z-[60] animate-in fade-in zoom-in-95 duration-200">
                <div className="px-4 py-3 border-b flex items-center justify-between bg-off-white">
                  <h3 className="font-semibold text-gray-800">Notifications</h3>

                  <button className="text-xs text-[#1D6A4A] font-medium hover:underline">Mark all as read</button>
                </div>
                
                <div className="max-h-[400px] overflow-y-auto">
                  {notifications.map((notification) => (
                    <div 
                      key={notification.id} 
                      className={`p-4 border-b last:border-0 hover:bg-gray-50 transition-colors flex gap-3 cursor-pointer ${
                        !notification.read ? 'bg-blue-50/30' : ''
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
                        <div className="mt-2 w-2 h-2 rounded-full bg-blue-500 shrink-0"></div>
                      )}
                    </div>
                  ))}
                </div>
                
                <div className="p-2 bg-off-white text-center border-t">
                  <button className="text-xs text-gray-500 hover:text-gray-800 font-medium">View all activity</button>
                </div>

              </div>
            )}
          </div>

          <div className="relative" ref={dropdownRef}>
            <button 
              onClick={() => setIsDropdownOpen(!isDropdownOpen)}
              className="flex items-center justify-center w-10 h-10 rounded-full border-2 border-transparent hover:border-[#1D6A4A] transition-all focus:outline-none"
            >
              <img 
                src={avatarUrl} 
                alt="User Avatar" 
                className="w-full h-full rounded-full object-cover bg-gray-100"
              />
            </button>

            {isDropdownOpen && (
              <div className="absolute right-0 mt-2 w-48 bg-white rounded-xl shadow-lg border py-1 animate-in fade-in zoom-in-95 duration-200">
                <div className="px-4 py-3 border-b">
                  <p className="text-sm font-semibold text-gray-800">John Doe</p>
                  <p className="text-xs text-gray-500 truncate">john.doe@example.com</p>
                </div>
                <div className="py-1">
                  <Link 
                    href="/account" 
                    className="flex items-center gap-3 px-4 py-2 text-sm text-gray-700 hover:bg-off-white hover:text-[#1D6A4A]"
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
            )}
          </div>
        </div>
      </div>
    </header>
  );
}
