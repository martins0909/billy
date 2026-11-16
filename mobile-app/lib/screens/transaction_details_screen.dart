import 'package:flutter/material.dart';
import '../theme/billy_colors.dart';
import '../widgets/billy_widgets.dart';
import '../data/transaction_data.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetailsScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isCredit = !transaction.amount.startsWith("-");
    // Same color logic as the history list: success for credit, white for debit
    final themeColor = isCredit ? BillyColors.success : Colors.white;
    final iconColor = isCredit ? BillyColors.success : BillyColors.primaryLight;
    final iconBgColor = isCredit ? BillyColors.success.withOpacity(0.15) : BillyColors.primary.withOpacity(0.18);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction Details", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GlowBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
               // 1. Amount and Status Section
               const SizedBox(height: 20),
               Container(
                 width: 70,
                 height: 70,
                 padding: const EdgeInsets.all(16),
                 decoration: BoxDecoration(
                   color: iconBgColor,
                   shape: BoxShape.circle,
                   border: Border.all(color: BillyColors.borderSoft),
                 ),
                 child: Icon(
                   isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                   size: 32,
                   color: iconColor,
                 ),
               ),
               const SizedBox(height: 16),
               Text(
                 transaction.amount,
                 style: TextStyle(
                   fontSize: 32,
                   fontWeight: FontWeight.bold,
                   color: themeColor,
                 ),
               ),
               const SizedBox(height: 8),
               Container(
                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                 decoration: BoxDecoration(
                   color: BillyColors.success.withOpacity(0.15),
                   borderRadius: BorderRadius.circular(20),
                 ),
                 child: const Text(
                   "Successful",
                   style: TextStyle(color: BillyColors.success, fontWeight: FontWeight.bold, fontSize: 14),
                 ),
               ),
               const SizedBox(height: 40),

               // 2. Details Card
               SizedBox(
                 width: double.infinity,
                 child: GlassCard(
                   radius: 20,
                   padding: const EdgeInsets.all(24),
                   child: Column(
                     children: [
                       _buildDetailRow("Transaction Type", _formatType(transaction.type)),
                       _buildDivider(),
                       _buildDetailRow("Date & Time", transaction.date),
                       _buildDivider(),
                       _buildDetailRow("Reference", "REF-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}"), // Mock ID
                       _buildDivider(),
                       _buildDetailRow("Description", transaction.title),

                       // Dynamic details if available (e.g. for Airtime, Betting)
                       if (transaction.details != null && transaction.details!.isNotEmpty) ...[
                          for (var entry in transaction.details!.entries) ...[
                             _buildDivider(),
                             _buildDetailRow(_capitalize(entry.key), entry.value.toString()),
                          ]
                       ]
                     ],
                   ),
                 ),
               ),

               // 3. Action Buttons
               const SizedBox(height: 40),
               GradientButton(
                 label: "Share Receipt",
                 expand: true,
                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                 onPressed: () {
                   // Placeholder for sharing receipt
                   ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text("Receipt Share feature coming soon!")),
                   );
                 },
               ),
               const SizedBox(height: 16),
               TextButton(
                 onPressed: () {
                    // Placeholder for reporting
                 },
                  child: const Text("Report an Issue", style: TextStyle(color: BillyColors.error, fontSize: 16)),
               )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Divider(height: 0, color: BillyColors.borderSoft),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: BillyColors.textSecondary, fontSize: 14)
        ),
        const SizedBox(width: 20),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)
          ),
        ),
      ],
    );
  }

  String _formatType(String type) {
    if (type.isEmpty) return "Transaction";
    return type[0].toUpperCase() + type.substring(1);
  }

  String _capitalize(String s) {
     if (s.isEmpty) return s;
     return s[0].toUpperCase() + s.substring(1);
  }
}
