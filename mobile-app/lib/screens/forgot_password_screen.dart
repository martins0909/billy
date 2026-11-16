import 'package:flutter/material.dart';
import '../theme/billy_colors.dart';
import '../widgets/billy_widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BillyColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GlowBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Forgot Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Enter your email or phone number to reset your password.",
                    style: TextStyle(
                      color: BillyColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 32),

                  GlassCard(
                    radius: 24,
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      children: [
                        // Email/Phone Input
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: "Email or Phone Number",
                            labelStyle: TextStyle(color: BillyColors.textMuted),
                            prefixIcon: Icon(Icons.email_outlined,
                                color: BillyColors.primaryLight),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Send Reset Link Button
                        GradientButton(
                          label: "Send Reset Link",
                          expand: true,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          onPressed: () {
                            // TODO: Implement Reset Password Logic
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
