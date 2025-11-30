import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({super.key});

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  String? _email;

  @override
  void initState() {
    super.initState();
    final user = Supabase.instance.client.auth.currentUser;
    _email = user?.email ?? 'Not signed in';

    Supabase.instance.client.auth.onAuthStateChange.listen((_) {
      final u = Supabase.instance.client.auth.currentUser;
      setState(() {
        _email = u?.email ?? 'Not signed in';
      });
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
                color: Color(0xFFE1A948),
              ),
            ),

            const SizedBox(height: 24),

            Center(
              child: Text(
                'Email:',
                style: const TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 20,
                  color: Color(0xFFE1A948),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Center(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF2A0A07),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: const Offset(0, 6),
                      blurRadius: 12,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Center(
                  child: Text(
                    _email ?? 'Not signed in',
                    style: const TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            buildButton(context, 'Edit Email', () => Navigator.pushNamed(context, '/change_email')),
            const SizedBox(height: 16),
            buildButton(context, 'Edit Password', () => Navigator.pushNamed(context, '/change_password')),
            const SizedBox(height: 16),
            buildButton(context, 'Delete Account', () => Navigator.pushNamed(context, '/acc_delete')),
            const SizedBox(height: 16),

            buildButton(context, 'Log Out', () async {
              await Supabase.instance.client.auth.signOut();

              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,'/',
                  (route) => false,
                );
              }
            }),
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
          backgroundColor: const Color(0xFFE1A948),
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
