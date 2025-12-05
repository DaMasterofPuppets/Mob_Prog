import 'package:flutter/material.dart';

class TestimonialsPage extends StatefulWidget {
  const TestimonialsPage({super.key});

  @override
  State<TestimonialsPage> createState() => _TestimonialsPageState();
}

class _TestimonialsPageState extends State<TestimonialsPage> {
  final PageController _pageController = PageController(viewportFraction: 0.7);
  int _currentIndex = 0;

  final List<Map<String, String>> testimonials = [
    {
      'name': 'Ava Suarez',
      'desc': 'I love getting readings from her! She is very easy to talk to and answers the follow-up questions I ask. Would get tarot readings from her again!.',
      'image': 'assets/images/testimonies_page/user1_ava.png'
    },
    {
      'name': 'Sam Canlas',
      'desc': 'I never believed in tarot readings and honestly thought they were a scam, but the things she brought up have already come true and it still shocks me. She\'s incredibly accurate, warm, and genuine — I highly recommend her to anyone who needs clarity.',
      'image': 'assets/images/testimonies_page/user2_sammy.png'
    },
    {
      'name': 'Summer Menchavez',
      'desc': 'One of the best tarot readings I\'ve gotten. You can never go wrong with their predictions, almost all readings came true! Even those I didnt think were true, were eventually revealed to be the true later on! 10/10 experience !',
      'image': 'assets/images/testimonies_page/user3_summer.png'
    },
    {
      'name': 'Aaron Ybanez',
      'desc': 'Her tarot reading service is quite entertaining at the same time very thoughtful and knowledgeable. The service was nothing short of outstanding that I never feel discomfort. Overall excellent tarot reading service would comeback ❤',
      'image': 'assets/images/testimonies_page/user4_aaron.png'
    },
    {
      'name': 'Shawn Dubouzet',
      'desc': 'Everytime I have had a reading from her lowkey scared me with how accurate she was. The way I gasped when I realized how her readings slowly fell into place. In fact, everything she has mentioned actually did happen this year!',
      'image': 'assets/images/testimonies_page/user5_shawn.png'
    },
  ];

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void _nextPage() {
    if (_currentIndex < testimonials.length - 1) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color maroon = const Color(0xFF420309);
    final Color gold = const Color(0xFFE1A948);
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;
    final isTablet = screenWidth >= 600;

    // Responsive sizing
    final bannerHeight = isLandscape 
        ? screenHeight * 0.35 
        : (isTablet ? screenHeight * 0.20 : screenHeight * 0.28);
    
    final carouselHeight = isLandscape 
        ? screenHeight * 0.48 
        : (isTablet ? screenHeight * 0.55 : screenHeight * 0.50);
    
    final arrowTopPosition = isLandscape 
        ? screenHeight * 0.50 
        : screenHeight * 0.60;

    final titleFontSize = isTablet ? 40.0 : 32.0;
    final avatarRadius = isTablet ? 60.0 : 50.0;
    final nameFontSize = isTablet ? 28.0 : 25.0;
    final descFontSize = isTablet ? 18.0 : 16.0;

    // Max content width for large screens
    final maxContentWidth = isTablet ? 1200.0 : double.infinity;

    return Scaffold(
      backgroundColor: maroon,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Container(
                width: screenWidth > maxContentWidth ? maxContentWidth : screenWidth,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back + title
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 24.0 : 16.0, 
                          vertical: isLandscape ? 4 : 8
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: isTablet ? 24 : 20,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back, 
                                  color: gold,
                                  size: isTablet ? 24 : 20,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            SizedBox(width: isTablet ? 20 : 16),
                            Text(
                              'Testimonials',
                              style: TextStyle(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'PlayfairDisplay',
                                color: gold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: isLandscape ? 5 : 10),

                      // Banner
                      Container(
                        height: bannerHeight,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/testimonies_page/banner.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      SizedBox(height: isLandscape ? 5 : 10),

                      // Carousel
                      SizedBox(
                        height: carouselHeight,
                        child: Padding(
                          padding: EdgeInsets.only(top: isLandscape ? 5 : 10),
                          child: PageView.builder(
                            key: const ValueKey('testimonials_pageview'),
                            controller: _pageController,
                            itemCount: testimonials.length,
                            onPageChanged: (index) {
                              setState(() => _currentIndex = index);
                            },
                            itemBuilder: (context, index) {
                              final item = testimonials[index];
                              return Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: isTablet ? 12 : 8, 
                                  vertical: isTablet ? 18 : 14
                                ),
                                padding: EdgeInsets.all(isTablet ? 28 : 20),
                                decoration: BoxDecoration(
                                  color: gold,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (item['image'] != null)
                                        CircleAvatar(
                                          radius: avatarRadius,
                                          backgroundImage: AssetImage(item['image']!),
                                          backgroundColor: Colors.transparent,
                                        ),
                                      SizedBox(height: isTablet ? 10 : 7),
                                      Text(
                                        item['name']!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: nameFontSize,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'PlayfairDisplay',
                                          color: maroon,
                                        ),
                                      ),
                                      SizedBox(height: isTablet ? 10 : 7),
                                      Text(
                                        item['desc']!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: descFontSize,
                                          fontFamily: 'PlayfairDisplay',
                                          color: maroon,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      // Dots indicator
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: isLandscape ? 8 : 14, 
                          top: isLandscape ? 4 : 8
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: testimonials.asMap().entries.map((entry) {
                            return Container(
                              width: isTablet ? 12 : 10,
                              height: isTablet ? 12 : 10,
                              margin: EdgeInsets.symmetric(horizontal: isTablet ? 5 : 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentIndex == entry.key
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.4),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Left Arrow
            Positioned(
              left: isLandscape ? 30 : (isTablet ? 40 : 20),
              top: arrowTopPosition,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _previousPage,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: isTablet ? 56 : 48,
                    height: isTablet ? 56 : 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: maroon,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        )
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: gold,
                      size: isTablet ? 28 : 24,
                    ),
                  ),
                ),
              ),
            ),
            
            // Right Arrow
            Positioned(
              right: isLandscape ? 30 : (isTablet ? 40 : 20),
              top: arrowTopPosition,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _nextPage,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: isTablet ? 56 : 48,
                    height: isTablet ? 56 : 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: maroon,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        )
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: gold,
                      size: isTablet ? 28 : 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}