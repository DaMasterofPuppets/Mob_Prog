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
    final maxContentWidth = isTablet ? 600.0 : double.infinity;
    
    // Responsive sizing
    final titleFontSize = isTablet ? 48.0 : 34.0;
    final labelFontSize = isTablet ? 26.0 : 20.0;
    final emailFontSize = isTablet ? 20.0 : 16.0;
    final buttonFontSize = isTablet ? 20.0 : 16.0;
    final topPadding = isTablet ? 5.0 : 2.0;
    final horizontalPadding = isTablet ? 48.0 : 34.0;
    final backButtonSize = isTablet ? 64.0 : 48.0;
    final backIconSize = isTablet ? 32.0 : 24.0;
    final buttonVerticalPadding = isTablet ? 20.0 : 14.0;
    final spacing = isTablet ? 24.0 : 16.0;
    final emailContainerPadding = isTablet ? 20.0 : 16.0;

    return Scaffold(
      backgroundColor: const Color(0xFF420309),
      body: SafeArea(
        child: Stack(
          children: [
            // MAIN CONTENT
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: topPadding,
                    left: horizontalPadding,
                    right: horizontalPadding,
                    bottom: 30,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxContentWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),

                        Text(
                          'Account Settings',
                          style: TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            fontSize: titleFontSize,
                            color: const Color(0xFFE1A948),
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 24),

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

                        const SizedBox(height: 12),

                        Container(
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
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: emailContainerPadding,
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

                        SizedBox(height: isTablet ? 48 : 32),

                        buildButton(
                          context,
                          'Edit Password',
                          () => Navigator.pushNamed(context, '/change_password'),
                          buttonFontSize,
                          buttonVerticalPadding,
                        ),
                        SizedBox(height: spacing),
                        buildButton(
                          context,
                          'Delete Account',
                          () => Navigator.pushNamed(context, '/acc_delete'),
                          buttonFontSize,
                          buttonVerticalPadding,
                        ),
                        SizedBox(height: spacing),

                        buildButton(
                          context,
                          'Log Out',
                          () async {
                            await Supabase.instance.client.auth.signOut();

                            if (context.mounted) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/',
                                (route) => false,
                              );
                            }
                          },
                          buttonFontSize,
                          buttonVerticalPadding,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // FIXED BACK BUTTON
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: const Color(0xFFE1A948),
                  size: backIconSize,
                ),
                onPressed: () => Navigator.pop(context),
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(12),
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

  Widget buildButton(
    BuildContext context,
    String text,
    VoidCallback onPressed,
    double fontSize,
    double verticalPadding,
  ) {
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