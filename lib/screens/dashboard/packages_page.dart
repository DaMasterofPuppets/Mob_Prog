import 'package:flutter/material.dart';

class PackagesPage extends StatelessWidget {
  const PackagesPage({super.key});

  void _showPackageInfo(BuildContext context, String imagePath, String title, String price, String description) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF420309),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Image
              Image.asset(
                imagePath,
                height: 120,
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFFFB84D),
                  fontFamily: 'LuxuriousScript',
                  fontSize: 60,
                ),
              ),
              const SizedBox(height: 10),

              // Price
              Text(
                price,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
              const SizedBox(height: 15),

              // Description
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontFamily: 'PlayfairDisplay',
                  height: 1.4,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFFFB84D);
    final double imageWidth = MediaQuery.of(context).size.width / 1.25;

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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Choose your package',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'LuxuriousScript',
                fontSize: 60,
                color: Color(0xFFE5A94E),
              ),
            ),
            const SizedBox(height: 20),

            GestureDetector(
              onTap: () => _showPackageInfo(
                context,
                'assets/images/packages_page/tiara_asset.png',
                'Tiara Package',
                'Php 100',
                'Short, sweet, and powerfully clear. '
                'The Tiara Package is perfect for a quick but meaningful peek into your current situation. '
                'With 4 carefully drawn tarot cards, this reading helps you focus on one question and reveals what’s unfolding around you. '
                'Great for beginners or those seeking fast clarity. 🌟💭',
              ),
              child: Image.asset(
                'assets/images/packages_page/tiara_package.png',
                width: imageWidth,
              ),
            ),
            const SizedBox(height: 15),

            GestureDetector(
              onTap: () => _showPackageInfo(
                context,
                'assets/images/packages_page/coronet_asset.png',
                'Coronet Package',
                'Php 150',
                'For matters of the heart and alignment. '
                'This package blends the clarity of 5 tarot cards with the divine wisdom of 3 oracle cards to offer a harmonious reading. '
                'The Coronet Package offers both insight and affirmation, a beautiful balance of grounded logic and spiritual whisper. '
                'Because your intuition deserves validation. 💖🔮',
              ),
              child: Image.asset(
                'assets/images/packages_page/coronet_package.png',
                width: imageWidth,
              ),
            ),
            const SizedBox(height: 15),

            GestureDetector(
              onTap: () => _showPackageInfo(
                context,
                'assets/images/packages_page/crown_asset.png',
                'Crown Package',
                'Php 250',
                'Unveil the mysteries of your soul. '
                'Our most powerful reading yet — the Crown Package is for those who seek the truth beneath the veil. '
                'With 8 tarot cards and 5 oracle cards, you will receive layered insight, deep spiritual guidance, and answers to the questions you have been afraid to ask. '
                'Perfect for major life decisions, shadow work, or diving into your soul’s journey. '
                'Let the Empress herself guide your destiny. 🌙✨',
              ),
              child: Image.asset(
                'assets/images/packages_page/crown_package.png',
                width: imageWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
