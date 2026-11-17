'use client';

import React, { useState } from 'react';
import Sidebar from '@/components/Sidebar';
import Header from '@/components/Header';
import MobileNav from '@/components/MobileNav';
import { 
  Search, 
  Plus, 
  User, 
  Trash2, 
  Edit2, 
  MoreVertical, 
  Landmark, 
  Smartphone,
  Check,
  X,
  Loader2
} from 'lucide-react';

export default function BeneficiariesPage() {
  const [filter, setFilter] = useState('All');
  const [searchQuery, setSearchQuery] = useState('');
  const [showAddModal, setShowAddModal] = useState(false);

  // Add Beneficiary State
  const [addStep, setAddStep] = useState<'details' | 'success'>('details');
  const [newBeneficiary, setNewBeneficiary] = useState({
    type: 'Bank Transfer',
    bank: '',
    accountNumber: '',
    name: ''
  });
  const [isVerifying, setIsVerifying] = useState(false);

  const [beneficiaries, setBeneficiaries] = useState([
    { id: 1, name: 'Sarah Wilson', type: 'Bank Transfer', detail: 'GTBank • 0123456789', avatar: 'SW', color: 'bg-purple-100 text-purple-600' },
    { id: 2, name: 'John Doe', type: 'Bank Transfer', detail: 'Access Bank • 1234567890', avatar: 'JD', color: 'bg-blue-100 text-blue-600' },
    { id: 3, name: 'Mom', type: 'Airtime', detail: 'MTN • 08031234567', avatar: 'M', color: 'bg-yellow-100 text-yellow-600' },
    { id: 4, name: 'Mike Smith', type: 'Bank Transfer', detail: 'UBA • 9876543210', avatar: 'MS', color: 'bg-green-100 text-green-600' },
    { id: 5, name: 'Wife', type: 'Airtime', detail: 'Airtel • 08021234567', avatar: 'W', color: 'bg-pink-100 text-pink-600' },
  ]);

  const filteredBeneficiaries = beneficiaries.filter(b => {
    if (filter !== 'All' && b.type !== filter) return false;
    if (searchQuery && !b.name.toLowerCase().includes(searchQuery.toLowerCase())) return false;
    return true;
  });

  const handleVerifyAccount = (number: string) => {
     if(number.length !== 10) return;
     setIsVerifying(true);
     setNewBeneficiary(prev => ({ ...prev, name: '' }));

     // Simulate API verification
     setTimeout(() => {
        setIsVerifying(false);
        setNewBeneficiary(prev => ({ ...prev, name: 'VERIFIED USER NAME' }));
     }, 1500);
  };

  const handleAddBeneficiary = () => {
     setAddStep('success');
     setBeneficiaries(prev => [
        {
           id: Date.now(),
           name: newBeneficiary.name || 'New User',
           type: newBeneficiary.type,
           detail: `${newBeneficiary.bank} • ${newBeneficiary.accountNumber}`,
           avatar: (newBeneficiary.name?.[0] || 'U').toUpperCase(),
           color: 'bg-gray-100 text-gray-600'
        },
        ...prev
     ]);
  };

  const closeAddModal = () => {
     setShowAddModal(false);
     setAddStep('details');
     setNewBeneficiary({ type: 'Bank Transfer', bank: '', accountNumber: '', name: '' });
  };

  return (
    <div className="flex min-h-screen app-bg">
      <Sidebar />

      <main className="flex-1 min-w-0 flex flex-col h-screen overflow-hidden">
        <Header title="Beneficiaries" />

        <div className="flex-1 overflow-y-auto p-4 md:p-8 pb-28 md:pb-8 space-y-8">
            {/* Header Stats & Action */}
            <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
               <div>
                  <h3 className="text-xl font-bold text-gray-800">Saved Beneficiaries</h3>
                  <p className="text-sm text-gray-500">Manage your saved contacts for quick transfers.</p>
               </div>
               <button 
                  onClick={() => setShowAddModal(true)}
                  className="btn-brand hover:brightness-110 text-white px-6 py-3 rounded-xl font-bold transition-all transform hover:-translate-y-0.5 flex items-center gap-2"
               >
                  <Plus size={20} />
                  Add New
               </button>
            </div>

            {/* Filters and Search */}
            <div className="flex flex-col md:flex-row gap-4 justify-between items-center glass-card p-2 rounded-2xl border">
               <div className="flex w-full md:w-auto p-1 bg-gray-50 rounded-xl">
                  {['All', 'Bank Transfer', 'Airtime'].map((f) => (
                    <button
                      key={f}
                      onClick={() => setFilter(f)}
                      className={`px-4 py-2 text-sm font-medium rounded-lg transition-all ${
                        filter === f ? 'bg-primary text-white shadow-sm' : 'text-gray-500 hover:text-gray-700'
                      }`}
                    >
                      {f}
                    </button>
                  ))}
               </div>

               <div className="relative w-full md:w-64">
                  <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 h-4 w-4" />
                  <input 
                     type="text" 
                     placeholder="Search beneficiaries..." 
                     value={searchQuery}
                     onChange={(e) => setSearchQuery(e.target.value)}
                     className="w-full pl-10 pr-4 py-2.5 rounded-xl border border-gray-200 outline-none focus:border-primary focus:ring-2 focus:ring-primary/10 transition-all text-sm font-medium"
                  />
               </div>
            </div>

            {/* Beneficiaries Grid */}
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
               {filteredBeneficiaries.map((beneficiary) => (
                  <div key={beneficiary.id} className="glass-card p-5 rounded-2xl border hover:shadow-md transition-all group relative">
                      <div className="absolute top-4 right-4 opacity-0 group-hover:opacity-100 transition-opacity">
                         <button className="p-2 hover:bg-red-50 text-red-500 rounded-full transition-colors" title="Delete">
                            <Trash2 size={16} />
                         </button>
                      </div>

                      <div className="flex items-center gap-4">
                         <div className={`w-14 h-14 rounded-full flex items-center justify-center font-bold text-xl ${beneficiary.color}`}>
                            {beneficiary.avatar}
                         </div>
                         <div>
                            <h4 className="font-bold text-gray-900">{beneficiary.name}</h4>
                            <p className="text-xs text-gray-500 flex items-center gap-1 mt-1">
                               {beneficiary.type === 'Bank Transfer' ? <Landmark size={12} /> : <Smartphone size={12} />}
                               {beneficiary.detail}
                            </p>
                         </div>
                      </div>

                      <div className="mt-6 flex gap-2">
                         <button className="flex-1 bg-gray-50 hover:bg-primary hover:text-white text-gray-700 py-2.5 rounded-xl text-sm font-bold transition-all">
                            Send Money
                         </button>
                      </div>
                  </div>
               ))}
            </div>

            {filteredBeneficiaries.length === 0 && (
               <div className="text-center py-20">
                  <div className="w-20 h-20 bg-gray-50 rounded-full flex items-center justify-center mx-auto mb-4 text-gray-400">
                     <User size={40} />
                  </div>
                  <h3 className="text-gray-900 font-bold mb-1">No beneficiaries found</h3>
                  <p className="text-gray-500 text-sm">Try adjusting your filters or add a new one.</p>
               </div>
            )}
        </div>
      </main>

      <MobileNav />

      {/* Add Beneficiary Modal */}
      {showAddModal && (
         <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm">
            <div className="bg-surface border rounded-2xl w-full max-w-md shadow-2xl animate-in fade-in zoom-in duration-200">
               <div className="flex items-center justify-between p-6 border-b border-gray-100">
                  <h3 className="text-xl font-bold text-gray-900">Add New Beneficiary</h3>
                  <button onClick={closeAddModal} className="p-2 hover:bg-gray-100 rounded-full transition-colors">
                     <X size={20} className="text-gray-500" />
                  </button>
               </div>

               <div className="p-6">
                  {addStep === 'details' ? (
                     <div className="space-y-4">
                         <div className="space-y-2">
                           <label className="text-sm font-medium text-gray-700">Type</label>
                           <div className="flex p-1 bg-gray-50 rounded-xl">
                              {['Bank Transfer', 'Airtime'].map(type => (
                                 <button 
                                    key={type}
                                    onClick={() => setNewBeneficiary(prev => ({ ...prev, type }))}
                                    className={`flex-1 py-2 text-sm font-medium rounded-lg transition-all ${newBeneficiary.type === type ? 'bg-primary text-white shadow-sm' : 'text-gray-500'}`}
                                 >
                                    {type}
                                 </button>
                              ))}
                           </div>
                         </div>

                         <div className="space-y-2">
                           <label className="text-sm font-medium text-gray-700">
                              {newBeneficiary.type === 'Bank Transfer' ? 'Select Bank' : 'Select Network'}
                           </label>
                           <select 
                              value={newBeneficiary.bank}
                              onChange={(e) => setNewBeneficiary(prev => ({ ...prev, bank: e.target.value }))}
                              className="w-full px-4 py-3 rounded-xl border border-gray-200 focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all font-medium bg-surface"
                           >
                              <option value="">Select Option</option>
                              {newBeneficiary.type === 'Bank Transfer' 
                                 ? ['GTBank', 'Access Bank', 'UBA', 'First Bank', 'Zenith Bank'].map(b => <option key={b} value={b}>{b}</option>)
                                 : ['MTN', 'Airtel', 'Glo', '9mobile'].map(n => <option key={n} value={n}>{n}</option>)
                              }
                           </select>
                         </div>

                         <div className="space-y-2">
                           <label className="text-sm font-medium text-gray-700">
                              {newBeneficiary.type === 'Bank Transfer' ? 'Account Number' : 'Phone Number'}
                           </label>
                           <div className="relative">
                              <input 
                                 type="text" 
                                 value={newBeneficiary.accountNumber}
                                 onChange={(e) => {
                                    setNewBeneficiary(prev => ({ ...prev, accountNumber: e.target.value }));
                                    handleVerifyAccount(e.target.value);
                                 }}
                                 maxLength={10}
                                 placeholder="Enter number"
                                 className="w-full pl-4 pr-12 py-3 rounded-xl border border-gray-200 focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all font-medium"
                              />
                              <div className="absolute right-3 top-1/2 -translate-y-1/2">
                                 {isVerifying ? (
                                    <Loader2 className="w-5 h-5 text-primary-light animate-spin" />
                                 ) : newBeneficiary.name ? (
                                    <Check className="w-5 h-5 text-green-600" />
                                 ) : null}
                              </div>
                           </div>
                         </div>

                         {newBeneficiary.name && (
                           <div className="p-3 bg-green-50 rounded-xl border border-green-100 flex items-center gap-2 text-green-700 text-xs font-bold animate-in fade-in slide-in-from-top-2">
                              <User size={14} />
                              {newBeneficiary.name}
                           </div>
                         )}

                         <button 
                           onClick={handleAddBeneficiary}
                           disabled={!newBeneficiary.name || !newBeneficiary.bank}
                           className="w-full btn-brand hover:brightness-110 disabled:[background-image:none] disabled:shadow-none disabled:bg-gray-200 disabled:text-gray-500 disabled:cursor-not-allowed text-white font-bold py-4 rounded-xl transition-all transform hover:-translate-y-0.5 mt-4"
                         >
                           Save Beneficiary
                         </button>
                     </div>
                  ) : (
                     <div className="py-6 text-center space-y-4">
                        <div className="w-20 h-20 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4 animate-in zoom-in duration-300">
                           <Check className="w-10 h-10 text-green-600" strokeWidth={3} />
                        </div>
                        <h4 className="text-xl font-bold text-gray-900">Saved Successfully!</h4>
                        <p className="text-sm text-gray-500">
                           <span className="font-bold text-gray-900">{newBeneficiary.name}</span> has been added to your beneficiaries.
                        </p>
                        <button 
                           onClick={closeAddModal}
                           className="w-full btn-brand hover:brightness-110 text-white font-bold py-4 rounded-xl transition-all transform hover:-translate-y-0.5"
                        >
                           Done
                        </button>
                     </div>
                  )}
               </div>
            </div>
         </div>
      )}

    </div>
  );
}
