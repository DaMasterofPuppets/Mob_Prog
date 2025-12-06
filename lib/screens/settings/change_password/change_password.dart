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
      _showErrorDialog(context, 'All fields are required.');
      return;
    }
    if (newPassword != reentered) {
      _showErrorDialog(context, 'New passwords do not match.');
      return;
    }
    if (newPassword.length < 6) {
      _showErrorDialog(context, 'New password must be at least 6 characters.');
      return;
    }

    final user = supabase.auth.currentUser;
    if (user == null || user.email == null) {
      _showErrorDialog(context, 'Not signed in. Please log in again.');
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
      _showErrorDialog(context, e.message);
    } catch (e) {
      _showErrorDialog(context, 'Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;
    const Color accent = Color(0xFFE1A948);
    
    showDialog(
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
            border: Border.all(color: accent, width: isTablet ? 4 : 3),
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
                  height: 1.4,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
              SizedBox(height: isTablet ? 24 : 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: isTablet ? 16 : 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(isTablet ? 12 : 10),
                    ),
                    side: const BorderSide(color: accent),
                  ),
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontSize: isTablet ? 20 : 16,
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;
    final maxContentWidth = isTablet ? 600.0 : double.infinity;
    
    final titleFontSize = isTablet ? 42.0 : 30.0;
    final logoHeight = isTablet ? 180.0 : 130.0;
    final topPadding = isTablet ? 80.0 : 70.0;
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
            // --- MAIN SCROLL CONTENT ---
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: topPadding,
                    left: horizontalPadding,
                    right: horizontalPadding,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxContentWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          'Edit: Password',
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
                          textFieldFontSize,
                          isTablet,
                        ),
                        _buildTextField(
                          'Enter New Password',
                          newPasswordController,
                          textFieldFontSize,
                          isTablet,
                        ),
                        _buildTextField(
                          'Re-Enter New Password',
                          reenterPasswordController,
                          textFieldFontSize,
                          isTablet,
                        ),
                        SizedBox(height: isTablet ? 32 : 24),
                        _buildButton(
                          _loading ? 'PROCESSING...' : 'NEXT',
                          _loading ? null : _handleChangePassword,
                          buttonFontSize,
                          buttonPaddingH,
                          buttonPaddingV,
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // --- FIXED TOP-LEFT BACK BUTTON ---
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
                  padding: const EdgeInsets.all(12),
                  fixedSize: Size(backButtonSize, backButtonSize),
                ),
              ),
            ),

            // --- LOADING OVERLAY ---
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
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hint,
    TextEditingController controller,
    double fontSize,
    bool isTablet,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 0 : 20,
        vertical: isTablet ? 12 : 8,
      ),
      child: TextField(
        controller: controller,
        obscureText: true,
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
}