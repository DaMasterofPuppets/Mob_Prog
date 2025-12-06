import 'package:flutter/material.dart';
import 'package:tarot_app/screens/dashboard/reader_page.dart';

class ReadersPage extends StatelessWidget {
  const ReadersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    const gold = Color(0xFFE1A948);
    const maroon = Color(0xFF420309);

    return Scaffold(
      backgroundColor: maroon,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                isTablet ? 40.0 : 24.0,
                isTablet ? 100 : 80,
                isTablet ? 40.0 : 24.0,
                isTablet ? 40 : 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top section
                  Column(
                    children: [
                      Text(
                        'Pick from our selection of talented\nreaders',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: isTablet ? 24 : 18,
                          height: 1.4,
                          fontFamily: 'PlayfairDisplay',
                        ),
                      ),
                      SizedBox(height: isTablet ? 24 : 18),
                      Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: isTablet ? 600 : double.infinity,
                          ),
                          child: GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TheReaderPage())),
                            child: Container(
                              padding: EdgeInsets.all(isTablet ? 18 : 14),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4B0B09),
                                borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                                border: Border.all(color: gold, width: isTablet ? 3 : 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.45),
                                    blurRadius: isTablet ? 16 : 14,
                                    offset: Offset(0, isTablet ? 10 : 10),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(isTablet ? 14 : 12),
                                    child: Image.asset(
                                      'assets/images/reader_page/the_reader_face.png',
                                      width: isTablet ? 220 : 210,
                                      height: isTablet ? 220 : 210,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: isTablet ? 20 : 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Deni',
                                          style: TextStyle(
                                            color: gold,
                                            fontSize: isTablet ? 38 : 28,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'PlayfairDisplay',
                                          ),
                                        ),
                                        SizedBox(height: isTablet ? 10 : 8),
                                        Container(height: 1, color: gold.withOpacity(0.15)),
                                        SizedBox(height: isTablet ? 12 : 10),
                                        Text(
                                          'The founder of Empress Reads. With eight years of experience, she has specialized in love readings.',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: isTablet ? 18 : 13.5,
                                            height: 1.3,
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
                        ),
                      ),
                    ],
                  ),

                  // Middle section - divider
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
                        child: Text('✦', style: TextStyle(color: gold, fontSize: isTablet ? 24 : 18)),
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

                  // Bottom section
                  Column(
                    children: [
                      Text(
                        'Join Our Reader Network',
                        style: TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          fontSize: isTablet ? 36 : 24,
                          fontWeight: FontWeight.bold,
                          color: gold,
                          letterSpacing: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: isTablet ? 16 : 12),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? screenWidth * 0.15 : 0,
                        ),
                        child: Text(
                          'We\'re seeking experienced tarot card readers to join our platform and share their gifts with our community.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            fontSize: isTablet ? 18 : 15,
                            color: Colors.white,
                            height: 1.5,
                          ),
                        ),
                      ),
                      SizedBox(height: isTablet ? 20 : 16),
                      SizedBox(
                        height: isTablet ? 140 : 120,
                        child: Image.asset(
                          'assets/images/reader_page/reader_art.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: isTablet ? 20 : 16),
                      ElevatedButton(
                        onPressed: () {
                          showJoinPopup(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: gold,
                          foregroundColor: maroon,
                          padding: EdgeInsets.symmetric(
                            horizontal: isTablet ? 60 : 50,
                            vertical: isTablet ? 20 : 16,
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
                            fontSize: isTablet ? 22 : 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Back button + "The Reader" title - upper left
            Positioned(
              top: 12,
              left: 12,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: isTablet ? 56 : 48,
                        height: isTablet ? 56 : 48,
                        decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                        child: Icon(
                          Icons.arrow_back,
                          color: Color(0xFFE1A948),
                          size: isTablet ? 28 : 24,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: isTablet ? 16 : 12),
                  Text(
                    'The Reader',
                    style: TextStyle(
                      color: Color(0xFFE1A948),
                      fontSize: isTablet ? 48 : 36,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'PlayfairDisplay',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showJoinPopup(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isTablet = screenWidth > 600;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(
          horizontal: isTablet ? 120 : 40,
          vertical: isTablet ? 80 : 24
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 32 : 20,
            vertical: isTablet ? 32 : 22
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF450003),
            borderRadius: BorderRadius.circular(isTablet ? 20 : 16),
            border: Border.all(
              color: Color(0xFFE1A948),
              width: isTablet ? 4 : 3
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: isTablet ? 90 : 64,
                fit: BoxFit.contain
              ),
              SizedBox(height: isTablet ? 18 : 12),
              Text(
                'Join Our Reader Network',
                style: TextStyle(
                  color: Color(0xFFE1A948),
                  fontSize: isTablet ? 28 : 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
              SizedBox(height: isTablet ? 18 : 12),
              Text(
                'In order to join please contact us at\nc202301060@iacademy.edu.ph',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTablet ? 18 : 14,
                ),
              ),
              SizedBox(height: isTablet ? 24 : 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xFFE1A948),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(
                      vertical: isTablet ? 16 : 12
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(isTablet ? 12 : 10)
                    ),
                  ),
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isTablet ? 20 : 16,
                    )
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