import 'package:flutter/material.dart';
import '../data/transaction_data.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final Transaction transaction;

  const TransactionDetailsScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isCredit = !transaction.amount.startsWith("-");
    // Use the same color logic as the history list: Green for credit, Black for debit
    final themeColor = isCredit ? Colors.green : Colors.black;
    final iconBgColor = isCredit ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1);

    return Scaffold(
      backgroundColor: Colors.grey[50], // Light background
      appBar: AppBar(
        title: const Text("Transaction Details", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
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
               ),
               child: Icon(
                 isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                 size: 32,
                 color: themeColor,
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
                 color: Colors.green.withOpacity(0.1),
                 borderRadius: BorderRadius.circular(20),
               ),
               child: const Text(
                 "Successful",
                 style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14),
               ),
             ),
             const SizedBox(height: 40),
             
             // 2. Details Card
             Container(
               padding: const EdgeInsets.all(24),
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(20),
                 boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.08), blurRadius: 15, offset: const Offset(0,5))
                 ]
               ),
               child: Column(
                 children: [
                   _buildDetailRow("Transaction Type", _formatType(transaction.type)),
                   const Divider(height: 32),
                   _buildDetailRow("Date & Time", transaction.date),
                   const Divider(height: 32),
                   _buildDetailRow("Reference", "REF-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}"), // Mock ID
                   const Divider(height: 32),
                   _buildDetailRow("Description", transaction.title),
                   
                   // Dynamic details if available (e.g. for Airtime, Betting)
                   if (transaction.details != null && transaction.details!.isNotEmpty) ...[
                      for (var entry in transaction.details!.entries) ...[
                         const Divider(height: 32),
                         _buildDetailRow(_capitalize(entry.key), entry.value.toString()),
                      ]
                   ]
                 ],
               ),
             ),
             
             // 3. Action Buttons
             const SizedBox(height: 40),
             ElevatedButton(
               onPressed: () {
                 // Placeholder for sharing receipt
                 ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text("Receipt Share feature coming soon!")),
                 );
               },
               style: ElevatedButton.styleFrom(
                 backgroundColor: const Color(0xFF1D6A4A),
                 minimumSize: const Size(double.infinity, 56),
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                 elevation: 0,
               ),
               child: const Text("Share Receipt", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
             ),
             const SizedBox(height: 16),
             TextButton(
               onPressed: () {
                  // Placeholder for reporting
               },
                child: const Text("Report an Issue", style: TextStyle(color: Colors.red, fontSize: 16)),
             )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label, 
          style: TextStyle(color: Colors.grey[600], fontSize: 14)
        ),
        const SizedBox(width: 20),
        Flexible(
          child: Text(
            value, 
            textAlign: TextAlign.right,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87)
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
