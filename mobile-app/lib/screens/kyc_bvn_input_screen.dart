import 'package:flutter/material.dart';

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.green, size: 40),
            ),
            const SizedBox(height: 20),
            const Text(
              "Verification Successful!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              "Your account limits have been increased to Tier 1.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                   Navigator.pop(context); // Close dialog
                   Navigator.pop(context); // Close input screen
                   Navigator.pop(context); // Close consent screen - back to account
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D6A4A),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Done", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Enter BVN", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              "Please enter your 11-digit Bank Verification Number below.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _bvnController,
              keyboardType: TextInputType.number,
              maxLength: 11,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, letterSpacing: 4, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: "00000000000",
                hintStyle: TextStyle(color: Colors.grey[300]),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: Color(0xFF1D6A4A), width: 2),
                ),
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
                  style: TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                      text: "*565*0#",
                      style: TextStyle(
                        color: Color(0xFF1D6A4A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _verifyBvn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D6A4A),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: _isLoading 
                  ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Text("Verify BVN", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
