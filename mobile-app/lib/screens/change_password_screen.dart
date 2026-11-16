import 'package:flutter/material.dart';
import '../theme/billy_colors.dart';
import '../widgets/billy_widgets.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
              _buildPasswordField("Current Password", _oldPasswordController, _obscureOld, () {
                setState(() => _obscureOld = !_obscureOld);
              }),
              const SizedBox(height: 20),
              _buildPasswordField("New Password", _newPasswordController, _obscureNew, () {
                setState(() => _obscureNew = !_obscureNew);
              }),
              const SizedBox(height: 20),
              _buildPasswordField("Confirm New Password", _confirmPasswordController, _obscureConfirm, () {
                setState(() => _obscureConfirm = !_obscureConfirm);
              }),
              const SizedBox(height: 50),
              GradientButton(
                label: "Update Password",
                expand: true,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                onPressed: () {
                  if (_newPasswordController.text != _confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("New passwords do not match")));
                    return;
                  }
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password changed successfully")));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller, bool obscure, VoidCallback onToggle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline, color: BillyColors.textMuted),
            suffixIcon: IconButton(
              icon: Icon(obscure ? Icons.visibility_off : Icons.visibility, color: BillyColors.textMuted),
              onPressed: onToggle,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}
