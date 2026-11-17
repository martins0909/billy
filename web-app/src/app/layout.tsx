import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "BILLY | Dashboard",
  description: "Web Dashboard for the BILLY Fintech App",
};

// Runs before paint so the saved theme is applied without a flash. Default is dark.
const themeScript = `try{var t=localStorage.getItem('billy-theme');if(t==='light'){document.documentElement.classList.remove('dark')}}catch(e){}`;

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className="dark" suppressHydrationWarning>
      <head>
        <script dangerouslySetInnerHTML={{ __html: themeScript }} />
      </head>
      <body className={`${inter.className} bg-off-white text-gray-900`}>
        {children}
      </body>
    </html>
  );
}
