import 'package:flutter/material.dart';
import '../theme/billy_colors.dart';
import '../widgets/billy_widgets.dart';
import 'edit_profile_screen.dart';
import 'change_password_screen.dart';
import 'change_pin_screen.dart';
import 'kyc_upgrade_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _pushNotifications = true;
  bool _emailAlerts = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Account",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: GlowBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
               _buildBanner(
                title: "Account settings",
                icon: Icons.person_outline,
                children: [
                  _buildOptionTile(
                    Icons.edit,
                    "Edit Profile",
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen())),
                  ),
                  _buildOptionTile(
                    Icons.verified_user_outlined,
                    "Verification Status",
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: BillyColors.warning.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text("Unverified", style: TextStyle(color: BillyColors.warning, fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const KycUpgradeScreen())),
                  ),
                  _buildOptionTile(Icons.location_on_outlined, "Saved Addresses", onTap: () {}),
                ],
              ),
              const SizedBox(height: 20),

              _buildBanner(
                title: "Security & Notification settings",
                icon: Icons.security,
                children: [
                  _buildOptionTile(
                    Icons.lock_outline,
                    "Change Password",
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen())),
                  ),
                  _buildOptionTile(
                    Icons.pin,
                    "Change Transaction PIN",
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePinScreen())),
                  ),
                  _buildOptionTile(
                    Icons.notifications_outlined,
                    "Push Notifications",
                    isSwitch: true,
                    switchValue: _pushNotifications,
                    onSwitchChanged: (val) => setState(() => _pushNotifications = val),
                  ),
                  _buildOptionTile(
                    Icons.email_outlined,
                    "Email Alerts",
                    isSwitch: true,
                    switchValue: _emailAlerts,
                    onSwitchChanged: (val) => setState(() => _emailAlerts = val),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              _buildBanner(
                title: "Others",
                icon: Icons.more_horiz,
                children: [
                  _buildOptionTile(Icons.share_outlined, "Share App", onTap: () {}),
                  _buildOptionTile(Icons.star_border, "Review App", onTap: () {}),
                  _buildOptionTile(Icons.help_outline, "Help & Support", onTap: () {}),
                  _buildOptionTile(Icons.info_outline, "About Us", onTap: () {}),
                  _buildOptionTile(Icons.policy_outlined, "Privacy Policy", onTap: () {}),
                  _buildOptionTile(Icons.logout, "Log Out", iconColor: BillyColors.error, textColor: BillyColors.error, onTap: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBanner({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return SizedBox(
      width: double.infinity,
      child: GlassCard(
        radius: 20,
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(icon, color: BillyColors.primaryLight),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: BillyColors.borderSoft),
            Column(children: children),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(
    IconData icon,
    String title,
    {
      VoidCallback? onTap,
      bool isSwitch = false,
      bool switchValue = false,
      ValueChanged<bool>? onSwitchChanged,
      Color iconColor = BillyColors.primaryLight,
      Color? textColor,
      Widget? trailing,
    }
  ) {
    final effectiveTextColor = textColor ?? Colors.white;

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: iconColor),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: effectiveTextColor,
        ),
      ),
      trailing: isSwitch
        ? Switch(
            value: switchValue,
            activeColor: BillyColors.primaryLight,
            activeTrackColor: BillyColors.primary.withOpacity(0.5),
            inactiveThumbColor: BillyColors.textMuted,
            inactiveTrackColor: BillyColors.surfaceHigh,
            onChanged: onSwitchChanged,
          )
        : (trailing ?? const Icon(Icons.arrow_forward_ios, size: 16, color: BillyColors.textMuted)),
      onTap: isSwitch ? null : onTap,
    );
  }
}
