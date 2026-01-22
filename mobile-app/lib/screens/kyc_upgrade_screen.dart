import 'package:flutter/material.dart';
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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("KYC Levels", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF1D6A4A),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF1D6A4A),
          tabs: const [
            Tab(text: "Tier 1"),
            Tab(text: "Tier 2"),
            Tab(text: "Tier 3"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTier1Content(),
          _buildTier2Content(),
          _buildTier3Content(),
        ],
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
          const Text("Requirements", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
          const Text("Requirements", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          _buildRequirementTile("BVN Verification", false),
          _buildRequirementTile("Face Verification (Selfie)", false),
          
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const KycBvnInputScreen()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1D6A4A),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Upgrade to Tier 2", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
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
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: const [
                Icon(Icons.lock_outline, color: Colors.grey),
                SizedBox(width: 12),
                Text("Complete Tier 2 to unlock", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildLimitCard("Daily Transaction Limit", "Unlimited"),
          const SizedBox(height: 12),
          _buildLimitCard("Maximum Balance", "Unlimited"),
          const SizedBox(height: 30),
          const Text("Requirements", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          _buildRequirementTile("Valid ID Card (NIN/Voter's Card)", false),
          _buildRequirementTile("Utility Bill (Proof of Address)", false),
        ],
      ),
    );
  }

  Widget _buildStatusBanner({required bool isVerified}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isVerified ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isVerified ? Colors.green : Colors.orange),
      ),
      child: Column(
        children: [
          Icon(
            isVerified ? Icons.check_circle : Icons.warning_amber_rounded,
            color: isVerified ? Colors.green : Colors.orange,
            size: 40,
          ),
          const SizedBox(height: 12),
          Text(
            isVerified ? "Current Level" : "Upgrade Available",
            style: TextStyle(
              color: isVerified ? Colors.green : Colors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isVerified 
              ? "You are currently on this tier." 
              : "Upgrade now to enjoy higher limits.",
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildLimitCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
            color: isCompleted ? const Color(0xFF1D6A4A) : Colors.grey,
          ),
          const SizedBox(width: 12),
          Text(title, style: TextStyle(color: isCompleted ? Colors.black : Colors.grey[700])),
        ],
      ),
    );
  }
}
