'use client';

import React from 'react';
import Sidebar from '@/components/Sidebar';
import Header from '@/components/Header';
import MobileNav from '@/components/MobileNav';
import { ShieldCheck, Info } from 'lucide-react';

export default function ChangePinPage() {
  const [pin, setPin] = React.useState(['', '', '', '']);
  const [confirmPin, setConfirmPin] = React.useState(['', '', '', '']);

  const handlePinChange = (index: number, value: string, isConfirm: boolean) => {
    if (value.length > 1) return;
    
    const targetSet = isConfirm ? setConfirmPin : setPin;
    const targetState = isConfirm ? confirmPin : pin;
    
    const newPin = [...targetState];
    newPin[index] = value;
    targetSet(newPin);

    // Auto-focus next input
    if (value !== '' && index < 3) {
      const nextInput = document.getElementById(`pin-${isConfirm ? 'confirm-' : ''}${index + 1}`);
      nextInput?.focus();
    }
  };

  const handleKeyDown = (e: React.KeyboardEvent, index: number, isConfirm: boolean) => {
    if (e.key === 'Backspace') {
       const targetState = isConfirm ? confirmPin : pin;
       if (targetState[index] === '' && index > 0) {
          const prevInput = document.getElementById(`pin-${isConfirm ? 'confirm-' : ''}${index - 1}`);
          prevInput?.focus();
       }
    }
  };

  return (
    <div className="flex min-h-screen pb-16 md:pb-0 bg-off-white">
      <Sidebar />


      <main className="flex-1 flex flex-col h-screen overflow-hidden">
        <Header title="Transaction PIN" />

        <div className="flex-1 overflow-y-auto p-4 md:p-8">
           <div className="max-w-md mx-auto space-y-8 pt-6">
              
              <div className="text-center space-y-2">
                 <div className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-green-50 text-[#1D6A4A] mb-2">
                    <ShieldCheck size={32} />
                 </div>
                 <h2 className="text-xl font-bold text-gray-900">Set Transaction PIN</h2>
                 <p className="text-gray-500 text-sm">
                    This PIN will be used to authorize withdrawals and sensitive transactions.
                 </p>
              </div>

              <form className="bg-white p-8 rounded-2xl shadow-lg shadow-gray-200/50 border border-gray-100 space-y-8">
                 
                 {/* New PIN */}
                 <div className="space-y-4">
                    <label className="block text-sm font-medium text-gray-700 text-center">Enter New 4-Digit PIN</label>
                    <div className="flex justify-center gap-4">
                       {pin.map((digit, i) => (
                          <input
                             key={i}
                             id={`pin-${i}`}
                             type="password"
                             inputMode="numeric"
                             maxLength={1}
                             value={digit}
                             onChange={(e) => handlePinChange(i, e.target.value, false)}
                             onKeyDown={(e) => handleKeyDown(e, i, false)}
                             className="w-12 h-14 border-2 border-gray-200 rounded-xl text-center text-2xl font-bold focus:border-[#1D6A4A] focus:ring-0 outline-none transition-colors bg-off-white focus:bg-white"
                          />
                       ))}

                    </div>
                 </div>

                 {/* Confirm PIN */}
                 <div className="space-y-4">
                    <label className="block text-sm font-medium text-gray-700 text-center">Confirm New PIN</label>
                    <div className="flex justify-center gap-4">
                       {confirmPin.map((digit, i) => (
                          <input
                             key={i}
                             id={`pin-confirm-${i}`}
                             type="password"
                             inputMode="numeric"
                             maxLength={1}
                             value={digit}
                             onChange={(e) => handlePinChange(i, e.target.value, true)}
                             onKeyDown={(e) => handleKeyDown(e, i, true)}
                             className="w-12 h-14 border-2 border-gray-200 rounded-xl text-center text-2xl font-bold focus:border-[#1D6A4A] focus:ring-0 outline-none transition-colors bg-off-white focus:bg-white"
                          />
                       ))}

                    </div>
                 </div>

                 <button className="w-full py-3 bg-[#1D6A4A] hover:bg-[#155a3d] text-white font-medium rounded-xl shadow-lg shadow-green-900/10 transition-colors mt-4">
                    Set PIN
                 </button>

              </form>

              <div className="flex gap-2 items-start bg-yellow-50 p-4 rounded-lg text-yellow-800 text-xs text-justify">
                 <Info size={16} className="shrink-0 mt-0.5" />
                 <p>Never share your PIN with anyone, including BILLY support staff. Ensure you pick a PIN that is hard to guess.</p>
              </div>

           </div>
        </div>
      </main>

      <MobileNav />
    </div>
  );
}
