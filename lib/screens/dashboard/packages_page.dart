import 'package:flutter/material.dart';

class PackagesPage extends StatelessWidget {
  const PackagesPage({super.key});

  void _showPackageInfo(BuildContext context, String imagePath, String title, String price, String description) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;
    final Color gold = const Color(0xFFE1A948);
    
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 600 : screenWidth * 0.9,
              maxHeight: isTablet ? 700 : screenWidth * 1.4,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF420309),
                  const Color(0xFF2a0206),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: gold.withOpacity(0.5),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: gold.withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Stack(
              children: [
                // Main content
                Padding(
                  padding: EdgeInsets.all(isTablet ? 40 : 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Top Image with shadow
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 15,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          imagePath,
                          height: title.contains('Crown') 
                              ? (isTablet ? 150 : 120)
                              : (isTablet ? 100 : 80),
                        ),
                      ),
                      
                      SizedBox(height: isTablet ? 20 : 15),

                      // Decorative divider
                      Container(
                        width: isTablet ? 100 : 80,
                        height: 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              gold,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      
                      SizedBox(height: isTablet ? 20 : 15),

                      // Title
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'LuxuriousScript',
                          fontSize: isTablet ? 56 : 48,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: isTablet ? 15 : 12),

                      // Price container
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 30 : 24,
                          vertical: isTablet ? 10 : 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: gold.withOpacity(0.4),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          price,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: gold,
                            fontSize: isTablet ? 24 : 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'PlayfairDisplay',
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: isTablet ? 20 : 15),

                      // Description with container
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.all(isTablet ? 20 : 16),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: gold.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Text(
                              description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.95),
                                fontSize: isTablet ? 16 : 14,
                                fontFamily: 'PlayfairDisplay',
                                height: 1.6,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Close button
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: gold,
                      size: isTablet ? 30 : 26,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black.withOpacity(0.5),
                    ),
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
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth >= 600;
    final isLandscape = screenWidth > screenHeight;

    return Scaffold(
      backgroundColor: const Color(0xFF420309),
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 32.0 : 16.0,
                vertical: isTablet ? 16 : 8,
              ),
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
                  SizedBox(width: isTablet ? 24 : 16),
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

            // Content - expanded to fill remaining space
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 60 : 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      'Choose your package',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'LuxuriousScript',
                        fontSize: isLandscape ? (isTablet ? 75 : 53) : (isTablet ? 60 : 44),
                        color: gold,
                      ),
                    ),
                    
                    SizedBox(height: isLandscape ? (isTablet ? 10 : 15) : (isTablet ? 9 : 5)),
                    
                    // Description
                    Text(
                      'Discover the different prices and reading offers from our readers',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: isLandscape ? (isTablet ? 25 : 21) : (isTablet ? 21 : 19),
                        color: Colors.white.withOpacity(0.9),
                        height: 1.5,
                      ),
                    ),
                    
                    SizedBox(height: isLandscape ? (isTablet ? 60 : 25) : (isTablet ? 25 : 15)),
                          
                    // Package cards - switch between vertical and horizontal based on orientation
                    if (isLandscape)
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: _buildPackageCard(
                                context,
                                'assets/images/packages_page/tiara_package.png',
                                'assets/images/packages_page/tiara_asset.png',
                                'Tiara Package',
                                'Php 100',
                                'The Tiara Package is simple, direct, and clear. With 4 tarot cards, it offers a quick snapshot of your current situation and answers one focused question. Ideal for beginners or anyone needing fast, straightforward insight. 🌟💭',
                                isTablet,
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: _buildPackageCard(
                                context,
                                'assets/images/packages_page/coronet_package.png',
                                'assets/images/packages_page/coronet_asset.png',
                                'Coronet Package',
                                'Php 150',
                                'The Coronet Package sits at the middle ground between the depth of the Crown Package and the simplicity of the Tiara Package. With 5 tarot cards and 3 oracle cards, it offers clear guidance without overwhelming detail — a balanced choice for those who want insight with ease. 💖🔮',
                                isTablet,
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: _buildPackageCard(
                                context,
                                'assets/images/packages_page/crown_package.png',
                                'assets/images/packages_page/crown_asset.png',
                                'Crown Package',
                                'Php 250',
                                'Discover deeper clarity with the Crown Package. This 8-card tarot and 5-card oracle reading offers thoughtful insight for major decisions, personal growth, and understanding what lies beneath the surface. A grounded, honest guide for those seeking direction. 👑✨',
                                isTablet,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: _buildPackageCard(
                                context,
                                'assets/images/packages_page/tiara_package.png',
                                'assets/images/packages_page/tiara_asset.png',
                                'Tiara Package',
                                'Php 100',
                                'The Tiara Package is simple, direct, and clear. With 4 tarot cards, it offers a quick snapshot of your current situation and answers one focused question. Ideal for beginners or anyone needing fast, straightforward insight. 🌟💭',
                                isTablet,
                              ),
                            ),
                            SizedBox(height: isTablet ? 15 : 10),
                            Flexible(
                              child: _buildPackageCard(
                                context,
                                'assets/images/packages_page/coronet_package.png',
                                'assets/images/packages_page/coronet_asset.png',
                                'Coronet Package',
                                'Php 150',
                                'The Coronet Package sits at the middle ground between the depth of the Crown Package and the simplicity of the Tiara Package. With 5 tarot cards and 3 oracle cards, it offers clear guidance without overwhelming detail — a balanced choice for those who want insight with ease. 💖🔮',
                                isTablet,
                              ),
                            ),
                            SizedBox(height: isTablet ? 15 : 10),
                            Flexible(
                              child: _buildPackageCard(
                                context,
                                'assets/images/packages_page/crown_package.png',
                                'assets/images/packages_page/crown_asset.png',
                                'Crown Package',
                                'Php 250',
                                'Discover deeper clarity with the Crown Package. This 8-card tarot and 5-card oracle reading offers thoughtful insight for major decisions, personal growth, and understanding what lies beneath the surface. A grounded, honest guide for those seeking direction. 👑✨',
                                isTablet,
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    SizedBox(height: isTablet ? 30 : 15),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageCard(
    BuildContext context,
    String imagePath,
    String assetPath,
    String title,
    String price,
    String description,
    bool isTablet,
  ) {
    return GestureDetector(
      onTap: () => _showPackageInfo(context, assetPath, title, price, description),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 15,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}