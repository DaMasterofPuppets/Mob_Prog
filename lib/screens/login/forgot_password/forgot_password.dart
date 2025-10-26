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

void _onConfirm() async {
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
      redirectTo: 'https://your-app-url.com/reset-password', // change if needed
    );

    setState(() => isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password reset link sent! Check your email.'),
        backgroundColor: Color(0xFFE1A948),
      ),
    );

    // Optionally navigate to verify screen (if you want to simulate verification)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPassVerify()),
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
                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    'Enter email linked to that\naccount to receive a\nverification code',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFE1A948),
                      fontSize: 16,
                      fontFamily: 'PlayfairDisplay',
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