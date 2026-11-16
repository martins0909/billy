import 'package:flutter/material.dart';
import '../theme/billy_colors.dart';
import '../widgets/billy_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController(text: "User");
  final TextEditingController _lastNameController = TextEditingController(text: "Name");
  final TextEditingController _emailController = TextEditingController(text: "user@example.com");
  final TextEditingController _phoneController = TextEditingController(text: "08012345678");

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
              // Profile Image Section
              Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: BillyColors.surfaceHigh,
                      border: Border.all(color: BillyColors.primaryLight, width: 3),
                      boxShadow: BillyColors.glow(0.4),
                    ),
                    child: const Icon(Icons.person, size: 80, color: BillyColors.textMuted),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // Logic to pick image
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          gradient: BillyColors.brandGradient,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Form Fields
              Row(
                children: [
                  Expanded(child: _buildTextField("First Name", _firstNameController, Icons.person_outline)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField("Last Name", _lastNameController, Icons.person_outline)),
                ],
              ),
              const SizedBox(height: 20),
              _buildTextField("Email Address", _emailController, Icons.email_outlined),
              const SizedBox(height: 20),
              _buildTextField("Phone Number", _phoneController, Icons.phone_android),

              const SizedBox(height: 50),

              // Save Button
              GradientButton(
                label: "Save Changes",
                expand: true,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                onPressed: () {
                  // Save logic simulation
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Profile Updated Successfully")),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: BillyColors.textMuted),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}
