import 'package:flutter/material.dart';
import '../theme/billy_colors.dart';
import '../widgets/billy_widgets.dart';
import 'kyc_bvn_input_screen.dart';

class KycUpgradeScreen extends StatefulWidget {
  const KycUpgradeScreen({super.key});

  @override
  State<KycUpgradeScreen> createState() => _KycUpgradeScreenState();
}

class _KycUpgradeScreenState extends State<KycUpgradeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("KYC Levels", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: BillyColors.textMuted,
          indicatorColor: BillyColors.primaryLight,
          dividerColor: BillyColors.borderSoft,
          tabs: const [
            Tab(text: "Tier 1"),
            Tab(text: "Tier 2"),
            Tab(text: "Tier 3"),
          ],
        ),
      ),
      body: GlowBackground(
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildTier1Content(),
            _buildTier2Content(),
            _buildTier3Content(),
          ],
        ),
      ),
    );
  }

  Widget _buildTier1Content() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStatusBanner(isVerified: true),
          const SizedBox(height: 20),
          _buildLimitCard("Daily Transaction Limit", "₦50,000"),
          const SizedBox(height: 12),
          _buildLimitCard("Maximum Balance", "₦300,000"),
          const SizedBox(height: 30),
          const Text("Requirements", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
          const SizedBox(height: 10),
          _buildRequirementTile("Phone Number Verified", true),
          _buildRequirementTile("Full Name Provided", true),
        ],
      ),
    );
  }

  Widget _buildTier2Content() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStatusBanner(isVerified: false), // Currently not verified
          const SizedBox(height: 20),
          _buildLimitCard("Daily Transaction Limit", "₦5,000,000"),
          const SizedBox(height: 12),
          _buildLimitCard("Maximum Balance", "Unlimited"),
          const SizedBox(height: 30),
          const Text("Requirements", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
          const SizedBox(height: 10),
          _buildRequirementTile("BVN Verification", false),
          _buildRequirementTile("Face Verification (Selfie)", false),
          
          const SizedBox(height: 40),
          GradientButton(
            label: "Upgrade to Tier 2",
            expand: true,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const KycBvnInputScreen()));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTier3Content() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: BillyColors.surfaceHigh,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: BillyColors.borderSoft),
            ),
            child: const Row(
              children: [
                Icon(Icons.lock_outline, color: BillyColors.textMuted),
                SizedBox(width: 12),
                Text("Complete Tier 2 to unlock", style: TextStyle(color: BillyColors.textSecondary, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildLimitCard("Daily Transaction Limit", "Unlimited"),
          const SizedBox(height: 12),
          _buildLimitCard("Maximum Balance", "Unlimited"),
          const SizedBox(height: 30),
          const Text("Requirements", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
          const SizedBox(height: 10),
          _buildRequirementTile("Valid ID Card (NIN/Voter's Card)", false),
          _buildRequirementTile("Utility Bill (Proof of Address)", false),
        ],
      ),
    );
  }

  Widget _buildStatusBanner({required bool isVerified}) {
    final statusColor = isVerified ? BillyColors.success : BillyColors.warning;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withOpacity(0.7)),
      ),
      child: Column(
        children: [
          Icon(
            isVerified ? Icons.check_circle : Icons.warning_amber_rounded,
            color: statusColor,
            size: 40,
          ),
          const SizedBox(height: 12),
          Text(
            isVerified ? "Current Level" : "Upgrade Available",
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isVerified 
              ? "You are currently on this tier." 
              : "Upgrade now to enjoy higher limits.",
            style: const TextStyle(color: BillyColors.textSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildLimitCard(String title, String value) {
    return GlassCard(
      radius: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: BillyColors.textSecondary, fontSize: 14)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildRequirementTile(String title, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
            color: isCompleted ? BillyColors.primaryLight : BillyColors.textMuted,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title, style: TextStyle(color: isCompleted ? Colors.white : BillyColors.textSecondary)),
          ),
        ],
      ),
    );
  }
}
