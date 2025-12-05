import 'package:flutter/material.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  bool _isDeleting = false;

  void _handleDelete() {
    setState(() {
      _isDeleting = true;
    });

    // simulate deletion process
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/acc_delete_succ');
    });
  }

  void _showConfirmDialog(BuildContext context) {
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
              Image.asset(
                'assets/images/logo.png',
                height: 64,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 12),
              const Text(
                'Confirm Deletion',
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
                'Are you sure you want to delete your account?\nThis action cannot be undone.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.4,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _handleDelete();
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: const BorderSide(color: accent),
                      ),
                      child: const Text(
                        'DELETE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF420309),
      body: SafeArea(
        child: Stack(
          children: [
            // === SCROLL CONTENT ===
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50), // spacing under back button
                    const Text(
                      'Account Deletion',
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: 34,
                        color: Color(0xFFE1A948),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 240,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'WARNING!',
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'All data and settings connected to this account will be deleted permanently.\n\nAre you sure you want to continue?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: _isDeleting ? null : () => _showConfirmDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE1A948),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
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

            // === FIXED BACK BUTTON ===
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFFE1A948)),
                onPressed: () => Navigator.pushReplacementNamed(context, '/acc_info'),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: const CircleBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
