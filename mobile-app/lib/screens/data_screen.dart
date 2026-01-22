import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String? _selectedNetwork;
  Map<String, dynamic>? _selectedPlan;
  
  // Nigeria Networks
  final List<Map<String, dynamic>> _networks = [
    {'name': 'MTN', 'color': Colors.yellow, 'logo': Icons.cell_tower},
    {'name': 'Airtel', 'color': Colors.red, 'logo': Icons.cell_tower},
    {'name': 'Glo', 'color': Colors.green, 'logo': Icons.cell_tower},
    {'name': '9mobile', 'color': Colors.lightGreen, 'logo': Icons.cell_tower},
  ];

  // Dummy Data Plans
  final Map<String, List<Map<String, dynamic>>> _dataPlans = {
    'MTN': [
      {'data': '100MB', 'validity': '1 Day', 'price': '100'},
      {'data': '200MB', 'validity': '3 Days', 'price': '200'},
      {'data': '500MB', 'validity': '7 Days', 'price': '500'},
      {'data': '1GB', 'validity': '1 Month', 'price': '1000'},
      {'data': '2GB', 'validity': '1 Month', 'price': '1200'},
      {'data': '5GB', 'validity': '1 Month', 'price': '2500'},
    ],
    'Airtel': [
      {'data': '100MB', 'validity': '1 Day', 'price': '100'},
      {'data': '300MB', 'validity': '2 Days', 'price': '200'},
      {'data': '1.5GB', 'validity': '1 Month', 'price': '1000'},
      {'data': '3GB', 'validity': '1 Month', 'price': '1500'},
      {'data': '10GB', 'validity': '1 Month', 'price': '3000'},
    ],
    'Glo': [
      {'data': '200MB', 'validity': '2 Days', 'price': '100'},
      {'data': '500MB', 'validity': '5 Days', 'price': '200'},
      {'data': '2GB', 'validity': '1 Month', 'price': '1000'},
      {'data': '5GB', 'validity': '1 Month', 'price': '2000'},
    ],
    '9mobile': [
      {'data': '100MB', 'validity': '1 Day', 'price': '100'},
      {'data': '650MB', 'validity': '1 Month', 'price': '1000'},
      {'data': '2GB', 'validity': '1 Month', 'price': '1200'},
    ],
  };

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> currentPlans = 
        _selectedNetwork != null ? (_dataPlans[_selectedNetwork] ?? []) : [];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("Buy Data", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Network Selection
            const Text(
              "Select Network",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _networks.map((network) {
                final bool isSelected = _selectedNetwork == network['name'];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedNetwork = network['name'];
                      _selectedPlan = null; // Reset plan when network changes
                    });
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: isSelected ? network['color'].withOpacity(0.2) : Colors.white,
                      border: Border.all(
                        color: isSelected ? network['color'] : Colors.grey.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(network['logo'], color: isSelected ? network['color'] : Colors.grey),
                        const SizedBox(height: 4),
                        Text(
                          network['name'],
                          style: TextStyle(
                            fontSize: 10, 
                            fontWeight: FontWeight.bold,
                            color: isSelected ? network['color'] : Colors.grey
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // Plan Selection
            const Text(
              "Select Data Plan",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Map<String, dynamic>>(
                  isExpanded: true,
                  hint: Text(_selectedNetwork == null ? "Select a network first" : "Choose a plan"),
                  value: _selectedPlan,
                  items: currentPlans.map((plan) {
                    return DropdownMenuItem<Map<String, dynamic>>(
                      value: plan,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${plan['data']} (${plan['validity']})", style: const TextStyle(fontWeight: FontWeight.w500)),
                          Text("₦${plan['price']}", style: const TextStyle(color: Color(0xFF1D6A4A), fontWeight: FontWeight.bold)),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: _selectedNetwork == null ? null : (value) {
                    setState(() {
                      _selectedPlan = value;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Phone Number Input
            const Text(
              "Phone Number",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: "Enter phone number",
                  prefixIcon: const Icon(Icons.phone_android, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.contact_phone, color: Color(0xFF1D6A4A)),
                    onPressed: () {
                      // Logic to pick contact would go here
                    },
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Buy Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedNetwork == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please select a network")),
                    );
                    return;
                  }
                  if (_selectedPlan == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please select a data plan")),
                    );
                    return;
                  }
                  if (_phoneController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter a phone number")),
                    );
                    return;
                  }
                  
                  // Show Confirmation Details
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) => Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Confirm Purchase",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          _buildDetailRow("Network", _selectedNetwork!),
                          _buildDetailRow("Type", "Data"),
                          _buildDetailRow("Plan", "${_selectedPlan!['data']} (${_selectedPlan!['validity']})"),
                          _buildDetailRow("Phone", _phoneController.text),
                          _buildDetailRow("Amount", "₦${_selectedPlan!['price']}"),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); // Close confirmation sheet
                                _showPinDialog(); // Open PIN dialog using main context
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1D6A4A),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: const Text("Confirm & Pay", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D6A4A),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
                child: const Text(
                  "Buy Data",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPinDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        String enteredPin = "";
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: const Center(child: Text("Enter PIN", style: TextStyle(fontWeight: FontWeight.bold))),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Enter your 4-digit security PIN", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index < enteredPin.length ? const Color(0xFF1D6A4A) : Colors.grey.shade300,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  // Simple Number Pad
                  Column(
                    children: [
                      for (var i = 0; i < 3; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(3, (j) {
                              int number = i * 3 + j + 1;
                              return _buildPinKey(number.toString(), (val) {
                                if (enteredPin.length < 4) {
                                  setState(() {
                                    enteredPin += val;
                                  });
                                  if (enteredPin.length == 4) {
                                    // Auto submit
                                    Future.delayed(const Duration(milliseconds: 300), () {
                                      Navigator.pop(context); // Close PIN dialog
                                      _processTransaction();
                                    });
                                  }
                                }
                              });
                            }),
                          ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(width: 60),
                          _buildPinKey("0", (val) {
                             if (enteredPin.length < 4) {
                                  setState(() {
                                    enteredPin += val;
                                  });
                                  if (enteredPin.length == 4) {
                                    Future.delayed(const Duration(milliseconds: 300), () {
                                      Navigator.pop(context);
                                      _processTransaction();
                                    });
                                  }
                                }
                          }),
                          InkWell(
                            onTap: () {
                              if (enteredPin.isNotEmpty) {
                                setState(() {
                                  enteredPin = enteredPin.substring(0, enteredPin.length - 1);
                                });
                              }
                            },
                            child: const SizedBox(
                              width: 60,
                              height: 60,
                              child: Icon(Icons.backspace_outlined),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel", style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildPinKey(String text, Function(String) onTap) {
    return InkWell(
      onTap: () => onTap(text),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade100,
        ),
        child: Text(text, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _processTransaction() {
    // Show Loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(color: Color(0xFF1D6A4A))),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close loading
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Transaction Successful!"), 
          backgroundColor: Color(0xFF1D6A4A),
        ),
      );
      Navigator.pop(context); // Go back to Home
    });
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 16)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}
