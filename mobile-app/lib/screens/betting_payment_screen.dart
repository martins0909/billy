import 'package:flutter/material.dart';
import '../theme/billy_colors.dart';
import '../widgets/billy_widgets.dart';

class BettingPaymentScreen extends StatefulWidget {
  final String providerName;
  final String providerIconAsset; // Or use generic icon if asset not available

  const BettingPaymentScreen({
    super.key,
    required this.providerName,
    required this.providerIconAsset,
  });

  @override
  State<BettingPaymentScreen> createState() => _BettingPaymentScreenState();
}

class _BettingPaymentScreenState extends State<BettingPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _customerIdController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _customerIdController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fund ${widget.providerName}", style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GlowBackground(
        child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Provider Header
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: BillyColors.primary.withOpacity(0.15),
                          shape: BoxShape.circle,
                          border: Border.all(color: BillyColors.border),
                          boxShadow: BillyColors.glow(0.25),
                        ),
                        child: const Icon(Icons.sports_soccer, size: 40, color: BillyColors.primaryLight),
                        // In a real app, use Image.asset(widget.providerIconAsset),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.providerName,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Customer ID Input
                const Text(
                  "User ID / Customer ID",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: BillyColors.textSecondary),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _customerIdController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter your ${widget.providerName} User ID",
                    prefixIcon: const Icon(Icons.person_outline, color: BillyColors.textMuted),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your User ID';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Amount Input
                const Text(
                  "Amount",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: BillyColors.textSecondary),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Enter amount (e.g 1000)",
                    prefixIcon: Icon(Icons.attach_money, color: BillyColors.textMuted), // Currency symbol usually
                    prefixText: "₦ ",
                    prefixStyle: TextStyle(color: Colors.white),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 40),

                // Pay Button
                GradientButton(
                  label: "Continue",
                  expand: true,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  onPressed: _processPayment,
                ),
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }

  void _processPayment() {
    if (_formKey.currentState!.validate()) {
      // Show Confirmation Dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: BillyColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: BillyColors.border),
          ),
          title: const Text("Confirm Transaction", style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Provider: ${widget.providerName}", style: const TextStyle(color: BillyColors.textSecondary)),
              const SizedBox(height: 8),
              Text("User ID: ${_customerIdController.text}", style: const TextStyle(color: BillyColors.textSecondary)),
              const SizedBox(height: 8),
              Text("Amount: ₦${_amountController.text}", style: const TextStyle(color: BillyColors.textSecondary)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: BillyColors.textSecondary)),
            ),
            GradientButton(
              label: "Proceed",
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              onPressed: () {
                Navigator.pop(context); // Close confirm dialog
                _showPinDialog();
              },
            ),
          ],
        ),
      );
    }
  }

  void _showPinDialog() {
    final TextEditingController pinController = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: BillyColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: BillyColors.border),
        ),
        title: const Text("Enter PIN", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Please enter your 4-digit PIN to confirm payment.", style: TextStyle(color: BillyColors.textSecondary)),
            const SizedBox(height: 16),
            TextField(
              controller: pinController,
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 4,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "****",
                counterText: "",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: BillyColors.textSecondary)),
          ),
          GradientButton(
            label: "Pay Details",
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            onPressed: () {
              if (pinController.text.length == 4) {
                Navigator.pop(context); // Close PIN dialog
                _executeTransaction();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please enter a valid 4-digit PIN")),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void _executeTransaction() {
    // Simulate Processing
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Processing Payment...")),
    );
    
    // Here you would add the transaction logic
    Future.delayed(const Duration(seconds: 2), () {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Payment Successful (Simulated)")),
      );
      Navigator.pop(context); // Go back
    });
  }
}
