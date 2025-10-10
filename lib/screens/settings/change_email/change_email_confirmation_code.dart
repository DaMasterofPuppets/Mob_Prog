import 'package:flutter/material.dart';

class ChangeEmailConfirmationCodePage extends StatefulWidget {
  const ChangeEmailConfirmationCodePage({super.key});

  @override
  State<ChangeEmailConfirmationCodePage> createState() =>
      _ChangeEmailConfirmationCodePageState();
}

class _ChangeEmailConfirmationCodePageState
    extends State<ChangeEmailConfirmationCodePage> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleInputChange(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF420309),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.black,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Color(0xFFE1A948)),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  'We have sent a\nconfirmation code\nto your email!📧',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 42,
                    color: Color(0xFFE1A948),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Input the 4 digit number\nwe have sent to your email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontFamily: 'PlayfairDisplay',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) =>
                          _handleInputChange(value, index),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                onPressed: () {
                  String code = _controllers.map((c) => c.text).join();
                  bool isAllDigits = RegExp(r'^\d{4}$').hasMatch(code);

                  if (isAllDigits) {
                    Navigator.pushNamed(context, '/change_email_success');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a valid 4-digit numeric code.'),
                      ),
                    );
                  }
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE1A948),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'CONFIRM',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
