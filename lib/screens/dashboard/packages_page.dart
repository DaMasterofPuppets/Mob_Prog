import 'package:flutter/material.dart';

class PackagesPage extends StatelessWidget {
  const PackagesPage({super.key});

  void _showPackageInfo(BuildContext context, String imagePath, String title, String price, String description) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;
    
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF420309),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          contentPadding: EdgeInsets.symmetric(
            vertical: isTablet ? 40 : 30,
            horizontal: isTablet ? 30 : 20,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Image
                Image.asset(
                  imagePath,
                  height: isTablet ? 150 : 120,
                ),
                SizedBox(height: isTablet ? 25 : 20),

                // Title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFE1A948),
                    fontFamily: 'LuxuriousScript',
                    fontSize: isTablet ? 70 : 60,
                  ),
                ),
                SizedBox(height: isTablet ? 15 : 10),

                // Price
                Text(
                  price,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 24 : 21,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'PlayfairDisplay',
                  ),
                ),
                SizedBox(height: isTablet ? 20 : 15),

                // Description
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 21 : 19,
                    fontFamily: 'PlayfairDisplay',
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color gold = const Color(0xFFE1A948);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;
    
    // Responsive image width
    final double imageWidth = isTablet 
        ? screenWidth / 2.0  // Tablets: half screen width
        : screenWidth / 1.25; // Phones: slightly smaller than full width

    return Scaffold(
      backgroundColor: const Color(0xFF420309),
      appBar: AppBar(
        backgroundColor: const Color(0xFF420309),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 16.0 : 0),
          child: Row(
            children: [
              CircleAvatar(
                radius: isTablet ? 24 : 20,
                backgroundColor: Colors.black,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Color(0xFFE1A948),
                    size: isTablet ? 28 : 24,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(width: isTablet ? 20 : 16),
              Text(
                'Packages',
                style: TextStyle(
                  fontSize: isTablet ? 42 : 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                  color: gold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? screenWidth * 0.1 : 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: isTablet ? 30 : 20),
                Text(
                  'Choose your package',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'LuxuriousScript',
                    fontSize: isTablet ? 70 : 60,
                    color: Color(0xFFE1A948),
                  ),
                ),
                SizedBox(height: isTablet ? 30 : 20),

                GestureDetector(
                  onTap: () => _showPackageInfo(
                    context,
                    'assets/images/packages_page/tiara_asset.png',
                    'Tiara Package',
                    'Php 100',
                    'Short, sweet, and powerfully clear. '
                        'The Tiara Package is perfect for a quick but meaningful peek into your current situation. '
                        'With 4 carefully drawn tarot cards, this reading helps you focus on one question and reveals what\'s unfolding around you. '
                        'Great for beginners or those seeking fast clarity. 🌟💭',
                  ),
                  child: Image.asset(
                    'assets/images/packages_page/tiara_package.png',
                    width: imageWidth,
                  ),
                ),
                SizedBox(height: isTablet ? 25 : 15),

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
                SizedBox(height: isTablet ? 25 : 15),

                GestureDetector(
                  onTap: () => _showPackageInfo(
                    context,
                    'assets/images/packages_page/crown_asset.png',
                    'Crown Package',
                    'Php 250',
                    'Unveil the mysteries of your soul. '
                        'Our most powerful reading yet — the Crown Package is for those who seek the truth beneath the veil. '
                        'With 8 tarot cards and 5 oracle cards, you will receive layered insight, deep spiritual guidance, and answers to the questions you have been afraid to ask. '
                        'Perfect for major life decisions, shadow work, or diving into your soul\'s journey. '
                        'Let the Empress herself guide your destiny. 🌙✨',
                  ),
                  child: Image.asset(
                    'assets/images/packages_page/crown_package.png',
                    width: imageWidth,
                  ),
                ),
                SizedBox(height: isTablet ? 40 : 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}