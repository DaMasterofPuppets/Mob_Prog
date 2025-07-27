import 'package:flutter/material.dart';

class EmailSuccessPage extends StatelessWidget {
  const EmailSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B0000),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 200),
              const Center(
                child: Text(
                  'Congrats! ✅',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE1A948),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                'Your email has been\nchanged successfully',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE1A948),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'RETURN\nTO LOG IN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 250),
            ],
          ),
        ),
      ),
    );
  }
}
