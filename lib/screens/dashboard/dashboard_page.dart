import 'package:flutter/material.dart';
import 'package:tarot_app/screens/dashboard/appointment_page.dart';
import 'package:tarot_app/screens/dashboard/packages.dart';
import 'package:tarot_app/screens/dashboard/testimonials.dart';
import 'package:tarot_app/screens/dashboard/the_reader.dart';

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
    final Color gold = const Color(0xFFFFB84D);
    final double cardWidth = MediaQuery.of(context).size.width * 0.4;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

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
                    _cardButton(context, 'assets/images/TheReader.png', const TheReaderPage()),
                    _cardButton(context, 'assets/images/ThePackages.png', const PackagesPage()),
                    _cardButton(context, 'assets/images/TheAppointments.png', const AppointmentPage()),
                    _cardButton(context, 'assets/images/TheTestimonies.png', const TestimonialsPage()),
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
