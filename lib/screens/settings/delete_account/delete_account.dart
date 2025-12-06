import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  bool _isDeleting = false;

  // -------------------------------
  // Confirmation Dialog
  // -------------------------------
  void _showConfirmationDialog() {
    const accent = Color(0xFFE1A948);
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(
          horizontal: isTablet ? 120 : 40,
          vertical: isTablet ? 60 : 24,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 30 : 20,
            vertical: isTablet ? 30 : 22,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF450003),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: accent, width: isTablet ? 4 : 3),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/logo.png',
                  height: isTablet ? 100 : 64, fit: BoxFit.contain),
              SizedBox(height: isTablet ? 20 : 12),

              Text(
                'Final Confirmation',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: accent,
                  fontSize: isTablet ? 30 : 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
              SizedBox(height: isTablet ? 20 : 12),

              Text(
                'This action cannot be undone. Your account and all associated data will be permanently deleted.\n\nDo you want to proceed?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTablet ? 20 : 14,
                  height: 1.4,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
              SizedBox(height: isTablet ? 28 : 16),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: accent,
                        side: BorderSide(color: accent, width: isTablet ? 3 : 2),
                        padding: EdgeInsets.symmetric(
                          vertical: isTablet ? 18 : 12,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isTablet ? 20 : 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: isTablet ? 20 : 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _deleteAccount();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(
                          vertical: isTablet ? 18 : 12,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: isTablet ? 20 : 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------
  // DELETE ACCOUNT LOGIC
  // -------------------------------
  Future<void> _deleteAccount() async {
    setState(() => _isDeleting = true);

    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;

      if (user == null) {
        throw Exception('No logged in user.');
      }

      // Custom Supabase RPC
      await supabase.rpc('delete_user');
      await supabase.auth.signOut();

      if (!mounted) return;
      _showSuccessDialog();
    } catch (e) {
      if (!mounted) return;
      setState(() => _isDeleting = false);
      _showErrorDialog(e.toString());
    }
  }

  // -------------------------------
  // SUCCESS DIALOG
  // -------------------------------
  void _showSuccessDialog() {
    const accent = Color(0xFFE1A948);
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding:
            EdgeInsets.symmetric(horizontal: isTablet ? 120 : 40, vertical: 24),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 30 : 20,
            vertical: isTablet ? 28 : 22,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF450003),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: accent, width: isTablet ? 4 : 3),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/logo.png',
                  height: isTablet ? 100 : 64),
              SizedBox(height: isTablet ? 20 : 12),

              Text(
                'Account Deleted',
                style: TextStyle(
                  color: accent,
                  fontSize: isTablet ? 28 : 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isTablet ? 20 : 12),

              Text(
                'Your account has been successfully deleted. You will now be redirected to the login screen.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTablet ? 20 : 14,
                  height: 1.4,
                ),
              ),
              SizedBox(height: isTablet ? 28 : 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(
                      vertical: isTablet ? 18 : 12,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    'Return to Login',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isTablet ? 20 : 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------
  // ERROR DIALOG
  // -------------------------------
  void _showErrorDialog(String error) {
    const accent = Color(0xFFE1A948);
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(
          horizontal: isTablet ? 120 : 40,
          vertical: 24,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 30 : 20,
            vertical: isTablet ? 28 : 22,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF450003),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: accent, width: isTablet ? 4 : 3),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline,
                  color: Colors.redAccent, size: isTablet ? 100 : 64),
              SizedBox(height: isTablet ? 20 : 12),

              Text(
                'Deletion Failed',
                style: TextStyle(
                  color: accent,
                  fontSize: isTablet ? 28 : 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isTablet ? 20 : 12),

              Text(
                'Failed to delete account. Please try again or contact support.\n\nError: $error',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTablet ? 20 : 14,
                  height: 1.4,
                ),
              ),
              SizedBox(height: isTablet ? 28 : 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(
                      vertical: isTablet ? 18 : 12,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    'OK',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isTablet ? 20 : 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------
  // MAIN PAGE UI
  // -------------------------------
 @override
Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isTablet = screenWidth > 600;

  return Scaffold(
    backgroundColor: const Color(0xFF420309),
    body: SafeArea(
      child: Stack(
        children: [
          // MAIN CONTENT
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 80 : 34,
                vertical: isTablet ? 120 : 70,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: isTablet ? 60 : 30),

                  Text(
                    'Account Deletion',
                    style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: isTablet ? 58 : 40,
                      color: const Color(0xFFE1A948),
                    ),
                  ),

                  SizedBox(height: isTablet ? 30 : 12),

                  Image.asset(
                    'assets/images/logo.png',
                    height: isTablet ? 300 : 230,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: isTablet ? 30 : 14),

                  Text(
                    'WARNING!',
                    style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: isTablet ? 60 : 42,
                      color: const Color(0xFFE1A948),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: isTablet ? 30 : 16),

                  Text(
                    'All data and settings connected to this account will be deleted permanently.\n\nAre you sure you want to continue?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: isTablet ? 26 : 17,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: isTablet ? 60 : 40),

                  ElevatedButton(
                    onPressed: _isDeleting ? null : _showConfirmationDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE1A948),
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 70 : 40,
                        vertical: isTablet ? 24 : 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'DELETE ACCOUNT',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: isTablet ? 26 : 16,
                      ),
                    ),
                  ),

                  SizedBox(height: isTablet ? 50 : 24),

                  if (_isDeleting)
                    const LinearProgressIndicator(
                      backgroundColor: Colors.white24,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE1A948)),
                    ),
                ],
              ),
            ),
          ),

          // FIXED BACK BUTTON (UPPER-LEFT)
          Positioned(
            top: 10,
            left: 10,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: const Color(0xFFE1A948),
                size: isTablet ? 40 : 28,
              ),
              onPressed: () => Navigator.pushReplacementNamed(context, '/acc_info'),
              style: IconButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.all(isTablet ? 16 : 10),
                shape: const CircleBorder(),
              ),
            ),
          ),

          // DISABLED OVERLAY WHEN LOADING
          if (_isDeleting)
            Container(
              color: Colors.black.withOpacity(0.25),
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE1A948)),
              ),
            ),
        ],
      ),
    ),
  );
}
}