'use client';

import React, { useState } from 'react';
import Sidebar from '@/components/Sidebar';
import Header from '@/components/Header';
import MobileNav from '@/components/MobileNav';
import TransactionRow from '@/components/TransactionRow';
import { Filter, Download, Calendar } from 'lucide-react';

export default function TransactionsPage() {
  const [filter, setFilter] = useState('All');

  const transactions = [
    { title: "Transfer to Sarah", subtitle: "Bank Transfer", date: "Today, 10:30 AM", amount: "- ₦ 5,000", status: "Success", isCredit: false },
    { title: "MTN Airtime", subtitle: "Airtime Purchase", date: "Yesterday, 2:15 PM", amount: "- ₦ 1,000", status: "Success", isCredit: false },
    { title: "Deposit from GTBank", subtitle: "Wallet Funding", date: "Jan 15, 2024", amount: "+ ₦ 25,000", status: "Success", isCredit: true },
    { title: "Netflix Subscription", subtitle: "Card Payment", date: "Jan 14, 2024", amount: "- ₦ 4,500", status: "Success", isCredit: false },
    { title: "Electricity Bill", subtitle: "Utility Payment", date: "Jan 12, 2024", amount: "- ₦ 15,000", status: "Success", isCredit: false },
    { title: "Transfer from John", subtitle: "Bank Transfer", date: "Jan 10, 2024", amount: "+ ₦ 10,000", status: "Success", isCredit: true },
    { title: "Jumia Order", subtitle: "Card Payment", date: "Jan 08, 2024", amount: "- ₦ 32,400", status: "Success", isCredit: false },
    { title: "Data Bundle", subtitle: "Airtime Purchase", date: "Jan 05, 2024", amount: "- ₦ 2,500", status: "Success", isCredit: false },
  ];

  return (
    <div className="flex min-h-screen app-bg">
      <Sidebar />


      <main className="flex-1 flex flex-col h-screen overflow-hidden">
        <Header title="Transactions" />

        <div className="flex-1 overflow-y-auto p-4 md:p-8 pb-28 md:pb-8 space-y-6">
          {/* Summary Cards */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div className="glass-card p-6 rounded-xl border">
              <p className="text-gray-500 text-sm mb-1">Total Spent (Jan)</p>
              <h3 className="text-2xl font-bold text-gray-800">₦ 60,400</h3>
            </div>
            <div className="glass-card p-6 rounded-xl border">
              <p className="text-gray-500 text-sm mb-1">Total Received (Jan)</p>
              <h3 className="text-2xl font-bold text-green-600">₦ 35,000</h3>
            </div>
            <div className="glass-card p-6 rounded-xl border flex items-center justify-between">
               <div>
                  <p className="text-gray-500 text-sm mb-1">Transactions</p>
                  <h3 className="text-2xl font-bold text-gray-800">8</h3>
               </div>
               <div className="p-3 bg-blue-50 rounded-full text-blue-600">
                  <Calendar size={24} />
               </div>
            </div>
          </div>

          {/* Filters and Actions */}
          <div className="flex flex-col md:flex-row justify-between gap-4">
            <div className="flex bg-surface p-1 rounded-lg border shadow-sm w-fit">
              {['All', 'Credit', 'Debit'].map((f) => (
                <button
                  key={f}
                  onClick={() => setFilter(f)}
                  className={`px-4 py-2 text-sm font-medium rounded-md transition-colors ${
                    filter === f ? 'bg-primary text-white shadow' : 'text-gray-600 hover:bg-gray-50'
                  }`}
                >
                  {f}
                </button>
              ))}
            </div>

            <div className="flex gap-2">
              <button className="flex items-center gap-2 px-4 py-2 bg-surface border rounded-lg hover:bg-gray-50 text-gray-700 text-sm font-medium shadow-sm">
                <Filter size={18} />
                <span>Filter</span>
              </button>
              <button className="flex items-center gap-2 px-4 py-2 bg-surface border rounded-lg hover:bg-gray-50 text-gray-700 text-sm font-medium shadow-sm">
                <Download size={18} />
                <span>Export</span>
              </button>
            </div>
          </div>

          {/* Transactions Table */}
          <div className="glass-card rounded-xl border overflow-hidden">
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="bg-off-white text-xs text-gray-500 uppercase">
                  <tr>
                    <th className="px-4 sm:px-6 py-4 text-left">Date &amp; Time</th><th className="px-4 sm:px-6 py-4 text-left">Description</th><th className="px-4 sm:px-6 py-4 text-left">Amount</th><th className="px-4 sm:px-6 py-4 text-right">Status</th>
                  </tr>
                </thead>
                <tbody className="divide-y">
                  {transactions
                    .filter(t => {
                      if (filter === 'Credit') return t.isCredit;
                      if (filter === 'Debit') return !t.isCredit;
                      return true;
                    })
                    .map((t, i) => (
                    <TransactionRow key={i} {...t} />
                  ))}
                </tbody>
              </table>
            </div>
            {/* Pagination */}
            <div className="px-6 py-4 border-t flex justify-between items-center text-sm text-gray-500 bg-gray-50/30">
               <span>Showing 1 to 8 of 8 entries</span>
               <div className="flex gap-2">
                  <button disabled className="px-3 py-1 border rounded disabled:opacity-50 hover:bg-gray-50">Previous</button>
                  <button disabled className="px-3 py-1 border rounded disabled:opacity-50 hover:bg-gray-50">Next</button>
               </div>
            </div>
          </div>
        </div>
      </main>

      <MobileNav />
    </div>
  );
}
