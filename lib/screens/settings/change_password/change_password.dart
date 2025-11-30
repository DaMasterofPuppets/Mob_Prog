import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController reenterPasswordController = TextEditingController();

  bool _loading = false;

  SupabaseClient get supabase => Supabase.instance.client;

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    reenterPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleChangePassword() async {
    final oldPassword = oldPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final reentered = reenterPasswordController.text.trim();

    if (newPassword.isEmpty || reentered.isEmpty || oldPassword.isEmpty) {
      _showError('All fields are required.');
      return;
    }
    if (newPassword != reentered) {
      _showError('New passwords do not match.');
      return;
    }
    if (newPassword.length < 6) {
      _showError('New password must be at least 6 characters.');
      return;
    }

    final user = supabase.auth.currentUser;
    if (user == null || user.email == null) {
      _showError('Not signed in. Please log in again.');
      if (mounted) Navigator.pushReplacementNamed(context, '/login');
      return;
    }

    setState(() => _loading = true);

    try {
      await supabase.auth.signInWithPassword(
        email: user.email!,
        password: oldPassword,
      );

      await supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );

      if (!mounted) return;

      Navigator.pushNamed(context, '/password_changed');
    } on AuthException catch (e) {
      _showError(e.message);
    } catch (e) {
      _showError('Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF420309),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Color(0xFFE1A948)),
                      onPressed: () => Navigator.pop(context),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: const CircleBorder(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Edit: Password',
                    style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: 30,
                      color: Color(0xFFFFD700),
                    ),
                  ),

                  const SizedBox(height: 30),
                  Image.asset('assets/images/logo.png', height: 130),
                  const SizedBox(height: 30),

                  _buildTextField('Enter Old Password', oldPasswordController),
                  _buildTextField('Enter New Password', newPasswordController),
                  _buildTextField('Re-Enter New Password', reenterPasswordController),

                  const SizedBox(height: 24),

                  _buildButton(
                    _loading ? 'PROCESSING...' : 'NEXT',
                    _loading ? null : _handleChangePassword,
                  ),
                ],
              ),
            ),
          ),


            if (_loading)
              Container(
                color: Colors.black.withOpacity(0.25),
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
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
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback? onPressed) {
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
