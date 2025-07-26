import 'package:flutter/material.dart';

class AccountInformation extends StatelessWidget {
  const AccountInformation({super.key});

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
                icon: const Icon(Icons.arrow_back, color: Color(0xFFFFD700)),
                onPressed: () => Navigator.pop(context),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: const CircleBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Account Settings',
              style: TextStyle(
                fontFamily: 'PlayfairDisplay',
                fontSize: 34,
                color: Color(0xFFFFD700),
              ),
            ),
            const SizedBox(height: 24),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/ryan_gosling.jpg'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Ryan_Gosling',
              style: TextStyle(
                fontFamily: 'PlayfairDisplay',
                fontSize: 22,
                color: Color(0xFFFFD700),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'literally.me@gmail.com',
              style: TextStyle(
                fontFamily: 'PlayfairDisplay',
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
            buildButton(
              context, 
              'Edit Profile', 
              () => Navigator.pushNamed(context, '/change_prof'),
            ),
            const SizedBox(height: 16),
            buildButton(
              context, 
              'Edit Email & Password', 
              () => Navigator.pushNamed(context, '/change_emailpass'),
            ),
            const SizedBox(height: 16),
            buildButton(
              context,
              'Delete Account',
              () => Navigator.pushNamed(context, '/acc_delete'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFC857),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
