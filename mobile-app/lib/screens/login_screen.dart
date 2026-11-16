import 'package:flutter/material.dart';
import '../theme/billy_colors.dart';
import '../widgets/billy_widgets.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';
import 'main_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BillyColors.background,
      body: GlowBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  // Logo / App Name
                  Center(
                    child: Column(
                      children: [
                        Container(
                          height: 88,
                          width: 88,
                          decoration: BoxDecoration(
                            gradient: BillyColors.brandGradient,
                            shape: BoxShape.circle,
                            boxShadow: BillyColors.glow(0.5),
                          ),
                          child: const Icon(
                            Icons.account_balance_wallet,
                            size: 42,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Billy",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),

                  GlassCard(
                    radius: 24,
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Welcome Text
                        const Text(
                          "Welcome Back!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Sign in to continue",
                          style: TextStyle(
                            color: BillyColors.textSecondary,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Phone/Email Input
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: "Phone Number or Email",
                            labelStyle: TextStyle(color: BillyColors.textMuted),
                            prefixIcon: Icon(Icons.person_outline,
                                color: BillyColors.primaryLight),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Password Input
                        TextFormField(
                          obscureText: !_isPasswordVisible,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle:
                                const TextStyle(color: BillyColors.textMuted),
                            prefixIcon: const Icon(Icons.lock_outline,
                                color: BillyColors.primaryLight),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: BillyColors.textMuted,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),

                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordScreen()),
                              );
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(color: BillyColors.primaryLight),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Login Button
                        GradientButton(
                          label: "Login",
                          expand: true,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const MainNavigation()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Sign Up Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: BillyColors.textSecondary),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen()),
                          );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: BillyColors.primaryLight,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
