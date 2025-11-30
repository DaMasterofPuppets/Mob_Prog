import 'package:flutter/material.dart';
import 'package:tarot_app/screens/dashboard/appointment_page.dart';
import 'package:tarot_app/screens/dashboard/packages_page.dart';
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
                SizedBox(height: isTablet ? 30 : 20),

                Image.asset(
                  'assets/images/logo.png',
                  width: isTablet ? 240 : 180,
                  height: isTablet ? 240 : 180,
                ),

                SizedBox(height: isTablet ? 20 : 10),

                Text(
                  'Pick A Card...',
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: isTablet ? 52 : 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: isTablet ? 40 : 30),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? screenWidth * 0.1 : 16,
                  ),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: isTablet ? 35 : 25,
                    mainAxisSpacing: isTablet ? 35 : 25,
                    childAspectRatio: isTablet ? 0.75 : 0.72,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _cardButton(context, 'assets/images/dashboard_page/the_reader.png', const TheReaderPage(), isTablet),
                      _cardButton(context, 'assets/images/dashboard_page/the_packages.png', const PackagesPage(), isTablet),
                      _cardButton(context, 'assets/images/dashboard_page/the_appointments.png', const AppointmentPage(), isTablet),
                      _cardButton(context, 'assets/images/dashboard_page/settings.png', const AccountInformation(), isTablet),
                    ],
                  ),
                ),

                SizedBox(height: isTablet ? 20 : 10),
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