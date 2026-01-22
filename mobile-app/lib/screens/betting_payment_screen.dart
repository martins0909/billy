import 'package:flutter/material.dart';

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
        title: Text("Fund ${widget.providerName}", style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
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
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.sports_soccer, size: 40, color: Colors.indigo[900]),
                        // In a real app, use Image.asset(widget.providerIconAsset),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.providerName,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Customer ID Input
                const Text(
                  "User ID / Customer ID",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _customerIdController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter your ${widget.providerName} User ID",
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.person_outline),
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
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter amount (e.g 1000)",
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.attach_money), // Currency symbol usually
                    prefixText: "₦ ",
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _processPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1D6A4A),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
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
          title: const Text("Confirm Transaction"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Provider: ${widget.providerName}"),
              const SizedBox(height: 8),
              Text("User ID: ${_customerIdController.text}"),
              const SizedBox(height: 8),
              Text("Amount: ₦${_amountController.text}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close confirm dialog
                _showPinDialog();
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1D6A4A)),
              child: const Text("Proceed", style: TextStyle(color: Colors.white)),
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
        title: const Text("Enter PIN"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Please enter your 4-digit PIN to confirm payment."),
            const SizedBox(height: 16),
            TextField(
              controller: pinController,
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 4,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "****",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                counterText: "",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
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
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1D6A4A)),
            child: const Text("Pay Details", style: TextStyle(color: Colors.white)),
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
