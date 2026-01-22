'use client';

import React from 'react';
import Sidebar from '@/components/Sidebar';
import Header from '@/components/Header';
import MobileNav from '@/components/MobileNav';
import { 
  CreditCard, 
  Lock, 
  Wifi, 
  Globe, 
  Shield, 
  User, 
  Check, 
  Plus
} from 'lucide-react';

export default function CardsPage() {
  const [cardStep, setCardStep] = React.useState<'details' | 'confirm' | 'pin'>('details');
  const [cardName, setCardName] = React.useState('');
  const [pin, setPin] = React.useState(['', '', '', '']);
  const CARD_CREATION_FEE = 2000;

  const handlePinChange = (index: number, value: string) => {
    if (value.length > 1) return;
    const newPin = [...pin];
    newPin[index] = value;
    setPin(newPin);
    
    // Auto-focus next input
    if (value && index < 3) {
      const nextInput = document.getElementById(`pin-${index + 1}`);
      nextInput?.focus();
    }
  };

  const handleKeyDown = (index: number, e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Backspace' && !pin[index] && index > 0) {
      const prevInput = document.getElementById(`pin-${index - 1}`);
      prevInput?.focus();
    }
  };

  return (
    <div className="flex min-h-screen pb-16 md:pb-0 bg-off-white transition-colors duration-300">
      <Sidebar />

      {/* Main Content */}
      <main className="flex-1 overflow-y-auto relative">
        <Header title="Cards" />

        <div className="p-8 max-w-4xl mx-auto space-y-8">
            <div className="bg-white rounded-2xl shadow-sm border p-8">
                <div className="flex items-center justify-between mb-8 border-b border-gray-100 pb-4">
                    <h3 className="text-xl font-bold text-gray-900">
                        {cardStep === 'details' ? 'Get Virtual Card' :
                        cardStep === 'confirm' ? 'Confirm Request' : 'Enter PIN'}
                    </h3>
                </div>

                <div className="grid md:grid-cols-2 gap-12">
                    {/* Card Preview Side */}
                    <div className="order-2 md:order-1">
                        <div className="relative w-full aspect-[1.586] bg-gradient-to-br from-[#1D6A4A] to-[#155a3d] rounded-2xl p-6 text-white shadow-xl overflow-hidden transform hover:scale-105 transition-transform duration-300">
                            <div className="absolute top-0 right-0 w-32 h-32 bg-white/10 rounded-full -mr-8 -mt-8 blur-2xl"></div>
                            <div className="relative z-10 flex flex-col justify-between h-full">
                                <div className="flex justify-between items-start">
                                    <div className="flex items-center gap-2">
                                        <span className="font-bold tracking-widest text-sm opacity-80">BILLY VIRTUAL</span>
                                    </div>
                                    <Wifi className="opacity-80 rotate-90" size={24} />
                                </div>

                                <div className="flex items-center gap-2 my-2">
                                    <Lock size={16} className="opacity-60" />
                                    <span className="text-xl md:text-2xl font-bold tracking-[0.2em] opacity-90">**** **** **** ****</span>
                                </div>

                                <div className="flex justify-between items-end">
                                    <div>
                                        <p className="text-[10px] opacity-60 font-bold mb-1">CARD HOLDER</p>
                                        <p className="font-bold tracking-wide uppercase">{cardName || 'YOUR NAME'}</p>
                                    </div>
                                    <span className="text-2xl font-bold italic">VISA</span>
                                </div>
                            </div>
                        </div>

                         <div className="mt-8 space-y-4">
                           <h4 className="font-bold text-gray-800">Card Features</h4>
                           <div className="flex gap-3 items-center p-4 bg-gray-50 rounded-xl hover:bg-gray-100 transition-colors">
                              <div className="p-2 bg-[#1D6A4A]/10 rounded-lg text-[#1D6A4A]"><Globe size={20} /></div>
                              <div>
                                 <p className="text-sm font-bold text-gray-900">Accepted Globally</p>
                                 <p className="text-xs text-gray-500">Use for international payments</p>
                              </div>
                           </div>
                           <div className="flex gap-3 items-center p-4 bg-gray-50 rounded-xl hover:bg-gray-100 transition-colors">
                              <div className="p-2 bg-[#1D6A4A]/10 rounded-lg text-[#1D6A4A]"><Shield size={20} /></div>
                              <div>
                                 <p className="text-sm font-bold text-gray-900">Secure Transactions</p>
                                 <p className="text-xs text-gray-500">3D Secure enabled for safety</p>
                              </div>
                           </div>
                        </div>
                    </div>

                    {/* Form Side */}
                    <div className="order-1 md:order-2 flex flex-col justify-center">
                         {cardStep === 'details' ? (
                           <>
                                <div className="space-y-6">
                                    <div>
                                        <h2 className="text-2xl font-bold text-gray-900 mb-2">Create Your Virtual Card</h2>
                                        <p className="text-gray-500">Get instant access to global payments with a Billy Virtual Visa Card.</p>
                                    </div>

                                    <div className="space-y-2">
                                        <label className="text-sm font-medium text-gray-700">Name on Card</label>
                                        <div className="relative">
                                            <User className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 h-5 w-5" />
                                            <input 
                                                type="text" 
                                                value={cardName}
                                                onChange={(e) => setCardName(e.target.value)}
                                                placeholder="Enter your full name"
                                                className="w-full pl-12 pr-4 py-4 rounded-xl border border-gray-200 focus:border-[#1D6A4A] focus:ring-2 focus:ring-[#1D6A4A]/20 outline-none transition-all font-medium"
                                            />
                                        </div>
                                    </div>

                                    <div className="p-4 bg-[#1D6A4A]/5 border border-[#1D6A4A]/20 rounded-xl flex items-center justify-between">
                                        <span className="text-sm font-medium text-[#1D6A4A]">One-time Creation Fee</span>
                                        <span className="text-base font-bold text-[#1D6A4A]">₦ {CARD_CREATION_FEE.toLocaleString()}</span>
                                    </div>
                                </div>

                                <button 
                                    onClick={() => setCardStep('confirm')}
                                    disabled={!cardName}
                                    className="w-full bg-[#1D6A4A] hover:bg-[#155a3d] disabled:bg-gray-300 disabled:cursor-not-allowed text-white font-bold py-4 rounded-xl transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 mt-8 flex items-center justify-center gap-2"
                                >
                                    <Plus size={20} />
                                    Create Card
                                </button>
                           </>
                         ) : cardStep === 'confirm' ? (
                            <div className="space-y-8 animate-in fade-in slide-in-from-right-8 duration-300">
                                <div>
                                    <h2 className="text-2xl font-bold text-gray-900 mb-2">Review Details</h2>
                                    <p className="text-gray-500">Please review your card details before proceeding.</p>
                                </div>

                                <div className="space-y-4 border-t border-b border-gray-100 py-6">
                                    <div className="flex justify-between items-center">
                                        <span className="text-gray-500">Service</span>
                                        <span className="font-bold text-gray-900">Virtual Card Creation</span>
                                    </div>
                                    <div className="flex justify-between items-center">
                                        <span className="text-gray-500">Name on Card</span>
                                        <span className="font-bold text-gray-900 uppercase">{cardName}</span>
                                    </div>
                                    <div className="flex justify-between items-center">
                                        <span className="text-gray-500">Fee</span>
                                        <span className="font-bold text-gray-900">₦ {CARD_CREATION_FEE.toLocaleString()}</span>
                                    </div>
                                </div>
                                
                                <div className="space-y-3">
                                    <button 
                                        onClick={() => setCardStep('pin')}
                                        className="w-full bg-[#1D6A4A] hover:bg-[#155a3d] text-white font-bold py-4 rounded-xl transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5"
                                        >
                                        Pay & Create
                                    </button>

                                    <button 
                                        onClick={() => setCardStep('details')}
                                        className="w-full text-gray-500 font-medium py-2 hover:text-gray-700 transition-colors"
                                    >
                                        Back to Edit
                                    </button>
                                </div>
                            </div>
                         ) : (
                            <div className="py-4 space-y-8 animate-in fade-in slide-in-from-right-8 duration-300">
                                <div className="text-center space-y-2">
                                    <div className="w-16 h-16 bg-[#1D6A4A]/10 rounded-full flex items-center justify-center mx-auto mb-4">
                                        <Lock className="w-8 h-8 text-[#1D6A4A]" />
                                    </div>
                                    <h4 className="font-bold text-gray-900">Enter your 4-digit PIN</h4>
                                    <p className="text-sm text-gray-500">
                                        Authorize payment of ₦ {CARD_CREATION_FEE.toLocaleString()}
                                    </p>
                                </div>

                                <div className="flex justify-center gap-4">
                                    {pin.map((digit, index) => (
                                        <input
                                            key={index}
                                            id={`pin-${index}`}
                                            type="password"
                                            inputMode="numeric"
                                            maxLength={1}
                                            value={digit}
                                            onChange={(e) => handlePinChange(index, e.target.value)}
                                            onKeyDown={(e) => handleKeyDown(index, e)}
                                            className="w-16 h-16 rounded-2xl border-2 border-gray-200 focus:border-[#1D6A4A] text-center text-2xl font-bold outline-none transition-all bg-gray-50 focus:bg-white"
                                        />
                                    ))}
                                </div>

                                <button 
                                    onClick={() => {
                                        alert("Card Creation Successful!");
                                        setCardStep('details');
                                        setCardName('');
                                        setPin(['', '', '', '']);
                                    }}
                                    disabled={pin.some(p => !p)}
                                    className="w-full bg-[#1D6A4A] hover:bg-[#155a3d] disabled:bg-gray-300 disabled:cursor-not-allowed text-white font-bold py-4 rounded-xl transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 mt-4"
                                >
                                    Confirm Payment
                                </button>
                            </div>
                         )}
                    </div>
                </div>
            </div>
        </div>
      </main>

      <MobileNav />
    </div>
  );
}
