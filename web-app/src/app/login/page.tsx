'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { Eye, EyeOff, Lock, Mail, ArrowRight } from 'lucide-react';
import ThemeToggle from '@/components/ThemeToggle';

export default function LoginPage() {
  const [showPassword, setShowPassword] = useState(false);
  const router = useRouter();

  const handleLogin = (e: React.FormEvent) => {
    e.preventDefault();
    router.push('/');
  };

  return (
    <div className="min-h-screen flex app-bg">
      <ThemeToggle className="fixed top-4 right-4 z-50" />
      {/* Left Side - Form */}
      <div className="w-full lg:w-1/2 flex items-center justify-center p-8 md:p-12 lg:p-24">
        <div className="w-full max-w-md space-y-8">
          <div className="text-center lg:text-left">
            <h1 className="text-3xl font-bold text-primary-light tracking-wider mb-2">BILLY</h1>
            <h2 className="text-2xl font-bold text-gray-900">Welcome Back! 👋</h2>
            <p className="text-gray-500 mt-2">Enter your credentials to access your account.</p>
          </div>

          <form className="space-y-6" onSubmit={handleLogin}>
            <div className="space-y-4">
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

              <div>
                <div className="flex items-center justify-between mb-1">
                   <label htmlFor="password" className="block text-sm font-medium text-gray-700">Password</label>
                   <Link href="/forgot-password" className="text-sm font-medium text-primary-light hover:underline">
                      Forgot password?
                   </Link>
                </div>
                <div className="relative">
                  <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <Lock className="h-5 w-5 text-gray-400" />
                  </div>
                  <input
                    id="password"
                    name="password"
                    type={showPassword ? "text" : "password"}
                    autoComplete="current-password"
                    required
                    className="block w-full pl-10 pr-10 py-3 border border-gray-300 rounded-lg focus:ring-primary focus:border-primary transition-colors"
                    placeholder="Enter your password"
                  />
                  <button
                    type="button"
                    onClick={() => setShowPassword(!showPassword)}
                    className="absolute inset-y-0 right-0 pr-3 flex items-center text-gray-400 hover:text-gray-600"
                  >
                    {showPassword ? <EyeOff className="h-5 w-5" /> : <Eye className="h-5 w-5" />}
                  </button>
                </div>
              </div>
            </div>

            <button
              type="submit"
              className="w-full flex justify-center py-3 px-4 border border-transparent rounded-xl text-sm font-semibold text-white btn-brand hover:brightness-110 focus:outline-none focus:ring-2 focus:ring-primary transition-colors"
            >
              Sign In
            </button>

            <div className="flex items-center justify-center gap-2 text-sm text-gray-500">
              Not a member? 
              <Link href="/signup" className="font-medium text-primary-light hover:underline flex items-center gap-0.5">
                Create an account <ArrowRight size={14} />
              </Link>
            </div>
          </form>
        </div>
      </div>

      {/* Right Side - Banner Image */}
      <div className="hidden lg:block w-1/2 bg-card-gradient relative overflow-hidden">
        <div className="absolute inset-0 bg-gradient-to-br from-primary-light/30 via-transparent to-brand-deep/60" />
        
        {/* Abstract Shapes */}
        <div className="absolute top-20 right-20 w-64 h-64 bg-white/10 rounded-full blur-3xl"></div>
        <div className="absolute bottom-20 left-20 w-96 h-96 bg-white/5 rounded-full blur-3xl"></div>
        
        <div className="absolute inset-0 flex flex-col items-center justify-center text-white p-12 text-center z-10">
          <h2 className="text-4xl font-bold mb-6">Manage Your Finances with Confidence</h2>
          <p className="text-lg text-white/80 max-w-lg leading-relaxed">
            Join thousands of users who trust BILLY for their daily transactions, bill payments, and financial management.
          </p>
        </div>
      </div>
    </div>
  );
}
