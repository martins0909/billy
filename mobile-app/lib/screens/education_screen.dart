import 'package:flutter/material.dart';
import '../theme/billy_colors.dart';
import '../widgets/billy_widgets.dart';
import 'waec_payment_screen.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Education", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GlowBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildEducationOption(
                  context,
                  "WAEC",
                  "Buy WAEC Result Checker PIN",
                  Icons.school,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WaecPaymentScreen(),
                      ),
                    );
                  },
                ),
                // Add more education services here in the future
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEducationOption(BuildContext context, String title, String subtitle, IconData icon, VoidCallback onTap) {
    return GlassCard(
      radius: 16,
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: BillyColors.primary.withOpacity(0.18),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: BillyColors.border),
            ),
            child: Icon(icon, color: BillyColors.primaryLight, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: BillyColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: BillyColors.textMuted),
        ],
      ),
    );
  }
}
