import 'package:flutter/material.dart';
import 'education_screen.dart';
import 'betting_screen.dart';
import 'airtime_screen.dart';
import 'data_screen.dart';
import 'atm_card_screen.dart';
import 'electricity_screen.dart';
import 'cable_tv_screen.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black, // Removed
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent to show scaffold background
        elevation: 0,
        title: const Text(
          "Services",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Black text
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildServiceBanner("Bills Payments", [
                {
                  'icon': Icons.phone, 
                  'label': 'Airtime',
                  'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AirtimeScreen())),
                },
                {
                  'icon': Icons.wifi, 
                  'label': 'Data',
                   'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DataScreen())),
                },
                {
                  'icon': Icons.sports_soccer, 
                  'label': 'Betting',
                  'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BettingScreen())),
                },
                {
                  'icon': Icons.school, 
                  'label': 'Education',
                  'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EducationScreen())),
                },
                {
                  'icon': Icons.lightbulb, 
                  'label': 'Electricity',
                  'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ElectricityScreen())),
                },
                {
                  'icon': Icons.tv, 
                  'label': 'Cable TV',
                  'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CableTvScreen())),
                },
              ]),
              const SizedBox(height: 16),
              _buildServiceBanner("Digital Services", [
                {'icon': Icons.rocket_launch, 'label': 'Social Boost'},
                {'icon': Icons.sim_card, 'label': 'eSIM Services'},
                {'icon': Icons.security, 'label': 'Proxies'},
                {'icon': Icons.campaign, 'label': 'Marketing'},
                {
                  'icon': Icons.credit_card, 
                  'label': 'Virtual Cards',
                  'onTap': () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AtmCardScreen())),
                },
                {'icon': Icons.calendar_month, 'label': 'Bookings'},
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceBanner(String title, List<Map<String, dynamic>> items) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // White background
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black, // Black text
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              Row(
                children: [
                   Expanded(
                    child: _buildQuickActionButton(
                      items[0]['icon'] as IconData, 
                      items[0]['label'] as String,
                      onTap: items[0]['onTap'] as VoidCallback?,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickActionButton(
                      items[1]['icon'] as IconData, 
                      items[1]['label'] as String,
                      onTap: items[1]['onTap'] as VoidCallback?,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickActionButton(
                      items[2]['icon'] as IconData, 
                      items[2]['label'] as String,
                      onTap: items[2]['onTap'] as VoidCallback?,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildQuickActionButton(
                      items[3]['icon'] as IconData, 
                      items[3]['label'] as String,
                      onTap: items[3]['onTap'] as VoidCallback?,
                    )
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickActionButton(
                      items[4]['icon'] as IconData, 
                      items[4]['label'] as String,
                      onTap: items[4]['onTap'] as VoidCallback?,
                    )
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickActionButton(
                      items[5]['icon'] as IconData, 
                      items[5]['label'] as String,
                      onTap: items[5]['onTap'] as VoidCallback?,
                    )
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(IconData icon, String label, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5E9), // Light green
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF38ef7d).withOpacity(0.1)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF1b5e20), size: 24), // Dark green icon
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black87, // Dark text
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
