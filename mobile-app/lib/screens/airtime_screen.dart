import 'package:flutter/material.dart';
import '../theme/billy_colors.dart';
import '../widgets/billy_widgets.dart';
import 'package:flutter/services.dart';

class AirtimeScreen extends StatefulWidget {
  const AirtimeScreen({super.key});

  @override
  State<AirtimeScreen> createState() => _AirtimeScreenState();
}

class _AirtimeScreenState extends State<AirtimeScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String? _selectedNetwork;
  
  // Nigeria Networks
  final List<Map<String, dynamic>> _networks = [
    {'name': 'MTN', 'color': Colors.yellow, 'logo': Icons.cell_tower}, // Placeholder icons
    {'name': 'Airtel', 'color': Colors.red, 'logo': Icons.cell_tower},
    {'name': 'Glo', 'color': Colors.green, 'logo': Icons.cell_tower},
    {'name': '9mobile', 'color': Colors.lightGreen, 'logo': Icons.cell_tower},
  ];

  final List<String> _quickAmounts = ['100', '200', '500', '1000', '2000', '5000'];

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buy Airtime", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: GlowBackground(
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Network Selection
            const Text(
              "Select Network",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _networks.map((network) {
                final bool isSelected = _selectedNetwork == network['name'];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedNetwork = network['name'];
                    });
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: isSelected ? network['color'].withOpacity(0.2) : BillyColors.surface,
                      border: Border.all(
                        color: isSelected ? network['color'] : BillyColors.borderSoft,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(network['logo'], color: isSelected ? network['color'] : BillyColors.textMuted),
                        const SizedBox(height: 4),
                        Text(
                          network['name'],
                          style: TextStyle(
                            fontSize: 10, 
                            fontWeight: FontWeight.bold,
                            color: isSelected ? network['color'] : BillyColors.textMuted
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // Phone Number Input
            const Text(
              "Phone Number",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.white),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(11)],
              decoration: InputDecoration(
                hintText: "Enter phone number",
                prefixIcon: const Icon(Icons.phone_android, color: BillyColors.textMuted),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.contact_phone, color: BillyColors.primaryLight),
                  onPressed: () {
                    // Logic to pick from contacts
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Amount Input
            const Text(
              "Amount",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                hintText: "Enter amount",
                prefixText: "₦ ",
                prefixStyle: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 16),

            // Quick Amounts
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _quickAmounts.map((amount) {
                return GestureDetector(
                  onTap: () {
                    _amountController.text = amount;
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: BillyColors.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: BillyColors.border),
                    ),
                    child: Text(
                      "₦$amount",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 40),

            // Pay Button
            GradientButton(
              label: "Pay",
              expand: true,
              padding: const EdgeInsets.symmetric(vertical: 16),
              onPressed: () {
                  // Implement payment logic here
                  if (_phoneController.text.isEmpty || _amountController.text.isEmpty || _selectedNetwork == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill all details")),
                    );
                    return;
                  }
                  
                  showModalBottomSheet(
                    context: context, 
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) => Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Confirm Transaction", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Network", style: TextStyle(color: BillyColors.textSecondary)),
                              Text(_selectedNetwork!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Number", style: TextStyle(color: BillyColors.textSecondary)),
                              Text(_phoneController.text, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Amount", style: TextStyle(color: BillyColors.textSecondary)),
                              Text("₦${_amountController.text}", style: const TextStyle(fontWeight: FontWeight.bold, color: BillyColors.primaryLight)),
                            ],
                          ),
                          const SizedBox(height: 30),
                          GradientButton(
                            label: "Confirm Pay",
                            expand: true,
                            onPressed: () {
                              Navigator.pop(context); // Close sheet
                              _showPinDialog();
                            },
                          )
                        ],
                      ),
                    )
                  );
              },
            ),
          ],
        ),
      ),
      ),
    );
  }

  void _showPinDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        String enteredPin = "";
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: BillyColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: BillyColors.border),
              ),
              title: const Center(child: Text("Enter PIN", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Enter your 4-digit security PIN", style: TextStyle(color: BillyColors.textSecondary)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index < enteredPin.length ? BillyColors.primaryLight : BillyColors.surfaceHigh,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  // Simple Number Pad
                  Column(
                    children: [
                      for (var i = 0; i < 3; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(3, (j) {
                              int number = i * 3 + j + 1;
                              return _buildPinKey(number.toString(), (val) {
                                if (enteredPin.length < 4) {
                                  setState(() {
                                    enteredPin += val;
                                  });
                                  if (enteredPin.length == 4) {
                                    // Auto submit
                                    Future.delayed(const Duration(milliseconds: 300), () {
                                      Navigator.pop(context); // Close PIN dialog
                                      _processTransaction();
                                    });
                                  }
                                }
                              });
                            }),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(width: 60),
                          _buildPinKey("0", (val) {
                             if (enteredPin.length < 4) {
                                  setState(() {
                                    enteredPin += val;
                                  });
                                  if (enteredPin.length == 4) {
                                    Future.delayed(const Duration(milliseconds: 300), () {
                                      Navigator.pop(context);
                                      _processTransaction();
                                    });
                                  }
                                }
                          }),
                          InkWell(
                            onTap: () {
                              if (enteredPin.isNotEmpty) {
                                setState(() {
                                  enteredPin = enteredPin.substring(0, enteredPin.length - 1);
                                });
                              }
                            },
                            child: const SizedBox(
                              width: 60,
                              height: 60,
                              child: Icon(Icons.backspace_outlined, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel", style: TextStyle(color: BillyColors.error)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildPinKey(String text, Function(String) onTap) {
    return InkWell(
      onTap: () => onTap(text),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: BillyColors.surfaceHigh,
          border: Border.all(color: BillyColors.borderSoft),
        ),
        child: Text(text, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  void _processTransaction() {
    // Show Loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(color: BillyColors.primary)),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close loading
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Transaction Successful!"), 
          backgroundColor: BillyColors.primary,
        ),
      );
      Navigator.pop(context); // Go back to Home
    });
  }
}
