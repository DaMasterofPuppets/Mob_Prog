import 'package:flutter/material.dart';
import 'package:tarot_app/screens/dashboard/reader_page.dart';

class ReadersPage extends StatelessWidget {
  const ReadersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = 24.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    const gold = Color(0xFFE1A948);
    const maroon = Color(0xFF420309);

    return Scaffold(
      backgroundColor: maroon,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(horizontalPadding, 28 + 48, horizontalPadding, 40),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    const _Header(),
                    const SizedBox(height: 18),
                    const Text(
                      'Pick from our selection of talented\nreaders',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        height: 1.4,
                        fontFamily: 'PlayfairDisplay',
                      ),
                    ),
                    const SizedBox(height: 18),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TheReaderPage())),
                      child: Container(
                        margin: const EdgeInsets.only(top: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4B0B09),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: gold, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.45),
                              blurRadius: 14,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/images/reader_page/the_reader_face.png',
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Deni',
                                    style: TextStyle(
                                      color: gold,
                                      fontSize: 28,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'PlayfairDisplay',
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(height: 1, color: gold.withOpacity(0.15)),
                                  const SizedBox(height: 12),
                                  const Text(
                                    'The founder of Empress Reads. With eight years of experience, she has specialized in love readings.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.5,
                                      height: 1.4,
                                      fontFamily: 'PlayfairDisplay',
                                    ),
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [gold.withOpacity(0.0), gold.withOpacity(0.85)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text('✦', style: TextStyle(color: gold, fontSize: isTablet ? 22 : 18)),
                        ),
                        Expanded(
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [gold.withOpacity(0.85), gold.withOpacity(0.0)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 35),

                    Text(
                      'Join Our Reader Network',
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: isTablet ? 36 : 26,
                        fontWeight: FontWeight.bold,
                        color: gold,
                        letterSpacing: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: isTablet ? 20 : 15),

                    Text(
                      'We\'re seeking experienced tarot card readers to join our platform and share their gifts with our community. If you\'re a skilled reader with a passion for helping others find clarity and guidance, we\'d love to feature you in our app.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: isTablet ? 20 : 16,
                        color: Colors.white,
                        height: 1.7,
                      ),
                    ),

                    SizedBox(height: isTablet ? 30 : 20),

                    SizedBox(
                      width: isTablet ? screenWidth * 0.25 : screenWidth * 0.55,
                      child: Image.asset(
                        'assets/images/reader_page/reader_art.png',
                        fit: BoxFit.contain,
                      ),
                    ),

                    SizedBox(height: isTablet ? 35 : 30),

                    ElevatedButton(
                      onPressed: () {
                        showJoinPopup(context);
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

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 12,
              left: 12,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_back, color: Color(0xFFE1A948)),
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

void showJoinPopup(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          decoration: BoxDecoration(
            color: const Color(0xFF450003),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: Color(0xFFE1A948), width: 3.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/logo.png', height: 64, fit: BoxFit.contain),
              const SizedBox(height: 12),
              const Text(
                'Join Our Reader Network',
                style: TextStyle(
                  color: Color(0xFFE1A948),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'In order to join please contact us at\nc202301060@iacademy.edu.ph',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xFFE1A948),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('OK', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        SizedBox(width: 64),
        Expanded(
          child: Text(
            'The Reader',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFE1A948),
              fontSize: 36,
              fontWeight: FontWeight.w600,
              fontFamily: 'PlayfairDisplay',
            ),
          ),
        ),
        SizedBox(width: 64),
      ],
    );
  }
}
