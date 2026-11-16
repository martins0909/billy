import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/billy_colors.dart';
import '../widgets/billy_widgets.dart';

class AddMoneyScreen extends StatelessWidget {
  const AddMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fund Wallet", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GlowBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Recommended",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: BillyColors.textSecondary),
              ),
              const SizedBox(height: 12),
              // Bank Transfer Option (The main one)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: BillyColors.cardGradient,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: BillyColors.primaryLight.withOpacity(0.5)),
                  boxShadow: BillyColors.glow(0.4),
                ),
                child: Column(
                  children: [
                    const Text("Bank Transfer", style: TextStyle(color: Colors.white70, fontSize: 14)),
                    const SizedBox(height: 12),
                    const Text(
                      "9012345678",
                      style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 2)
                    ),
                    const SizedBox(height: 8),
                    const Text("Wema Bank", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                     const SizedBox(height: 4),
                    const Text("Billy - User Name", style: TextStyle(color: Colors.white70, fontSize: 14)),
                    const SizedBox(height: 24),
                    GradientButton(
                      label: "Copy Number",
                      icon: Icons.copy,
                      onPressed: () {
                        Clipboard.setData(const ClipboardData(text: "9012345678"));
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account number copied!")));
                      },
                    ),
                  ],
                ),
              ),
               const SizedBox(height: 16),
               const Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Icon(Icons.info_outline, size: 16, color: BillyColors.textMuted),
                   SizedBox(width: 8),
                   Expanded(
                     child: Text(
                       "Make a transfer to this account number from any bank app. Money is added to your wallet instantly.",
                       style: TextStyle(color: BillyColors.textSecondary, fontSize: 13, height: 1.4)
                     ),
                   ),
                 ],
               ),

              const SizedBox(height: 32),
              const Text(
                "Other Methods",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: BillyColors.textSecondary),
              ),
              const SizedBox(height: 12),

              _buildOptionTile(
                context,
                icon: Icons.credit_card,
                title: "Fund with Card",
                subtitle: "Add money securely using your debit card",
                color: BillyColors.primaryLight,
                onTap: () {
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Card funding integration pending")));
                },
              ),
               const SizedBox(height: 12),
              _buildOptionTile(
                context,
                icon: Icons.dialpad,
                title: "USSD Code",
                subtitle: "Dial a code to fund your wallet",
                color: BillyColors.primaryLight,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("USSD integration pending")));
                },
              ),
               const SizedBox(height: 12),
              _buildOptionTile(
                context,
                icon: Icons.people_outline,
                title: "Request Money",
                subtitle: "Ask a friend or family member for money",
                color: BillyColors.primaryLight,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Request feature pending")));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTile(BuildContext context, {required IconData icon, required String title, required String subtitle, required Color color, required VoidCallback onTap}) {
    return GlassCard(
      radius: 16,
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: BillyColors.primary.withOpacity(0.18),
              shape: BoxShape.circle,
              border: Border.all(color: BillyColors.borderSoft),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: BillyColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: BillyColors.textMuted),
        ],
      ),
    );
  }
}
