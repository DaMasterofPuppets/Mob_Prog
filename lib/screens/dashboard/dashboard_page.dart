import 'package:flutter/material.dart';
import 'package:tarot_app/screens/dashboard/appointment_page.dart';
import 'package:tarot_app/screens/dashboard/packages_page.dart';
import 'package:tarot_app/screens/dashboard/testimonials_page.dart';
import 'package:tarot_app/screens/dashboard/reader_page.dart';
import 'package:tarot_app/screens/login/load_screen.dart';
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

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // TOP BAR WITH BACK AND SETTINGS
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Back Button
      Row(
        children: [
          CircleAvatar(
  backgroundColor: Colors.black,
  child: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.amber),
    onPressed: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoadScreen()),
      );
    },
  ),
),
const SizedBox(width: 16),
        ],
      ),

      // Settings Button
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AccountInformation()),
          );
        },
        child: Image.asset(
          'assets/images/settings_page/settings.png',
          width: 40,
          height: 40,
        ),
      ),
    ],
  ),
),


              // LOGO IMAGE
              Image.asset(
                'assets/images/logo.png',
                width: 150,
                height: 150,
              ),

              const SizedBox(height: 5),

              // PICK A CARD TEXT
              const Text(
                'Pick a card...',
                style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontSize: 42,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              // CARD GRID
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.72,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _cardButton(context, 'assets/images/dashboard_page/the_reader.png', const TheReaderPage()),
                    _cardButton(context, 'assets/images/dashboard_page/the_packages.png', const PackagesPage()),
                    _cardButton(context, 'assets/images/dashboard_page/the_appointments.png', const AppointmentPage()),
                    _cardButton(context, 'assets/images/dashboard_page/the_testimonies.png', const TestimonialsPage()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardButton(BuildContext context, String asset, Widget page) {
    return GestureDetector(
      onTap: () => navigateTo(context, page),
      child: Image.asset(
        asset,
        fit: BoxFit.contain,
      ),
    );
  }
}
