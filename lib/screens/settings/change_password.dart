import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B0000),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.amber),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Edit: Password',
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 30,
                    color: Color(0xFFE1A948),
                  ),
                ),
                const SizedBox(height: 30),
                Image.asset('assets/images/logo.png', height: 130),
                const SizedBox(height: 30),
                _buildTextField('Enter Old Password'),
                _buildTextField('Enter New Password'),
                _buildTextField('Re-Enter New Password'),
                const SizedBox(height: 24),
                _buildButton('NEXT', () {
                  Navigator.pushNamed(context, '/password_changed');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE1A948),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
