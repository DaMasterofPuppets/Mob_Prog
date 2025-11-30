import 'package:flutter/material.dart';
import 'package:tarot_app/screens/dashboard/appointment_page.dart';
import 'package:tarot_app/screens/dashboard/packages_page.dart';
import 'package:tarot_app/screens/dashboard/testimonials_page.dart';
import 'package:tarot_app/screens/dashboard/reader_page.dart';
import 'package:tarot_app/screens/settings/settings_dashboard.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  void navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = const Color(0xFF420309);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 32.0 : 16.0,
                    vertical: isTablet ? 16 : 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const AccountInformation()),
                          );
                        },
                        child: Image.asset(
                          'assets/images/settings_page/settings.png',
                          width: isTablet ? 50 : 40,
                          height: isTablet ? 50 : 40,
                        ),
                      ),
                    ],
                  ),
                ),

                Image.asset(
                  'assets/images/logo.png',
                  width: isTablet ? 180 : 130,
                  height: isTablet ? 180 : 130,
                ),

                SizedBox(height: isTablet ? 10 : 0),

                Text(
                  'Pick A Card',
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: isTablet ? 45 : 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: isTablet ? 35 : 25),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? screenWidth * 0.15 : 20,
                  ),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: isTablet ? 30 : 20,
                    mainAxisSpacing: isTablet ? 30 : 20,
                    childAspectRatio: isTablet ? 0.75 : 0.72,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _cardButton(context, 'assets/images/dashboard_page/the_reader.png', const TheReaderPage(), isTablet),
                      _cardButton(context, 'assets/images/dashboard_page/the_packages.png', const PackagesPage(), isTablet),
                      _cardButton(context, 'assets/images/dashboard_page/the_appointments.png', const AppointmentPage(), isTablet),
                      _cardButton(context, 'assets/images/dashboard_page/the_testimonies.png', const TestimonialsPage(), isTablet),
                    ],
                  ),
                ),

                SizedBox(height: isTablet ? 40 : 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardButton(BuildContext context, String asset, Widget page, bool isTablet) {
    return GestureDetector(
      onTap: () => navigateTo(context, page),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: isTablet
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Image.asset(
          asset,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
