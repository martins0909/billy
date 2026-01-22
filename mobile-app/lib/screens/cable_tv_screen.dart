import 'package:flutter/material.dart';

class CableTvScreen extends StatefulWidget {
  const CableTvScreen({super.key});

  @override
  State<CableTvScreen> createState() => _CableTvScreenState();
}

class _CableTvScreenState extends State<CableTvScreen> {
  final TextEditingController _smartCardController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  
  String? _selectedProvider;
  String? _selectedPackage;
  String? _verifiedName;
  bool _isVerifying = false;

  final List<Map<String, dynamic>> _providers = [
    {'name': 'DSTV', 'color': Colors.blue},
    {'name': 'GOTV', 'color': Colors.green},
    {'name': 'Startimes', 'color': Colors.orange},
    {'name': 'Showmax', 'color': Colors.pink},
  ];

  final Map<String, List<Map<String, dynamic>>> _packages = {
    'DSTV': [
      {'name': 'DSTV Premium', 'price': 29500},
      {'name': 'DSTV Compact Plus', 'price': 19800},
      {'name': 'DSTV Compact', 'price': 12500},
      {'name': 'DSTV Confam', 'price': 7400},
      {'name': 'DSTV Yanga', 'price': 4200},
      {'name': 'DSTV Padi', 'price': 2500},
    ],
    'GOTV': [
      {'name': 'GOTV Supa', 'price': 7600},
      {'name': 'GOTV Max', 'price': 5700},
      {'name': 'GOTV Jolli', 'price': 3950},
      {'name': 'GOTV Jinja', 'price': 2700},
      {'name': 'GOTV Smallie', 'price': 1300},
    ],
    'Startimes': [
      {'name': 'Classic', 'price': 3800},
      {'name': 'Basic', 'price': 2600},
      {'name': 'Smart', 'price': 3500},
      {'name': 'Nova', 'price': 1500},
    ],
    'Showmax': [
      {'name': 'Showmax Pro', 'price': 3200},
      {'name': 'Showmax Mobile', 'price': 1200},
    ],
  };

  @override
  void dispose() {
    _smartCardController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _verifySmartCard() {
    if (_smartCardController.text.length < 10) return;
    
    setState(() {
      _isVerifying = true;
      _verifiedName = null;
    });

    // Simulate verification delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isVerifying = false;
          _verifiedName = "JANE DOE - ${_selectedProvider ?? 'UNKNOWN'}";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("Cable TV Subscription", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
            // Provider Selection
            const Text(
              "Select Provider",
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
                  hint: const Text("Select Cable Provider"),
                  value: _selectedProvider,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
                  items: _providers.map((provider) {
                    return DropdownMenuItem<String>(
                      value: provider['name'],
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: provider['color'].withOpacity(0.2),
                            radius: 14,
                            child: Text(
                              provider['name'].substring(0, 1),
                              style: TextStyle(color: provider['color'], fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            provider['name'],
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedProvider = val;
                      _selectedPackage = null;
                      _amountController.clear();
                      _verifiedName = null;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Package Selection
            const Text(
              "Select Package",
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
                  hint: const Text("Select Package"),
                  value: _selectedPackage,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
                  items: _selectedProvider == null 
                    ? [] 
                    : _packages[_selectedProvider]!.map((pkg) {
                        return DropdownMenuItem<String>(
                          value: pkg['name'],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(pkg['name'], style: const TextStyle(color: Colors.black87)),
                              Text("₦${pkg['price']}", style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1D6A4A))),
                            ],
                          ),
                        );
                      }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedPackage = val;
                      final pkg = _packages[_selectedProvider]!.firstWhere((element) => element['name'] == val);
                      _amountController.text = pkg['price'].toString();
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Smart Card Number
            const Text("Smart Card / IUC Number", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
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
                    controller: _smartCardController,
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                       setState(() => _verifiedName = null);
                    },
                    decoration: InputDecoration(
                      hintText: "Enter IUC / Smart Card Number",
                      prefixIcon: const Icon(Icons.credit_card, color: Colors.grey),
                      suffixIcon: TextButton(
                        onPressed: _selectedProvider == null ? null : _verifySmartCard,
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

            // Amount (Read Only)
            const Text("Amount", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: _amountController,
                readOnly: true,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                decoration: const InputDecoration(
                  hintText: "0.00",
                  prefixIcon: Icon(Icons.attach_money, color: Colors.grey),
                  prefixText: "₦ ",
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
                   if (_selectedProvider == null || _selectedPackage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Select Provider and Package")));
                      return;
                   }
                   if (_smartCardController.text.length < 5) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter a valid Smart Card Number")));
                      return;
                   }

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
            _buildDetailRow("Service", "Cable TV"),
            _buildDetailRow("Provider", _selectedProvider!),
            _buildDetailRow("Package", _selectedPackage!),
            _buildDetailRow("IUC/Smart Card Number", _smartCardController.text),
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
      
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF1D6A4A), size: 60),
              const SizedBox(height: 20),
              const Text("Successful!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text("Your Cable TV subscription has been renewed.", textAlign: TextAlign.center),
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
