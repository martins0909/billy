'use client';

import React from 'react';
import Link from 'next/link';
import { Mail, ArrowLeft } from 'lucide-react';

export default function ForgotPasswordPage() {
  return (
    <div className="min-h-screen flex app-bg">
      {/* Left Side - Form */}
      <div className="w-full lg:w-1/2 flex items-center justify-center p-8 md:p-12 lg:p-24">
        <div className="w-full max-w-md space-y-8">
          <div className="text-center lg:text-left">
            <Link href="/login" className="inline-flex items-center text-sm text-gray-500 hover:text-gray-700 mb-6 transition-colors">
              <ArrowLeft size={16} className="mr-1" /> Back to Login
            </Link>
            <h1 className="text-3xl font-bold text-primary-light tracking-wider mb-2">BILLY</h1>
            <h2 className="text-2xl font-bold text-gray-900">Forgot Password? 🔒</h2>
            <p className="text-gray-500 mt-2">Don't worry! It happens. Please enter the email associated with your account.</p>
          </div>

          <form className="space-y-6" onSubmit={(e) => e.preventDefault()}>
            <div>
              <label htmlFor="email" className="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <Mail className="h-5 w-5 text-gray-400" />
                </div>
                <input
                  id="email"
                  name="email"
                  type="email"
                  autoComplete="email"
                  required
                  className="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg focus:ring-primary focus:border-primary transition-colors"
                  placeholder="name@example.com"
                />
              </div>
            </div>

            <button
              type="submit"
              className="w-full flex justify-center py-3 px-4 border border-transparent rounded-xl text-sm font-semibold text-white btn-brand hover:brightness-110 focus:outline-none focus:ring-2 focus:ring-primary transition-colors"
            >
              Reset Password
            </button>
            
            <p className="text-center text-sm text-gray-500">
               Remember your password? <Link href="/login" className="font-medium text-primary-light hover:underline">Log in</Link>
            </p>
          </form>
        </div>
      </div>

      {/* Right Side - Banner Image */}
      <div className="hidden lg:block w-1/2 bg-card-gradient relative overflow-hidden">
        <div className="absolute inset-0 bg-gradient-to-bl from-primary-light/30 via-transparent to-brand-deep/60" />
        
        {/* Abstract Shapes */}
        <div className="absolute top-1/2 left-1/2 w-96 h-96 bg-white/10 rounded-full blur-3xl transform -translate-x-1/2 -translate-y-1/2"></div>
        
        <div className="absolute inset-0 flex flex-col items-center justify-center text-white p-12 text-center z-10">
          <h2 className="text-4xl font-bold mb-6">Secure Account Recovery</h2>
          <p className="text-lg text-white/80 max-w-lg leading-relaxed">
            We prioritize your security. Follow the steps sent to your email to recover access to your funds safely.
          </p>
        </div>
      </div>
    </div>
  );
}
