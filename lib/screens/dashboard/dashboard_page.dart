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
    //Background Color
    final Color backgroundColor = const Color(0xFF420309);
    final Color gold = const Color(0xFFFFB84D);
    final double imageSize = MediaQuery.of(context).size.width * 0.4;

    return Scaffold(
      //Back Button
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.amber),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'PlayfairDisplay',
                color: gold,
              ),
            ),
          ],
        ),
      ),

      //Interacti Icons
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Pick a card',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'PlayfairDisplay',
              fontSize: 35,
              color: Color(0xFFE5A94E),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: imageSize * 2 + 40,
              height: imageSize * 2 + 40,
              child: GridView.count(
                crossAxisCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  _imageButton(context, 'assets/images/TheAppointments.png', const AppointmentPage(), imageSize),
                  _imageButton(context, 'assets/images/ThePackages.png', const PackagesPage(), imageSize),
                  _imageButton(context, 'assets/images/TheReader.png', const TheReaderPage(), imageSize),
                  _imageButton(context, 'assets/images/TheTestimonies.png', const TestimonialsPage(), imageSize),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageButton(BuildContext context, String asset, Widget page, double size) {
    return GestureDetector(
      onTap: () => navigateTo(context, page),
      child: Image.asset(
        asset,
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    );
  }
}
