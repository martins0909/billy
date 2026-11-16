import 'package:flutter/material.dart';
import '../theme/billy_colors.dart';
import '../widgets/billy_widgets.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool _isBalanceVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "My Wallet",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: GlowBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Balance Card
                _buildBalanceCard(),
                const SizedBox(height: 24),

                // 2. Action Buttons
                _buildActionButtons(),
                const SizedBox(height: 32),

                // 3. Security & KYC Status
                _buildSecuritySection(),
                const SizedBox(height: 32),

                // 4. Recent Transactions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recent Transactions",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "See All",
                        style: TextStyle(color: BillyColors.primaryLight),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildTransactionList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
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
          const Text(
            "WALLET BALANCE",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isBalanceVisible ? "₦ 45,200.50" : "₦ * * * * *",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: Icon(
                  _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white.withOpacity(0.8),
                ),
                onPressed: () {
                  setState(() {
                    _isBalanceVisible = !_isBalanceVisible;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return GlassCard(
      radius: 20,
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton(Icons.add, "Fund"),
          _buildVerticalDivider(),
          _buildActionButton(Icons.arrow_outward, "Withdraw"),
          _buildVerticalDivider(),
          _buildActionButton(Icons.send, "Transfer"),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 40,
      width: 1,
      color: BillyColors.borderSoft,
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: BillyColors.primary.withOpacity(0.18),
            shape: BoxShape.circle,
            border: Border.all(color: BillyColors.borderSoft),
          ),
          child: Icon(icon, color: BillyColors.primaryLight, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSecuritySection() {
    return GlassCard(
      radius: 16,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: BillyColors.primary.withOpacity(0.18),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.shield, color: BillyColors.primaryLight, size: 24),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Security & KYC Status",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Tier 2 Verified • Biometrics Active",
                  style: TextStyle(
                    color: BillyColors.success,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: BillyColors.textMuted),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    final transactions = [
      {
        'title': 'Wallet Funding',
        'date': 'Today, 9:41 AM',
        'amount': '+ ₦ 10,000.00',
        'isCredit': true,
        'icon': Icons.account_balance_wallet,
      },
      {
        'title': 'Airtime Purchase',
        'date': 'Yesterday, 4:30 PM',
        'amount': '- ₦ 500.00',
        'isCredit': false,
        'icon': Icons.phone_android,
      },
      {
        'title': 'Electricity Bill',
        'date': 'Jan 28, 2:15 PM',
        'amount': '- ₦ 3,200.00',
        'isCredit': false,
        'icon': Icons.lightbulb,
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final tx = transactions[index];
        final isCredit = tx['isCredit'] as bool;

        return GlassCard(
          radius: 16,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isCredit
                      ? BillyColors.success.withOpacity(0.15)
                      : BillyColors.error.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  tx['icon'] as IconData,
                  color: isCredit ? BillyColors.success : BillyColors.error,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx['title'] as String,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tx['date'] as String,
                      style: const TextStyle(
                        color: BillyColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                tx['amount'] as String,
                style: TextStyle(
                  color: isCredit ? BillyColors.success : Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
