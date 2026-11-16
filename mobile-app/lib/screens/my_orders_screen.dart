import 'package:flutter/material.dart';
import '../theme/billy_colors.dart';
import '../widgets/billy_widgets.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BillyColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "My Orders",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          labelColor: BillyColors.primaryLight,
          unselectedLabelColor: BillyColors.textMuted,
          indicatorColor: BillyColors.primaryLight,
          dividerColor: BillyColors.borderSoft,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: "Active"),
            Tab(text: "Completed"),
            Tab(text: "Cancelled"),
          ],
        ),
      ),
      body: GlowBackground(
        child: TabBarView(
          controller: _tabController,
          children: const [
            _OrdersList(status: "Active"),
            _OrdersList(status: "Completed"),
            _OrdersList(status: "Cancelled"),
          ],
        ),
      ),
    );
  }
}

class _OrdersList extends StatelessWidget {
  final String status;

  const _OrdersList({required this.status});

  @override
  Widget build(BuildContext context) {
    // Dummy data based on status
    final List<Map<String, dynamic>> orders = _getDummyOrders(status);

    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined, size: 64, color: BillyColors.textMuted),
            const SizedBox(height: 16),
            Text(
              "No $status orders found",
              style: const TextStyle(color: BillyColors.textSecondary, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _OrderCard(order: order);
      },
    );
  }

  List<Map<String, dynamic>> _getDummyOrders(String status) {
    if (status == "Active") {
      return [
        {
          "id": "#12345",
          "service": "Airtime Purchase",
          "date": "Jan 10, 2026",
          "price": "₦5,000",
          "status": "In Progress",
          "image": Icons.phone,
          "color": Colors.green[100],
        },
        {
          "id": "#12348",
          "service": "Data Subscription",
          "date": "Jan 12, 2026",
          "price": "₦10,000",
          "status": "Scheduled",
          "image": Icons.wifi,
          "color": Colors.blue[100],
        },
      ];
    } else if (status == "Completed") {
      return [
        {
          "id": "#12340",
          "service": "Cable TV Sub",
          "date": "Dec 28, 2025",
          "price": "₦12,500",
          "status": "Completed",
          "image": Icons.tv,
          "color": Colors.purple[100],
        },
        {
          "id": "#12335",
          "service": "Electricity Bill",
          "date": "Dec 15, 2025",
          "price": "₦20,000",
          "status": "Completed",
          "image": Icons.lightbulb,
          "color": Colors.yellow[100],
        },
        {
          "id": "#12330",
          "service": "Betting Wallet Fund",
          "date": "Dec 05, 2025",
          "price": "₦2,500",
          "status": "Completed",
          "image": Icons.sports_soccer,
          "color": Colors.greenAccent[100],
        },
      ];
    } else {
      return [
        {
          "id": "#12320",
          "service": "Social Boost",
          "date": "Nov 20, 2025",
          "price": "₦50,000",
          "status": "Cancelled",
          "image": Icons.rocket_launch,
          "color": Colors.red[100],
        },
      ];
    }
  }
}

class _OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassCard(
        radius: 16,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: (order['color'] as Color?)?.withOpacity(0.25) ??
                        BillyColors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: BillyColors.borderSoft),
                  ),
                  child: Icon(
                    order['image'],
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['service'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order['id'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: BillyColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      order['price'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: BillyColors.primaryLight,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(order['status']).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        order['status'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(order['status']),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: BillyColors.borderSoft),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order['date'],
                  style: const TextStyle(color: BillyColors.textSecondary, fontSize: 13),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to details
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: BillyColors.primaryLight,
                  ),
                  child: const Text("View Details"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "In Progress":
        return BillyColors.primaryLight;
      case "Scheduled":
        return BillyColors.warning;
      case "Completed":
        return BillyColors.success;
      case "Cancelled":
        return BillyColors.error;
      default:
        return BillyColors.textMuted;
    }
  }
}
