import 'package:flutter/material.dart';
import 'screens/dashboard/the_reader.dart';
import 'screens/dashboard/packages.dart';
import 'screens/dashboard/testimonials.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  final Color backgroundColor = const Color(0xFF420309);

  void navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: Navigator.canPop(context)
            ? Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.amber),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            imageButton(context, 'assets/TheAppointments.png', const PageOne()),
            imageButton(context, 'assets/ThePackages.png', const PackagesPage()), // ⬅ linked to packages
            imageButton(context, 'assets/TheReader.png', const ReaderPage()),
            imageButton(context, 'assets/TheTestimonies.png', const TestimonialsPage()), // ⬅ linked to testimonials
          ],
        ),
      ),
    );
  }

  Widget imageButton(BuildContext context, String asset, Widget page) {
    return GestureDetector(
      onTap: () => navigateTo(context, page),
      child: Image.asset(
        asset,
        width: 80,
        height: 80,
      ),
    );
  }
}

// PLACEHOLDERS FOR OTHER BUTTONS
class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) => const _SimplePage(title: 'The Appointments');
}

class _SimplePage extends StatelessWidget {
  final String title;
  const _SimplePage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF420309),
      appBar: AppBar(
        backgroundColor: const Color(0xFF420309),
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
