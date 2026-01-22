import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ElectricityScreen extends StatefulWidget {
  const ElectricityScreen({super.key});

  @override
  State<ElectricityScreen> createState() => _ElectricityScreenState();
}

class _ElectricityScreenState extends State<ElectricityScreen> {
  final TextEditingController _meterNumberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  
  String? _selectedDisco;
  String _meterType = "Prepaid";
  String? _verifiedName;
  bool _isVerifying = false;

  final List<String> _meterTypes = ["Prepaid", "Postpaid"];

  final List<Map<String, dynamic>> _discos = [
    {'name': 'Ikeja Electric', 'short': 'IKEDC', 'color': Colors.amber},
    {'name': 'Eko Electric', 'short': 'EKEDC', 'color': Colors.red},
    {'name': 'Abuja Electric', 'short': 'AEDC', 'color': Colors.green},
    {'name': 'Ibadan Electric', 'short': 'IBEDC', 'color': Colors.blue},
    {'name': 'Enugu Electric', 'short': 'EEDC', 'color': Colors.orange},
    {'name': 'Port Harcourt', 'short': 'PHED', 'color': Colors.purple},
    {'name': 'Benin Electric', 'short': 'BEDC', 'color': Colors.cyan},
  ];

  @override
  void dispose() {
    _meterNumberController.dispose();
    _amountController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _verifyMeter() {
    if (_meterNumberController.text.length < 10) return;
    
    setState(() {
      _isVerifying = true;
      _verifiedName = null;
    });

    // Simulate verification delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isVerifying = false;
          _verifiedName = "JOHN DOE - ${_selectedDisco ?? 'UNKNOWN'}";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("Electricity Bill", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
            // Disco Selection
            const Text(
              "Select Distribution Company",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text("Select Disco"),
                  value: _selectedDisco,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
                  items: _discos.map((disco) {
                    return DropdownMenuItem<String>(
                      value: disco['name'],
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: disco['color'].withOpacity(0.2),
                            radius: 14,
                            child: Text(
                              disco['short'].substring(0, 1),
                              style: TextStyle(color: disco['color'], fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: "${disco['name']} ",
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 14),
                                children: [
                                  TextSpan(
                                    text: "(${disco['short']})",
                                    style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 13),
                                  )
                                ]
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedDisco = val;
                      _verifiedName = null;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Meter Type
            const Text("Meter Type", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 8),
            Row(
              children: _meterTypes.map((type) {
                final isSelected = _meterType == type;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _meterType = type),
                    child: Container(
                      margin: EdgeInsets.only(right: type == _meterTypes.first ? 10 : 0),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF1D6A4A) : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: isSelected ? const Color(0xFF1D6A4A) : Colors.grey.shade300),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        type,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // Meter Number
            const Text("Meter Number", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                   TextField(
                    controller: _meterNumberController,
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      if (val.length >= 10 && _selectedDisco != null) {
                         // Auto verify simulation if we wanted, but let's stick to button or suffix
                      }
                      setState(() => _verifiedName = null);
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Meter Number",
                      prefixIcon: const Icon(Icons.confirmation_number_outlined, color: Colors.grey),
                      suffixIcon: TextButton(
                        onPressed: _selectedDisco == null ? null : _verifyMeter,
                        child: _isVerifying 
                          ? const SizedBox(width: 15, height: 15, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Text("Verify", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                  ),
                  if (_verifiedName != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                      ),
                      child: Text(
                        _verifiedName!,
                        style: const TextStyle(color: Color(0xFF1D6A4A), fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Amount
            const Text("Amount", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "0.00",
                  prefixIcon: Icon(Icons.attach_money, color: Colors.grey), // Using generic money icon, can swap for Naira symbol if available
                  prefixText: "₦ ",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
            ),

            const SizedBox(height: 24),

             // Phone Number
            const Text("Phone Number", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "For token delivery",
                  prefixIcon: Icon(Icons.phone_android, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                   if (_selectedDisco == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Select a Distribution Company")));
                      return;
                   }
                   if (_meterNumberController.text.length < 5) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter a valid Meter Number")));
                      return;
                   }
                   if (_amountController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter Amount")));
                      return;
                   }

                   // If name not verified, maybe verify first? For now proceed.
                   _showConfirmationSheet();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D6A4A),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
                child: const Text(
                  "Proceed",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationSheet() {
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
              "Confirm Payment",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildDetailRow("Service", "Electricity"),
            _buildDetailRow("Disco", _selectedDisco!),
            _buildDetailRow("Meter Type", _meterType),
            _buildDetailRow("Meter No.", _meterNumberController.text),
            _buildDetailRow("Amount", "₦${_amountController.text}"),
            
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close sheet
                  _showPinDialog(); // Trigger PIN flow
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D6A4A),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Confirm & Pay", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            )
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
                                     Future.delayed(const Duration(milliseconds: 300), () {
                                      Navigator.pop(context); 
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
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(color: Color(0xFF1D6A4A))),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close loading
      
      // Success Dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.flash_on, color: Color(0xFF1D6A4A), size: 60),
              const SizedBox(height: 20),
              const Text("Successful!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text("Your payment has been processed. Token will be sent to your phone.", textAlign: TextAlign.center),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.pop(context); // Go back
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D6A4A),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Done", style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      );
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
