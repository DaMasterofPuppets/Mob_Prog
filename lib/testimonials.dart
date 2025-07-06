import 'package:flutter/material.dart';

class TestimonialsPage extends StatefulWidget {
  const TestimonialsPage({super.key});

  @override
  State<TestimonialsPage> createState() => _TestimonialsPageState();
}

class _TestimonialsPageState extends State<TestimonialsPage> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentIndex = 0;

  final List<Map<String, String>> testimonials = [
    {
      'name': 'Ava Suarez',
      'desc': 'Came to tarot reading and it was an amazing experience.'
    },
    {
      'name': 'Samantha Canlas',
      'desc': 'The app just made tarot reading easier.'
    },
    {
      'name': 'Paul John Torral',
      'desc': 'The staff were so friendly and accommodating.'
    },
    {
      'name': 'Kristel Timtim',
      'desc': 'Highly recommended for beginners.'
    },
    {
      'name': 'Spyke Matthew Lim',
      'desc': 'I learned so much about myself through this reading.'
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
    return Scaffold(
      backgroundColor: const Color(0xFF450009),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button and title
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                  const Text(
                    'Testimonials',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                      fontFamily: 'PlayfairDisplay',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Stack(
                children: [
                  PageView.builder(
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
                          if (_pageController.position.haveDimensions) {
                            scale = (_pageController.page! - index).abs();
                            scale = (1 - (scale * 0.3)).clamp(0.8, 1.0);
                          }
                          return Transform.scale(
                            scale: scale,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFB84D),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    item['name']!,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'PlayfairDisplay',
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    item['desc']!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'PlayfairDisplay',
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

                  // Left arrow
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        iconSize: 48,
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.amber),
                        onPressed: _previousPage,
                      ),
                    ),
                  ),

                  // Right arrow
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        iconSize: 48,
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.amber),
                        onPressed: _nextPage,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Dots indicator
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
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
                          ? Colors.amber
                          : Colors.amber.withOpacity(0.4),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
