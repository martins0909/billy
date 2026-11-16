import 'package:flutter/material.dart';
import '../theme/billy_colors.dart';
import '../widgets/billy_widgets.dart';
import 'login_screen.dart';

class SignupFormScreen extends StatefulWidget {
  const SignupFormScreen({super.key});

  @override
  State<SignupFormScreen> createState() => _SignupFormScreenState();
}

class _SignupFormScreenState extends State<SignupFormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

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
                    "Create Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Join Billy today!",
                    style: TextStyle(
                      color: BillyColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),

                  GlassCard(
                    radius: 24,
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Full Name Input
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: "Full Name",
                            labelStyle: TextStyle(color: BillyColors.textMuted),
                            prefixIcon: Icon(Icons.person_outline,
                                color: BillyColors.primaryLight),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Email Input
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Email Address",
                            labelStyle: TextStyle(color: BillyColors.textMuted),
                            prefixIcon: Icon(Icons.email_outlined,
                                color: BillyColors.primaryLight),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Phone Number Input
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: "Phone Number",
                            labelStyle: TextStyle(color: BillyColors.textMuted),
                            prefixIcon: Icon(Icons.phone_android,
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
                        const SizedBox(height: 20),

                        // Confirm Password Input
                        TextFormField(
                          obscureText: !_isConfirmPasswordVisible,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            labelStyle:
                                const TextStyle(color: BillyColors.textMuted),
                            prefixIcon: const Icon(Icons.lock_outline,
                                color: BillyColors.primaryLight),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: BillyColors.textMuted,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordVisible =
                                      !_isConfirmPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Sign Up Button
                        GradientButton(
                          label: "Create Account",
                          expand: true,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          onPressed: () {
                            // TODO: Implement Registration Logic
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: BillyColors.textSecondary),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: BillyColors.primaryLight,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---- Signup Choice Screen (alternative UI) ----
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BillyColors.background,
      body: GlowBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // LOGO
                Image.asset(
                  'assets/billylogo.png',
                  height: 80,
                ),

                const SizedBox(height: 12),

                // TAGLINE
                const Column(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Join Billy',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: ' and start paying',
                            style: TextStyle(
                              color: BillyColors.textSecondary,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'your bills easier',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: BillyColors.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // APPLE BUTTON
                authButton(
                  text: 'Sign Up with Apple',
                  icon: Icons.apple,
                  bgColor: Colors.black,
                  textColor: Colors.white,
                  borderColor: BillyColors.border,
                  onPressed: () {},
                ),

                // GOOGLE BUTTON
                authButton(
                  text: 'Sign Up with Google',
                  icon: Icons.g_mobiledata,
                  bgColor: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {},
                ),

                // PHONE BUTTON
                outlineButton(
                  text: 'Use Phone Number',
                  icon: Icons.phone,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupFormScreen()),
                    );
                  },
                ),

                // EMAIL BUTTON
                outlineButton(
                  text: 'Use Email Address',
                  icon: Icons.email,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupFormScreen()),
                    );
                  },
                ),

                const SizedBox(height: 24),

                // OR DIVIDER
                Row(
                  children: const [
                    Expanded(child: Divider(color: BillyColors.borderSoft)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'or',
                        style: TextStyle(color: BillyColors.textMuted),
                      ),
                    ),
                    Expanded(child: Divider(color: BillyColors.borderSoft)),
                  ],
                ),

                const SizedBox(height: 16),

                // LOGIN LINK
                TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    }
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(color: BillyColors.textSecondary),
                      children: [
                        TextSpan(
                          text: 'Log In',
                          style: TextStyle(
                            color: BillyColors.primaryLight,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
}

// FILLED BUTTON
Widget authButton({
  required String text,
  required IconData icon,
  required Color bgColor,
  required Color textColor,
  Color? borderColor,
  required VoidCallback onPressed,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: textColor,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: borderColor != null
              ? BorderSide(color: borderColor)
              : BorderSide.none,
        ),
      ),
    ),
  );
}

// OUTLINE BUTTON
Widget outlineButton({
  required String text,
  required IconData icon,
  required VoidCallback onPressed,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    width: double.infinity,
    child: OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.black.withOpacity(0.25),
        side: BorderSide(
            color: BillyColors.primaryLight.withOpacity(0.8), width: 1.2),
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  );
}
