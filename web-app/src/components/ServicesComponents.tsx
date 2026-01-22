'use client';

import React from 'react';
import { 
  Smartphone, 
  Wifi, 
  Trophy, 
  GraduationCap, 
  Zap, 
  Tv, 
  Rocket, 
  Cpu, 
  Shield, 
  Megaphone, 
  CreditCard, 
  Calendar,
  X,
  Check,
  Lock,
  ChevronDown,
  ChevronRight,
  Loader2,
  Copy
} from 'lucide-react';

export default function ServicesComponents() {
  const [showAirtimeModal, setShowAirtimeModal] = React.useState(false);
  const [showDataModal, setShowDataModal] = React.useState(false);
  const [showElectricityModal, setShowElectricityModal] = React.useState(false);
  const [showCableModal, setShowCableModal] = React.useState(false);
  const [showEducationModal, setShowEducationModal] = React.useState(false);

  // Airtime State
  const [airtimeStep, setAirtimeStep] = React.useState<'details' | 'pin'>('details');
  const [selectedNetwork, setSelectedNetwork] = React.useState('MTN');

  // Data State
  const [dataStep, setDataStep] = React.useState<'details' | 'pin'>('details');
  const [selectedPlan, setSelectedPlan] = React.useState<string>('');
  const [showPlanSelection, setShowPlanSelection] = React.useState(false);

  // Electricity State
  const [electricityStep, setElectricityStep] = React.useState<'details' | 'pin' | 'success'>('details');
  const [generatedToken, setGeneratedToken] = React.useState<string>('');
  const [selectedDisco, setSelectedDisco] = React.useState<string>('');
  const [showDiscoSelection, setShowDiscoSelection] = React.useState(false);
  const [meterType, setMeterType] = React.useState<'Prepaid' | 'Postpaid'>('Prepaid');
  const [meterNumber, setMeterNumber] = React.useState('');
  const [amount, setAmount] = React.useState('');
  const [isVerifying, setIsVerifying] = React.useState(false);
  const [verifiedName, setVerifiedName] = React.useState<string | null>(null);

  // Cable TV State
  const [cableStep, setCableStep] = React.useState<'details' | 'pin' | 'success'>('details');
  const [selectedProvider, setSelectedProvider] = React.useState<string>('');
  const [selectedPackage, setSelectedPackage] = React.useState<string>('');
  const [smartCardNumber, setSmartCardNumber] = React.useState('');
  const [cableAmount, setCableAmount] = React.useState('');
  const [isVerifyingCard, setIsVerifyingCard] = React.useState(false);
  const [verifiedCardName, setVerifiedCardName] = React.useState<string | null>(null);
  
  // Education State
  const [educationStep, setEducationStep] = React.useState<'menu' | 'waec-details' | 'pin' | 'success'>('menu');
  const [waecQuantity, setWaecQuantity] = React.useState(1);
  const [waecPhone, setWaecPhone] = React.useState('');
  const [waecGeneratedPins, setWaecGeneratedPins] = React.useState<{pin: string, serial: string}[]>([]);
  const WAEC_PRICE = 3500;

  const [pin, setPin] = React.useState(['', '', '', '']);

  const networks = [
    { id: 'MTN', color: 'bg-yellow-400' },
    { id: 'AIRTEL', color: 'bg-red-500' },
    { id: 'GLO', color: 'bg-green-500' },
    { id: '9MOBILE', color: 'bg-green-800' }
  ];

  const dataPlans = {
    MTN: [
      { id: '1', name: '100MB Daily Plan', price: '100', validity: '1 Day' },
      { id: '2', name: '200MB 3-Day Plan', price: '200', validity: '3 Days' },
      { id: '3', name: '1GB Monthly Plan', price: '1000', validity: '30 Days' },
      { id: '4', name: '2.5GB Monthly Plan', price: '2000', validity: '30 Days' },
    ],
    AIRTEL: [
      { id: '1', name: '100MB Daily', price: '100', validity: '1 Day' },
      { id: '2', name: '3GB Monthly', price: '1500', validity: '30 Days' },
    ],
    GLO: [
      { id: '1', name: '1GB Monthly', price: '1000', validity: '30 Days' },
    ],
    '9MOBILE': [
      { id: '1', name: '500MB Weekly', price: '500', validity: '7 Days' },
    ]
  };

  const discos = [
    { id: 'ikeja', name: 'Ikeja Electric', short: 'IKEDC', color: 'bg-amber-500', text: 'text-amber-600', bg: 'bg-amber-100' },
    { id: 'eko', name: 'Eko Electric', short: 'EKEDC', color: 'bg-red-500', text: 'text-red-600', bg: 'bg-red-100' },
    { id: 'abuja', name: 'Abuja Electric', short: 'AEDC', color: 'bg-green-500', text: 'text-green-600', bg: 'bg-green-100' },
    { id: 'ibadan', name: 'Ibadan Electric', short: 'IBEDC', color: 'bg-blue-500', text: 'text-blue-600', bg: 'bg-blue-100' },
    { id: 'enugu', name: 'Enugu Electric', short: 'EEDC', color: 'bg-orange-500', text: 'text-orange-600', bg: 'bg-orange-100' },
    { id: 'ph', name: 'Port Harcourt', short: 'PHED', color: 'bg-purple-500', text: 'text-purple-600', bg: 'bg-purple-100' },
    { id: 'benin', name: 'Benin Electric', short: 'BEDC', color: 'bg-cyan-500', text: 'text-cyan-600', bg: 'bg-cyan-100' },
  ];

  const cableProviders = [
    { id: 'DSTV', name: 'DSTV', color: 'bg-blue-500', text: 'text-blue-600', bg: 'bg-blue-100' },
    { id: 'GOTV', name: 'GOTV', color: 'bg-green-500', text: 'text-green-600', bg: 'bg-green-100' },
    { id: 'Startimes', name: 'Startimes', color: 'bg-orange-500', text: 'text-orange-600', bg: 'bg-orange-100' },
    { id: 'Showmax', name: 'Showmax', color: 'bg-pink-500', text: 'text-pink-600', bg: 'bg-pink-100' },
  ];

  const cablePackages = {
    DSTV: [
      { name: 'DSTV Premium', price: 29500 },
      { name: 'DSTV Compact Plus', price: 19800 },
      { name: 'DSTV Compact', price: 12500 },
      { name: 'DSTV Confam', price: 7400 },
      { name: 'DSTV Yanga', price: 4200 },
      { name: 'DSTV Padi', price: 2500 },
    ],
    GOTV: [
      { name: 'GOTV Supa', price: 7600 },
      { name: 'GOTV Max', price: 5700 },
      { name: 'GOTV Jolli', price: 3950 },
      { name: 'GOTV Jinja', price: 2700 },
      { name: 'GOTV Smallie', price: 1300 },
    ],
    Startimes: [
      { name: 'Classic', price: 3800 },
      { name: 'Basic', price: 2600 },
      { name: 'Smart', price: 3500 },
      { name: 'Nova', price: 1500 },
    ],
    Showmax: [
      { name: 'Showmax Pro', price: 3200 },
      { name: 'Showmax Mobile', price: 1200 },
    ],
  };

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

  const closeAirtimeModal = () => {
    setShowAirtimeModal(false);
    setAirtimeStep('details');
    setPin(['', '', '', '']);
  };

  const closeDataModal = () => {
    setShowDataModal(false);
    setDataStep('details');
    setSelectedPlan('');
    setPin(['', '', '', '']);
  };

  const handleVerifyMeter = (number?: string) => {
    const numToCheck = number || meterNumber;
    if (numToCheck.length < 10) return;
    setIsVerifying(true);
    setVerifiedName(null);
    
    // Simulate API call
    setTimeout(() => {
      setIsVerifying(false);
      setVerifiedName(`JOHN DOE - ${discos.find(d => d.id === selectedDisco)?.short || 'UNKNOWN'}`);
    }, 2000);
  };

  const closeElectricityModal = () => {
    setShowElectricityModal(false);
    setElectricityStep('details');
    setSelectedDisco('');
    setMeterType('Prepaid');
    setMeterNumber('');
    setAmount('');
    setVerifiedName(null);
    setGeneratedToken('');
    setPin(['', '', '', '']);
  };

  const verifySmartCard = (number?: string) => {
    const numToCheck = number || smartCardNumber;
    if (numToCheck.length < 10) return;
    setIsVerifyingCard(true);
    setVerifiedCardName(null);
    
    setTimeout(() => {
      setIsVerifyingCard(false);
      setVerifiedCardName(`JANE DOE - ${selectedProvider || 'UNKNOWN'}`);
    }, 2000);
  };

  const closeCableModal = () => {
    setShowCableModal(false);
    setCableStep('details');
    setSelectedProvider('');
    setSelectedPackage('');
    setSmartCardNumber('');
    setCableAmount('');
    setVerifiedCardName(null);
    setPin(['', '', '', '']);
  };

  const closeEducationModal = () => {
    setShowEducationModal(false);
    setEducationStep('menu');
    setWaecQuantity(1);
    setWaecPhone('');
    setWaecGeneratedPins([]);
    setPin(['', '', '', '']);
  };

  const handleWaecPurchase = () => {
    setEducationStep('success');
    const newPins = Array.from({ length: waecQuantity }, (_, i) => ({
      pin: Array(3).fill(0).map(() => Math.floor(1000 + Math.random() * 9000)).join(''),
      serial: 'WR' + Array(3).fill(0).map(() => Math.floor(1000 + Math.random() * 9000)).join('')
    }));
    setWaecGeneratedPins(newPins);
  };

  const serviceGroups = [
    {
      title: "Bills Payments",
      items: [
        { 
          icon: <Smartphone size={24} />, 
          label: 'Airtime', 
          color: 'bg-blue-100 text-blue-600',
          onClick: () => setShowAirtimeModal(true)
        },
        { 
          icon: <Wifi size={24} />, 
          label: 'Data', 
          color: 'bg-green-100 text-green-600',
          onClick: () => setShowDataModal(true)
        },
        { icon: <Trophy size={24} />, label: 'Betting', color: 'bg-orange-100 text-orange-600' },
        { 
          icon: <GraduationCap size={24} />, 
          label: 'Education', 
          color: 'bg-purple-100 text-purple-600',
          onClick: () => setShowEducationModal(true)
        },
        { 
          icon: <Zap size={24} />, 
          label: 'Electricity', 
          color: 'bg-yellow-100 text-yellow-600',
          onClick: () => setShowElectricityModal(true) 
        },
        { 
          icon: <Tv size={24} />, 
          label: 'Cable TV', 
          color: 'bg-red-100 text-red-600',
          onClick: () => setShowCableModal(true)
        },
      ]
    },
    {
      title: "Digital Services",
      items: [
        { icon: <Rocket size={24} />, label: 'Social Boost', color: 'bg-indigo-100 text-indigo-600' },
        { icon: <Cpu size={24} />, label: 'eSIM', color: 'bg-cyan-100 text-cyan-600' },
        { icon: <Shield size={24} />, label: 'Proxies', color: 'bg-slate-100 text-slate-600' },
        { icon: <Megaphone size={24} />, label: 'Marketing', color: 'bg-pink-100 text-pink-600' },
        { icon: <CreditCard size={24} />, label: 'Virtual Cards', color: 'bg-teal-100 text-teal-600' },
        { icon: <Calendar size={24} />, label: 'Bookings', color: 'bg-lime-100 text-lime-600' },
      ]
    }
  ];

  return (
    <>
      <div className="bg-white p-6 rounded-2xl border shadow-sm h-full overflow-y-auto">
         <h3 className="font-bold text-gray-800 mb-4">Services</h3>
         <div className="space-y-6">
            {serviceGroups.map((group) => (
              <div key={group.title}>
                <h4 className="text-xs font-semibold text-gray-500 uppercase mb-3 tracking-wider">{group.title}</h4>
                <div className="grid grid-cols-3 gap-4">
                  {group.items.map((item, index) => (
                    <button 
                      key={index}
                      onClick={item.onClick}
                      className="flex flex-col items-center gap-2 p-4 rounded-xl hover:bg-gray-50 transition-colors border border-transparent hover:border-gray-100"
                    >
                      <div className={`w-12 h-12 rounded-full flex items-center justify-center ${item.color.split(' ')[0]} ${item.color.split(' ')[1]}`}>
                         {item.icon}
                      </div>
                      <span className="text-xs font-semibold text-gray-700 text-center">{item.label}</span>
                    </button>
                  ))}
                </div>
              </div>
            ))}
         </div>
      </div>

      {/* Airtime Modal */}
      {showAirtimeModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm">
          <div className="bg-white rounded-2xl w-full max-w-md shadow-2xl animate-in fade-in zoom-in duration-200">
            <div className="flex items-center justify-between p-6 border-b border-gray-100">
              <h3 className="text-xl font-bold text-gray-900">{airtimeStep === 'details' ? 'Buy Airtime' : 'Enter Transaction PIN'}</h3>
              <button 
                onClick={closeAirtimeModal}
                className="p-2 hover:bg-gray-100 rounded-full transition-colors"
              >
                <X size={20} className="text-gray-500" />
              </button>
            </div>
            
            <div className="p-6 space-y-6">
              {airtimeStep === 'details' ? (
                <>
                  <div className="space-y-4">
                    <label className="text-sm font-medium text-gray-700">Select Network</label>
                    <div className="grid grid-cols-4 gap-3">
                      {networks.map((network) => (
                        <button
                          key={network.id}
                          onClick={() => setSelectedNetwork(network.id)}
                          className={`relative flex flex-col items-center gap-2 p-3 rounded-xl border transition-all ${
                            selectedNetwork === network.id 
                              ? 'border-[#1D6A4A] bg-[#1D6A4A]/5 ring-1 ring-[#1D6A4A]' 
                              : 'border-gray-200 hover:border-gray-300 hover:bg-gray-50'
                          }`}
                        >
                          <div className={`w-8 h-8 rounded-full ${network.color}`} />
                          <span className="text-[10px] font-bold">{network.id}</span>
                          {selectedNetwork === network.id && (
                            <div className="absolute top-1 right-1 w-4 h-4 bg-[#1D6A4A] rounded-full flex items-center justify-center text-white">
                              <Check size={10} strokeWidth={4} />
                            </div>
                          )}
                        </button>
                      ))}
                    </div>
                  </div>

                  <div className="space-y-2">
                    <label className="text-sm font-medium text-gray-700">Phone Number</label>
                    <div className="relative">
                      <Smartphone className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 h-5 w-5" />
                      <input 
                        type="tel" 
                        placeholder="0801 234 5678"
                        className="w-full pl-12 pr-4 py-3 rounded-xl border border-gray-200 focus:border-[#1D6A4A] focus:ring-2 focus:ring-[#1D6A4A]/20 outline-none transition-all placeholder:text-gray-300 font-medium"
                      />
                    </div>
                  </div>

                  <div className="space-y-2">
                    <label className="text-sm font-medium text-gray-700">Amount</label>
                    <div className="relative">
                      <span className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500 font-medium">₦</span>
                      <input 
                        type="number" 
                        placeholder="0.00"
                        className="w-full pl-8 pr-4 py-3 rounded-xl border border-gray-200 focus:border-[#1D6A4A] focus:ring-2 focus:ring-[#1D6A4A]/20 outline-none transition-all font-bold text-lg text-gray-900 placeholder:text-gray-300"
                      />
                    </div>
                  </div>

                  <button 
                    onClick={() => setAirtimeStep('pin')}
                    className="w-full bg-[#1D6A4A] hover:bg-[#155a3d] text-white font-bold py-4 rounded-xl transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 flex items-center justify-center gap-2"
                  >
                    Continue
                  </button>
                </>
              ) : (
                <div className="py-4 space-y-8">
                  <div className="text-center space-y-2">
                    <div className="w-16 h-16 bg-[#1D6A4A]/10 rounded-full flex items-center justify-center mx-auto mb-4">
                      <Lock className="w-8 h-8 text-[#1D6A4A]" />
                    </div>
                    <h4 className="font-bold text-gray-900">Enter your 4-digit PIN</h4>
                    <p className="text-sm text-gray-500 px-8">
                      Please enter your transaction PIN to confirm this purchase.
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
                        className="w-14 h-14 rounded-xl border-2 border-gray-200 focus:border-[#1D6A4A] text-center text-2xl font-bold outline-none transition-all bg-gray-50 focus:bg-white"
                      />
                    ))}
                  </div>

                  <button 
                    onClick={() => {
                      alert('Transaction Processing...');
                      closeAirtimeModal();
                    }}
                    disabled={pin.some(d => !d)}
                    className="w-full bg-[#1D6A4A] hover:bg-[#155a3d] disabled:bg-gray-300 disabled:cursor-not-allowed text-white font-bold py-4 rounded-xl transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 flex items-center justify-center gap-2 mt-8"
                  >
                    Confirm Payment
                  </button>

                   <button 
                    onClick={() => setAirtimeStep('details')}
                    className="w-full text-gray-500 font-medium py-2 hover:text-gray-700 transition-colors"
                  >
                    Back
                  </button>
                </div>
              )}
            </div>
          </div>
        </div>
      )}

      {/* Data Modal */}
      {showDataModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm">
          <div className="bg-white rounded-2xl w-full max-w-md shadow-2xl animate-in fade-in zoom-in duration-200">
            <div className="flex items-center justify-between p-6 border-b border-gray-100">
              <h3 className="text-xl font-bold text-gray-900">{dataStep === 'details' ? 'Buy Data' : 'Enter Transaction PIN'}</h3>
              <button 
                onClick={closeDataModal}
                className="p-2 hover:bg-gray-100 rounded-full transition-colors"
              >
                <X size={20} className="text-gray-500" />
              </button>
            </div>
            
            <div className="p-6 space-y-6">
              {dataStep === 'details' ? (
                <>
                  <div className="space-y-4">
                    <label className="text-sm font-medium text-gray-700">Select Network</label>
                    <div className="grid grid-cols-4 gap-3">
                      {networks.map((network) => (
                        <button
                          key={network.id}
                          onClick={() => {
                            setSelectedNetwork(network.id);
                            setSelectedPlan('');
                          }}
                          className={`relative flex flex-col items-center gap-2 p-3 rounded-xl border transition-all ${
                            selectedNetwork === network.id 
                              ? 'border-[#1D6A4A] bg-[#1D6A4A]/5 ring-1 ring-[#1D6A4A]' 
                              : 'border-gray-200 hover:border-gray-300 hover:bg-gray-50'
                          }`}
                        >
                          <div className={`w-8 h-8 rounded-full ${network.color}`} />
                          <span className="text-[10px] font-bold">{network.id}</span>
                          {selectedNetwork === network.id && (
                            <div className="absolute top-1 right-1 w-4 h-4 bg-[#1D6A4A] rounded-full flex items-center justify-center text-white">
                              <Check size={10} strokeWidth={4} />
                            </div>
                          )}
                        </button>
                      ))}
                    </div>
                  </div>

                  <div className="space-y-2">
                     <label className="text-sm font-medium text-gray-700">Data Plan</label>
                     <div className="relative">
                       <button 
                         onClick={() => setShowPlanSelection(true)}
                         className="w-full relative pl-4 pr-10 py-3 rounded-xl border border-gray-200 focus:border-[#1D6A4A] focus:ring-2 focus:ring-[#1D6A4A]/20 outline-none transition-all bg-white font-medium text-gray-900 text-left"
                       >
                         {/* @ts-ignore */}
                         {selectedPlan && dataPlans[selectedNetwork]?.find((p: any) => p.id === selectedPlan)
                           // @ts-ignore
                           ? `${dataPlans[selectedNetwork].find((p: any) => p.id === selectedPlan).name} - ₦${dataPlans[selectedNetwork].find((p: any) => p.id === selectedPlan).price}`
                           : <span className="text-gray-400">Select a plan</span>
                         }
                         <ChevronDown className="absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 pointer-events-none" size={20} />
                       </button>
                     </div>
                  </div>

                  {/* Plan Selection Bottom Sheet */}
                  {showPlanSelection && (
                    <div className="fixed inset-0 z-[60] flex justify-end flex-col">
                      <div 
                        className="absolute inset-0 bg-black/60 backdrop-blur-sm"
                        onClick={() => setShowPlanSelection(false)}
                      />
                      <div className="relative bg-white rounded-t-3xl p-6 shadow-2xl animate-in slide-in-from-bottom duration-300 max-h-[70vh] flex flex-col">
                        <div className="flex items-center justify-between mb-6">
                          <h3 className="text-lg font-bold text-gray-900">Select Data Plan</h3>
                          <button 
                            onClick={() => setShowPlanSelection(false)}
                            className="p-2 hover:bg-gray-100 rounded-full transition-colors"
                          >
                            <X size={20} className="text-gray-500" />
                          </button>
                        </div>
                        
                        <div className="overflow-y-auto space-y-3 pb-8">
                          {/* @ts-ignore */}
                          {dataPlans[selectedNetwork]?.map((plan: any) => (
                            <button
                              key={plan.id}
                              onClick={() => {
                                setSelectedPlan(plan.id);
                                setShowPlanSelection(false);
                              }}
                              className={`w-full flex items-center justify-between p-4 rounded-xl border transition-all ${
                                selectedPlan === plan.id
                                  ? 'border-[#1D6A4A] bg-[#1D6A4A]/5 ring-1 ring-[#1D6A4A]'
                                  : 'border-gray-100 hover:border-gray-300 hover:bg-gray-50'
                              }`}
                            >
                              <div className="text-left">
                                <p className="font-bold text-gray-900">{plan.name}</p>
                                <p className="text-xs text-gray-500">{plan.validity}</p>
                              </div>
                              <p className="font-bold text-[#1D6A4A]">₦{plan.price}</p>
                            </button>
                          ))}
                        </div>
                      </div>
                    </div>
                  )}

                  <div className="space-y-2">
                    <label className="text-sm font-medium text-gray-700">Phone Number</label>
                    <div className="relative">
                      <Smartphone className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 h-5 w-5" />
                      <input 
                        type="tel" 
                        placeholder="0801 234 5678"
                        className="w-full pl-12 pr-4 py-3 rounded-xl border border-gray-200 focus:border-[#1D6A4A] focus:ring-2 focus:ring-[#1D6A4A]/20 outline-none transition-all placeholder:text-gray-300 font-medium"
                      />
                    </div>
                  </div>

                  <div className="space-y-2">
                    <label className="text-sm font-medium text-gray-700">Amount</label>
                    <div className="w-full px-4 py-3 rounded-xl bg-gray-50 border border-gray-200 font-bold text-gray-500">
                      {selectedPlan 
                        // @ts-ignore
                        ? `₦ ${dataPlans[selectedNetwork]?.find((p: any) => p.id === selectedPlan)?.price || '0.00'}`
                        : '₦ 0.00'
                      }
                    </div>
                  </div>

                  <button 
                    onClick={() => setDataStep('pin')}
                    disabled={!selectedPlan}
                    className="w-full bg-[#1D6A4A] hover:bg-[#155a3d] disabled:bg-gray-300 disabled:cursor-not-allowed text-white font-bold py-4 rounded-xl transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 flex items-center justify-center gap-2"
                  >
                    Continue
                  </button>
                </>
              ) : (
                <div className="py-4 space-y-8">
                  <div className="text-center space-y-2">
                    <div className="w-16 h-16 bg-[#1D6A4A]/10 rounded-full flex items-center justify-center mx-auto mb-4">
                      <Lock className="w-8 h-8 text-[#1D6A4A]" />
                    </div>
                    <h4 className="font-bold text-gray-900">Enter your 4-digit PIN</h4>
                    <p className="text-sm text-gray-500 px-8">
                      Please enter your transaction PIN to confirm this purchase.
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
                        className="w-14 h-14 rounded-xl border-2 border-gray-200 focus:border-[#1D6A4A] text-center text-2xl font-bold outline-none transition-all bg-gray-50 focus:bg-white"
                      />
                    ))}
                  </div>

                  <button 
                    onClick={() => {
                      alert('Data Purchase Processing...');
                      closeDataModal();
                    }}
                     disabled={pin.some(d => !d)}
                    className="w-full bg-[#1D6A4A] hover:bg-[#155a3d] disabled:bg-gray-300 disabled:cursor-not-allowed text-white font-bold py-4 rounded-xl transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 flex items-center justify-center gap-2 mt-8"
                  >
                    Confirm Payment
                  </button>

                   <button 
                    onClick={() => setDataStep('details')}
                    className="w-full text-gray-500 font-medium py-2 hover:text-gray-700 transition-colors"
                  >
                    Back
                  </button>
                </div>
              )}
            </div>
          </div>
        </div>
      )}

      {/* Electricity Modal */}
      {showElectricityModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm">
          <div className="bg-white rounded-2xl w-full max-w-md shadow-2xl animate-in fade-in zoom-in duration-200">
            <div className="flex items-center justify-between p-6 border-b border-gray-100">
              <h3 className="text-xl font-bold text-gray-900">{electricityStep === 'details' ? 'Electricity Bill' : 'Enter Transaction PIN'}</h3>
              <button 
                onClick={closeElectricityModal}
                className="p-2 hover:bg-gray-100 rounded-full transition-colors"
              >
                <X size={20} className="text-gray-500" />
              </button>
            </div>
            
            <div className="p-6 space-y-6">
              {electricityStep === 'details' ? (
                <>
                  <div className="space-y-4">
                    <label className="text-sm font-medium text-gray-700">Select Distribution Company</label>
                    <div className="space-y-2">
                      {/* Mobile View - Bottom Sheet Trigger */}
                      <button 
                         onClick={() => setShowDiscoSelection(true)}
                         className="md:hidden w-full relative pl-4 pr-10 py-3 rounded-xl border border-gray-200 focus:border-[#1D6A4A] focus:ring-2 focus:ring-[#1D6A4A]/20 outline-none transition-all bg-white font-medium text-gray-900 text-left"
                       >
                         {selectedDisco 
                           // @ts-ignore
                           ? `${discos.find((d) => d.id === selectedDisco)?.name} (${discos.find((d) => d.id === selectedDisco)?.short})`
                           : <span className="text-gray-400">Select Disco</span>
                         }
                         <ChevronDown className="absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 pointer-events-none" size={20} />
                       </button>

                       {/* Desktop View - Native Select */}
                       <div className="hidden md:block relative">
                         <select 
                           value={selectedDisco}
                           onChange={(e) => {
                             setSelectedDisco(e.target.value);
                             setVerifiedName(null);
                           }}
                           className="w-full pl-4 pr-10 py-3 rounded-xl border border-gray-200 focus:border-[#1D6A4A] focus:ring-2 focus:ring-[#1D6A4A]/20 outline-none transition-all appearance-none bg-white font-medium text-gray-900"
                         >
                           <option value="" disabled>Select Disco</option>
                           {discos.map((disco) => (
                             <option key={disco.id} value={disco.id}>{disco.name} ({disco.short})</option>
                           ))}
                         </select>
                         <ChevronDown className="absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 pointer-events-none" size={20} />
                       </div>
                    </div>
                  </div>

                  {/* Disco Selection Bottom Sheet */}
                  {showDiscoSelection && (
                    <div className="fixed inset-0 z-[60] flex justify-end flex-col">
                      <div 
                        className="absolute inset-0 bg-black/60 backdrop-blur-sm"
                        onClick={() => setShowDiscoSelection(false)}
                      />
                      <div className="relative bg-white rounded-t-3xl p-6 shadow-2xl animate-in slide-in-from-bottom duration-300 max-h-[70vh] flex flex-col">
                        <div className="flex items-center justify-between mb-6">
                          <h3 className="text-lg font-bold text-gray-900">Select Distribution Company</h3>
                          <button 
                            onClick={() => setShowDiscoSelection(false)}
                            className="p-2 hover:bg-gray-100 rounded-full transition-colors"
                          >
                            <X size={20} className="text-gray-500" />
                          </button>
                        </div>
                        
                        <div className="overflow-y-auto space-y-3 pb-8">
                          {discos.map((disco) => (
                            <button
                              key={disco.id}
                              onClick={() => {
                                setSelectedDisco(disco.id);
                                setVerifiedName(null);
                                setShowDiscoSelection(false);
                              }}
                              className={`w-full flex items-center gap-4 p-4 rounded-xl border transition-all ${
                                selectedDisco === disco.id
                                  ? 'border-[#1D6A4A] bg-[#1D6A4A]/5 ring-1 ring-[#1D6A4A]'
                                  : 'border-gray-100 hover:border-gray-300 hover:bg-gray-50'
                              }`}
                            >
                              <div className={`w-10 h-10 rounded-full ${disco.bg} flex items-center justify-center text-sm font-bold ${disco.text}`}>
                                {disco.short.substring(0, 1)}
                              </div>
                              <div className="text-left flex-1">
                                <p className="font-bold text-gray-900 text-sm">{disco.name}</p>
                                <p className="text-xs text-gray-500">{disco.short}</p>
                              </div>
                              {selectedDisco === disco.id && <Check size={20} className="text-[#1D6A4A]" />}
                            </button>
                          ))}
                        </div>
                      </div>
                    </div>
                  )}

                  <div className="space-y-2">
                    <label className="text-sm font-medium text-gray-700">Meter Type</label>
                    <div className="flex bg-gray-100 p-1 rounded-xl">
                      {['Prepaid', 'Postpaid'].map((type) => (
                        <button
                          key={type}
                          // @ts-ignore
                          onClick={() => setMeterType(type)}
                          className={`flex-1 py-2 rounded-lg text-sm font-bold transition-all ${
                            meterType === type 
                              ? 'bg-[#1D6A4A] text-white shadow-sm' 
                              : 'text-gray-500 hover:text-gray-700'
                          }`}
                        >
                          {type}
                        </button>
                      ))}
                    </div>
                  </div>

                  <div className="space-y-2">
                    <label className="text-sm font-medium text-gray-700">Meter Number</label>
                    <div className="relative">
                      <input 
                        type="number" 
                        value={meterNumber}
                        onChange={(e) => {
                          const val = e.target.value;
                          setMeterNumber(val);
                          setVerifiedName(null);
                          if (val.length >= 11 && selectedDisco) {
                              handleVerifyMeter(val);
                          }
                        }}
                        placeholder="Enter Meter Number"
                        className="w-full pl-4 pr-24 py-3 rounded-xl border border-gray-200 focus:border-[#1D6A4A] focus:ring-2 focus:ring-[#1D6A4A]/20 outline-none transition-all font-medium"
                      />
                      <button 
                        onClick={() => handleVerifyMeter()}
                        disabled={!selectedDisco || meterNumber.length < 5 || isVerifying}
                        className="absolute right-2 top-1/2 -translate-y-1/2 px-3 py-1.5 text-xs font-bold text-[#1D6A4A] bg-[#1D6A4A]/10 rounded-lg hover:bg-[#1D6A4A]/20 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
                      >
                        {isVerifying ? <Loader2 className="w-4 h-4 animate-spin" /> : 'Verify'}
                      </button>
                    </div>
                    {verifiedName && (
                      <div className="p-3 bg-green-50 rounded-xl border border-green-100 flex items-center gap-2 text-green-700 text-xs font-bold animate-in fade-in slide-in-from-top-2">
                        <Check size={14} />
                        {verifiedName}
                      </div>
                    )}
                  </div>

                  <div className="space-y-2">
                    <label className="text-sm font-medium text-gray-700">Amount</label>
                    <div className="relative">
                      <span className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500 font-bold">₦</span>
                      <input 
                        type="number" 
                        value={amount}
                        onChange={(e) => setAmount(e.target.value)}
                        placeholder="0.00"
                        className="w-full pl-8 pr-4 py-3 rounded-xl border border-gray-200 focus:border-[#1D6A4A] focus:ring-2 focus:ring-[#1D6A4A]/20 outline-none transition-all font-bold text-lg"
                      />
                    </div>
                  </div>

                  <button 
                    onClick={() => setElectricityStep('pin')}
                    disabled={!selectedDisco || !meterNumber || !amount}
                    className="w-full bg-[#1D6A4A] hover:bg-[#155a3d] disabled:bg-gray-300 disabled:cursor-not-allowed text-white font-bold py-4 rounded-xl transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 flex items-center justify-center gap-2 mt-4"
                  >
                    Proceed
                  </button>
                </>
              ) : electricityStep === 'pin' ? (
                <div className="py-4 space-y-8">
                  <div className="text-center space-y-2">
                    <div className="w-16 h-16 bg-[#1D6A4A]/10 rounded-full flex items-center justify-center mx-auto mb-4">
                      <Lock className="w-8 h-8 text-[#1D6A4A]" />
                    </div>
                    <h4 className="font-bold text-gray-900">Enter your 4-digit PIN</h4>
                    <p className="text-sm text-gray-500 px-8">
                      Confirm purchase of ₦{amount} electricity for {verifiedName || meterNumber}
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
                        className="w-14 h-14 rounded-xl border-2 border-gray-200 focus:border-[#1D6A4A] text-center text-2xl font-bold outline-none transition-all bg-gray-50 focus:bg-white"
                      />
                    ))}
                  </div>

                  <button 
                    onClick={() => {
                      // Generate random 20 digit token (5 groups of 4)
                      const token = Array(5).fill(0).map(() => Math.floor(1000 + Math.random() * 9000)).join(' ');
                      setGeneratedToken(token);
                      setElectricityStep('success');
                    }}
                    disabled={pin.some(d => !d)}
                    className="w-full bg-[#1D6A4A] hover:bg-[#155a3d] disabled:bg-gray-300 disabled:cursor-not-allowed text-white font-bold py-4 rounded-xl transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 flex items-center justify-center gap-2 mt-8"
                  >
                    Confirm Payment
                  </button>

                   <button 
                    onClick={() => setElectricityStep('details')}
                    className="w-full text-gray-500 font-medium py-2 hover:text-gray-700 transition-colors"
                  >
                    Back
                  </button>
                </div>
              ) : (
                 <div className="py-4 space-y-6">
                  <div className="text-center space-y-2">
                    <div className="w-20 h-20 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4 animate-in zoom-in duration-300">
                      <Check className="w-10 h-10 text-green-600" strokeWidth={3} />
                    </div>
                    <h4 className="text-xl font-bold text-gray-900">Payment Successful!</h4>
                    <p className="text-sm text-gray-500">
                      Your electricity token has been generated successfully.
                    </p>
                  </div>

                  <div className="bg-gray-50 p-6 rounded-2xl border border-dashed border-gray-300 space-y-4">
                    <div className="text-center">
                       <p className="text-xs font-bold text-gray-400 uppercase tracking-wider mb-2">Token Code</p>
                       <p className="text-2xl md:text-3xl font-mono font-bold text-[#1D6A4A] tracking-wider select-all">
                         {generatedToken}
                       </p>
                    </div>
                    <button 
                      onClick={() => {
                        navigator.clipboard.writeText(generatedToken.replace(/\s/g, ''));
                        alert('Token copied!');
                      }}
                      className="w-full flex items-center justify-center gap-2 py-2 text-sm font-bold text-[#1D6A4A] bg-[#1D6A4A]/10 rounded-lg hover:bg-[#1D6A4A]/20 transition-colors"
                    >
                      <Copy size={16} />
                      Copy Token
                    </button>
                  </div>

                  <div className="space-y-3 pt-2">
                     <div className="flex justify-between items-center text-sm">
                       <span className="text-gray-500">Meter Number</span>
                       <span className="font-bold text-gray-900">{meterNumber}</span>
                     </div>
                      <div className="flex justify-between items-center text-sm">
                       <span className="text-gray-500">Amount</span>
                       <span className="font-bold text-gray-900">₦{amount}</span>
                     </div>
                      <div className="flex justify-between items-center text-sm">
                       <span className="text-gray-500">Disco</span>
                       <span className="font-bold text-gray-900">{discos.find(d => d.id === selectedDisco)?.short}</span>
                     </div>
                  </div>

                  <button 
                    onClick={closeElectricityModal}
                    className="w-full bg-[#1D6A4A] hover:bg-[#155a3d] text-white font-bold py-4 rounded-xl transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 mt-4"
                  >
                    Done
                  </button>
                </div>
              )}
            </div>
          </div>
        </div>
      )}

      {/* Cable TV Modal */}
      {showCableModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm">
          <div className="bg-white rounded-2xl w-full max-w-md shadow-2xl animate-in fade-in zoom-in duration-200">
            <div className="flex items-center justify-between p-6 border-b border-gray-100">
              <h3 className="text-xl font-bold text-gray-900">{cableStep === 'details' ? 'Cable TV Subscription' : 'Enter Transaction PIN'}</h3>
              <button 
                onClick={closeCableModal}
                className="p-2 hover:bg-gray-100 rounded-full transition-colors"
              >
                <X size={20} className="text-gray-500" />
              </button>
            </div>
            
            <div className="p-6 space-y-6">
              {cableStep === 'details' ? (
                <>
                  <div className="space-y-4">
                    {/* Provider Selection */}
                    <div className="space-y-2">
                      <label className="text-sm font-medium text-gray-700">Select Provider</label>
                      <select
                        value={selectedProvider}
                        onChange={(e) => {
                          setSelectedProvider(e.target.value);
                          setSelectedPackage('');
                          setCableAmount('');
                        }}
                        className="w-full px-4 py-3 rounded-xl border border-gray-200 focus:border-[#1D6A4A] focus:ring-2 focus:ring-[#1D6A4A]/20 outline-none transition-all font-medium bg-white"
                      >
                        <option value="">Select Cable Provider</option>
                        {cableProviders.map((provider) => (
                          <option key={provider.id} value={provider.name}>
                            {provider.name}
                          </option>
                        ))}
                      </select>
                    </div>

                    {/* Package Selection */}
                    <div className="space-y-2">
                       <label className="text-sm font-medium text-gray-700">Select Package</label>
                       <select
                         value={selectedPackage}
                         onChange={(e) => {
                           setSelectedPackage(e.target.value);
                           // @ts-ignore
                           const pkg = cablePackages[selectedProvider]?.find((p: any) => p.name === e.target.value);
                           if (pkg) setCableAmount(pkg.price.toString());
                         }}
                         disabled={!selectedProvider}
                         className="w-full px-4 py-3 rounded-xl border border-gray-200 focus:border-[#1D6A4A] focus:ring-2 focus:ring-[#1D6A4A]/20 outline-none transition-all font-medium bg-white disabled:bg-gray-100 disabled:text-gray-400"
                       >
                         <option value="">Select Package</option>
                         {/* @ts-ignore */}
                         {selectedProvider && cablePackages[selectedProvider]?.map((pkg: any) => (
                           <option key={pkg.name} value={pkg.name}>
                             {pkg.name} - ₦{pkg.price}
                           </option>
                         ))}
                       </select>
                    </div>
                  </div>

                  <div className="space-y-2">
                    <label className="text-sm font-medium text-gray-700">Smart Card Number</label>
                    <div className="relative">
                      <input 
                        type="text" 
                        value={smartCardNumber}
                        onChange={(e) => {
                           setSmartCardNumber(e.target.value);
                           setVerifiedCardName(null);
                           if(e.target.value.length >= 10) verifySmartCard(e.target.value);
                        }}
                        placeholder="Enter Smart Card Number"
                        className="w-full pl-4 pr-12 py-3 rounded-xl border border-gray-200 focus:border-[#1D6A4A] focus:ring-2 focus:ring-[#1D6A4A]/20 outline-none transition-all font-medium"
                      />
                       <div className="absolute right-3 top-1/2 -translate-y-1/2">
                         {isVerifyingCard ? (
                           <Loader2 className="w-5 h-5 text-[#1D6A4A] animate-spin" />
                         ) : verifiedCardName ? (
                           <Check className="w-5 h-5 text-green-600" />
                         ) : null}
                       </div>
                    </div>
                    {verifiedCardName && (
                      <div className="p-3 bg-green-50 rounded-xl border border-green-100 flex items-center gap-2 text-green-700 text-xs font-bold animate-in fade-in slide-in-from-top-2">
                        <Check size={14} />
                        {verifiedCardName}
                      </div>
                    )}
                  </div>

                  <div className="space-y-2">
                    <label className="text-sm font-medium text-gray-700">Amount to Pay</label>
                    <div className="relative">
                      <span className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500 font-bold">₦</span>
                      <input 
                        type="number" 
                        value={cableAmount}
                        readOnly
                        className="w-full pl-8 pr-4 py-3 rounded-xl border border-gray-200 bg-gray-50 font-bold text-lg text-gray-500 cursor-not-allowed"
                      />
                    </div>
                  </div>

                  <button 
                    onClick={() => setCableStep('pin')}
                    disabled={!selectedProvider || !selectedPackage || !verifiedCardName || !cableAmount}
                    className="w-full bg-[#1D6A4A] hover:bg-[#155a3d] disabled:bg-gray-300 disabled:cursor-not-allowed text-white font-bold py-4 rounded-xl transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 flex items-center justify-center gap-2 mt-4"
                  >
                    Proceed
                  </button>
                </>
              ) : cableStep === 'pin' ? (
                <div className="py-4 space-y-8">
                  <div className="text-center space-y-2">
                     <div className="w-16 h-16 bg-[#1D6A4A]/10 rounded-full flex items-center justify-center mx-auto mb-4">
                      <Lock className="w-8 h-8 text-[#1D6A4A]" />
                    </div>
                    <h4 className="font-bold text-gray-900">Enter your 4-digit PIN</h4>
                    <p className="text-sm text-gray-500 px-8">
                      Confirm ₦{cableAmount} subscription for {verifiedCardName}
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
                        className="w-14 h-14 rounded-xl border-2 border-gray-200 focus:border-[#1D6A4A] text-center text-2xl font-bold outline-none transition-all bg-gray-50 focus:bg-white"
                      />
                    ))}
                  </div>

                  <button 
                    onClick={() => {
                      // Process Payment Simulation
                      setCableStep('success');
                    }}
                    disabled={pin.some(p => !p)}
                    className="w-full bg-[#1D6A4A] hover:bg-[#155a3d] disabled:bg-gray-300 disabled:cursor-not-allowed text-white font-bold py-4 rounded-xl transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 mt-8"
                  >
                    Confirm Payment
                  </button>
                </div>
              ) : (
                 <div className="py-4 space-y-6">
                  <div className="text-center space-y-2">
                    <div className="w-20 h-20 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4 animate-in zoom-in duration-300">
                      <Check className="w-10 h-10 text-green-600" strokeWidth={3} />
                    </div>
                    <h4 className="text-xl font-bold text-gray-900">Payment Successful!</h4>
                    <p className="text-sm text-gray-500">
                      Your cable subscription has been processed successfully.
                    </p>
                  </div>

                  <div className="bg-gray-50 p-6 rounded-2xl border border-dashed border-gray-300 space-y-4">
                     <div className="flex justify-between items-center text-sm">
                       <span className="text-gray-500">Smart Card</span>
                       <span className="font-bold text-gray-900">{smartCardNumber}</span>
                     </div>
                      <div className="flex justify-between items-center text-sm">
                       <span className="text-gray-500">Beneficiary</span>
                       <span className="font-bold text-gray-900">{verifiedCardName}</span>
                     </div>
                      <div className="flex justify-between items-center text-sm">
                       <span className="text-gray-500">Package</span>
                       <span className="font-bold text-gray-900">{selectedPackage}</span>
                     </div>
                     <div className="flex justify-between items-center text-sm">
                       <span className="text-gray-500">Amount</span>
                       <span className="font-bold text-gray-900">₦{cableAmount}</span>
                     </div>
                  </div>

                  <button 
                    onClick={closeCableModal}
                    className="w-full bg-[#1D6A4A] hover:bg-[#155a3d] text-white font-bold py-4 rounded-xl transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 mt-4"
                  >
                    Done
                  </button>
                </div>
              )}
            </div>
          </div>
        </div>
      )}

      {/* Education Modal */}
      {showEducationModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm">
          <div className="bg-white rounded-2xl w-full max-w-md shadow-2xl animate-in fade-in zoom-in duration-200">
            <div className="flex items-center justify-between p-6 border-b border-gray-100">
              <h3 className="text-xl font-bold text-gray-900">
                {educationStep === 'menu' ? 'Education' : 
                 educationStep === 'success' ? 'Purchase Successful' :
                 educationStep === 'pin' ? 'Enter PIN' : 'WAEC Result Checker'}
              </h3>
              <button 
                onClick={closeEducationModal}
                className="p-2 hover:bg-gray-100 rounded-full transition-colors"
              >
                <X size={20} className="text-gray-500" />
              </button>
            </div>
            
            <div className="p-6 space-y-6 max-h-[70vh] overflow-y-auto">
              {educationStep === 'menu' ? (
                <div className="space-y-4">
                  <button 
                    onClick={() => setEducationStep('waec-details')}
                    className="w-full flex items-center gap-4 p-4 rounded-xl border border-gray-200 hover:border-[#1D6A4A] hover:bg-[#1D6A4A]/5 transition-all group shadow-sm bg-white"
                  >
                    <div className="w-12 h-12 rounded-xl bg-green-50 flex items-center justify-center text-[#1b5e20] group-hover:scale-110 transition-transform">
                      <GraduationCap size={24} />
                    </div>
                    <div className="flex-1 text-left">
                      <p className="font-bold text-gray-900 text-lg">WAEC</p>
                      <p className="text-xs text-gray-500">Buy WAEC Result Checker PIN</p>
                    </div>
                    <ChevronRight size={20} className="text-gray-400 group-hover:text-[#1D6A4A]" />
                  </button>
                  {/* Placeholder for future options */}
                </div>
              ) : educationStep === 'waec-details' ? (
                <>
                   <div className="bg-[#1D6A4A] rounded-xl p-6 text-center text-white space-y-2">
                      <GraduationCap className="w-12 h-12 mx-auto text-white/90" />
                      <h4 className="font-bold text-lg">WAEC Result Checker PIN</h4>
                      <p className="text-white/80">₦ {WAEC_PRICE.toLocaleString()} / pin</p>
                   </div>

                   <div className="flex items-center justify-between p-4 bg-gray-50 rounded-xl border border-gray-100">
                      <span className="font-bold text-gray-900">Quantity</span>
                      <div className="flex items-center gap-4 bg-white rounded-lg border border-gray-200 p-1">
                         <button 
                           onClick={() => waecQuantity > 1 && setWaecQuantity(q => q - 1)}
                           className="w-8 h-8 flex items-center justify-center rounded-md hover:bg-gray-100 text-gray-600 disabled:opacity-50"
                           disabled={waecQuantity <= 1}
                         >
                            -
                         </button>
                         <span className="w-8 text-center font-bold text-gray-900">{waecQuantity}</span>
                          <button 
                           onClick={() => waecQuantity < 10 && setWaecQuantity(q => q + 1)}
                           className="w-8 h-8 flex items-center justify-center rounded-md hover:bg-gray-100 text-gray-600 disabled:opacity-50"
                           disabled={waecQuantity >= 10}
                         >
                            +
                         </button>
                      </div>
                   </div>

                   <div className="flex justify-between items-center p-4 bg-gray-50 rounded-xl border border-gray-100">
                      <span className="font-medium text-gray-700">Total Amount</span>
                      <span className="text-xl font-bold text-[#1D6A4A]">₦ {(WAEC_PRICE * waecQuantity).toLocaleString()}</span>
                   </div>

                   <div className="space-y-2">
                      <label className="text-sm font-medium text-gray-700">Phone Number</label>
                      <div className="relative">
                        <input 
                          type="tel" 
                          value={waecPhone}
                          onChange={(e) => setWaecPhone(e.target.value)}
                          placeholder="Enter phone number"
                          className="w-full pl-10 pr-4 py-3 rounded-xl border border-gray-200 focus:border-[#1D6A4A] focus:ring-2 focus:ring-[#1D6A4A]/20 outline-none transition-all font-medium bg-white text-gray-900"
                        />
                        <Smartphone className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 w-5 h-5" />
                      </div>
                   </div>

                   <div className="p-3 bg-blue-50 rounded-xl border border-blue-100 flex gap-3">
                      <div className="mt-0.5"><div className="w-4 h-4 rounded-full border-2 border-blue-400 flex items-center justify-center text-[10px] font-bold text-blue-500">i</div></div>
                      <p className="text-xs text-blue-800 leading-relaxed">
                        Your PIN(s) and Serial Number(s) will be displayed immediately after successful payment.
                      </p>
                   </div>

                   <button 
                      onClick={() => setEducationStep('pin')}
                      disabled={!waecPhone || waecPhone.length < 10}
                      className="w-full bg-[#1D6A4A] hover:bg-[#155a3d] disabled:bg-gray-300 disabled:cursor-not-allowed text-white font-bold py-4 rounded-xl transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5"
                    >
                      Pay Securely
                    </button>
                </>
              ) : educationStep === 'pin' ? (
                 <div className="py-4 space-y-8">
                  <div className="text-center space-y-2">
                     <div className="w-16 h-16 bg-[#1D6A4A]/10 rounded-full flex items-center justify-center mx-auto mb-4">
                      <Lock className="w-8 h-8 text-[#1D6A4A]" />
                    </div>
                    <h4 className="font-bold text-gray-900">Enter your 4-digit PIN</h4>
                    <p className="text-sm text-gray-500 px-8">
                      Confirm purchase of WAEC PIN(s) for ₦{(WAEC_PRICE * waecQuantity).toLocaleString()}
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
                        className="w-14 h-14 rounded-xl border-2 border-gray-200 focus:border-[#1D6A4A] text-center text-2xl font-bold outline-none transition-all bg-gray-50 focus:bg-white"
                      />
                    ))}
                  </div>

                  <button 
                    onClick={handleWaecPurchase}
                    disabled={pin.some(p => !p)}
                    className="w-full bg-[#1D6A4A] hover:bg-[#155a3d] disabled:bg-gray-300 disabled:cursor-not-allowed text-white font-bold py-4 rounded-xl transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 mt-8"
                  >
                    Confirm Payment
                  </button>
                   <button 
                    onClick={() => setEducationStep('waec-details')}
                    className="w-full text-gray-500 font-medium py-2 hover:text-gray-700 transition-colors"
                  >
                    Back
                  </button>
                </div>
              ) : (
                // Success Step
                 <div className="py-4 space-y-6">
                  <div className="text-center space-y-2">
                    <div className="w-20 h-20 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4 animate-in zoom-in duration-300">
                      <Check className="w-10 h-10 text-green-600" strokeWidth={3} />
                    </div>
                    <h4 className="text-xl font-bold text-gray-900">Purchase Successful!</h4>
                    <p className="text-sm text-gray-500">
                      You have successfully purchased {waecQuantity} WAEC PIN(s).
                    </p>
                  </div>

                  <div className="max-h-[300px] overflow-y-auto space-y-4 pr-1">
                    {waecGeneratedPins.map((item, index) => (
                      <div key={index} className="bg-gray-50 p-4 rounded-xl border border-gray-200 space-y-3">
                         <div className="flex justify-between items-start">
                            <span className="text-xs font-bold text-gray-400 uppercase">PIN {index + 1}</span>
                            <button 
                              onClick={() => {
                                navigator.clipboard.writeText(`PIN: ${item.pin} S/N: ${item.serial}`);
                                alert('Copied to clipboard');
                              }}
                              className="text-[#1D6A4A] hover:bg-[#1D6A4A]/10 p-1.5 rounded-lg transition-colors"
                            >
                              <Copy size={16} />
                            </button>
                         </div>
                         <div className="flex justify-between items-center">
                            <div>
                              <p className="text-xs text-gray-500">PIN</p>
                              <p className="font-mono font-bold text-gray-900">{item.pin}</p>
                            </div>
                            <div className="text-right">
                              <p className="text-xs text-gray-500">Serial No</p>
                              <p className="font-mono font-bold text-gray-900">{item.serial}</p>
                            </div>
                         </div>
                      </div>
                    ))}
                  </div>

                  <button 
                    onClick={closeEducationModal}
                    className="w-full bg-[#1D6A4A] hover:bg-[#155a3d] text-white font-bold py-4 rounded-xl transition-all shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 mt-4"
                  >
                    Done
                  </button>
                </div>
              )}
            </div>
          </div>
        </div>
      )}
    </>
  );
}
