'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import { Eye, EyeOff, Lock, Mail, User, Phone, ArrowRight } from 'lucide-react';

export default function SignupPage() {
  const [showPassword, setShowPassword] = useState(false);

  return (
    <div className="min-h-screen flex bg-white">
      {/* Left Side - Form */}
      <div className="w-full lg:w-1/2 flex items-center justify-center p-8 md:p-12 lg:p-16">
        <div className="w-full max-w-md space-y-6">
          <div className="text-center lg:text-left">
            <h1 className="text-3xl font-bold text-[#1D6A4A] tracking-wider mb-2">BILLY</h1>
            <h2 className="text-2xl font-bold text-gray-900">Create an Account 🚀</h2>
            <p className="text-gray-500 mt-2">Start your journey to better financial freedom.</p>
          </div>

          <form className="space-y-5" onSubmit={(e) => e.preventDefault()}>
            <div className="space-y-4">
              <div>
                <label htmlFor="fullname" className="block text-sm font-medium text-gray-700 mb-1">Full Name</label>
                <div className="relative">
                  <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <User className="h-5 w-5 text-gray-400" />
                  </div>
                  <input
                    id="fullname"
                    name="fullname"
                    type="text"
                    required
                    className="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg focus:ring-[#1D6A4A] focus:border-[#1D6A4A] transition-colors"
                    placeholder="John Doe"
                  />
                </div>
              </div>

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
                    className="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg focus:ring-[#1D6A4A] focus:border-[#1D6A4A] transition-colors"
                    placeholder="name@example.com"
                  />
                </div>
              </div>
              
              <div>
                <label htmlFor="phone" className="block text-sm font-medium text-gray-700 mb-1">Phone Number</label>
                <div className="relative">
                  <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <Phone className="h-5 w-5 text-gray-400" />
                  </div>
                  <input
                    id="phone"
                    name="phone"
                    type="tel"
                    required
                    className="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg focus:ring-[#1D6A4A] focus:border-[#1D6A4A] transition-colors"
                    placeholder="+234 800 000 0000"
                  />
                </div>
              </div>

              <div>
                <label htmlFor="password" className="block text-sm font-medium text-gray-700 mb-1">Password</label>
                <div className="relative">
                  <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <Lock className="h-5 w-5 text-gray-400" />
                  </div>
                  <input
                    id="password"
                    name="password"
                    type={showPassword ? "text" : "password"}
                    required
                    className="block w-full pl-10 pr-10 py-3 border border-gray-300 rounded-lg focus:ring-[#1D6A4A] focus:border-[#1D6A4A] transition-colors"
                    placeholder="Create a password"
                  />
                  <button
                    type="button"
                    onClick={() => setShowPassword(!showPassword)}
                    className="absolute inset-y-0 right-0 pr-3 flex items-center text-gray-400 hover:text-gray-600"
                  >
                    {showPassword ? <EyeOff className="h-5 w-5" /> : <Eye className="h-5 w-5" />}
                  </button>
                </div>
                <p className="text-xs text-gray-500 mt-1">Must be at least 8 characters long</p>
              </div>
            </div>

            <div className="flex items-center">
              <input
                id="terms"
                name="terms"
                type="checkbox"
                required
                className="h-4 w-4 text-[#1D6A4A] focus:ring-[#1D6A4A] border-gray-300 rounded"
              />
              <label htmlFor="terms" className="ml-2 block text-sm text-gray-900">
                I agree to the <a href="#" className="text-[#1D6A4A] hover:underline">Terms of Service</a> and <a href="#" className="text-[#1D6A4A] hover:underline">Privacy Policy</a>
              </label>
            </div>

            <button
              type="submit"
              className="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-[#1D6A4A] hover:bg-[#155a3d] focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-[#1D6A4A] transition-colors"
            >
              Create Account
            </button>

            <div className="flex items-center justify-center gap-2 text-sm text-gray-500">
              Already have an account? 
              <Link href="/login" className="font-medium text-[#1D6A4A] hover:underline flex items-center gap-0.5">
                Sign in <ArrowRight size={14} />
              </Link>
            </div>
          </form>
        </div>
      </div>

      {/* Right Side - Banner Image */}
      <div className="hidden lg:block w-1/2 bg-[#1D6A4A] relative overflow-hidden">
        <div className="absolute inset-0 bg-gradient-to-tr from-[#1D6A4A] to-[#0d3323]" />
        
        {/* Abstract Shapes */}
        <div className="absolute bottom-40 right-10 w-80 h-80 bg-white/10 rounded-full blur-3xl"></div>
        <div className="absolute top-10 left-10 w-40 h-40 bg-white/5 rounded-full blur-2xl"></div>
        
        <div className="absolute inset-0 flex flex-col items-center justify-center text-white p-12 text-center z-10">
          <h2 className="text-4xl font-bold mb-6">Smart Banking for Smart People</h2>
          <p className="text-lg text-white/80 max-w-lg leading-relaxed">
             Experience seamless transactions and control over your money like never before. 
          </p>
        </div>
      </div>
    </div>
  );
}
