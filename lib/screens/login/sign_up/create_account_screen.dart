import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool _tosAgreed = false;
  bool _privacyAgreed = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF470000),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Image.asset('assets/images/logo.png', height: 190),
                        const SizedBox(height: 10),
                        const Column(
                          children: [
                            Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 43,
                                color: Color(0xFFE1A948),
                                fontFamily: 'PlayfairDisplay',
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        _buildInputField('Email', controller: _emailController),
                        _buildInputField(
                          'Password',
                          controller: _passwordController,
                          obscureText: true,
                          isPassword: true,
                          isVisible: _isPasswordVisible,
                          onToggleVisibility: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        _buildInputField(
                          'Confirm Password',
                          controller: _confirmPasswordController,
                          obscureText: true,
                          isPassword: true,
                          isVisible: _isConfirmPasswordVisible,
                          onToggleVisibility: () {
                            setState(() {
                              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        _buildAgreementRow(
                          value: _tosAgreed,
                          onChanged: (value) {
                            setState(() {
                              _tosAgreed = value ?? false;
                            });
                          },
                          text: 'I agree to the ',
                          linkText: 'Terms of Service',
                          onLinkTap: () => _showTermsDialog(context),
                        ),
                        const SizedBox(height: 10),
                        _buildAgreementRow(
                          value: _privacyAgreed,
                          onChanged: (value) {
                            setState(() {
                              _privacyAgreed = value ?? false;
                            });
                          },
                          text: 'I agree to the ',
                          linkText: 'Privacy Policy',
                          onLinkTap: () => _showPrivacyDialog(context),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: (_tosAgreed && _privacyAgreed && !_isLoading)
                                ? _registerUser
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE1A948),
                              disabledBackgroundColor: const Color(0xFFE1A948).withAlpha(128),
                              shape: const StadiumBorder(),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              elevation: 4,
                            ),
                            child: const Text(
                              'REGISTER',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE1A948)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAgreementRow({
    required bool value,
    required ValueChanged<bool?> onChanged,
    required String text,
    required String linkText,
    required VoidCallback onLinkTap,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              checkColor: Colors.black,
              activeColor: const Color(0xFFE1A948),
              side: const BorderSide(color: Colors.white, width: 2),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: onLinkTap,
            child: RichText(
              text: TextSpan(
                text: text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
                children: [
                  TextSpan(
                    text: linkText,
                    style: const TextStyle(
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
      ],
    );
  }

  Widget _buildInputField(
    String hint, {
    bool obscureText = false,
    TextEditingController? controller,
    bool isPassword = false,
    bool isVisible = false,
    VoidCallback? onToggleVisibility,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        obscureText: obscureText && !isVisible,
        style: const TextStyle(fontSize: 15),
        decoration: _inputDecoration(
          hint,
          isPassword: isPassword,
          isVisible: isVisible,
          onToggleVisibility: onToggleVisibility,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
    String hint, {
    bool isPassword = false,
    bool isVisible = false,
    VoidCallback? onToggleVisibility,
  }) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                isVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: onToggleVisibility,
            )
          : null,
    );
  }

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF470000),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text(
            'Terms of Service',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFE1A948),
              fontFamily: 'PlayfairDisplay',
              fontSize: 20,
            ),
          ),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Last Updated: November 2024\n',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12, fontFamily: 'PlayfairDisplay', color: Colors.white70),
                ),
                Text(
                  '1. Acceptance of Terms\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay', color: Color(0xFFE1A948)),
                ),
                Text(
                  'By creating an account and using our application, you agree to be bound by these Terms of Service. If you do not agree to these terms, please do not use our service.\n',
                  style: TextStyle(fontSize: 14, fontFamily: 'PlayfairDisplay', color: Colors.white),
                ),
                Text(
                  '2. User Accounts\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay', color: Color(0xFFE1A948)),
                ),
                Text(
                  'You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. You must provide accurate and complete information when creating your account.\n',
                  style: TextStyle(fontSize: 14, fontFamily: 'PlayfairDisplay', color: Colors.white),
                ),
                Text(
                  '3. Acceptable Use\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay', color: Color(0xFFE1A948)),
                ),
                Text(
                  'You agree not to:\n'
                  '• Use the service for any illegal purposes\n'
                  '• Harass, abuse, or harm other users\n'
                  '• Spam or distribute malware\n'
                  '• Attempt to gain unauthorized access to our systems\n'
                  '• Impersonate others or misrepresent your affiliation\n',
                  style: TextStyle(fontSize: 14, fontFamily: 'PlayfairDisplay', color: Colors.white),
                ),
                Text(
                  '4. Account Termination\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay', color: Color(0xFFE1A948)),
                ),
                Text(
                  'We reserve the right to suspend or terminate your account at any time for violations of these terms, including but not limited to spamming, hacking, or other misuse of the service.\n',
                  style: TextStyle(fontSize: 14, fontFamily: 'PlayfairDisplay', color: Colors.white),
                ),
                Text(
                  '5. Modifications\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay', color: Color(0xFFE1A948)),
                ),
                Text(
                  'We reserve the right to modify these terms at any time. Continued use of the service after changes constitutes acceptance of the modified terms.\n',
                  style: TextStyle(fontSize: 14, fontFamily: 'PlayfairDisplay', color: Colors.white),
                ),
                Text(
                  '6. Disclaimer\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay', color: Color(0xFFE1A948)),
                ),
                Text(
                  'The service is provided "as is" without warranties of any kind. We do not guarantee uninterrupted or error-free service.\n',
                  style: TextStyle(fontSize: 14, fontFamily: 'PlayfairDisplay', color: Colors.white),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Color(0xFFE1A948),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF470000),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text(
            'Privacy Policy',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFE1A948),
              fontFamily: 'PlayfairDisplay',
              fontSize: 20,
            ),
          ),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Last Updated: November 2024\n',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12, fontFamily: 'PlayfairDisplay', color: Colors.white70),
                ),
                Text(
                  '1. Information We Collect\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay', color: Color(0xFFE1A948)),
                ),
                Text(
                  'We collect information you provide directly to us, including:\n'
                  '• Email address\n'
                  '• Account credentials\n'
                  '• Usage data and preferences\n',
                  style: TextStyle(fontSize: 14, fontFamily: 'PlayfairDisplay', color: Colors.white),
                ),
                Text(
                  '2. How We Use Your Information\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay', color: Color(0xFFE1A948)),
                ),
                Text(
                  'We use the information we collect to:\n'
                  '• Provide and maintain our services\n'
                  '• Send you technical notices and updates\n'
                  '• Respond to your comments and questions\n'
                  '• Improve our application and user experience\n',
                  style: TextStyle(fontSize: 14, fontFamily: 'PlayfairDisplay', color: Colors.white),
                ),
                Text(
                  '3. Information Sharing\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay', color: Color(0xFFE1A948)),
                ),
                Text(
                  'We do not sell, trade, or rent your personal information to third parties. We may share your information only:\n'
                  '• With your consent\n'
                  '• To comply with legal obligations\n'
                  '• To protect our rights and safety\n',
                  style: TextStyle(fontSize: 14, fontFamily: 'PlayfairDisplay', color: Colors.white),
                ),
                Text(
                  '4. Data Security\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay', color: Color(0xFFE1A948)),
                ),
                Text(
                  'We implement appropriate security measures to protect your personal information. However, no method of transmission over the internet is 100% secure.\n',
                  style: TextStyle(fontSize: 14, fontFamily: 'PlayfairDisplay', color: Colors.white),
                ),
                Text(
                  '5. Your Rights\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay', color: Color(0xFFE1A948)),
                ),
                Text(
                  'You have the right to:\n'
                  '• Access your personal data\n'
                  '• Request correction of your data\n'
                  '• Request deletion of your account\n'
                  '• Opt-out of marketing communications\n',
                  style: TextStyle(fontSize: 14, fontFamily: 'PlayfairDisplay', color: Colors.white),
                ),
                Text(
                  '6. Changes to This Policy\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay', color: Color(0xFFE1A948)),
                ),
                Text(
                  'We may update this privacy policy from time to time. We will notify you of any changes by posting the new policy on this page.\n',
                  style: TextStyle(fontSize: 14, fontFamily: 'PlayfairDisplay', color: Colors.white),
                ),
                Text(
                  '7. Contact Us\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'PlayfairDisplay', color: Color(0xFFE1A948)),
                ),
                Text(
                  'If you have questions about this privacy policy, please contact us through the app support section.\n',
                  style: TextStyle(fontSize: 14, fontFamily: 'PlayfairDisplay', color: Colors.white),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Close',
                style: TextStyle(
                  color: Color(0xFFE1A948),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _registerUser() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showDialog('Error', 'Please fill in all fields.');
      return;
    }

    if (!_isValidEmail(email)) {
      _showDialog('Error', 'Please enter a valid email address.');
      return;
    }

    if (password.length < 6) {
      _showDialog('Error', 'Password must be at least 6 characters long.');
      return;
    }

    if (password != confirmPassword) {
      _showDialog('Error', 'Passwords do not match.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final supabase = Supabase.instance.client;

      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      setState(() {
        _isLoading = false;
      });

      if (response.user != null) {
        if (mounted) {
          _showDialog(
            'Success',
            'Account created successfully! Please check your email to confirm your account.',
            onOk: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          );
        }
      } else {
        if (mounted) {
          _showDialog('Error', 'Signup failed. Please try again.');
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        _showDialog('Error', 'An error occurred: ${e.toString()}');
      }
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _showDialog(String title, String message, {VoidCallback? onOk}) {
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
          style: const TextStyle(fontFamily: 'PlayfairDisplay', color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (onOk != null) onOk();
            },
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
}