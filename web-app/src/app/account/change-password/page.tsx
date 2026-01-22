'use client';

import React from 'react';
import Sidebar from '@/components/Sidebar';
import Header from '@/components/Header';
import MobileNav from '@/components/MobileNav';
import { Lock, Eye, EyeOff, ShieldAlert } from 'lucide-react';

export default function ChangePasswordPage() {
  const [showCurrent, setShowCurrent] = React.useState(false);
  const [showNew, setShowNew] = React.useState(false);
  const [showConfirm, setShowConfirm] = React.useState(false);

  return (
    <div className="flex min-h-screen pb-16 md:pb-0 bg-off-white">
      <Sidebar />


      <main className="flex-1 flex flex-col h-screen overflow-hidden">
        <Header title="Change Password" />

        <div className="flex-1 overflow-y-auto p-4 md:p-8">
           <div className="max-w-xl mx-auto space-y-8">
              
              {/* Security Banner */}
              <div className="bg-blue-50 border border-blue-100 rounded-xl p-4 flex gap-3 text-sm text-blue-800">
                 <ShieldAlert size={20} className="shrink-0" />
                 <p>
                    Ensure your account is using a long, random password to stay secure. Use at least 8 characters with numbers and symbols.
                 </p>
              </div>

              <form className="bg-white p-6 md:p-8 rounded-2xl shadow-sm border border-gray-100 space-y-6">
                 
                 <PasswordInput 
                    label="Current Password" 
                    placeholder="Enter current password" 
                    isVisible={showCurrent} 
                    onToggle={() => setShowCurrent(!showCurrent)} 
                 />

                 <div className="h-px bg-gray-100 my-2"></div>

                 <PasswordInput 
                    label="New Password" 
                    placeholder="Enter new password" 
                    isVisible={showNew} 
                    onToggle={() => setShowNew(!showNew)} 
                 />

                 <PasswordInput 
                    label="Confirm New Password" 
                    placeholder="Repeat new password" 
                    isVisible={showConfirm} 
                    onToggle={() => setShowConfirm(!showConfirm)} 
                 />

                 <div className="pt-4 flex items-center justify-end gap-3">
                    <button type="button" className="px-6 py-2.5 text-gray-600 font-medium hover:bg-off-white rounded-lg transition-colors">
                       Cancel
                    </button>

                    <button type="submit" className="px-6 py-2.5 bg-[#1D6A4A] hover:bg-[#155a3d] text-white font-medium rounded-lg shadow-lg shadow-green-900/10 transition-colors">
                       Update Password
                    </button>
                 </div>
              </form>

              <div className="text-center">
                 <a href="/forgot-password" className="text-sm text-[#1D6A4A] font-medium hover:underline">
                    Forgot your password?
                 </a>
              </div>

           </div>
        </div>
      </main>

      <MobileNav />
    </div>
  );
}

function PasswordInput({ label, placeholder, isVisible, onToggle }: { label: string, placeholder: string, isVisible: boolean, onToggle: () => void }) {
   return (
      <div className="space-y-1.5">
         <label className="block text-sm font-medium text-gray-700">{label}</label>
         <div className="relative">
            <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-gray-400">
               <Lock size={18} />
            </div>
            <input 
               type={isVisible ? "text" : "password"} 
               className="block w-full pl-10 pr-10 py-2.5 border border-gray-200 rounded-lg focus:ring-2 focus:ring-[#1D6A4A]/20 focus:border-[#1D6A4A] transition-all text-sm outline-none"
               placeholder={placeholder}
            />
            <button 
               type="button" 
               onClick={onToggle}
               className="absolute inset-y-0 right-0 pr-3 flex items-center text-gray-400 hover:text-gray-600 transition-colors"
            >
               {isVisible ? <EyeOff size={18} /> : <Eye size={18} />}
            </button>
         </div>
      </div>
   );
}
