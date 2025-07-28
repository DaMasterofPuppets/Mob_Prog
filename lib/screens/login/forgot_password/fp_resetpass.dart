import 'package:flutter/material.dart';
import 'package:tarot_app/screens/login/load_screen.dart';

class ForgotPassReset extends StatefulWidget {
  const ForgotPassReset({super.key});

  @override
  State<ForgotPassReset> createState() => _ForgotPassResetState();
}

class _ForgotPassResetState extends State<ForgotPassReset> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  final Color bgColor = const Color(0xFF420309);
  final Color accentColor = const Color(0xFFFFC857);
  final Color highlightColor = const Color(0xFFE1A948);

  void _showCustomSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: highlightColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _validatePasswords() {
    String password = _passwordController.text.trim();
    String confirm = _confirmController.text.trim();

    if (password.isEmpty || confirm.isEmpty) {
      _showCustomSnackBar('Please fill out both fields');
      return;
    }

    if (password != confirm) {
      _showCustomSnackBar('Passwords do not match');
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoadScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back, color: highlightColor),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const CircleBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Centered Title
              Center(
                child: Column(
                  children: const [
                    Text(
                      'Account',
                      style: TextStyle(
                        fontSize: 38,
                        fontFamily: 'PlayfairDisplay',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFC857),
                      ),
                    ),
                    Text(
                      'Recovery',
                      style: TextStyle(
                        fontSize: 38,
                        fontFamily: 'PlayfairDisplay',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFC857),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Subtitle
              const Center(
                child: Text(
                  'Enter New Password',
                  style: TextStyle(
                    color: Color(0xFFFFC857),
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Password Field
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 15),

              // Confirm Password Field
              TextField(
                controller: _confirmController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Reconfirm Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 40),

              // Confirm Button
              Center(
                child: ElevatedButton(
                  onPressed: _validatePasswords,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
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
