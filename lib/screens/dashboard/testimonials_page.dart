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
      'desc': 'I never believed in tarot readings and honestly thought they were a scam, but the things she brought up have already come true and it still shocks me. She’s incredibly accurate, warm, and genuine — I highly recommend her to anyone who needs clarity.',
      'image': 'assets/images/testimonies_page/user2_sammy.png'
    },
    {
      'name': 'Summer Menchavez',
      'desc': 'One of the best tarot readings I’ve gotten. You can never go wrong with their predictions, almost all readings came true! Even those I didnt think were true, were eventually revealed to be the true later on! 10/10 experience !',
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

    return Scaffold(
      backgroundColor: maroon,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView( // ✅ Added to prevent vertical overflow
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back + title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Color(0xFFE1A948)),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Testimonials',
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

                  const SizedBox(height: 10),

                  // Bigger banner
                  Container(
                    height: MediaQuery.of(context).size.height * 0.28,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/testimonies_page/banner.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Carousel
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.50, // ✅ bounded height so it doesn't overflow
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: testimonials.length,
                        onPageChanged: (index) {
                          setState(() => _currentIndex = index);
                        },
                        itemBuilder: (context, index) {
                          final item = testimonials[index];
                          return AnimatedBuilder(
                            animation: _pageController,
                            builder: (context, child) {
                              double scale = 1.0;
                              if (!_pageController.hasClients || !_pageController.position.haveDimensions) {
                                scale = 1.0;
                              } else {
                                scale = (_pageController.page! - index).abs();
                                scale = (1 - (scale * 0.2)).clamp(0.85, 1.0);
                              }
                              return Transform.scale(
                                scale: scale,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: gold,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: SingleChildScrollView( // ✅ added to handle long text inside card
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if (item['image'] != null)
                                          CircleAvatar(
                                            radius: 50,
                                            backgroundImage: AssetImage(item['image']!),
                                            backgroundColor: Colors.transparent,
                                          ),
                                        const SizedBox(height: 7),
                                        Text(
                                          item['name']!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'PlayfairDisplay',
                                            color: maroon,
                                          ),
                                        ),
                                        const SizedBox(height: 7),
                                        Text(
                                          item['desc']!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'PlayfairDisplay',
                                            color: maroon,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),

                  // Dots indicator
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: testimonials.asMap().entries.map((entry) {
                        return Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
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

            // Arrows wrapped in circle
            Positioned(
              left: 10,
              top: MediaQuery.of(context).size.height * 0.60,
              child: Container(
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
                child: IconButton(
                  iconSize: 28,
                  icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFE1A948)),
                  onPressed: _previousPage,
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: MediaQuery.of(context).size.height * 0.60,
              child: Container(
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
                child: IconButton(
                  iconSize: 28,
                  icon: const Icon(Icons.arrow_forward_ios, color: Color(0xFFE1A948)),
                  onPressed: _nextPage,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
