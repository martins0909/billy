'use client';

import React from 'react';
import Sidebar from '@/components/Sidebar';
import Header from '@/components/Header';
import MobileNav from '@/components/MobileNav';
import { MapPin, Home, Briefcase, Plus, Trash2, Edit2, MoreVertical } from 'lucide-react';

export default function SavedAddressesPage() {
  return (
    <div className="flex min-h-screen pb-16 md:pb-0 bg-off-white">
      <Sidebar />


      <main className="flex-1 flex flex-col h-screen overflow-hidden">
        <Header title="Saved Addresses" />

        <div className="flex-1 overflow-y-auto p-4 md:p-8">
           <div className="max-w-3xl mx-auto space-y-6">
              
              {/* Add New Button */}
              <button className="w-full py-4 border-2 border-dashed border-gray-300 rounded-xl flex items-center justify-center gap-2 text-gray-500 hover:border-[#1D6A4A] hover:text-[#1D6A4A] transition-colors bg-white hover:bg-green-50/10">
                 <div className="w-8 h-8 rounded-full bg-gray-100 flex items-center justify-center group-hover:bg-[#1D6A4A]/20">
                    <Plus size={20} />
                 </div>
                 <span className="font-medium">Add New Address</span>
              </button>

              {/* Address List */}
              <div className="space-y-4">
                 <AddressCard 
                    type="home"
                    label="Home"
                    address="12B Akin Adesola Street, Victoria Island, Lagos, Nigeria"
                    isDefault={true}
                 />
                 <AddressCard 
                    type="work"
                    label="Office"
                    address="Plot 5, Block B, Eko Atlantic City, Lagos, Nigeria"
                    isDefault={false}
                 />
                 <AddressCard 
                    type="other"
                    label="Mom's House"
                    address="45 Awolowo Way, Ikeja, Lagos, Nigeria"
                    isDefault={false}
                 />
              </div>

           </div>
        </div>
      </main>

      <MobileNav />
    </div>
  );
}

function AddressCard({ type, label, address, isDefault }: { type: 'home' | 'work' | 'other', label: string, address: string, isDefault: boolean }) {
   const Icon = type === 'home' ? Home : type === 'work' ? Briefcase : MapPin;
   
   return (
      <div className="bg-white p-5 rounded-xl border border-gray-100 shadow-sm hover:shadow-md transition-shadow group relative">
         <div className="flex items-start gap-4">
            <div className="w-10 h-10 rounded-full bg-green-50 text-[#1D6A4A] flex items-center justify-center shrink-0">
               <Icon size={20} />
            </div>
            
            <div className="flex-1">
               <div className="flex items-center gap-3 mb-1">
                  <h3 className="font-bold text-gray-800">{label}</h3>
                  {isDefault && (
                     <span className="px-2 py-0.5 bg-gray-100 text-gray-600 text-[10px] font-bold uppercase tracking-wider rounded">Default</span>
                  )}
               </div>
               <p className="text-gray-600 text-sm leading-relaxed">{address}</p>
            </div>

            <div className="flex items-center gap-2">
               <button className="p-2 text-gray-400 hover:text-blue-600 hover:bg-blue-50 rounded-lg transition-colors" title="Edit">
                  <Edit2 size={18} />
               </button>
               <button className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors" title="Delete">
                  <Trash2 size={18} />
               </button>
            </div>
         </div>
      </div>
   );
}
