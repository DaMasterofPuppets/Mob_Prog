import 'package:flutter/material.dart';
import 'package:tarot_app/screens/login/forgot_password/fp_verify.dart';

//supabase time
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final List<String> allowedDomains = [
    'gmail.com',
    'yahoo.com',
    'outlook.com',
    'hotmail.com',
    'icloud.com',
    'protonmail.com',
  ];

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    final domain = value.split('@').last.toLowerCase();
    if (!allowedDomains.contains(domain)) {
      return 'Unsupported email domain';
    }

    return null;
  }

  void _showDialog(String title, String message, {bool isError = false}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF470000),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'PlayfairDisplay',
            fontSize: 20,
            color: Color(0xFFE1A948),
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontFamily: 'PlayfairDisplay',
            color: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(
                color: Color(0xFFE1A948),
                fontWeight: FontWeight.bold,
                fontFamily: 'PlayfairDisplay',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onConfirm() async {
    final email = _emailController.text.trim();
    final validationMessage = validateEmail(email);

    if (validationMessage != null) {
      _showDialog('Invalid Email', validationMessage, isError: true);
      return;
    }

    setState(() => isLoading = true);

    try {
      await Supabase.instance.client.auth.resetPasswordForEmail(
        email,
        redirectTo: 'https://your-app-url.com/reset-password', // change if needed
      );

      setState(() => isLoading = false);

      if (mounted) {
        _showDialog(
          'Success',
          'Password reset link sent! Check your email.',
        );

        // Optionally navigate to verify screen
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ForgotPassVerify()),
            );
          }
        });
      }
    } on AuthException catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        _showDialog('Error', e.message, isError: true);
      }
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        _showDialog(
          'Error',
          'Something went wrong. Please try again.',
          isError: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF470000),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.topLeft,
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
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Image.asset('assets/images/logo.png', height: 150),
                      const SizedBox(height: 10),
                      const Text(
                        'Account\nRecovery',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFE1A948),
                          fontSize: 42,
                          fontFamily: 'PlayfairDisplay',
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Enter email linked to your account\nto receive a verification code',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'PlayfairDisplay',
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter your email',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 16.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      isLoading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE1A948)),
                            )
                          : ElevatedButton(
                              onPressed: _onConfirm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE1A948),
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 4,
                              ),
                              child: const Text(
                                'CONFIRM',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}