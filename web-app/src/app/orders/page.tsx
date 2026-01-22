'use client';

import React, { useState } from 'react';
import Sidebar from '@/components/Sidebar';
import Header from '@/components/Header';
import MobileNav from '@/components/MobileNav';
import { 
  Smartphone, 
  Wifi, 
  Tv, 
  Zap, 
  Trophy, 
  Rocket, 
  ShoppingBag,
  Info 
} from 'lucide-react';

type OrderStatus = 'Active' | 'Completed' | 'Cancelled';

const DUMMY_ORDERS = {
  Active: [
    {
      id: "#12345",
      service: "Airtime Purchase",
      date: "Jan 10, 2026",
      price: "₦5,000",
      status: "In Progress",
      icon: <Smartphone size={24} />,
      color: "bg-green-100",
      statusColor: "text-blue-600 bg-blue-100"
    },
    {
      id: "#12348",
      service: "Data Subscription",
      date: "Jan 12, 2026",
      price: "₦10,000",
      status: "Scheduled",
      icon: <Wifi size={24} />,
      color: "bg-blue-100",
      statusColor: "text-orange-600 bg-orange-100"
    }
  ],
  Completed: [
    {
      id: "#12340",
      service: "Cable TV Sub",
      date: "Dec 28, 2025",
      price: "₦12,500",
      status: "Completed",
      icon: <Tv size={24} />,
      color: "bg-purple-100",
      statusColor: "text-green-600 bg-green-100"
    },
    {
      id: "#12335",
      service: "Electricity Bill",
      date: "Dec 15, 2025",
      price: "₦20,000",
      status: "Completed",
      icon: <Zap size={24} />,
      color: "bg-yellow-100",
      statusColor: "text-green-600 bg-green-100"
    },
    {
      id: "#12330",
      service: "Betting Wallet Fund",
      date: "Dec 05, 2025",
      price: "₦2,500",
      status: "Completed",
      icon: <Trophy size={24} />,
      color: "bg-green-100",
      statusColor: "text-green-600 bg-green-100"
    }
  ],
  Cancelled: [
    {
      id: "#12320",
      service: "Social Boost",
      date: "Nov 20, 2025",
      price: "₦50,000",
      status: "Cancelled",
      icon: <Rocket size={24} />,
      color: "bg-red-100",
      statusColor: "text-red-600 bg-red-100"
    }
  ]
};

export default function OrdersPage() {
  const [activeTab, setActiveTab] = useState<OrderStatus>('Active');

  const orders = DUMMY_ORDERS[activeTab];

  return (
    <div className="flex min-h-screen pb-16 md:pb-0 bg-off-white">
      <Sidebar />

      <main className="flex-1 flex flex-col h-screen overflow-hidden">
        <Header title="My Orders" />

        <div className="flex-1 overflow-y-auto">
          <div className="max-w-3xl mx-auto w-full">
            
            {/* Tabs */}
            <div className="sticky top-0 bg-off-white z-10 px-4 pt-4 border-b border-gray-200">
               <div className="flex space-x-8">
                 {['Active', 'Completed', 'Cancelled'].map((tab) => (
                   <button
                     key={tab}
                     onClick={() => setActiveTab(tab as OrderStatus)}
                     className={`pb-3 text-sm font-medium transition-colors relative ${
                       activeTab === tab 
                         ? 'text-[#1D6A4A]' 
                         : 'text-gray-500 hover:text-gray-700'
                     }`}
                   >
                     {tab}
                     {activeTab === tab && (
                       <div className="absolute bottom-0 left-0 right-0 h-0.5 bg-[#1D6A4A] rounded-t-full" />
                     )}
                   </button>
                 ))}
               </div>
            </div>

            {/* Content */}
            <div className="p-4 md:p-8 space-y-4">
              {orders.length === 0 ? (
                <div className="flex flex-col items-center justify-center py-20 text-gray-400">
                  <ShoppingBag size={64} className="mb-4 opacity-50" />
                  <p className="text-gray-600 font-medium">No {activeTab.toLowerCase()} orders found</p>
                </div>
              ) : (
                orders.map((order) => (
                  <div key={order.id} className="bg-white rounded-2xl p-4 shadow-sm border border-gray-100">
                    <div className="flex items-start gap-4">
                      {/* Icon */}
                      <div className={`w-12 h-12 rounded-xl flex items-center justify-center ${order.color} shrink-0`}>
                        {React.cloneElement(order.icon as React.ReactElement, { className: "text-gray-800" })}
                      </div>

                      {/* Details */}
                      <div className="flex-1 min-w-0">
                         <div className="flex justify-between items-start">
                            <div>
                               <h3 className="font-bold text-gray-900 truncate pr-2">{order.service}</h3>
                               <p className="text-sm text-gray-500 mt-0.5">{order.id}</p>
                            </div>
                            <div className="text-right shrink-0">
                               <p className="text-[#1D6A4A] font-bold">{order.price}</p>
                               <div className={`inline-block px-2 py-1 rounded-lg text-[10px] font-bold mt-1 uppercase ${order.statusColor}`}>
                                 {order.status}
                               </div>
                            </div>
                         </div>
                      </div>
                    </div>

                    <div className="my-4 border-t border-gray-100" />

                    <div className="flex justify-between items-center">
                       <p className="text-xs text-gray-500">{order.date}</p>
                       <button className="text-[#1D6A4A] text-sm font-medium hover:text-[#155a3d] transition-colors">
                         View Details
                       </button>
                    </div>
                  </div>
                ))
              )}
            </div>
          </div>
        </div>
      </main>

      <MobileNav />
    </div>
  );
}
