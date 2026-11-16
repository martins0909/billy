import 'package:flutter/material.dart';
import '../theme/billy_colors.dart';
import '../widgets/billy_widgets.dart';

class KycBvnInputScreen extends StatefulWidget {
  const KycBvnInputScreen({super.key});

  @override
  State<KycBvnInputScreen> createState() => _KycBvnInputScreenState();
}

class _KycBvnInputScreenState extends State<KycBvnInputScreen> {
  final TextEditingController _bvnController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _bvnController.dispose();
    super.dispose();
  }

  void _verifyBvn() {
    if (_bvnController.text.length != 11) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 11-digit BVN")),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate API call
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _isLoading = false);
        _showSuccessDialog();
      }
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: BillyColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: BillyColors.border),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: BillyColors.success.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: BillyColors.success, size: 40),
            ),
            const SizedBox(height: 20),
            const Text(
              "Verification Successful!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              "Your account limits have been increased to Tier 1.",
              textAlign: TextAlign.center,
              style: TextStyle(color: BillyColors.textSecondary),
            ),
            const SizedBox(height: 20),
            GradientButton(
              label: "Done",
              expand: true,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              onPressed: () {
                 Navigator.pop(context); // Close dialog
                 Navigator.pop(context); // Close input screen
                 Navigator.pop(context); // Close consent screen - back to account
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter BVN", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GlowBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Text(
                "Please enter your 11-digit Bank Verification Number below.",
                textAlign: TextAlign.center,
                style: TextStyle(color: BillyColors.textSecondary, fontSize: 16),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _bvnController,
                keyboardType: TextInputType.number,
                maxLength: 11,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, letterSpacing: 4, fontWeight: FontWeight.bold, color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "00000000000",
                  hintStyle: TextStyle(color: BillyColors.textMuted),
                  counterStyle: TextStyle(color: BillyColors.textMuted),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Dial code logic
                },
                child: RichText(
                  text: const TextSpan(
                    text: "Don't know your BVN? Dial ",
                    style: TextStyle(color: BillyColors.textSecondary),
                    children: [
                      TextSpan(
                        text: "*565*0#",
                        style: TextStyle(
                          color: BillyColors.primaryLight,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Opacity(
                opacity: _isLoading ? 0.7 : 1,
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: BillyColors.brandGradient,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: BillyColors.glow(0.45),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(40),
                      onTap: _isLoading ? null : _verifyBvn,
                      child: Center(
                        child: _isLoading
                            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                            : const Text("Verify BVN", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
