import 'package:flutter/material.dart';
import '../theme/billy_colors.dart';
import '../widgets/billy_widgets.dart';
import 'package:flutter/services.dart';

class AtmCardScreen extends StatefulWidget {
  const AtmCardScreen({super.key});

  @override
  State<AtmCardScreen> createState() => _AtmCardScreenState();
}

class _AtmCardScreenState extends State<AtmCardScreen> {
  final TextEditingController _nameController = TextEditingController();
  final String _creationFee = "2000"; 

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Virtual Card", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
            // Marketing / Visual Header
            Center(
              child: Container(
                height: 200,
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: BillyColors.cardGradient,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: BillyColors.border),
                  boxShadow: BillyColors.glow(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "BILLY VIRTUAL",
                          style: TextStyle(color: Colors.white70, fontSize: 14, letterSpacing: 1.5),
                        ),
                        const Icon(Icons.wifi, color: Colors.white70, size: 24),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.lock_outline, color: Colors.white60, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          "**** **** **** ****",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 22,
                            letterSpacing: 4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("CARD HOLDER", style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 10)),
                            const SizedBox(height: 4),
                            Text(
                               _nameController.text.isEmpty ? "YOUR NAME" : _nameController.text.toUpperCase(),
                               style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                         const Text(
                          "VISA",
                          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 30),

            // Features List
            const Text("Card Features", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 10),
            _buildFeatureItem(Icons.public, "Accepted Globally", "Use for international payments"),
            _buildFeatureItem(Icons.security, "Secure Transactions", "3D Secure enabled for safety"),
            _buildFeatureItem(Icons.bolt, "Instant Creation", "Get your card details immediately"),

            const SizedBox(height: 30),

            // Input Form
            const Text("Card Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 10),
            TextField(
              controller: _nameController,
              onChanged: (val) => setState(() {}),
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Name on Card",
                hintText: "Enter your full name",
                prefixIcon: Icon(Icons.person_outline, color: BillyColors.primaryLight),
              ),
            ),

            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: BillyColors.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: BillyColors.border),
              ),
              child: Row(
                children: [
                   const Icon(Icons.info_outline, color: BillyColors.primaryLight, size: 20),
                   const SizedBox(width: 8),
                   Text("Creation Fee: ₦$_creationFee", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Action Button
            GradientButton(
              label: "Create Card",
              expand: true,
              padding: const EdgeInsets.symmetric(vertical: 16),
              onPressed: () {
                   if (_nameController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter the name for the card")),
                      );
                      return;
                   }
                  _showConfirmationSheet();
              },
            ),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: BillyColors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: BillyColors.borderSoft),
            ),
            child: Icon(icon, color: BillyColors.primaryLight, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
              Text(subtitle, style: const TextStyle(color: BillyColors.textSecondary, fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }

  void _showConfirmationSheet() {
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
            const Text(
              "Confirm Card Order",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            _buildDetailRow("Service", "Virtual Card Creation"),
            _buildDetailRow("Name", _nameController.text),
            _buildDetailRow("Fee", "₦$_creationFee"),
            
            const SizedBox(height: 30),
            GradientButton(
              label: "Pay & Create",
              expand: true,
              onPressed: () {
                Navigator.pop(context); // Close sheet
                _showPinDialog();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: BillyColors.textSecondary, fontSize: 16)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
        ],
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
                                     Future.delayed(const Duration(milliseconds: 300), () {
                                      Navigator.pop(context); 
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
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(color: BillyColors.primary)),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close loading
      
      // Success Dialog with "View Card" button
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          backgroundColor: BillyColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: BillyColors.border),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: BillyColors.primaryLight, size: 60),
              const SizedBox(height: 20),
              const Text("Success!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 10),
              const Text("Your virtual card has been created successfully.", textAlign: TextAlign.center, style: TextStyle(color: BillyColors.textSecondary)),
              const SizedBox(height: 20),
              GradientButton(
                label: "Done",
                expand: true,
                padding: const EdgeInsets.symmetric(vertical: 12),
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Go back to Home
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
