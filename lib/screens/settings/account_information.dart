import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({super.key});

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  File? _image; // Holds selected image temporarily

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _image = File(picked.path); // Update state with new image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF420309),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFFFFD700)),
                onPressed: () => Navigator.pop(context),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: const CircleBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Account Settings',
              style: TextStyle(
                fontFamily: 'PlayfairDisplay',
                fontSize: 34,
                color: Color(0xFFFFD700),
              ),
            ),
            const SizedBox(height: 24),

            // 👤 Profile picture with edit button
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : const AssetImage('assets/images/ryan_gosling.jpg') as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Image.asset(
                      'assets/images/Edit_Button.png',
                      width: 28,
                      height: 28,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Text(
              'Ryan_Gosling',
              style: TextStyle(
                fontFamily: 'PlayfairDisplay',
                fontSize: 22,
                color: Color(0xFFFFD700),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'literally.me@gmail.com',
              style: TextStyle(
                fontFamily: 'PlayfairDisplay',
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),

            // 🔘 Action buttons
            buildButton(context, 'Edit Username', () => Navigator.pushNamed(context, '/edit_username')),
            const SizedBox(height: 16),
            buildButton(context, 'Edit Email', () => Navigator.pushNamed(context, '/edit_email')),
            const SizedBox(height: 16),
            buildButton(context, 'Edit Password', () => Navigator.pushNamed(context, '/edit_password')),
            const SizedBox(height: 16),
            buildButton(context, 'Delete Account', () => Navigator.pushNamed(context, '/acc_delete')),
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFC857),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
