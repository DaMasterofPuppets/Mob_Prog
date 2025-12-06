import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> showStyledErrorDialog(BuildContext context, String message) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isTablet = screenWidth >= 600;
  
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isTablet ? 120 : 40,
        vertical: isTablet ? 80 : 24,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 32 : 20,
          vertical: isTablet ? 32 : 22,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF450003),
          borderRadius: BorderRadius.circular(isTablet ? 20 : 16),
          border: Border.all(
            color: const Color(0xFFE1A948),
            width: isTablet ? 4 : 3,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: isTablet ? 90 : 64,
              fit: BoxFit.contain,
            ),
            SizedBox(height: isTablet ? 18 : 12),
            Text(
              'Error',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFFE1A948),
                fontSize: isTablet ? 26 : 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'PlayfairDisplay',
              ),
            ),
            SizedBox(height: isTablet ? 18 : 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: isTablet ? 18 : 14,
              ),
            ),
            SizedBox(height: isTablet ? 24 : 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFE1A948),
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: isTablet ? 16 : 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(isTablet ? 12 : 10),
                  ),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isTablet ? 20 : 16,
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
      await _showError('All fields are required.');
      return;
    }
    if (newPassword != reentered) {
      await _showError('New passwords do not match.');
      return;
    }
    if (newPassword.length < 6) {
      await _showError('New password must be at least 6 characters.');
      return;
    }

    if (oldPassword == newPassword) {
      await _showError('New password cannot be the same as the old password.');
      return;
    }

    final user = supabase.auth.currentUser;
    if (user == null || user.email == null) {
      await _showError('Not signed in. Please log in again.');
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
          onSuccess: () {},
        ),
      );
    } on AuthException catch (e) {
      setState(() => _loading = false);
      await _showError(e.message);
    } catch (e) {
      setState(() => _loading = false);
      await _showError('Something went wrong. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;
    final maxContentWidth = isTablet ? 600.0 : double.infinity;
    
    final titleFontSize = isTablet ? 42.0 : 30.0;
    final logoHeight = isTablet ? 180.0 : 130.0;
    final horizontalPadding = isTablet ? 48.0 : 34.0;
    final backButtonSize = isTablet ? 64.0 : 48.0;
    final backIconSize = isTablet ? 32.0 : 24.0;
    final textFieldFontSize = isTablet ? 18.0 : 16.0;
    final buttonFontSize = isTablet ? 20.0 : 16.0;
    final buttonPaddingH = isTablet ? 48.0 : 36.0;
    final buttonPaddingV = isTablet ? 16.0 : 12.0;

    return Scaffold(
      backgroundColor: const Color(0xFF420309),
      body: SafeArea(
        child: Stack(
  children: [
    /// FIXED TOP-LEFT BACK BUTTON
    Positioned(
      top: 10,
      left: 10,
      child: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: const Color(0xFFE1A948),
          size: backIconSize,
        ),
        onPressed: () => Navigator.pop(context),
        style: IconButton.styleFrom(
          backgroundColor: Colors.black,
          shape: const CircleBorder(),
          fixedSize: Size(backButtonSize, backButtonSize),
        ),
      ),
    ),

    /// MAIN CONTENT
    Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: isTablet ? 80 : 70,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxContentWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: isTablet ? 60 : 50), // adds space below button

                Text(
                  'Edit Password',
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: titleFontSize,
                    color: const Color(0xFFE1A948),
                  ),
                ),
                SizedBox(height: isTablet ? 40 : 30),

                Image.asset('assets/images/logo.png', height: logoHeight),
                SizedBox(height: isTablet ? 40 : 30),

                _buildTextField(
                  'Enter Old Password',
                  oldPasswordController,
                  obscure: _obscureOld,
                  toggleObscure: () => setState(() => _obscureOld = !_obscureOld),
                  fontSize: textFieldFontSize,
                  isTablet: isTablet,
                ),

                _buildTextField(
                  'Enter New Password',
                  newPasswordController,
                  obscure: _obscureNew,
                  toggleObscure: () => setState(() => _obscureNew = !_obscureNew),
                  fontSize: textFieldFontSize,
                  isTablet: isTablet,
                ),

                _buildTextField(
                  'Re-Enter New Password',
                  reenterPasswordController,
                  obscure: _obscureReenter,
                  toggleObscure: () => setState(() => _obscureReenter = !_obscureReenter),
                  fontSize: textFieldFontSize,
                  isTablet: isTablet,
                ),

                SizedBox(height: isTablet ? 32 : 24),

                _buildButton(
                  _loading ? 'PROCESSING...' : 'NEXT',
                  _loading ? null : _handleChangePassword,
                  buttonFontSize,
                  buttonPaddingH,
                  buttonPaddingV,
                ),
              ],
            ),
          ),
        ),
      ),
    ),

    if (_loading)
      Container(
        color: Colors.black.withOpacity(0.25),
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFE1A948)),
          strokeWidth: isTablet ? 5.0 : 4.0,
        ),
      ),
  ],
)

      ),
    );
  }

  Widget _buildTextField(
    String hint,
    TextEditingController controller, {
    required bool obscure,
    required VoidCallback toggleObscure,
    required double fontSize,
    required bool isTablet,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 0 : 20,
        vertical: isTablet ? 12 : 8,
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        enableSuggestions: false,
        autocorrect: false,
        style: TextStyle(fontSize: fontSize),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: fontSize),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: isTablet ? 20 : 16,
            vertical: isTablet ? 20 : 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(isTablet ? 12 : 10),
          ),
          suffixIcon: IconButton(
            onPressed: toggleObscure,
            icon: Icon(
              obscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.black54,
              size: isTablet ? 28 : 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    String text,
    VoidCallback? onPressed,
    double fontSize,
    double paddingH,
    double paddingV,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE1A948),
        foregroundColor: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<void> _showError(String message) {
    return showStyledErrorDialog(context, message);
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
      await showStyledErrorDialog(context, 'A new code has been sent to your email.');
      _startResendCooldown();
    } on AuthException catch (e) {
      setState(() => isLoading = false);
      await showStyledErrorDialog(context, e.message);
    } catch (e) {
      setState(() => isLoading = false);
      await showStyledErrorDialog(context, 'Failed to resend code. Try again.');
    }
  }

  Future<void> _verifyAndUpdate() async {
    final otp = _otpController.text.trim();
    if (!_formKey.currentState!.validate()) return;
    setState(() => isLoading = true);
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
      
      final screenWidth = MediaQuery.of(context).size.width;
      final isTablet = screenWidth >= 600;
      
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(
            horizontal: isTablet ? 120 : 40,
            vertical: isTablet ? 80 : 24,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 32 : 20,
              vertical: isTablet ? 32 : 22,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF450003),
              borderRadius: BorderRadius.circular(isTablet ? 20 : 16),
              border: Border.all(
                color: const Color(0xFFE1A948),
                width: isTablet ? 4 : 3,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: isTablet ? 90 : 64,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: isTablet ? 18 : 12),
                Text(
                  'Password Updated',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFFE1A948),
                    fontSize: isTablet ? 26 : 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlayfairDisplay',
                  ),
                ),
                SizedBox(height: isTablet ? 18 : 12),
                Text(
                  'Your password has been updated successfully. Please sign in with your new credentials.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 18 : 14,
                  ),
                ),
                SizedBox(height: isTablet ? 24 : 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFFE1A948),
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: isTablet ? 16 : 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(isTablet ? 12 : 10),
                      ),
                    ),
                    child: Text(
                      'BACK TO LOGIN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isTablet ? 20 : 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } on AuthException catch (e) {
      setState(() => isLoading = false);
      await showStyledErrorDialog(context, e.message);
    } catch (e, st) {
      setState(() => isLoading = false);
      await showStyledErrorDialog(context, 'Failed to verify code or update password.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;
    
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isTablet ? 120 : 40,
        vertical: isTablet ? 80 : 24,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 32 : 20,
          vertical: isTablet ? 28 : 18,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF450003),
          borderRadius: BorderRadius.circular(isTablet ? 20 : 16),
          border: Border.all(
            color: const Color(0xFFE1A948),
            width: isTablet ? 4 : 3,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Image.asset(
                'assets/images/logo.png',
                height: isTablet ? 90 : 64,
                fit: BoxFit.contain,
              ),
              SizedBox(height: isTablet ? 18 : 12),
              Text(
                'Enter Verification Code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFE1A948),
                  fontSize: isTablet ? 26 : 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
              SizedBox(height: isTablet ? 18 : 12),
              Text(
                'Enter the 6-digit code sent to your email to confirm password change.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTablet ? 18 : 14,
                ),
              ),
              SizedBox(height: isTablet ? 20 : 14),
              TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 6,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isTablet ? 20 : 16,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Verification code',
                  hintStyle: TextStyle(fontSize: isTablet ? 18 : 16),
                  counterText: '',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: isTablet ? 20 : 14,
                    horizontal: isTablet ? 20 : 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(isTablet ? 12 : 8),
                  ),
                ),
                validator: _validateOtp,
              ),
              SizedBox(height: isTablet ? 12 : 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (resendCooldown == 0 && !isLoading) ? _resendCode : null,
                    child: resendCooldown == 0
                        ? Text(
                            'Resend code',
                            style: TextStyle(
                              color: const Color(0xFFE1A948),
                              fontSize: isTablet ? 18 : 14,
                            ),
                          )
                        : Text(
                            'Resend in ${resendCooldown}s',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isTablet ? 18 : 14,
                            ),
                          ),
                  ),
                ],
              ),
              SizedBox(height: isTablet ? 24 : 16),
              SizedBox(
                width: double.infinity,
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFE1A948)),
                          strokeWidth: isTablet ? 5.0 : 4.0,
                        ),
                      )
                    : OutlinedButton(
                        onPressed: _verifyAndUpdate,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFFE1A948),
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: isTablet ? 16 : 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(isTablet ? 12 : 10),
                          ),
                          side: const BorderSide(color: Color(0xFFE1A948)),
                        ),
                        child: Text(
                          'CONFIRM',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isTablet ? 20 : 16,
                          ),
                        ),
                      ),
              ),
              SizedBox(height: isTablet ? 12 : 8),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'CANCEL',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isTablet ? 18 : 14,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}