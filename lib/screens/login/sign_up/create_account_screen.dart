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
                    padding: const EdgeInsets.all(12),
                    fixedSize: const Size(48, 48),
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
                      color: Color(0xFFE1A948),
                      fontFamily: 'PlayfairDisplay',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Account',
                    style: TextStyle(
                      fontSize: 48,
                      color: Color(0xFFE1A948),
                      fontFamily: 'PlayfairDisplay',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            _buildInputField('Username'),
            _buildInputField('Email'),
            _buildInputField('Password', obscureText: true),
            _buildInputField('Reconfirm Password', obscureText: true),

            const SizedBox(height: 15),

            // TOS Checkbox + Text
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Checkbox(
                    value: tosAgreed,
                    onChanged: (value) {
                      setState(() {
                        tosAgreed = value ?? false;
                      });
                    },
                    checkColor: Colors.black,
                    activeColor: const Color(0xFFE1A948),
                  ),
                ),
Expanded(
  child: Padding(
    padding: const EdgeInsets.only(top: 5),
    child: GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              //TERMS AND SERVICE
              title: const Text('Terms and Services'),
              content: const SingleChildScrollView(
                child: Text(
                  'By creating an account, you agree to abide by all guidelines set forth by the application. Any violations may cause to account termination and a police report.'
                  'By agreeing, you acknowledge that any misuse of the app, such as sharing disinformation, spamming, or hacking, may result in account suspension or termination. '
                  'Your data will be stolen by us. We have the right to modify these terms at any time.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Agree',
                    style: TextStyle(color: Color(0xFFE1A948)),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: RichText(
        text: const TextSpan(
          text: 'By making an account you acknowledge \nour ',
          style: TextStyle(color: Colors.white, fontSize: 12),
          children: [
            TextSpan(
              text: 'Terms and Services',
              style: TextStyle(
                color: Color(0xFFE1A948),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
),

              ],
            ),

            const SizedBox(height: 10),

            // Register Button
            Center(
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: tosAgreed
                      ? () => Navigator.pushNamed(context, '/confirm')
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE1A948),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 15),
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

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
