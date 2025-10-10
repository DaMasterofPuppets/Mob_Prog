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

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/acc_delete_succ');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF420309),
      body: Padding(
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
            const SizedBox(height: 20),
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
                color: Color(0xFFE1A948),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'All data and settings connected to this account will be deleted permanently.\n\nAre you sure you want to continue?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'PlayfairDisplay',
                fontSize: 20,
                color: Color(0xFFE1A948),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _isDeleting ? null : _handleDelete,
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
    );
  }
}
