import 'package:flutter/material.dart';

class PasswordChangedPage extends StatelessWidget {
  const PasswordChangedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B0000),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Congrats! ✅',
              style: TextStyle(
                fontFamily: 'PlayfairDisplay',
                fontSize: 50,
                color: Color(0xFFE1A948),
              ),
            ),
            const SizedBox(height: 50),
            Text(
              'Your password has\nbeen changed\nsuccessfully',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white , fontFamily: 'PlayfairDisplay', fontSize: 22),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE1A948),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
              child: const Text('RETURN TO LOG IN'),
            ),
          ],
        ),
      ),
    );
  }
}
