import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool tosAgreed = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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

            // Title
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

            // Input fields
            _buildInputField('Username', controller: _usernameController),
            _buildInputField('Email', controller: _emailController),
            _buildInputField('Password', controller: _passwordController, obscureText: true),
            _buildInputField('Reconfirm Password', controller: _confirmPasswordController, obscureText: true),

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
                              title: const Text('Terms and Services'),
                              content: const SingleChildScrollView(
                                child: Text(
                                  'By creating an account, you agree to abide by all guidelines set forth by the application. '
                                  'Any violations may cause account termination. Misuse such as spamming or hacking may result in suspension. '
                                  'We reserve the right to modify these terms at any time.',
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
                  onPressed: tosAgreed ? _registerUser : null,
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

  // Input field widget
  Widget _buildInputField(String hint,
      {bool obscureText = false, TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Center(
        child: SizedBox(
          width: 320,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: _inputDecoration(hint),
          ),
        ),
      ),
    );
  }

//Input decoration
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

//Register
  void _registerUser() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showDialog('Please fill in all fields.');
      return;
    }

    if (password != confirmPassword) {
      _showDialog('Passwords do not match.');
      return;
    }

    try {
      final supabase = Supabase.instance.client;
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'username': username}, //for username (wala pa)
      );

      if (response.user != null) {
        _showDialog('Account created successfully! Please check your email to confirm.', onOk: () {
          Navigator.pushReplacementNamed(context, '/login');
        });
      } else {
        _showDialog('Signup failed. Try again.');
      }
    } catch (e) {
      _showDialog('Error: ${e.toString()}');
    }
  }

//for dialog
  void _showDialog(String message, {VoidCallback? onOk}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Up'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (onOk != null) onOk();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
