import 'package:flutter/material.dart';

class TheReaderPage extends StatelessWidget {
  const TheReaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color maroon = const Color(0xFF420309);
    final Color gold = Color(0xFFE1A948);
    
    // Get screen width for responsive design
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

              SizedBox(height: isTablet ? 20 : 10),

              // Framed Image - responsive sizing
              Center(
                child: SizedBox(
                  height: isTablet ? 450 : 350,
                  width: isTablet ? screenWidth * 0.7 : double.infinity,
                  child: Image.asset(
                    'assets/images/reader_page/the_reader_face.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              SizedBox(height: isTablet ? 30 : 20),

              // Intro Text
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? screenWidth * 0.15 : 24.0,
                ),
                child: Text(
                  'Hello! My name is Deni and I\'m a 2nd year SE student. I have 8 years of tarot card reading experience, and I specialize in love readings!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 18,
                    color: Colors.white,
                    height: 1.6,
                  ),
                ),
              ),

              SizedBox(height: isTablet ? 35 : 25),

              // Description
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? screenWidth * 0.15 : 24.0,
                ),
                child: Text(
                  '🌙✨ Welcome, dear soul. The universe brought you here for a reason. Whether your heart is full of questions, quietly healing, or bursting with hope, the cards are ready to reveal what you need to hear. Through intuition, energy, and the sacred language of tarot, I offer love-focused guidance tailored just for you.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 18,
                    color: Colors.white,
                    height: 1.6,
                  ),
                ),
              ),

              SizedBox(height: isTablet ? 40 : 30),

              // Apprentice Section
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
                            '✨',
                            style: TextStyle(fontSize: isTablet ? 24 : 20),
                          ),
                        ),
                        Expanded(child: Divider(color: gold.withOpacity(0.5), thickness: 1)),
                      ],
                    ),
                    
                    SizedBox(height: isTablet ? 30 : 20),
                    
                    // Apprentice heading
                    Text(
                      'Seeking Apprentices',
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: isTablet ? 28 : 24,
                        fontWeight: FontWeight.bold,
                        color: gold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    SizedBox(height: isTablet ? 20 : 15),
                    
                    // Apprentice description
                    Text(
                      'Are you drawn to the mystical arts? Do you feel the call to learn tarot reading? I\'m currently accepting apprentices who are eager to explore the sacred wisdom of the cards. Join me on this spiritual journey and discover your own intuitive gifts.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: 16,
                        color: Colors.white,
                        height: 1.6,
                      ),
                    ),
                    
                    SizedBox(height: isTablet ? 30 : 25),
                    
                    // Apply button
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Navigate to apprentice application page
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const ApprenticeApplicationPage(),
                        //   ),
                        // );
                        
                        // Temporary message while page is being created
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Application page coming soon!'),
                            backgroundColor: gold,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: gold,
                        foregroundColor: maroon,
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 48 : 40,
                          vertical: isTablet ? 18 : 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 8,
                      ),
                      child: Text(
                        'Apply Now',
                        style: TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          fontSize: isTablet ? 20 : 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: isTablet ? 50 : 40),
            ],
          ),
        ),
      ),
    );
  }
}