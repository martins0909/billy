import 'package:flutter/material.dart';
import '../theme/billy_colors.dart';
import '../widgets/billy_widgets.dart';
import 'package:flutter/services.dart';
import '../data/transaction_data.dart';
import 'airtime_screen.dart';
import 'data_screen.dart';
import 'atm_card_screen.dart';
import 'transaction_history_screen.dart';
import 'add_money_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onSwitchToServices;

  const HomeScreen({super.key, this.onSwitchToServices});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isBalanceVisible = true;

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 18) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlowBackground(
        fadeTop: false,
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 22),
                _buildBalanceCard(),
                const SizedBox(height: 26),
                _buildQuickActionsSection(),
                const SizedBox(height: 22),
                _buildPhoneVerificationBanner(),
                const SizedBox(height: 16),
                _buildPromoBanner(),
                const SizedBox(height: 26),
                const SectionTitle(title: "Recent Transactions"),
                const SizedBox(height: 14),
                _buildRecentTransactions(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Header
  // ---------------------------------------------------------------------------
  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 76,
          height: 76,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: BillyColors.brandGradient,
            boxShadow: BillyColors.glow(0.45),
          ),
          child: ClipOval(
            child: Image.network(
              'https://randomuser.me/api/portraits/women/44.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: BillyColors.surfaceHigh,
                child: const Icon(Icons.person, color: Colors.white, size: 38),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _greeting,
                style: const TextStyle(
                  color: BillyColors.textSecondary,
                  fontSize: 20,
                ),
              ),
              Row(
                children: [
                  const Flexible(
                    child: Text(
                      "Blessing",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        height: 1.15,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: BillyColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, color: Colors.white, size: 14),
                  ),
                ],
              ),
              const Text(
                "Have a great day ahead!",
                style: TextStyle(
                  color: BillyColors.textSecondary,
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 76,
                height: 2,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [BillyColors.primaryLight, Colors.transparent],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: BillyColors.surface.withOpacity(0.8),
                border: Border.all(color: BillyColors.border, width: 1.5),
                boxShadow: BillyColors.glow(0.25),
              ),
              child: IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.white, size: 28),
                onPressed: () {},
              ),
            ),
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF2D3F),
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  "2",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Wallet balance card
  // ---------------------------------------------------------------------------
  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      decoration: BoxDecoration(
        gradient: BillyColors.cardGradient,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: BillyColors.primaryLight.withOpacity(0.55), width: 1.5),
        boxShadow: BillyColors.glow(0.45),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.account_balance_wallet, color: Colors.white, size: 30),
                    const SizedBox(width: 10),
                    const Flexible(
                      child: Text(
                        "Wallet Balance",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => setState(() => _isBalanceVisible = !_isBalanceVisible),
                      child: Icon(
                        _isBalanceVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TransactionHistoryScreen()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: BillyColors.primaryLight.withOpacity(0.7)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.history, color: Colors.white, size: 22),
                      SizedBox(width: 6),
                      Text(
                        "Transaction\nHistory",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 1.15,
                        ),
                      ),
                      SizedBox(width: 2),
                      Icon(Icons.chevron_right, color: Colors.white70, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              _isBalanceVisible ? "₦ 50,000.00" : "****",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GradientButton(
                  label: "Add Money",
                  icon: Icons.add,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddMoneyScreen()),
                    );
                  },
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: OutlinePillButton(
                  label: "Withdraw",
                  icon: Icons.north_east,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Quick actions
  // ---------------------------------------------------------------------------
  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          title: "Quick Actions",
          actionLabel: "See All",
          onAction: widget.onSwitchToServices,
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionButton(
                Icons.phone,
                "Airtime",
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AirtimeScreen())),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildQuickActionButton(
                Icons.wifi,
                "Data",
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DataScreen())),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildQuickActionButton(
                Icons.credit_card,
                "ATM Card",
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AtmCardScreen())),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionButton(Icons.public, "Foreign Number", onTap: widget.onSwitchToServices),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildQuickActionButton(Icons.card_giftcard, "Engagement", onTap: widget.onSwitchToServices),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildQuickActionButton(Icons.grid_view, "More", onTap: widget.onSwitchToServices),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionButton(IconData icon, String label, {VoidCallback? onTap}) {
    return GlassCard(
      onTap: onTap,
      radius: 22,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShaderMask(
            shaderCallback: (rect) => const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFC77DFF), BillyColors.primary],
            ).createShader(rect),
            child: Icon(icon, color: Colors.white, size: 38),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Phone verification banner
  // ---------------------------------------------------------------------------
  Widget _buildPhoneVerificationBanner() {
    return Container(
      width: double.infinity,
      height: 190,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF3A0F8F), Color(0xFF5B0FD1), Color(0xFF8A2BFF)],
        ),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: BillyColors.primaryLight.withOpacity(0.5)),
        boxShadow: BillyColors.glow(0.3),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Stack(
          children: [
            // Phone + flags illustration
            Positioned(
              right: 8,
              top: 0,
              bottom: 0,
              width: 150,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: 0.24,
                    child: Container(
                      width: 78,
                      height: 140,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF2A0F73), Color(0xFF0B0430)],
                        ),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFB9B3D0), width: 3),
                        boxShadow: BillyColors.glow(0.6),
                      ),
                      child: const Icon(Icons.verified_user, color: BillyColors.primaryLight, size: 46),
                    ),
                  ),
                  Positioned(top: 18, left: 8, child: _flag('🇺🇸')),
                  Positioned(bottom: 26, left: 0, child: _flag('🇨🇦')),
                  Positioned(top: 24, right: 0, child: _flag('🇬🇧')),
                  Positioned(bottom: 16, right: 6, child: _flag('🇩🇪')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 150, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                      children: const [
                        TextSpan(text: "Buy all countries phone number for verification with ease in "),
                        TextSpan(
                          text: "less than 5 secs",
                          style: TextStyle(color: Color(0xFFE0B3FF)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  GestureDetector(
                    onTap: widget.onSwitchToServices,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1E8FF),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Verify Now",
                            style: TextStyle(
                              color: BillyColors.deepPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, color: BillyColors.deepPurple, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _flag(String emoji) {
    return Container(
      width: 38,
      height: 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: Colors.white70, width: 2),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 6)],
      ),
      child: Text(emoji, style: const TextStyle(fontSize: 22)),
    );
  }

  // ---------------------------------------------------------------------------
  // Cashback promo banner
  // ---------------------------------------------------------------------------
  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        gradient: BillyColors.glassGradient,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: BillyColors.primaryLight.withOpacity(0.6), width: 1.5),
        boxShadow: BillyColors.glow(0.25),
      ),
      child: Row(
        children: [
          Container(
            width: 74,
            height: 74,
            decoration: BoxDecoration(
              gradient: BillyColors.brandGradient,
              borderRadius: BorderRadius.circular(18),
              boxShadow: BillyColors.glow(0.5),
            ),
            child: const Icon(Icons.card_giftcard, color: Colors.white, size: 44),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text(
                      "Get ",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ShaderMask(
                      shaderCallback: (rect) => const LinearGradient(
                        colors: [Color(0xFFD08BFF), BillyColors.primary],
                      ).createShader(rect),
                      child: const Text(
                        "10%",
                        style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Flexible(
                      child: Text(
                        " Cashback",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const Text(
                  "On every successful transaction",
                  style: TextStyle(color: BillyColors.textSecondary, fontSize: 12.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Recent transactions
  // ---------------------------------------------------------------------------
  Widget _buildRecentTransactions() {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recentTransactions.length,
      itemBuilder: (context, index) {
        final transaction = recentTransactions[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GlassCard(
            radius: 18,
            padding: const EdgeInsets.all(14),
            onTap: () => _showTransactionDetails(transaction),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    gradient: BillyColors.brandGradient,
                    shape: BoxShape.circle,
                    boxShadow: BillyColors.glow(0.3),
                  ),
                  child: const Icon(Icons.arrow_upward, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        transaction.date,
                        style: const TextStyle(color: BillyColors.textMuted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Text(
                  transaction.amount,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  void _showTransactionDetails(Transaction transaction) {
    if (transaction.type == 'waec' && transaction.details != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("WAEC Result Checker"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("PIN:", style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(transaction.details!['pin']),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 20),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: transaction.details!['pin']));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("PIN copied to clipboard")),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text("Serial Number:", style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(transaction.details!['serial']),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 20),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: transaction.details!['serial']));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Serial Number copied")),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        ),
      );
    } else {
      // Default details for other transactions
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(transaction.title),
          content: Text("Amount: ${transaction.amount}\nDate: ${transaction.date}"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        ),
      );
    }
  }
}
