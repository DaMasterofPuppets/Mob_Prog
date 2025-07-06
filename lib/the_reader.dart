import 'package:flutter/material.dart';

void main() {
  runApp(const ReaderApp());
}

class ReaderApp extends StatelessWidget {
  const ReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ReaderPage(),
    );
  }
}

class ReaderPage extends StatelessWidget {
  const ReaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF560000), // deep maroon
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Back Button
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 5),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 28,
                        child: Icon(Icons.arrow_back, color: Colors.amber, size: 28),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Framed Image
              SizedBox(
                height: 350,
                child: Image.asset(
                  'assets/the_reader.png',
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 5),

              // Title - The Reader
              Text(
                'The Reader',
                style: const TextStyle(
                  fontFamily: 'LuxuriousScript',
                  fontSize: 70,
                  color: Color(0xFFE5A94E),
                ),
              ),

              const SizedBox(height: 5),

              // Intro Text
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Text(
                  'Hello! My name is Deni and I’m a 2nd year SE student. I have 8 years of tarot card reading experience, and I specialize in love readings!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 18,
                    color: Colors.white,
                    height: 1.6,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Description
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Text(
                  '🌙✨ Welcome, dear soul. The universe brought you here for a reason. Whether your heart is full of questions, quietly healing, or bursting with hope, the cards are ready to reveal what you need to hear. Through intuition, energy, and the sacred language of tarot, I offer love-focused guidance tailored just for you.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 18,
                    color: Colors.white,
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
