import 'package:flutter/material.dart';

class PackagesPage extends StatelessWidget {
  const PackagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF420309),
      appBar: AppBar(
        backgroundColor: const Color(0xFF420309),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: CircleAvatar(
            backgroundColor: Colors.black,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.amber),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Choose your package',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'PlayfairDisplay', 
                fontSize: 35,                   
                color: Color(0xFFE5A94E),       
              ),
            ),
            const SizedBox(height: 30),

            // Package images stacked
            Image.asset('assets/images/Packages-Page/Tiara_Package.png'),
            const SizedBox(height: 20),
            Image.asset('assets/images/Packages-Page/Coronet_Package.png'),
            const SizedBox(height: 20),
            Image.asset('assets/images/Packages-Page/Crown_Package.png'),
          ],
        ),
      ),
    );
  }
}
