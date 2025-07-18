import 'package:flutter/material.dart';
import 'package:tarot_app/screens/login/fp_resetpass.dart';

class ForgotPassVerify extends StatefulWidget {
  const ForgotPassVerify({super.key});

  @override
  State<ForgotPassVerify> createState() => _ForgotPassVerifyState();
}

class _ForgotPassVerifyState extends State<ForgotPassVerify> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  void _onConfirm() {
    String code = _controllers.map((c) => c.text).join();
    if (code.length < 4 || code.contains(RegExp(r'[^0-9]'))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 4-digit code.'),
          backgroundColor: Color(0xFFE1A948),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ForgotPassReset()), // this is the redirect route
      );
    }
  }

  Widget _buildCodeBox(int index) {
    return SizedBox(
      width: 60,
      child: TextField(
        controller: _controllers[index],
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF450003),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFFE1A948)),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: const CircleBorder(),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  'Account\nRecovery',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFFC76A),
                    fontSize: 38,
                    fontFamily: 'PlayfairDisplay',
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Center(
                child: Column(
                  children: [
                    Text(
                      'SUCCESS!',
                      style: TextStyle(
                        color: Color(0xFFFFD700),
                        fontSize: 36,
                        fontFamily: 'PlayfairDisplay',
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Enter the 4-digit code to reset\naccount password.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFFFC76A),
                        fontFamily: 'PlayfairDisplay',
                        fontSize: 16,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, _buildCodeBox),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC76A),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'CONFIRM',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
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