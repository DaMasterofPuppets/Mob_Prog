import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  // password visibility flags
  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureReenter = true;

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

      await supabase.auth.signInWithOtp(email: user.email!);

      setState(() => _loading = false);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ChangePasswordOtpDialog(
          email: user.email!,
          newPassword: newPassword,
          onSuccess: () {
            // Intentionally left empty to avoid automatic navigation to /password_changed.
            // The confirmation dialog already instructs the user to go back to menu.
          },
        ),
      );
    } on AuthException catch (e) {
      setState(() => _loading = false);
      _showError(e.message);
    } catch (e) {
      setState(() => _loading = false);
      _showError('Something went wrong. Please try again.');
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
                      'Edit Password',
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: 30,
                        color: Color(0xFFE1A948),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Image.asset('assets/images/logo.png', height: 130),
                    const SizedBox(height: 30),
                    _buildTextField(
                      'Enter Old Password',
                      oldPasswordController,
                      obscure: _obscureOld,
                      toggleObscure: () => setState(() => _obscureOld = !_obscureOld),
                    ),
                    _buildTextField(
                      'Enter New Password',
                      newPasswordController,
                      obscure: _obscureNew,
                      toggleObscure: () => setState(() => _obscureNew = !_obscureNew),
                    ),
                    _buildTextField(
                      'Re-Enter New Password',
                      reenterPasswordController,
                      obscure: _obscureReenter,
                      toggleObscure: () => setState(() => _obscureReenter = !_obscureReenter),
                    ),
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

  /// Updated: accepts obscure flag and toggle callback for eye icon
  Widget _buildTextField(
    String hint,
    TextEditingController controller, {
    required bool obscure,
    required VoidCallback toggleObscure,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: IconButton(
            onPressed: toggleObscure,
            icon: Icon(
              obscure ? Icons.visibility_off : Icons.visibility,
              // match icon color to UI; dark enough on white background
              color: Colors.black54,
            ),
          ),
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

class ChangePasswordOtpDialog extends StatefulWidget {
  final String email;
  final String newPassword;
  final VoidCallback onSuccess;
  const ChangePasswordOtpDialog({
    required this.email,
    required this.newPassword,
    required this.onSuccess,
    super.key,
  });

  @override
  State<ChangePasswordOtpDialog> createState() => _ChangePasswordOtpDialogState();
}

class _ChangePasswordOtpDialogState extends State<ChangePasswordOtpDialog> {
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? dialogError;
  int resendCooldown = 0;
  Timer? _cooldownTimer;

  @override
  void dispose() {
    _otpController.dispose();
    _cooldownTimer?.cancel();
    super.dispose();
  }

  String? _validateOtp(String? v) {
    if (v == null || v.isEmpty) return 'Please enter the code';
    if (v.length < 4) return 'Enter the full code';
    return null;
  }

  void _setDialogError(String? message) {
    setState(() => dialogError = message);
    if (message != null) {
      Future.delayed(const Duration(seconds: 7), () {
        if (mounted && dialogError == message) {
          setState(() => dialogError = null);
        }
      });
    }
  }

  void _startResendCooldown() {
    _cooldownTimer?.cancel();
    setState(() => resendCooldown = 60);
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() {
        resendCooldown--;
        if (resendCooldown <= 0) {
          _cooldownTimer?.cancel();
          resendCooldown = 0;
        }
      });
    });
  }

  Future<void> _resendCode() async {
    if (resendCooldown > 0) return;
    try {
      setState(() => isLoading = true);
      await Supabase.instance.client.auth.signInWithOtp(email: widget.email);
      setState(() => isLoading = false);
      _setDialogError('A new code has been sent to your email.');
      _startResendCooldown();
    } on AuthException catch (e) {
      setState(() => isLoading = false);
      _setDialogError(e.message);
    } catch (e) {
      setState(() => isLoading = false);
      _setDialogError('Failed to resend code. Try again.');
    }
  }

  Future<void> _verifyAndUpdate() async {
    final otp = _otpController.text.trim();
    if (!_formKey.currentState!.validate()) return;
    setState(() => isLoading = true);
    _setDialogError(null);
    try {
      await Supabase.instance.client.auth.verifyOTP(
        token: otp,
        type: OtpType.recovery,
        email: widget.email,
      );
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: widget.newPassword),
      );
      setState(() => isLoading = false);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            decoration: BoxDecoration(
              color: const Color(0xFF450003),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: const Color(0xFFE1A948), width: 3.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/logo.png', height: 64, fit: BoxFit.contain),
                const SizedBox(height: 12),
                const Text(
                  'Password Updated',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFE1A948),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlayfairDisplay',
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Your password has been updated successfully. Please sign in with your new credentials.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onSuccess();
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFFE1A948),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('BACK TO MENU', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } on AuthException catch (e) {
      setState(() => isLoading = false);
      _setDialogError(e.message);
    } catch (e, st) {
      setState(() => isLoading = false);
      _setDialogError('Failed to verify code or update password.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFF450003),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: const Color(0xFFE1A948), width: 3.0),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Image.asset('assets/images/logo.png', height: 64, fit: BoxFit.contain),
              const SizedBox(height: 12),
              const Text(
                'Enter Verification Code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFE1A948),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Enter the 6-digit code sent to your email to confirm password change.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 14),
              if (dialogError != null) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE1A948)),
                  ),
                  child: Text(
                    dialogError!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Color(0xFFE1A948), fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 6,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Verification code',
                  counterText: '',
                  contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
                validator: _validateOtp,
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (resendCooldown == 0 && !isLoading) ? _resendCode : null,
                    child: resendCooldown == 0
                        ? const Text('Resend code', style: TextStyle(color: Color(0xFFE1A948)))
                        : Text('Resend in ${resendCooldown}s', style: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : OutlinedButton(
                        onPressed: _verifyAndUpdate,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFFE1A948),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          side: const BorderSide(color: Color(0xFFE1A948)),
                        ),
                        child: const Text('CONFIRM', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('CANCEL', style: TextStyle(color: Colors.white)),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
