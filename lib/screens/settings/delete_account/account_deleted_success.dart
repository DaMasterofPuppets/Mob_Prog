import 'package:flutter/material.dart';

class AccountDeletedSuccess extends StatelessWidget {
  const AccountDeletedSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF420309),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 180),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 240,
              ),
              const SizedBox(height: 48),
              const Text(
                'Deleted successfully',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              const SizedBox(height: 20),
            const Text(
                'Thank you\nfor being a part of\nEmpress Reads.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 20,
                  color: Color(0xFFE1A948),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE1A948),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
                child: const Text(
                  'GOT IT',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
