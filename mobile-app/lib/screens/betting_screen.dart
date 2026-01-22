import 'package:flutter/material.dart';
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
        title: const Text("Betting Services", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
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
    );
  }

  Widget _buildProviderCard(BuildContext context, String name, String assetPath) {
    return GestureDetector(
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
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200], // Placeholder color
                shape: BoxShape.circle,
                // image: DecorationImage(image: AssetImage(assetPath)), // Uncomment when assets exist
              ),
              child: const Icon(Icons.sports_soccer, color: Colors.black54), // Fallback icon
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
