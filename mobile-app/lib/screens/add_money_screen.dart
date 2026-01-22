import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddMoneyScreen extends StatelessWidget {
  const AddMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Fund Wallet", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recommended",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            // Bank Transfer Option (The main one)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1D6A4A),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF1D6A4A).withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8)),
                ],
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
                  ElevatedButton.icon(
                    onPressed: () {
                      Clipboard.setData(const ClipboardData(text: "9012345678"));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account number copied!")));
                    },
                    icon: const Icon(Icons.copy, size: 18, color: Color(0xFF1D6A4A)),
                    label: const Text("Copy Number", style: TextStyle(color: Color(0xFF1D6A4A), fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  )
                ],
              ),
            ),
             const SizedBox(height: 16),
             Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 const Icon(Icons.info_outline, size: 16, color: Colors.grey),
                 const SizedBox(width: 8),
                 Expanded(
                   child: Text(
                     "Make a transfer to this account number from any bank app. Money is added to your wallet instantly.", 
                     style: TextStyle(color: Colors.grey[600], fontSize: 13, height: 1.4)
                   ),
                 ),
               ],
             ),
            
            const SizedBox(height: 32),
            const Text(
              "Other Methods",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 12),

            _buildOptionTile(
              context,
              icon: Icons.credit_card,
              title: "Fund with Card",
              subtitle: "Add money securely using your debit card",
              color: Colors.blue,
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
              color: Colors.orange,
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
              color: Colors.purple,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Request feature pending")));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(BuildContext context, {required IconData icon, required String title, required String subtitle, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
             BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
