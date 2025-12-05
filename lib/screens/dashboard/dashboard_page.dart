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
    final screenHeight = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;
    final isTablet = screenWidth >= 600;

    // Calculate max width for large screens
    final maxContentWidth = isTablet ? 1200.0 : 600.0;
    final contentWidth = screenWidth > maxContentWidth ? maxContentWidth : screenWidth;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Container(
              width: contentWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: isTablet ? 30 : 20),

                  Image.asset(
                    'assets/images/logo.png',
                    width: isTablet ? 180 : 120,
                    height: isTablet ? 200 : 140,
                  ),

                  SizedBox(height: isTablet ? 20 : 10),

                  Text(
                    '(Pick A Card)',
                    style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontSize: isTablet ? 42 : 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: isTablet ? 40 : 30),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? contentWidth * 0.1 : 16,
                    ),
                    child: isLandscape
                        ? _buildLandscapeLayout(context, isTablet)
                        : _buildPortraitLayout(context, isTablet),
                  ),

                  SizedBox(height: isTablet ? 20 : 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context, bool isTablet) {
    return GridView.count(
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
    );
  }

  Widget _buildLandscapeLayout(BuildContext context, bool isTablet) {
    final cards = [
      _cardButton(context, 'assets/images/dashboard_page/the_reader.png', const TheReaderPage(), isTablet),
      _cardButton(context, 'assets/images/dashboard_page/the_packages.png', const PackagesPage(), isTablet),
      _cardButton(context, 'assets/images/dashboard_page/the_appointments.png', const AppointmentPage(), isTablet),
      _cardButton(context, 'assets/images/dashboard_page/settings.png', const AccountInformation(), isTablet),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 12 : 8),
            child: cards[index],
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
                    offset: const Offset(0, 4),
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