import 'package:flutter/material.dart';

class PackagesPage extends StatelessWidget {
  const PackagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFFFB84D);

    final List<Map<String, String>> packages = [
      {
        'title': 'Tiara Package',
        'image': 'assets/images/Packages-Page/Tiara_Package.png',
        'description': 'This package offers a light and insightful reading perfect for quick guidance.'
      },
      {
        'title': 'Coronet Package',
        'image': 'assets/images/Packages-Page/Coronet_Package.png',
        'description': 'A medium-depth reading that dives into your current challenges and opportunities.'
      },
      {
        'title': 'Crown Package',
        'image': 'assets/images/Packages-Page/Crown_Package.png',
        'description': 'Our most comprehensive reading, revealing deeper spiritual insights and future pathways.'
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF420309),
      appBar: AppBar(
        backgroundColor: const Color(0xFF420309),
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
              'Packages',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Choose your package',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'PlayfairDisplay',
                fontSize: 28,
                color: Color(0xFFE5A94E),
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 3 / 4,
              children: packages.map((package) {
                return GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      backgroundColor: const Color(0xFF420309),
                      title: Text(
                        package['title']!,
                        style: TextStyle(
                          color: gold,
                          fontFamily: 'PlayfairDisplay',
                        ),
                      ),
                      content: Text(
                        package['description']!,
                        style: const TextStyle(color: Colors.white),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close', style: TextStyle(color: Colors.amber)),
                        ),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: Image.asset(
                          package['image']!,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        package['title']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: gold,
                          fontFamily: 'PlayfairDisplay',
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
