'use client';

import React, { useEffect, useState } from 'react';
import Link from 'next/link';
import { Megaphone, Send, ChevronRight, Zap, ShieldCheck, Gift } from 'lucide-react';

const announcements = [
  'Fast delivery on every purchase',
  'Get 10% cashback on every successful transaction',
  'Buy phone numbers for verification in less than 5 secs',
];

const slides = [
  {
    tag: 'Community',
    icon: Send,
    iconBg: 'bg-sky-500',
    title: 'Stay Updated',
    text: 'Join our Telegram platform today for more updates.',
    cta: 'Join Telegram',
    href: '/services',
    bg: Send,
    gradient: 'from-[#3b0d63] via-[#4f1685] to-[#6a229f]',
  },
  {
    tag: 'Rewards',
    icon: Gift,
    iconBg: 'bg-amber-500',
    title: 'Get 10% Cashback',
    text: 'On every successful transaction. Start saving today.',
    cta: 'Start Now',
    href: '/services',
    bg: Gift,
    gradient: 'from-[#2f0b52] via-[#471373] to-[#5e1e94]',
  },
  {
    tag: 'Verification',
    icon: ShieldCheck,
    iconBg: 'bg-emerald-500',
    title: 'Foreign Numbers',
    text: 'Buy all countries phone numbers for verification with ease.',
    cta: 'Verify Now',
    href: '/services',
    bg: ShieldCheck,
    gradient: 'from-[#35095c] via-[#531a85] to-[#7226ad]',
  },
];

export default function HomeSlider() {
  const [index, setIndex] = useState(0);
  const [paused, setPaused] = useState(false);

  useEffect(() => {
    if (paused) return;
    const t = setInterval(() => setIndex((i) => (i + 1) % slides.length), 5000);
    return () => clearInterval(t);
  }, [paused]);

  const loop = [...announcements, ...announcements];

  return (
    <div className="space-y-4">
      {/* Announcement strip */}
      <div className="flex items-center overflow-hidden rounded-2xl bg-gradient-to-r from-[#7a2fd0] via-[#9a38d8] to-[#b53ad0] text-white shadow-glow-sm">
        <div className="flex h-12 w-12 shrink-0 items-center justify-center bg-black/15">
          <Megaphone size={22} />
        </div>
        <div className="relative flex-1 overflow-hidden">
          <div className="flex w-max animate-marquee whitespace-nowrap py-3">
            {loop.map((a, i) => (
              <span key={i} className="mx-8 inline-flex items-center gap-2 text-sm sm:text-base font-semibold">
                {a} <Zap size={16} className="text-yellow-300" />
              </span>
            ))}
          </div>
        </div>
      </div>

      {/* Slider */}
      <div onMouseEnter={() => setPaused(true)} onMouseLeave={() => setPaused(false)}>
        <div className="overflow-hidden rounded-3xl border border-primary/30">
          <div
            className="flex transition-transform duration-500 ease-out"
            style={{ transform: `translateX(-${index * 100}%)` }}
          >
            {slides.map((s) => {
              const Icon = s.icon;
              const Bg = s.bg;
              return (
                <div key={s.title} className={`relative w-full shrink-0 overflow-hidden bg-gradient-to-br ${s.gradient} p-6 sm:p-8 text-white`}>
                  <Bg size={190} strokeWidth={1} className="pointer-events-none absolute -right-6 top-1/2 -translate-y-1/2 text-white/10" />
                  <div className="relative">
                    <div className="flex items-center gap-3 mb-4">
                      <span className={`flex h-11 w-11 items-center justify-center rounded-xl ${s.iconBg}`}>
                        <Icon size={22} />
                      </span>
                      <span className="text-sm font-bold uppercase tracking-widest text-white/80">{s.tag}</span>
                    </div>
                    <h3 className="text-3xl font-extrabold">{s.title}</h3>
                    <p className="mt-1.5 max-w-md text-white/75">{s.text}</p>
                    <Link
                      href={s.href}
                      className="mt-5 inline-flex items-center gap-2 rounded-full bg-white px-6 py-3 font-bold text-primary-dark hover:bg-white/90 transition-colors"
                    >
                      {s.cta} <ChevronRight size={18} />
                    </Link>
                  </div>
                </div>
              );
            })}
          </div>
        </div>

        <div className="mt-3 flex items-center justify-center gap-2">
          {slides.map((s, i) => (
            <button
              key={s.title}
              onClick={() => setIndex(i)}
              aria-label={`Go to slide ${i + 1}`}
              className={`h-2 rounded-full transition-all ${i === index ? 'w-8 bg-primary' : 'w-2 bg-gray-300'}`}
            />
          ))}
        </div>
      </div>
    </div>
  );
}
