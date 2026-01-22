import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SetPinScreen extends StatefulWidget {
  final VoidCallback? onCompleted;
  final bool isReset;

  const SetPinScreen({super.key, this.onCompleted, this.isReset = false});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _pin = "";
  String _confirmPin = "";
  bool _isConfirming = false;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    // Auto focus the hidden field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyPress(String value) {
    setState(() {
      _errorMessage = "";
      if (value.length <= 4) {
        _pinController.text = value;
        if (!_isConfirming) {
          _pin = value;
          if (_pin.length == 4) {
             _moveToConfirmation();
          }
        } else {
          _confirmPin = value;
          if (_confirmPin.length == 4) {
            _validateAndSave();
          }
        }
      }
    });
  }

  void _moveToConfirmation() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _isConfirming = true;
        _pinController.clear(); 
      });
    });
  }

  void _validateAndSave() {
    if (_pin == _confirmPin) {
      // Save PIN logic would go here (e.g., SecureStorage)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Transaction PIN set successfully!"),
          backgroundColor: Color(0xFF1D6A4A),
        ),
      );
      if (widget.onCompleted != null) {
        widget.onCompleted!();
      } else {
        Navigator.pop(context);
      }
    } else {
      setState(() {
        _errorMessage = "PINs do not match. Try again.";
        _isConfirming = false;
        _pin = "";
        _confirmPin = "";
        _pinController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D6A4A), // Dark Green background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Icon(Icons.lock_outline, size: 60, color: Colors.white),
            const SizedBox(height: 20),
            Text(
              _isConfirming ? "Confirm PIN" : "Set Transaction PIN",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _isConfirming 
                  ? "Re-enter your 4-digit PIN" 
                  : "Create a 4-digit PIN for transactions",
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            
            const SizedBox(height: 40),
            
            // PIN Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                String currentText = _isConfirming ? _confirmPin : _pin;
                bool isFilled = index < currentText.length;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isFilled ? Colors.white : Colors.white.withOpacity(0.3),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                );
              }),
            ),

            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Color(0xFFFF5252), fontWeight: FontWeight.bold),
                ),
              ),

            const Spacer(),

            // Hidden Text Field for Keyboard Input
            SizedBox(
              height: 0,
              width: 0,
              child: TextField(
                controller: _pinController,
                focusNode: _focusNode,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 4,
                onChanged: _handleKeyPress,
              ),
            ),

            // Custom Number Pad (Visual Only, taps redirect to text field)
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildNumberRow(["1", "2", "3"]),
                  _buildNumberRow(["4", "5", "6"]),
                  _buildNumberRow(["7", "8", "9"]),
                  _buildNumberRow([null, "0", "back"]),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberRow(List<String?> numbers) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: numbers.map((number) {
          if (number == null) return const SizedBox(width: 80, height: 80);
          
          if (number == "back") {
            return InkWell(
              onTap: () {
                String current = _isConfirming ? _confirmPin : _pin;
                if (current.isNotEmpty) {
                  _handleKeyPress(current.substring(0, current.length - 1));
                }
              },
              borderRadius: BorderRadius.circular(40),
              child: const SizedBox(
                width: 80, 
                height: 80,
                child: Icon(Icons.backspace_outlined, size: 28),
              ),
            );
          }

          return InkWell(
            onTap: () {
              String current = _isConfirming ? _confirmPin : _pin;
              if (current.length < 4) {
                _handleKeyPress(current + number);
              }
            },
            borderRadius: BorderRadius.circular(40),
            child: Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade100,
              ),
              child: Text(
                number,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
