import React from 'react';
import { ArrowUp, ArrowDown } from 'lucide-react';

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
    <tr className="hover:bg-primary/5 border-b border-primary/10 last:border-b-0 transition-colors">
      <td className="px-4 sm:px-6 py-4">
        <div className="flex items-center gap-3">
          <div className={`w-10 h-10 shrink-0 rounded-full flex items-center justify-center text-white ${
            isCredit ? 'bg-brand-gradient shadow-glow-sm' : 'bg-red-500/80'
          }`}>
            {isCredit ? <ArrowUp size={18} /> : <ArrowDown size={18} />}
          </div>
          <p className="text-sm text-gray-700 whitespace-nowrap">{date}</p>
        </div>
      </td>
      <td className="px-4 sm:px-6 py-4">
        <p className="font-medium text-gray-800 text-sm">{title}</p>
        <p className="text-xs text-gray-500">{subtitle}</p>
      </td>
      <td className={`px-4 sm:px-6 py-4 font-bold whitespace-nowrap ${isCredit ? 'text-green-600' : 'text-gray-800'}`}>
        {amount}
      </td>
      <td className="px-4 sm:px-6 py-4 text-right">
        <span className={`inline-block px-3 py-1 rounded-full text-xs font-semibold border ${
          status === 'Success' ? 'bg-green-100 text-green-700 border-green-500/40' :
          status === 'Pending' ? 'bg-yellow-100 text-yellow-700 border-yellow-500/40' :
          'bg-red-100 text-red-700 border-red-500/40'
        }`}>
          {status === 'Success' ? 'Successful' : status}
        </span>
      </td>
    </tr>
  );
}