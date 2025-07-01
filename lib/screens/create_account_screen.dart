import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool tosAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF470000),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFFE1A948)),
                  onPressed: () => Navigator.pop(context),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12), // Same padding as LoginPage
                    fixedSize: const Size(48, 48),     // Ensures same size circle
                  ),
                ),
              ),
            ),

            const SizedBox(height: 90),
            Center(
              child: Column(
                children: const [
                  Text(
                    'Create',
                    style: TextStyle(
                      fontSize: 48,
                      color: Color(0xFFFFD700),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Account',
                    style: TextStyle(
                      fontSize: 48,
                      color: Color(0xFFFFD700),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Text Fields with reduced width
            _buildInputField('Username'),
            _buildInputField('Email'),
            _buildInputField('Password', obscureText: true),
            _buildInputField('Reconfirm Password', obscureText: true),

            const SizedBox(height: 15),

            // Interactive TOS Checkbox
            Padding(
              padding: const EdgeInsets.only(left: 50.0), // shift everything right
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: tosAgreed,
                    onChanged: (value) {
                      setState(() {
                        tosAgreed = value ?? false;
                      });
                    },
                    checkColor: Colors.black,
                    activeColor: Colors.amber,
                  ),
                  const Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'By making an account you acknowledge \nour ',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                        children: [
                          TextSpan(
                            text: 'Terms and Services',
                            style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Register Button
            Center(
              child: SizedBox(
                width: 200, // 👈 Adjust this value to control button width
                child: ElevatedButton(
                  onPressed: tosAgreed
                      ? () => Navigator.pushNamed(context, '/confirm')
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC860),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 15), // removed horizontal padding
                  ),
                  child: const Text(
                    'REGISTER',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget builder for centered text fields with consistent width
  Widget _buildInputField(String hint, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Center(
        child: SizedBox(
          width: 320,
          child: TextField(
            obscureText: obscureText,
            decoration: _inputDecoration(hint),
          ),
        ),
      ),
    );
  }

  // Input decoration helper
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
