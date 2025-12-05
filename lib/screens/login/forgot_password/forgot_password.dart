import 'dart:async';
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
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email address';
    return null;
  }

  Future<void> _onConfirm() async {
    final email = _emailController.text.trim();
    final validationMessage = validateEmail(email);

    if (validationMessage != null) {
      _showErrorDialog(validationMessage);
      return;
    }

    setState(() => isLoading = true);

    try {
      await Supabase.instance.client.auth.signInWithOtp(email: email);
      setState(() => isLoading = false);

      _showOtpDialog(email);
    } on AuthException catch (e) {
      setState(() => isLoading = false);
      _showErrorDialog(e.message);
    } catch (e) {
      setState(() => isLoading = false);
      _showErrorDialog('Something went wrong. Please try again.');
    }
  }

  void _showErrorDialog(String message) {
    const Color accent = Color(0xFFE1A948);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          decoration: BoxDecoration(
            color: const Color(0xFF450003),
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
              Image.asset('assets/images/logo.png', height: 64),
              const SizedBox(height: 12),
              const Text(
                'Error',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFE1A948),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.4,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(color: accent),
                  ),
                  child: const Text(
                    'OK',
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
      ),
    );
  }

  void _showOtpDialog(String email) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => OtpAndResetDialog(
        email: email,
        onSuccess: () {
          Navigator.of(context).pop();
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF470000),
      body: Stack(
        children: [
          // MAIN SCROLL CONTENT
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Center(
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
                            style: const TextStyle(color: Colors.black),
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
            ),
          ),

          // FIXED TOP-LEFT BACK BUTTON
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
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
        ],
      ),
    );
  }
}

// ===== OTP AND RESET DIALOG =====
class OtpAndResetDialog extends StatefulWidget {
  final String email;
  final VoidCallback onSuccess;
  const OtpAndResetDialog({
    required this.email,
    required this.onSuccess,
    super.key,
  });

  @override
  State<OtpAndResetDialog> createState() => _OtpAndResetDialogState();
}

class _OtpAndResetDialogState extends State<OtpAndResetDialog> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool isLoading = false;
  String? dialogError;

  int resendCooldown = 0;
  Timer? _cooldownTimer;

  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _otpController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    _cooldownTimer?.cancel();
    super.dispose();
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

  Future<void> _submitReset() async {
    final otp = _otpController.text.trim();
    final newPass = _newPassController.text;
    final confirm = _confirmPassController.text;

    if (otp.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      _setDialogError('All fields are required.');
      return;
    }

    if (newPass != confirm) {
      _setDialogError('Passwords do not match.');
      return;
    }

    if (newPass.length < 6) {
      _setDialogError('Password must be at least 6 characters.');
      return;
    }

    setState(() => isLoading = true);

    try {
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: newPass),
      );

      setState(() => isLoading = false);
      widget.onSuccess();
    } on AuthException catch (e) {
      setState(() => isLoading = false);
      _setDialogError(e.message);
    } catch (e) {
      setState(() => isLoading = false);
      _setDialogError('Failed to reset password. Try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color accent = Color(0xFFE1A948);
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        decoration: BoxDecoration(
          color: const Color(0xFF450003),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: accent, width: 3.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/logo.png', height: 64),
            const SizedBox(height: 12),
            const Text(
              'Reset Password',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFE1A948),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'PlayfairDisplay',
              ),
            ),
            const SizedBox(height: 12),
            if (dialogError != null)
              Text(
                dialogError!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.4,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _otpController,
              decoration: InputDecoration(
                hintText: 'OTP Code',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _newPassController,
              obscureText: _obscureNew,
              decoration: InputDecoration(
                hintText: 'New Password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscureNew ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscureNew = !_obscureNew),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _confirmPassController,
              obscureText: _obscureConfirm,
              decoration: InputDecoration(
                hintText: 'Confirm Password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                suffixIcon: IconButton(
                  icon: Icon(_obscureConfirm
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : OutlinedButton(
                      onPressed: _submitReset,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        side: const BorderSide(color: accent),
                      ),
                      child: const Text(
                        'RESET PASSWORD',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.grey.shade700,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'CANCEL',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
