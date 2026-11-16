'use client';

import React from 'react';
import Sidebar from '@/components/Sidebar';
import Header from '@/components/Header';
import MobileNav from '@/components/MobileNav';
import { User, Mail, Phone, MapPin, Camera, Save } from 'lucide-react';
import Link from 'next/link';

export default function EditProfilePage() {
  return (
    <div className="flex min-h-screen app-bg">
      <Sidebar />


      <main className="flex-1 flex flex-col h-screen overflow-hidden">
        <Header title="Edit Profile" />

        <div className="flex-1 overflow-y-auto p-4 md:p-8 pb-28 md:pb-8">
           <div className="max-w-2xl mx-auto glass-card rounded-xl border p-6 md:p-8">
              <div className="flex flex-col items-center mb-8">
                 <div className="relative">
                    <div className="w-24 h-24 rounded-full bg-gray-200 border-4 border-primary/60 shadow-glow-sm overflow-hidden">
                       <img 
                          src="https://randomuser.me/api/portraits/men/32.jpg" 
                          alt="Profile" 
                          className="w-full h-full object-cover"
                       />
                    </div>
                    <button className="absolute bottom-0 right-0 p-2 btn-brand text-white rounded-full hover:brightness-110 transition-all">
                       <Camera size={16} />
                    </button>
                 </div>
                 <h2 className="mt-4 text-xl font-bold text-gray-800">John Doe</h2>
                 <p className="text-gray-500 text-sm">Tier 1 Account</p>
              </div>

              <form className="space-y-6" onSubmit={(e) => e.preventDefault()}>
                 <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                       <label className="block text-sm font-medium text-gray-700 mb-1">First Name</label>
                       <div className="relative">
                          <User className="absolute left-3 top-3 text-gray-400" size={18} />
                          <input 
                             type="text" 
                             defaultValue="John"
                             className="w-full pl-10 pr-4 py-2.5 border rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none"
                          />
                       </div>
                    </div>
                    <div>
                       <label className="block text-sm font-medium text-gray-700 mb-1">Last Name</label>
                       <div className="relative">
                          <User className="absolute left-3 top-3 text-gray-400" size={18} />
                          <input 
                             type="text" 
                             defaultValue="Doe"
                             className="w-full pl-10 pr-4 py-2.5 border rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none"
                          />
                       </div>
                    </div>
                 </div>

                 <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
                    <div className="relative">
                       <Mail className="absolute left-3 top-3 text-gray-400" size={18} />
                       <input 
                          type="email" 
                          defaultValue="john.doe@example.com"
                          className="w-full pl-10 pr-4 py-2.5 border rounded-lg bg-off-white text-gray-500 cursor-not-allowed"
                          disabled
                       />

                    </div>
                    <p className="text-xs text-gray-400 mt-1">Email cannot be changed contact support.</p>
                 </div>

                 <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">Phone Number</label>
                    <div className="relative">
                       <Phone className="absolute left-3 top-3 text-gray-400" size={18} />
                       <input 
                          type="tel" 
                          defaultValue="+234 800 000 0000"
                          className="w-full pl-10 pr-4 py-2.5 border rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent outline-none"
                       />
                    </div>
                 </div>

                 <div className="pt-4 flex gap-4">
                    <Link href="/account" className="flex-1 py-3 px-4 border border-gray-300 text-gray-700 font-medium rounded-lg hover:bg-gray-50 text-center transition-colors">
                       Cancel
                    </Link>
                    <button type="submit" className="flex-1 py-3 px-4 btn-brand text-white font-semibold rounded-xl hover:brightness-110 flex items-center justify-center gap-2 transition-all">
                       <Save size={18} />
                       Save Changes
                    </button>
                 </div>
              </form>
           </div>
        </div>
      </main>

      <MobileNav />
    </div>
  );
}
