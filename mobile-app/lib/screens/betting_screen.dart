import 'package:flutter/material.dart';
import '../theme/billy_colors.dart';
import '../widgets/billy_widgets.dart';
import 'betting_payment_screen.dart';

class BettingScreen extends StatelessWidget {
  const BettingScreen({super.key});

  final List<Map<String, String>> bettingProviders = const [
    {'name': 'SportyBet', 'icon': 'assets/sportybet.png'}, 
    {'name': 'Bet9ja', 'icon': 'assets/bet9ja.png'},
    // Add more providers here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Betting Services", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GlowBackground(
        child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              itemCount: bettingProviders.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final provider = bettingProviders[index];
                return _buildProviderCard(context, provider['name']!, provider['icon']!);
              },
            ),
          ),
      ),
      ),
    );
  }

  Widget _buildProviderCard(BuildContext context, String name, String assetPath) {
    return GlassCard(
      radius: 16,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BettingPaymentScreen(
              providerName: name,
              providerIconAsset: assetPath,
            ),
          ),
        );
      },
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: BillyColors.primary.withOpacity(0.15),
              shape: BoxShape.circle,
              border: Border.all(color: BillyColors.borderSoft),
              // image: DecorationImage(image: AssetImage(assetPath)), // Uncomment when assets exist
            ),
            child: const Icon(Icons.sports_soccer, color: BillyColors.primaryLight), // Fallback icon
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: BillyColors.textMuted),
        ],
      ),
    );
  }
}
