import 'package:flutter/material.dart';
import 'testimonials_page.dart';

class TheReaderPage extends StatelessWidget {
  const TheReaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color maroon = const Color(0xFF420309);
    final Color gold = Color(0xFFE1A948);
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;
    final isTablet = screenWidth >= 600;
    
    // Max content width for large screens
    final maxContentWidth = isTablet ? 1000.0 : double.infinity;

    return Scaffold(
      backgroundColor: maroon,
      body: SafeArea(
        child: Center(
          child: Container(
            width: screenWidth > maxContentWidth ? maxContentWidth : screenWidth,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button + Title (row)
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
                          'The Reader',
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

                  SizedBox(height: isTablet ? 10 : 8),

                  // Photo with drop shadow
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: isTablet ? 450 : 350,
                          width: isTablet ? screenWidth * 0.5 : screenWidth * 0.85,
                          child: Image.asset(
                            'assets/images/reader_page/the_reader_face.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Name "Deni"
                  Center(
                    child: Text(
                      'Deni',
                      style: TextStyle(
                        fontFamily: 'LuxuriousScript',
                        fontSize: isTablet ? 110 : 95,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        letterSpacing: 3,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(5, 5),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Decorative divider (centered and limited width)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? screenWidth * 0.15 : 24.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Divider(color: gold.withOpacity(0.5), thickness: 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            '✨',
                            style: TextStyle(fontSize: isTablet ? 22 : 18),
                          ),
                        ),
                        Expanded(child: Divider(color: gold.withOpacity(0.5), thickness: 1)),
                      ],
                    ),
                  ),

                  // small gap before bio
                  SizedBox(height: isTablet ? 10 : 6),

                  // Bio text
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? screenWidth * 0.15 : 24.0,
                    ),
                    child: Text(
                      'With eight years of devoted experience in tarot reading, Deniella specializes in matters of the heart. As a third-year Software Engineering student, she weaves ancient wisdom with modern insight, offering seekers clarity and guidance on their unique love journeys.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: isTablet ? 20 : 16,
                        color: Colors.white,
                        height: 1.7,
                      ),
                    ),
                  ),

                  SizedBox(height: isTablet ? 35 : 25),

                  // Description with emojis
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? screenWidth * 0.15 : 24.0,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(isTablet ? 32 : 24),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: gold.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        '🌙✨ Welcome, dear soul. The universe brought you here for a reason. Whether your heart is full of questions, quietly healing, or bursting with hope, the cards are ready to reveal what you need to hear. Through intuition, energy, and the sacred language of tarot, I offer love-focused guidance tailored just for you.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          fontSize: isTablet ? 20 : 16,
                          color: Colors.white,
                          height: 1.7,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: isTablet ? 35 : 25),
                  
                  // Testimonials section - Text and Image
                  Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isTablet ? 700 : 340,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // LEFT SIDE — stacked text
                          Flexible(
                            flex: isTablet ? 3 : 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Want to hear from my\nclients?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'PlayfairDisplay',
                                    color: Colors.white,
                                    fontSize: isTablet ? 32 : 20,
                                    height: 1.3,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Click on the card!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'PlayfairDisplay',
                                    color: Colors.white,
                                    fontSize: isTablet ? 28 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: isTablet ? 40 : 26),

                          // RIGHT SIDE — tarot card image
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TestimonialsPage()),
                              );
                            },
                            child: Container(
                              height: isTablet ? 280 : 185,
                              width: isTablet ? 200 : 130,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(2),
                                child: Image.asset(
                                  'assets/images/dashboard_page/the_testimonies.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: isTablet ? 60 : 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}