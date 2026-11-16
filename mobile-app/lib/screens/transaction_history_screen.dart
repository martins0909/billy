import 'package:flutter/material.dart';
import '../data/transaction_data.dart';
import '../theme/billy_colors.dart';
import '../widgets/billy_widgets.dart';
import 'transaction_details_screen.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transaction History",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GlowBackground(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: recentTransactions.length,
          itemBuilder: (context, index) {
            final transaction = recentTransactions[index];
            final isCredit = !transaction.amount.startsWith("-");

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GlassCard(
                radius: 16,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionDetailsScreen(transaction: transaction),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isCredit
                            ? BillyColors.success.withOpacity(0.15)
                            : BillyColors.primary.withOpacity(0.18),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                        color: isCredit ? BillyColors.success : BillyColors.primaryLight,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            transaction.date,
                            style: const TextStyle(
                              color: BillyColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      transaction.amount,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isCredit ? BillyColors.success : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
