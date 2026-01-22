import 'package:flutter/material.dart';
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
      // backgroundColor: Colors.black, // Removed
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Black icon
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
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
                    color: Colors.black, // Black text
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Join Billy today!",
                  style: TextStyle(
                    color: Colors.grey[600], // Darker grey
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 32),

                // Full Name Input
                TextFormField(
                  style: const TextStyle(color: Colors.black), // Black text
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    labelStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF1D6A4A)), // Dark Green
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!), // Light grey border
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Color(0xFF1D6A4A)), // Dark Green
                    ),
                    filled: true,
                    fillColor: Colors.white, // White fill
                  ),
                ),
                const SizedBox(height: 20),

                // Email Input
                TextFormField(
                  style: const TextStyle(color: Colors.black), // Black text
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email Address",
                    labelStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFF1D6A4A)), // Dark Green
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Color(0xFF1D6A4A)), // Dark Green
                    ),
                    filled: true,
                    fillColor: Colors.white, // White fill
                  ),
                ),
                const SizedBox(height: 20),

                // Phone Number Input
                TextFormField(
                  style: const TextStyle(color: Colors.black), // Black text
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    labelStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon: const Icon(Icons.phone_android, color: Color(0xFF1D6A4A)), // Dark Green
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Color(0xFF1D6A4A)), // Dark Green
                    ),
                    filled: true,
                    fillColor: Colors.white, // White fill
                  ),
                ),
                const SizedBox(height: 20),

                // Password Input
                TextFormField(
                  obscureText: !_isPasswordVisible,
                  style: const TextStyle(color: Colors.black), // Black text
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF1D6A4A)), // Dark Green
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Color(0xFF1D6A4A)), // Dark Green
                    ),
                    filled: true,
                    fillColor: Colors.white, // White fill
                  ),
                ),
                const SizedBox(height: 20),

                // Confirm Password Input
                TextFormField(
                  obscureText: !_isConfirmPasswordVisible,
                  style: const TextStyle(color: Colors.black), // Black text
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF1D6A4A)), // Dark Green
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Color(0xFF1D6A4A)), // Dark Green
                    ),
                    filled: true,
                    fillColor: Colors.white, // White fill
                  ),
                ),
                const SizedBox(height: 40),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement Registration Logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1D6A4A), // Dark Green
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.grey[600]), // Darker grey
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Color(0xFF1D6A4A), // Dark Green
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
    );
  }
}

// ---- Signup Choice Screen (alternative UI) ----
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.1,
            colors: [
              Color(0xFF6A00FF),
              Color(0xFF1A0638),
              Color(0xFF090011),
            ],
          ),
        ),
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
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: ' and start paying',
                            style: TextStyle(
                              color: Colors.white70,
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
                        color: Colors.white70,
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
                    Expanded(child: Divider(color: Colors.white24)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'or',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.white24)),
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
                      style: TextStyle(color: Colors.white70),
                      children: [
                        TextSpan(
                          text: 'Log In',
                          style: TextStyle(
                            color: Colors.purpleAccent,
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
        side: const BorderSide(color: Colors.white24),
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  );
}
