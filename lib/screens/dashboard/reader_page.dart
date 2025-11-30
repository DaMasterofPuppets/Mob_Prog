import 'package:flutter/material.dart';

class TheReaderPage extends StatelessWidget {
  const TheReaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color maroon = const Color(0xFF420309);
    final Color gold = Color(0xFFE1A948);
    
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;

    return Scaffold(
      backgroundColor: maroon,
      body: SafeArea(
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
                      width: isTablet ? screenWidth * 0.7 : double.infinity,
                      child: Image.asset(
                        'assets/images/reader_page/the_reader_face.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),

              // Name "Deni"
              SizedBox(height: isTablet ? 10 : 8),
              Center(
                child: Text(
                  'Deni',
                  style: TextStyle(
                    fontFamily: 'LuxuriousScript',
                    fontSize: isTablet ? 110 : 95, // keep it large and pretty
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

              // <-- TIGHTENED SPACING HERE -->
              SizedBox(height: isTablet ? 6 : 6),

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
                    fontSize: isTablet ? 18 : 16,
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
                      fontSize: isTablet ? 18 : 16,
                      color: Colors.white,
                      height: 1.7,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),

              SizedBox(height: isTablet ? 50 : 40),

              // Hiring Section
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? screenWidth * 0.15 : 24.0,
                ),
                child: Column(
                  children: [
                    // Decorative divider
                    Row(
                      children: [
                        Expanded(child: Divider(color: gold.withOpacity(0.5), thickness: 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '🪞',
                            style: TextStyle(fontSize: isTablet ? 24 : 20),
                          ),
                        ),
                        Expanded(child: Divider(color: gold.withOpacity(0.5), thickness: 1)),
                      ],
                    ),
                    
                    SizedBox(height: isTablet ? 35 : 25),
                    
                    // Hiring heading
                    Text(
                      'Join Our Reader Network',
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: isTablet ? 32 : 26,
                        fontWeight: FontWeight.bold,
                        color: gold,
                        letterSpacing: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    SizedBox(height: isTablet ? 20 : 15),
                    
                    // Hiring description
                    Text(
                      'We\'re seeking experienced tarot card readers to join our platform and share their gifts with our community. If you\'re a skilled reader with a passion for helping others find clarity and guidance, we\'d love to feature you in our app.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: isTablet ? 18 : 16,
                        color: Colors.white,
                        height: 1.7,
                      ),
                    ),
                    
                    // Reader Art Image
                    SizedBox(
                      width: isTablet ? screenWidth * 0.4 : screenWidth * 0.6,
                      child: Image.asset(
                        'assets/images/reader_page/reader_art.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    
                    SizedBox(height: isTablet ? 35 : 30),
                    
                    // Apply button
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Application page coming soon! Stay tuned.'),
                            backgroundColor: gold,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: gold,
                        foregroundColor: maroon,
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 60 : 50,
                          vertical: isTablet ? 20 : 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 8,
                      ),
                      child: Text(
                        'Apply to Join',
                        style: TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          fontSize: isTablet ? 22 : 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: isTablet ? 60 : 50),
            ],
          ),
        ),
      ),
    );
  }
}
