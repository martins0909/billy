import type { Config } from "tailwindcss";

/**
 * BILLY dark-purple theme.
 *
 * The neutral `gray` scale is inverted (50 = darkest surface, 900 = lightest text)
 * so every existing `bg-gray-*`, `text-gray-*` and `border-gray-*` utility in the
 * app automatically renders correctly on the dark background. The pastel status
 * tints (`*-50/100/200`) are turned into translucent dark tints, and the matching
 * text shades are lightened, for the same reason.
 */
const config: Config = {
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        primary: "#8A2BFF",
        "primary-dark": "#5B0FD1",
        "primary-light": "#B14DFF",
        "brand-deep": "#1A0638",
        "off-white": "#07030F",
        surface: "#120826",
        "surface-high": "#1C0F3D",
        edge: "#3A2470",

        gray: {
          50: "#1A1033",
          100: "#22164A",
          200: "#34285F",
          300: "#6B5FA0",
          400: "#8F84B8",
          500: "#A89FCC",
          600: "#C4BDE0",
          700: "#D8D3EE",
          800: "#EBE8F7",
          900: "#F8F6FF",
        },
        green: {
          50: "rgba(34,197,94,0.12)",
          100: "rgba(34,197,94,0.18)",
          200: "rgba(34,197,94,0.30)",
          300: "#86efac",
          400: "#4ade80",
          500: "#22c55e",
          600: "#4ade80",
          700: "#4ade80",
          800: "#22c55e",
          900: "#166534",
        },
        red: {
          50: "rgba(239,68,68,0.12)",
          100: "rgba(239,68,68,0.18)",
          200: "rgba(239,68,68,0.30)",
          300: "#fca5a5",
          400: "#f87171",
          500: "#ef4444",
          600: "#f87171",
          700: "#f87171",
          800: "#ef4444",
          900: "#991b1b",
        },
        yellow: {
          50: "rgba(250,204,21,0.12)",
          100: "rgba(250,204,21,0.18)",
          200: "rgba(250,204,21,0.30)",
          300: "#fde047",
          400: "#facc15",
          500: "#eab308",
          600: "#facc15",
          700: "#facc15",
          800: "#eab308",
          900: "#854d0e",
        },
        amber: {
          50: "rgba(245,158,11,0.12)",
          100: "rgba(245,158,11,0.18)",
          200: "rgba(245,158,11,0.30)",
          300: "#fcd34d",
          400: "#fbbf24",
          500: "#f59e0b",
          600: "#fbbf24",
          700: "#fbbf24",
          800: "#f59e0b",
          900: "#92400e",
        },
        orange: {
          50: "rgba(249,115,22,0.12)",
          100: "rgba(249,115,22,0.18)",
          200: "rgba(249,115,22,0.30)",
          300: "#fdba74",
          400: "#fb923c",
          500: "#f97316",
          600: "#fb923c",
          700: "#fb923c",
          800: "#f97316",
          900: "#9a3412",
        },
        blue: {
          50: "rgba(59,130,246,0.12)",
          100: "rgba(59,130,246,0.18)",
          200: "rgba(59,130,246,0.30)",
          300: "#93c5fd",
          400: "#60a5fa",
          500: "#3b82f6",
          600: "#60a5fa",
          700: "#60a5fa",
          800: "#3b82f6",
          900: "#1e40af",
        },
        purple: {
          50: "rgba(168,85,247,0.12)",
          100: "rgba(168,85,247,0.18)",
          200: "rgba(168,85,247,0.30)",
          300: "#d8b4fe",
          400: "#c084fc",
          500: "#a855f7",
          600: "#c084fc",
          700: "#c084fc",
          800: "#a855f7",
          900: "#6b21a8",
        },
        pink: {
          50: "rgba(236,72,153,0.12)",
          100: "rgba(236,72,153,0.18)",
          200: "rgba(236,72,153,0.30)",
          300: "#f9a8d4",
          400: "#f472b6",
          500: "#ec4899",
          600: "#f472b6",
          700: "#f472b6",
          800: "#ec4899",
          900: "#9d174d",
        },
        cyan: {
          50: "rgba(6,182,212,0.12)",
          100: "rgba(6,182,212,0.18)",
          200: "rgba(6,182,212,0.30)",
          300: "#67e8f9",
          400: "#22d3ee",
          500: "#06b6d4",
          600: "#22d3ee",
          700: "#22d3ee",
          800: "#06b6d4",
          900: "#155e75",
        },
      },
      borderColor: {
        DEFAULT: "rgba(168,85,247,0.22)",
      },
      divideColor: {
        DEFAULT: "rgba(168,85,247,0.16)",
      },
      backgroundImage: {
        "brand-gradient": "linear-gradient(135deg, #B14DFF 0%, #8A2BFF 45%, #5B0FD1 100%)",
        "card-gradient": "linear-gradient(135deg, #7A1FF5 0%, #5B0FD1 45%, #2A0A66 100%)",
      },
      boxShadow: {
        glow: "0 0 32px rgba(138,43,255,0.35)",
        "glow-sm": "0 0 18px rgba(138,43,255,0.30)",
      },
    },
  },
  plugins: [],
};
export default config;
