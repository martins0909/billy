import 'package:flutter/material.dart';
import '../theme/billy_colors.dart';
import 'home_screen.dart';
import 'my_orders_screen.dart';
import 'services_screen.dart';
import 'wallet_screen.dart';
import 'account_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  static const _items = [
    (Icons.home_rounded, 'Home'),
    (Icons.grid_view_rounded, 'Services'),
    (Icons.account_balance_wallet_rounded, 'Wallet'),
    (Icons.assignment_rounded, 'My Orders'),
    (Icons.person_rounded, 'Account'),
  ];

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(onSwitchToServices: () => _onItemTapped(1)),
      const ServicesScreen(),
      const WalletScreen(),
      const MyOrdersScreen(),
      const AccountScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: _buildNavBar(),
    );
  }

  Widget _buildNavBar() {
    return Container(
      color: BillyColors.background,
      padding: const EdgeInsets.fromLTRB(10, 6, 10, 10),
      child: SafeArea(
        top: false,
        child: Container(
          height: 74,
          decoration: BoxDecoration(
            gradient: BillyColors.glassGradient,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: BillyColors.primaryLight.withOpacity(0.55), width: 1.4),
            boxShadow: BillyColors.glow(0.3),
          ),
          child: Row(
            children: [
              for (int i = 0; i < _items.length; i++) ...[
                if (i > 0)
                  Container(width: 1, height: 38, color: BillyColors.borderSoft),
                Expanded(child: _buildNavItem(i)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final selected = index == _selectedIndex;
    final (icon, label) = _items[index];
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () => _onItemTapped(index),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 28,
                color: selected ? BillyColors.primaryLight : Colors.white,
              ),
              const SizedBox(height: 3),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: selected ? BillyColors.primaryLight : Colors.white,
                ),
              ),
            ],
          ),
          if (selected)
            Positioned(
              bottom: 0,
              child: Container(
                width: 46,
                height: 3.5,
                decoration: BoxDecoration(
                  gradient: BillyColors.brandGradient,
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: BillyColors.glow(0.6),
                ),
              ),
            ),
        ],
      ),
    );
  }
}