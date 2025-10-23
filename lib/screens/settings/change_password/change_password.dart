import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController reenterPasswordController = TextEditingController();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    reenterPasswordController.dispose();
    super.dispose();
  }

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
                        icon: const Icon(Icons.arrow_back, color: Color(0xFFE1A948)),
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

                // Password fields
                _buildTextField('Enter Old Password', oldPasswordController),
                _buildTextField('Enter New Password', newPasswordController),
                _buildTextField('Re-Enter New Password', reenterPasswordController),

                const SizedBox(height: 24),

                // Next button with validation
                _buildButton('NEXT', () {
                  final oldPassword = oldPasswordController.text.trim();
                  final newPassword = newPasswordController.text.trim();
                  final reentered = reenterPasswordController.text.trim();

                  if (oldPassword != 'masterofpuppets') {
                    _showError('Old password is incorrect.');
                    return;
                  }

                  if (newPassword != reentered) {
                    _showError('New passwords do not match.');
                    return;
                  }

                  if (newPassword.isEmpty || reentered.isEmpty) {
                    _showError('New password cannot be empty.');
                    return;
                  }

                  Navigator.pushNamed(context, '/password_changed');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        controller: controller,
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

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}