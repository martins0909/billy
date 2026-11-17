import type { Config } from "tailwindcss";
import plugin from "tailwindcss/plugin";
import twColors from "tailwindcss/colors";

/**
 * BILLY theme: light + dark, driven by CSS variables.
 *
 * - `.dark` on <html> switches the palette (see ThemeToggle).
 * - The neutral `gray` scale and the status tints (green/red/yellow/...) are
 *   variable-driven, so every existing `text-gray-*`, `bg-gray-*`, `bg-green-100`
 *   etc. utility flips automatically between themes.
 */

const hexToRgb = (hex: string) => {
  const h = hex.replace("#", "");
  return [0, 2, 4].map((i) => parseInt(h.slice(i, i + 2), 16));
};
const ch = (hex: string) => hexToRgb(hex).join(" ");
const blend = (fgHex: string, bg: number[], a: number) =>
  hexToRgb(fgHex)
    .map((c, i) => Math.round(c * a + bg[i] * (1 - a)))
    .join(" ");

const v = (name: string) => `rgb(var(--${name}) / <alpha-value>)`;

// ---- neutral scale ---------------------------------------------------------
const GRAY_LIGHT: Record<string, string> = {
  50: "#f8f7fb",
  100: "#f1eff6",
  200: "#e4e1ec",
  300: "#cbc6d8",
  400: "#9a94ab",
  500: "#6f687f",
  600: "#544e63",
  700: "#3b3647",
  800: "#251f31",
  900: "#150f1f",
};
const GRAY_DARK: Record<string, string> = {
  50: "#15111d",
  100: "#1d1827",
  200: "#2b2536",
  300: "#585167",
  400: "#857e95",
  500: "#a49db3",
  600: "#c3bdd0",
  700: "#d9d5e3",
  800: "#ece9f3",
  900: "#f8f6fc",
};

// ---- status hues -----------------------------------------------------------
const hues = {
  green: twColors.green,
  red: twColors.red,
  yellow: twColors.yellow,
  amber: twColors.amber,
  orange: twColors.orange,
  blue: twColors.blue,
  purple: twColors.purple,
  pink: twColors.pink,
  cyan: twColors.cyan,
};
const DARK_SURFACE = hexToRgb("#0e0b14");

const lightVars: Record<string, string> = {
  "--bg": ch("#f6f5fa"),
  "--surface": ch("#ffffff"),
  "--surface-high": ch("#f3effa"),
  "--edge": ch("#e6e1ef"),
  "--input": ch("#ffffff"),
  "--primary-light": ch("#7b2cbf"),
  "--tile": ch("#f2e9fc"),
  "--tile-edge": ch("#e0cdf5"),
  "--logo": "#6d28a8",
  "--card-shadow": "0 1px 2px rgba(25,12,45,.05), 0 8px 24px rgba(25,12,45,.06)",
  "--glow-a": "rgba(139,52,216,.10)",
  "--glow-b": "rgba(139,52,216,.06)",
};
const darkVars: Record<string, string> = {
  "--bg": ch("#000000"),
  "--surface": ch("#0e0b14"),
  "--surface-high": ch("#1a1424"),
  "--edge": ch("#2a2433"),
  "--input": ch("#14101c"),
  "--primary-light": ch("#b88af0"),
  "--tile": ch("#33104f"),
  "--tile-edge": ch("#5e2a96"),
  "--logo": "#ffffff",
  "--card-shadow": "none",
  "--glow-a": "rgba(120,45,190,.16)",
  "--glow-b": "rgba(90,30,150,.10)",
};

for (const k of Object.keys(GRAY_LIGHT)) {
  lightVars[`--gray-${k}`] = ch(GRAY_LIGHT[k]);
  darkVars[`--gray-${k}`] = ch(GRAY_DARK[k]);
}

const hueColors: Record<string, Record<string, string>> = {};
for (const [name, scale] of Object.entries(hues)) {
  const s = scale as unknown as Record<string, string>;
  for (const shade of ["50", "100", "200", "600", "700", "800"]) {
    lightVars[`--${name}-${shade}`] = ch(s[shade]);
  }
  darkVars[`--${name}-50`] = blend(s["500"], DARK_SURFACE, 0.1);
  darkVars[`--${name}-100`] = blend(s["500"], DARK_SURFACE, 0.16);
  darkVars[`--${name}-200`] = blend(s["500"], DARK_SURFACE, 0.28);
  darkVars[`--${name}-600`] = ch(s["400"]);
  darkVars[`--${name}-700`] = ch(s["400"]);
  darkVars[`--${name}-800`] = ch(s["300"]);
  hueColors[name] = {
    50: v(`${name}-50`),
    100: v(`${name}-100`),
    200: v(`${name}-200`),
    300: s["300"],
    400: s["400"],
    500: s["500"],
    600: v(`${name}-600`),
    700: v(`${name}-700`),
    800: v(`${name}-800`),
    900: s["900"],
  };
}

const grayColors: Record<string, string> = {};
for (const k of Object.keys(GRAY_LIGHT)) grayColors[k] = v(`gray-${k}`);

const config: Config = {
  darkMode: "class",
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        primary: "#8b34d8",
        "primary-dark": "#5b1a9e",
        "primary-light": v("primary-light"),
        "brand-deep": "#1a0638",
        "off-white": v("bg"),
        surface: v("surface"),
        "surface-high": v("surface-high"),
        edge: v("edge"),
        tile: v("tile"),
        "tile-edge": v("tile-edge"),
        gray: grayColors,
        ...hueColors,
      },
      borderColor: {
        DEFAULT: v("edge"),
      },
      divideColor: {
        DEFAULT: v("edge"),
      },
      backgroundImage: {
        "brand-gradient": "linear-gradient(135deg, #9b4fe6 0%, #8b34d8 45%, #5b1a9e 100%)",
        "card-gradient": "linear-gradient(135deg, #7c2fc4 0%, #63219f 55%, #45146f 100%)",
      },
      boxShadow: {
        glow: "0 10px 34px rgba(110,40,180,0.35)",
        "glow-sm": "0 6px 20px rgba(110,40,180,0.28)",
      },
      keyframes: {
        marquee: {
          "0%": { transform: "translateX(0)" },
          "100%": { transform: "translateX(-50%)" },
        },
      },
      animation: {
        marquee: "marquee 22s linear infinite",
      },
    },
  },
  plugins: [
    plugin(({ addBase }) => {
      addBase({
        ":root": lightVars,
        ".dark": darkVars,
      });
    }),
  ],
};
export default config;
