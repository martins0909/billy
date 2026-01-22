import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black, // Removed to use theme background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Header
              _buildHeader(),
              const SizedBox(height: 20),

              // 2. Balance Card
              _buildBalanceCard(),
              const SizedBox(height: 24),

              // 3. Quick Actions Section
              _buildQuickActionsSection(),
              const SizedBox(height: 16),
              _buildPhoneVerificationBanner(),
              const SizedBox(height: 24),

              // 5. Promotional Banner
              _buildPromoBanner(),
              const SizedBox(height: 24),

              // 6. Recent Transactions
              const Text(
                "Recent Transactions",
                style: TextStyle(
                  color: Colors.black, // Changed to black
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildRecentTransactions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, User",
                  style: TextStyle(
                    color: Colors.grey[600], // Changed to grey[600]
                    fontSize: 14,
                  ),
                ),
                const Text(
                  "Good Morning",
                  style: TextStyle(
                    color: Colors.black, // Changed to black
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Colors.black), // Changed to black
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1D6A4A),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D6A4A).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Wallet Balance",
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(
                      _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _isBalanceVisible = !_isBalanceVisible;
                      });
                    },
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TransactionHistoryScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Transaction History",
                    style: TextStyle(
                      color: Color(0xFF27835E),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _isBalanceVisible ? "₦ 50,000.00" : "****",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddMoneyScreen()));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add, color: Color(0xFF27835E), size: 20),
                      SizedBox(width: 8),
                      Text(
                        "Add Money",
                        style: TextStyle(
                          color: Color(0xFF27835E),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_outward, color: Color(0xFF27835E), size: 20),
                    SizedBox(width: 8),
                    Text(
                      "Withdraw",
                      style: TextStyle(
                        color: Color(0xFF27835E),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // Changed to white
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Quick Action",
            style: TextStyle(
              color: Colors.black, // Changed to black
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildQuickActionButton(
                    Icons.phone, 
                    "Airtime",
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AirtimeScreen())),
                  )),
                  const SizedBox(width: 12),
                  Expanded(child: _buildQuickActionButton(
                    Icons.wifi, 
                    "Data",
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DataScreen())),
                  )),
                  const SizedBox(width: 12),
                  Expanded(child: _buildQuickActionButton(
                    Icons.credit_card, 
                    "ATM Card",
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AtmCardScreen())),
                  )),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildQuickActionButton(Icons.public, "Foreign Number")),
                  const SizedBox(width: 12),
                  Expanded(child: _buildQuickActionButton(Icons.campaign, "Engagement")),
                  const SizedBox(width: 12),
                  Expanded(child: _buildQuickActionButton(
                    Icons.grid_view, 
                    "More",
                    onTap: widget.onSwitchToServices,
                  )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(IconData icon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5E9), // Light green background
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF38ef7d).withOpacity(0.1)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF1b5e20), size: 24), // Dark green icon
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black87, // Dark text
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildPhoneVerificationBanner() {
    return Container(
      width: double.infinity,
      height: 140, // Fixed height for the banner
      decoration: BoxDecoration(
        color: const Color(0xFF1D6A4A), // Dark Green
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1D6A4A).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Buy all countries phone number for verification with ease in less than 5 secs",
                        style: TextStyle(
                          color: Colors.white, // White text on dark green
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Icon(Icons.verified, color: Color(0xFF38ef7d), size: 24),
                    ],
                  ),
                ),
                // Spacer to push text to the left, leaving room for the image
                const Expanded(flex: 1, child: SizedBox()),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.asset(
                "assets/phone1.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9), // Very light green
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF38ef7d).withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Get 10% Cashback",
                    style: TextStyle(
                      color: const Color(0xFF1b5e20), // Dark green text
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "On your first airtime recharge",
                    style: TextStyle(
                      color: Colors.grey[700], // Dark grey text
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 100,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF38ef7d).withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: const Icon(Icons.local_offer, color: Color(0xFF1b5e20), size: 40), // Dark green icon
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: recentTransactions.length,
      itemBuilder: (context, index) {
        final transaction = recentTransactions[index];
        return GestureDetector(
          onTap: () => _showTransactionDetails(transaction),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white, // White background
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_upward, color: Colors.red, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.title,
                        style: const TextStyle(
                          color: Colors.black, // Black text
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        transaction.date,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Text(
                  transaction.amount,
                  style: const TextStyle(
                    color: Colors.black, // Black text
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
