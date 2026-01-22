import React from 'react';
import { ArrowUpRight, ArrowDownLeft } from 'lucide-react';

interface TransactionRowProps {
  title: string;
  subtitle: string;
  date: string;
  amount: string;
  status: string;
  isCredit?: boolean;
}

export default function TransactionRow({ title, subtitle, date, amount, status, isCredit = false }: TransactionRowProps) {
  return (
    <tr className="hover:bg-off-white border-b border-gray-100 last:border-b-0 transition-colors">
      <td className="px-6 py-4">
        <div className="flex items-center gap-3">

          <div className={`w-10 h-10 rounded-full flex items-center justify-center ${
            isCredit ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'
          }`}>
            {isCredit ? <ArrowDownLeft size={18} /> : <ArrowUpRight size={18} />}
          </div>
          <div>
            <p className="font-semibold text-gray-800 text-sm">{title}</p>
            <p className="text-xs text-gray-500">{subtitle}</p>
          </div>
        </div>
      </td>
      <td className="px-6 py-4">
        <span className={`px-2 py-1 rounded text-xs font-semibold ${
          status === 'Success' ? 'bg-green-100 text-green-700' : 
          status === 'Pending' ? 'bg-yellow-100 text-yellow-700' :
          'bg-red-100 text-red-700'
        }`}>
          {status}
        </span>
      </td>
      <td className="px-6 py-4 text-sm text-gray-500">{date}</td>
      <td className={`px-6 py-4 text-right font-bold ${isCredit ? 'text-green-600' : 'text-gray-800'}`}>
        {amount}
      </td>
    </tr>
  );
}
