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
      'desc': 'I was honestly skeptical at first, but the tarot reading gave me so much clarity. I left feeling lighter and more hopeful.',
      'image': 'assets/images/ava.png'
    },
    {
      'name': 'Sam Canlas',
      'desc': 'Booking through the app was so smooth! It’s like having a spiritual guide right at your fingertips.',
      'image': 'assets/images/sammy.png'
    },
    {
      'name': 'Stinky Binky',
      'desc': 'The staff made me feel completely at ease. It felt like I was talking to old friends.',
      'image': 'assets/images/binky.png'
    },
    {
      'name': 'Hermione Ching',
      'desc': 'I’m new to tarot but they explained everything patiently. I left with a new perspective.',
      'image': 'assets/images/hermione.png'
    },
    {
      'name': 'Chubi',
      'desc': 'My reading touched on things I hadn’t voiced out loud. Healing in ways I can’t explain.',
      'image': 'assets/images/chubi.png'
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
    final Color gold = const Color(0xFFFFB84D);

    return Scaffold(
      backgroundColor: maroon,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
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
                          icon: const Icon(Icons.arrow_back, color: Colors.amber),
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
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/testimonialsbanner.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Carousel
                Expanded(
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (item['image'] != null)
                                      CircleAvatar(
                                        radius: 80,
                                        backgroundImage: AssetImage(item['image']!),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    const SizedBox(height: 18),
                                    Text(
                                      item['name']!,
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'PlayfairDisplay',
                                        color: maroon,
                                      ),
                                    ),
                                    const SizedBox(height: 14),
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
                      offset: Offset(2, 2),
                    )
                  ],
                ),
                child: IconButton(
                  iconSize: 28,
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.amber),
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
                      offset: Offset(2, 2),
                    )
                  ],
                ),
                child: IconButton(
                  iconSize: 28,
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.amber),
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
