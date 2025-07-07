import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  void navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

//The UI
  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = const Color(0xFF420309);
    final double imageSize = MediaQuery.of(context).size.width * 0.4;

//Page Structure
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

          //FOr grid view
          child: GridView.count(
            crossAxisCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: [
              _imageButton(context, 'assets/images/TheAppointments.png', const AppointmentsPage(), imageSize),
              _imageButton(context, 'assets/images/ThePackages.png', const PackagesPage(), imageSize),
              _imageButton(context, 'assets/images/TheReader.png', const ReaderPage(), imageSize),
              _imageButton(context, 'assets/images/TheTestimonies.png', const TestimoniesPage(), imageSize),
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

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _emptyScaffold(context, "Appointments Page");
  }
}

class PackagesPage extends StatelessWidget {
  const PackagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _emptyScaffold(context, "Packages Page");
  }
}

class ReaderPage extends StatelessWidget {
  const ReaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _emptyScaffold(context, "Reader Page");
  }
}

class TestimoniesPage extends StatelessWidget {
  const TestimoniesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _emptyScaffold(context, "Testimonies Page");
  }
}

Widget _emptyScaffold(BuildContext context, String title) {
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
