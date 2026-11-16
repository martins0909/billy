import 'package:flutter/material.dart';
import '../theme/billy_colors.dart';
import '../widgets/billy_widgets.dart';
import 'package:flutter/services.dart';
import '../data/transaction_data.dart';
import 'dart:math';

class WaecPaymentScreen extends StatefulWidget {
  const WaecPaymentScreen({super.key});

  @override
  State<WaecPaymentScreen> createState() => _WaecPaymentScreenState();
}

class _WaecPaymentScreenState extends State<WaecPaymentScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final double _unitPrice = 3500.00;
  int _quantity = 1;

  double get _totalPrice => _unitPrice * _quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WAEC Result Checker", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GlowBackground(
        child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: BillyColors.cardGradient,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: BillyColors.border),
                  boxShadow: BillyColors.glow(),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.school, size: 60, color: Colors.white),
                    const SizedBox(height: 16),
                    const Text(
                      "WAEC Result Checker PIN",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "₦ ${_unitPrice.toStringAsFixed(2)} / pin",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                   const Text(
                    "Quantity:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: BillyColors.surface,
                      border: Border.all(color: BillyColors.border),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, color: BillyColors.primaryLight),
                          onPressed: () {
                            if (_quantity > 1) {
                              setState(() => _quantity--);
                            }
                          },
                        ),
                        Text(
                          "$_quantity",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: BillyColors.primaryLight),
                          onPressed: () {
                            if (_quantity < 10) { // Limit to 10 for safety
                              setState(() => _quantity++);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
               GlassCard(
                radius: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Amount:",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      "₦ ${_totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: BillyColors.primaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Phone Number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: BillyColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Enter phone number",
                  prefixIcon: Icon(Icons.phone_android),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: BillyColors.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: BillyColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: BillyColors.primaryLight),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        "Your PIN(s) and Serial Number(s) will be displayed immediately after successful payment.",
                        style: TextStyle(
                          color: BillyColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              GradientButton(
                label: "Pay Securely",
                expand: true,
                onPressed: _confirmPayment,
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }

  void _confirmPayment() {
    // Basic validation
    // if (_phoneController.text.isEmpty) { ... }

     showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Confirm Purchase"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Service: WAEC Result Checker", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              Text("Quantity: $_quantity", style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              Text("Total: ₦${_totalPrice.toStringAsFixed(2)}", style: const TextStyle(color: Colors.white)),
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
              style: ElevatedButton.styleFrom(backgroundColor: BillyColors.primary),
              child: const Text("Proceed", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
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
            const Text("Please enter your 4-digit PIN to confirm purchase."),
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
            style: ElevatedButton.styleFrom(backgroundColor: BillyColors.primary),
            child: const Text("Pay", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _executeTransaction() {
    // Show Loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(color: BillyColors.primaryLight)),
    );

    // Simulate Network Request
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close loading dialog

      // Generate Mock PINs and Serials
      final random = Random();
      // For simplicity, we'll just generate one pair or show a list in a real app.
      // Here let's generate a list of result checkers
      List<Map<String, String>> purchasedPins = [];
      for(int i = 0; i < _quantity; i++) {
        purchasedPins.add({
          'pin': List.generate(12, (_) => random.nextInt(10)).join(),
          'serial': "WR${List.generate(10, (_) => random.nextInt(10)).join()}",
        });
      }

      // Add to History (Just showing the first one for brevity in history title, or aggregate)
      setState(() {
        recentTransactions.insert(0, Transaction(
          title: "WAEC Pins ($_quantity)",
          date: "Just now",
          amount: "- ₦ ${_totalPrice.toStringAsFixed(2)}",
          type: 'waec',
          details: {
            // Storing the first one primarily for the simple history viewer, 
            // in a real app would store the full list
            'pin': purchasedPins.first['pin']!,
            'serial': purchasedPins.first['serial']!,
            'quantity': _quantity,
            'all_pins': purchasedPins, // Store all
          },
        ));
      });

      // Show Success Dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: BillyColors.success),
              SizedBox(width: 8),
              Text("Purchase Successful"),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("You have successfully purchased $_quantity WAEC PIN(s).", style: const TextStyle(fontSize: 14, color: BillyColors.textSecondary)),
                const SizedBox(height: 16),
                ...purchasedPins.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("PIN ${index + 1}:", style: const TextStyle(fontWeight: FontWeight.bold, color: BillyColors.textMuted)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: BillyColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: BillyColors.borderSoft),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("PIN: ${item['pin']}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                                Text("S/N: ${item['serial']}", style: const TextStyle(fontSize: 12, color: BillyColors.textSecondary)),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy, color: BillyColors.primaryLight, size: 20),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: "PIN: ${item['pin']} S/N: ${item['serial']}"));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Copied!")),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: BillyColors.borderSoft),
                    ],
                  );
                }),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to Education Screen (optional)
              },
              child: const Text("Close", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      );
    });
  }
}
