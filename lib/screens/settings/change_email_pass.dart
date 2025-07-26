import 'package:flutter/material.dart';

class ChangeEmailPassword extends StatelessWidget {
  const ChangeEmailPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Email & Password')),
      body: const Center(
        child: Text('This is the Change Email & Password screen.'),
      ),
    );
  }
}
