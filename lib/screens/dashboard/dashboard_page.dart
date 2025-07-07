import 'package:flutter/material.dart';

// ✅ import your actual pages
import 'package:tarrot_app/screens/dashboard/packages.dart';
import 'package:tarrot_app/screens/dashboard/the_reader.dart';
import 'package:tarrot_app/screens/dashboard/testimonials.dart';

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
    final double imageSize = MediaQuery.of(context).size.width * 0.4;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFE1A948)),
            onPressed: () => Navigator.pop(context),
            style: IconButton.styleFrom(
              backgroundColor: Colors.black,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(12),
              fixedSize: const Size(48, 48),
            ),
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: imageSize * 2 + 40,
          height: imageSize * 2 + 40,
          child: GridView.count(
            crossAxisCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: [
              _imageButton(context, 'assets/images/TheAppointments.png', const PlaceholderPage(title: "Appointments Page"), imageSize),
              _imageButton(context, 'assets/images/ThePackages.png', const PackagesPage(), imageSize),
              _imageButton(context, 'assets/images/TheReader.png', const TheReaderPage(), imageSize),
              _imageButton(context, 'assets/images/TheTestimonies.png', const TestimonialsPage(), imageSize),
            ],
          ),
        ),
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

// keep your placeholder only for Appointments
class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF420309),
      appBar: AppBar(
        backgroundColor: const Color(0xFF420309),
        title: Text(title),
      ),
      body: const Center(
        child: Text(
          'Work in Progress',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
