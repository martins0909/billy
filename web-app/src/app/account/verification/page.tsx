'use client';

import React from 'react';
import Sidebar from '@/components/Sidebar';
import Header from '@/components/Header';
import MobileNav from '@/components/MobileNav';
import { ShieldCheck, CheckCircle2, XCircle, AlertCircle, Upload, ChevronRight, Lock } from 'lucide-react';

export default function VerificationPage() {
  return (
    <div className="flex min-h-screen pb-16 md:pb-0 bg-off-white">
      <Sidebar />


      <main className="flex-1 flex flex-col h-screen overflow-hidden">
        <Header title="Verification Status" />

        <div className="flex-1 overflow-y-auto p-4 md:p-8">
           <div className="max-w-3xl mx-auto space-y-6">
              
              {/* Current Status Banner */}
              <div className="bg-orange-50 border border-orange-200 rounded-xl p-6 flex flex-col md:flex-row items-center gap-6">
                 <div className="w-16 h-16 bg-orange-100 rounded-full flex items-center justify-center text-orange-600 shrink-0">
                    <AlertCircle size={32} />
                 </div>
                 <div className="text-center md:text-left flex-1">
                    <h3 className="text-lg font-bold text-gray-800">Account Unverified (Tier 1)</h3>
                    <p className="text-gray-600 text-sm mt-1">
                       Your account is currently limited. Complete verification to increase your transaction limits and unlock more features.
                    </p>
                 </div>
                 <button className="px-6 py-2.5 bg-orange-500 hover:bg-orange-600 text-white font-medium rounded-lg text-sm shadow-sm transition-colors whitespace-nowrap">
                    Upgrade to Tier 2
                 </button>
              </div>

              {/* Tiers Information */}
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                 <TierCard 
                    level="Tier 1" 
                    status="active" 
                    limits="₦50,000 / day" 
                    reqs={['Email Verified', 'Phone Number']} 
                 />
                 <TierCard 
                    level="Tier 2" 
                    status="next" 
                    limits="₦200,000 / day" 
                    reqs={['BVN Verification', 'Valid ID Card']} 
                 />
                 <TierCard 
                    level="Tier 3" 
                    status="locked" 
                    limits="Unlimited" 
                    reqs={['Utility Bill', 'Face Verification']} 
                 />
              </div>

              {/* Verification Steps */}
              <div className="bg-white rounded-xl shadow-sm border overflow-hidden">
                 <div className="px-6 py-4 border-b bg-off-white">
                    <h3 className="font-semibold text-gray-800">Required Documents</h3>
                 </div>
                 <div className="divide-y">

                    <VerificationStep 
                       title="Bank Verification Number (BVN)" 
                       description="Verify your identity with your 11-digit BVN"
                       status="completed"
                    />
                    <VerificationStep 
                       title="Government Issued ID" 
                       description="Upload a clear copy of your Driver's License, NIN, or Passport"
                       status="pending"
                       actionLabel="Upload ID"
                    />
                    <VerificationStep 
                       title="Utility Bill" 
                       description="Proof of address not older than 3 months"
                       status="locked"
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

function TierCard({ level, status, limits, reqs }: { level: string, status: 'active' | 'next' | 'locked', limits: string, reqs: string[] }) {
   const isLocked = status === 'locked';
   const isActive = status === 'active';
   
   return (
      <div className={`p-5 rounded-xl border-2 flex flex-col h-full ${
         isActive ? 'border-[#1D6A4A] bg-[#1D6A4A]/5' : 
         isLocked ? 'border-gray-100 bg-off-white opacity-60' : 
         'border-orange-200 bg-white shadow-sm'
      }`}>
         <div className="flex justify-between items-start mb-4">

            <span className={`text-sm font-bold px-2 py-1 rounded ${
               isActive ? 'bg-[#1D6A4A] text-white' : 
               'bg-gray-200 text-gray-700'
            }`}>{level}</span>
            {isActive && <CheckCircle2 className="text-[#1D6A4A]" size={20} />}
            {!isLocked && !isActive && <div className="w-5 h-5 rounded-full border-2 border-orange-500"></div>}
            {isLocked && <div className="w-5 h-5 rounded-full border-2 border-gray-300"></div>}
         </div>
         
         <div className="mb-4">
            <p className="text-xs text-gray-500 uppercase tracking-wide mb-1">Daily Limit</p>
            <p className="font-bold text-gray-900 text-lg">{limits}</p>
         </div>

         <div className="mt-auto">
            <p className="text-xs text-gray-500 uppercase tracking-wide mb-2">Requirements</p>
            <ul className="space-y-1">
               {reqs.map((req, i) => (
                  <li key={i} className="text-xs text-gray-700 flex items-center gap-1.5">
                     <div className="w-1 h-1 bg-gray-400 rounded-full"></div>
                     {req}
                  </li>
               ))}
            </ul>
         </div>
      </div>
   );
}

function VerificationStep({ title, description, status, actionLabel }: { title: string, description: string, status: 'completed' | 'pending' | 'locked', actionLabel?: string }) {
   return (
      <div className="p-6 flex flex-col md:flex-row md:items-center justify-between gap-4">
         <div className="flex gap-4">
            <div className={`w-10 h-10 rounded-full flex items-center justify-center shrink-0 ${
               status === 'completed' ? 'bg-green-100 text-green-600' :
               status === 'pending' ? 'bg-orange-100 text-orange-600' :
               'bg-gray-100 text-gray-400'
            }`}>
               {status === 'completed' ? <CheckCircle2 size={20} /> : 
                status === 'pending' ? <Upload size={20} /> :
                <Lock size={20} />}
            </div>
            <div>
               <h4 className={`font-semibold ${status === 'locked' ? 'text-gray-400' : 'text-gray-800'}`}>{title}</h4>
               <p className="text-sm text-gray-500 max-w-sm">{description}</p>
            </div>
         </div>
         
         {status === 'pending' && (
            <button className="px-4 py-2 border border-orange-200 text-orange-700 font-medium rounded-lg hover:bg-orange-50 transition-colors text-sm flex items-center gap-2">
               {actionLabel}
               <ChevronRight size={16} />
            </button>
         )}
         {status === 'completed' && (
            <span className="px-3 py-1 bg-green-50 text-green-700 text-xs font-bold rounded-full self-start md:self-center">Verified</span>
         )}
      </div>
   );
}
