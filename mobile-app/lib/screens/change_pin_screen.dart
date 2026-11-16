import 'package:flutter/material.dart';
import '../theme/billy_colors.dart';
import '../widgets/billy_widgets.dart';

class ChangePinScreen extends StatefulWidget {
  const ChangePinScreen({super.key});

  @override
  State<ChangePinScreen> createState() => _ChangePinScreenState();
}

class _ChangePinScreenState extends State<ChangePinScreen> {
  // We'll use simple text fields for entering generic 4 digits for each step
  final _oldPinController = TextEditingController();
  final _newPinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change PIN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: GlowBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                "Secure your wallet by updating your transaction PIN.",
                style: TextStyle(color: BillyColors.textSecondary, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              _buildPinField("Current PIN", _oldPinController),
              const SizedBox(height: 20),
              _buildPinField("New PIN", _newPinController),
              const SizedBox(height: 20),
              _buildPinField("Confirm New PIN", _confirmPinController),

              const SizedBox(height: 50),
              GradientButton(
                label: "Update PIN",
                expand: true,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                onPressed: () {
                   if (_newPinController.text != _confirmPinController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("New PINs do not match")));
                    return;
                  }
                   if (_newPinController.text.length != 4) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("PIN must be 4 digits")));
                    return;
                  }
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("PIN changed successfully")));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          maxLength: 4,
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            counterText: "",
            prefixIcon: Icon(Icons.pin, color: BillyColors.textMuted),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}
