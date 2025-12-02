import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
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
      await Supabase.instance.client.auth.signInWithOtp(email: email);

      setState(() => isLoading = false);

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
    } on AuthException catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFFE1A948)),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: const CircleBorder(),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
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
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
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
    );
  }
}

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
  final _formKey = GlobalKey<FormState>();

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

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (v.length < 6) return 'Password must be at least 6 characters';
    return null;
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

  Future<void> _submitReset() async {
    final otp = _otpController.text.trim();
    final newPass = _newPassController.text;
    final confirm = _confirmPassController.text;

    if (!_formKey.currentState!.validate()) return;
    if (newPass != confirm) {
      _setDialogError('Passwords do not match');
      return;
    }

    setState(() => isLoading = true);
    _setDialogError(null);

    try {
      await Supabase.instance.client.auth.verifyOTP(
        token: otp,
        type: OtpType.recovery,
        email: widget.email,
      );

      await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: newPass),
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
                'Enter the 6-digit code sent to your email and choose a new password.',
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
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                maxLength: 6,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Verification code',
                  counterText: '',
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: _validateOtp,
              ),

              const SizedBox(height: 6),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (resendCooldown == 0 && !isLoading)
                        ? _resendCode
                        : null,
                    child: resendCooldown == 0
                        ? const Text('Resend code',
                            style: TextStyle(color: Color(0xFFE1A948)))
                        : Text(
                            'Resend in ${resendCooldown}s',
                            style: const TextStyle(color: Colors.white),
                          ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              TextFormField(
                controller: _newPassController,
                obscureText: _obscureNew,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'New password',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscureNew ? Icons.visibility_off : Icons.visibility),
                    color: Colors.black54,
                    onPressed: () =>
                        setState(() => _obscureNew = !_obscureNew),
                  ),
                ),
                validator: _validatePassword,
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: _confirmPassController,
                obscureText: _obscureConfirm,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Confirm password',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 16.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirm
                        ? Icons.visibility_off
                        : Icons.visibility),
                    color: Colors.black54,
                    onPressed: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                ),
                validator: _validatePassword,
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : OutlinedButton(
                        onPressed: _submitReset,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFFE1A948),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          side: const BorderSide(color: Color(0xFFE1A948)),
                        ),
                        child: const Text('RESET PASSWORD',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
              ),

              const SizedBox(height: 8),

              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('CANCEL',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
