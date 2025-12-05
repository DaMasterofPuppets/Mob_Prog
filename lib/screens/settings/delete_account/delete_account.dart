import 'dart:async';
import 'package:flutter/material.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  bool _isDeleting = false;

  void _showUnavailablePopup() {
    const accent = Color(0xFFE1A948);
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
            border: Border.all(color: accent, width: 3.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/logo.png', height: 64, fit: BoxFit.contain),
              const SizedBox(height: 12),
              const Text(
                'Feature Unavailable',
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
                'Sorry, this feature is currently unavailable.\n\nHowever, if you really want to delete your account asap, please contact us at\nc202301060@iacademy.edu.ph',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.4,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                        onPressed: () => Navigator.pushReplacementNamed(context, '/acc_info'),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: const CircleBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Account Deletion',
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: 30,
                        color: Color(0xFFE1A948),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 130,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'WARNING!',
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: 32,
                        color: Color(0xFFE1A948),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'All data and settings connected to this account will be deleted permanently.\n\nAre you sure you want to continue?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: _isDeleting ? null : _showUnavailablePopup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE1A948),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text(
                        'DELETE ACCOUNT',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (_isDeleting)
                      const LinearProgressIndicator(
                        backgroundColor: Colors.white24,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE1A948)),
                      ),
                  ],
                ),
              ),
            ),
            if (_isDeleting)
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
}
