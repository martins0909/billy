'use client';

import React, { useState } from 'react';
import { useRouter } from 'next/navigation';
import Sidebar from '@/components/Sidebar';
import Header from '@/components/Header';
import MobileNav from '@/components/MobileNav';
import { 
  User, 
  Settings, 
  MapPin, 
  Lock, 
  KeyRound, 
  Bell, 
  Mail, 
  ShieldCheck, 
  ChevronRight,
  LayoutDashboard,
  Check
} from 'lucide-react';

export default function AccountPage() {
  const router = useRouter();
  const [pushNotifications, setPushNotifications] = useState(true);
  const [emailAlerts, setEmailAlerts] = useState(false);

  return (
    <div className="flex min-h-screen pb-16 md:pb-0 bg-off-white">
      <Sidebar />

      <main className="flex-1 flex flex-col h-screen overflow-hidden">
        <Header title="Account Settings" />

        <div className="flex-1 overflow-y-auto p-4 md:p-8">
           <div className="max-w-3xl mx-auto space-y-6">
              
              {/* Account Settings Section */}
              <div className="bg-white rounded-xl shadow-sm border overflow-hidden">
                <div className="px-6 py-4 border-b bg-off-white flex items-center gap-3">
                  <div className="p-2 bg-blue-100 text-blue-600 rounded-lg">
                    <User size={20} />
                  </div>

                  <h3 className="font-semibold text-gray-800">Account Settings</h3>
                </div>
                
                <div className="divide-y">
                  <SettingsItem 
                    icon={<User size={18} />} 
                    title="Edit Profile"
                    onClick={() => router.push('/account/edit-profile')} 
                  />
                  <SettingsItem 
                    icon={<ShieldCheck size={18} />} 
                    title="Verification Status"
                    trailing={
                      <span className="px-2 py-1 bg-orange-100 text-orange-600 text-xs font-bold rounded">
                        Unverified
                      </span>
                    }
                    onClick={() => router.push('/account/verification')}
                  />
                  <SettingsItem 
                    icon={<MapPin size={18} />} 
                    title="Saved Addresses"
                    onClick={() => router.push('/account/saved-addresses')}
                  />
                </div>
              </div>

              {/* Security & Notification Settings Section */}
              <div className="bg-white rounded-xl shadow-sm border overflow-hidden">
                <div className="px-6 py-4 border-b bg-off-white flex items-center gap-3">
                  <div className="p-2 bg-green-100 text-green-600 rounded-lg">
                    <ShieldCheck size={20} />
                  </div>
                  <h3 className="font-semibold text-gray-800">Security & Notifications</h3>

                </div>
                
                <div className="divide-y">
                  <SettingsItem 
                    icon={<Lock size={18} />} 
                    title="Change Password"
                    onClick={() => router.push('/account/change-password')} 
                  />
                  <SettingsItem 
                    icon={<KeyRound size={18} />} 
                    title="Change Transaction PIN"
                    onClick={() => router.push('/account/change-pin')} 
                  />
                   <SettingsItem 
                    icon={<Bell size={18} />} 
                    title="Push Notifications"
                    isSwitch
                    checked={pushNotifications}
                    onChange={setPushNotifications}
                  />
                   <SettingsItem 
                    icon={<Mail size={18} />} 
                    title="Email Alerts"
                    isSwitch
                    checked={emailAlerts}
                    onChange={setEmailAlerts}
                  />
                </div>
              </div>

           </div>
        </div>
      </main>

      <MobileNav />
    </div>
  );
}

interface SettingsItemProps {
  icon: React.ReactNode;
  title: string;
  trailing?: React.ReactNode;
  onClick?: () => void;
  isSwitch?: boolean;
  checked?: boolean;
  onChange?: (checked: boolean) => void;
}

function SettingsItem({ icon, title, trailing, onClick, isSwitch, checked, onChange }: SettingsItemProps) {
  return (
    <div 
      onClick={isSwitch ? undefined : onClick}
      className={`px-6 py-4 flex items-center justify-between hover:bg-off-white transition-colors ${!isSwitch ? 'cursor-pointer' : ''}`}
    >
      <div className="flex items-center gap-4">

        <div className="text-gray-500">
          {icon}
        </div>
        <span className="text-sm font-medium text-gray-700">{title}</span>
      </div>

      <div className="flex items-center gap-2">
        {trailing}
        {isSwitch ? (
          <button 
            onClick={() => onChange?.(!checked)}
            className={`w-11 h-6 rounded-full transition-colors relative ${checked ? 'bg-[#1D6A4A]' : 'bg-gray-200'}`}
          >
            <span 
              className={`absolute top-1 left-1 bg-white w-4 h-4 rounded-full transition-transform ${checked ? 'translate-x-5' : 'translate-x-0'}`}
            />
          </button>
        ) : (
          <ChevronRight size={18} className="text-gray-400" />
        )}
      </div>
    </div>
  );
}
