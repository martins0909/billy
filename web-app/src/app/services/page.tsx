'use client';

import React from 'react';
import Sidebar from '@/components/Sidebar';
import Header from '@/components/Header';
import MobileNav from '@/components/MobileNav';
import ServicesComponents from '@/components/ServicesComponents';

export default function ServicesPage() {
  return (
    <div className="flex min-h-screen app-bg">
      <Sidebar />


      <main className="flex-1 flex flex-col h-screen overflow-hidden">
        <Header title="Services" />

        <div className="flex-1 overflow-y-auto p-4 md:p-8 pb-28 md:pb-8">
           <div className="max-w-3xl mx-auto">
              <ServicesComponents />
           </div>
        </div>
      </main>

      <MobileNav />
    </div>
  );
}
