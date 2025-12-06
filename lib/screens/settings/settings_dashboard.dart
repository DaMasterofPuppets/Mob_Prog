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
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;

    final horizontalPadding = isTablet ? 60.0 : 34.0;
    final topPadding = isTablet ? 120.0 : 100.0;
    final titleFontSize = isTablet ? 42.0 : 34.0;
    final labelFontSize = isTablet ? 22.0 : 20.0;
    final emailFontSize = isTablet ? 18.0 : 16.0;
    final buttonFontSize = isTablet ? 18.0 : 16.0;
    final buttonPaddingV = isTablet ? 18.0 : 14.0;
    final containerBorderRadius = isTablet ? 16.0 : 12.0;
    final backButtonSize = isTablet ? 64.0 : 48.0;
    final backIconSize = isTablet ? 32.0 : 24.0;

    return Scaffold(
      backgroundColor: const Color(0xFF420309),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: topPadding,
                  left: horizontalPadding,
                  right: horizontalPadding,
                  bottom: isTablet ? 40 : 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Account Settings',
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: titleFontSize,
                        color: const Color(0xFFE1A948),
                      ),
                    ),
                    SizedBox(height: isTablet ? 30 : 24),
                    Text(
                      'Email:',
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: labelFontSize,
                        color: const Color(0xFFE1A948),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: isTablet ? 14 : 12),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A0A07),
                        borderRadius: BorderRadius.circular(containerBorderRadius),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: const Offset(0, 6),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 20 : 16,
                        vertical: isTablet ? 20 : 16,
                      ),
                      child: Text(
                        _email ?? 'Not signed in',
                        style: TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          fontSize: emailFontSize,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: isTablet ? 40 : 32),
                    buildButton(context, 'Edit Password', () => Navigator.pushNamed(context, '/change_password'),
                        fontSize: buttonFontSize, verticalPadding: buttonPaddingV),
                    SizedBox(height: isTablet ? 20 : 16),
                    buildButton(context, 'Delete Account', () => Navigator.pushNamed(context, '/acc_delete'),
                        fontSize: buttonFontSize, verticalPadding: buttonPaddingV),
                    SizedBox(height: isTablet ? 20 : 16),
                    buildButton(context, 'Log Out', () async {
                      await Supabase.instance.client.auth.signOut();
                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/',
                          (route) => false,
                        );
                      }
                    }, fontSize: buttonFontSize, verticalPadding: buttonPaddingV),
                  ],
                ),
              ),
            ),
            // BACK BUTTON - fixed top-left
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: const Color(0xFFE1A948), size: backIconSize),
                onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: const CircleBorder(),
                  fixedSize: Size(backButtonSize, backButtonSize),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, String text, VoidCallback onPressed,
      {required double fontSize, required double verticalPadding}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE1A948),
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: fontSize,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
