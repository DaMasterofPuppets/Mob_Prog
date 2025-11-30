import 'package:flutter/material.dart';
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

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  Future<void> _onConfirm() async {
    final email = _emailController.text.trim();
    final validationMessage = validateEmail(email);

    if (validationMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(validationMessage),
          backgroundColor: const Color(0xFFE1A948),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await Supabase.instance.client.auth.resetPasswordForEmail(
        email,
        redirectTo: 'https://your-app-url.com/reset-password',
      );

      setState(() => isLoading = false);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => EmailConfirmationDialog(
          onBackToMenu: () {
            Navigator.of(context).pop();
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      );
    } on AuthException catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF450003),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
          child: Form(
            key: _formKey,
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
                      color: Color(0xFFE1A948),
                      fontSize: 38,
                      fontFamily: 'PlayfairDisplay',
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 45),
                const Center(
                  child: Text(
                    'Enter email linked to that account\nto receive a verification code',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFE1A948),
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter your email',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : ElevatedButton(
                          onPressed: _onConfirm,
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
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmailConfirmationDialog extends StatelessWidget {
  final VoidCallback onBackToMenu;
  const EmailConfirmationDialog({required this.onBackToMenu, super.key});

  static const Color brown = Color(0xFF6B3E26);
  static const Color accent = Color(0xFFE1A948);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        decoration: BoxDecoration(
          color: Color(0xFF450003),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: accent, width: 3.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Image.asset(
              'assets/images/logo.png',
              height: 64,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 12),

            const Text(
              'Email Confirmation Sent',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFE1A948),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'PlayfairDisplay',
              ),
            ),

            const SizedBox(height: 12),

            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.4,
                ),
                children: [
                  const TextSpan(
                    text: 'Please check your email for instructions on how to change your ',
                  ),
                  const TextSpan(
                    text: 'password',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onBackToMenu,
                style: OutlinedButton.styleFrom(
                  backgroundColor: accent,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(color: accent),
                ),
                child: const Text(
                  'BACK TO MENU',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
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
