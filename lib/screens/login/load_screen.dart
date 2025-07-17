import 'package:flutter/material.dart';

class LoadScreen extends StatelessWidget {
  const LoadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF470000),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 300,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image.asset('assets/images/logo.png'),
              ),
            ),

            SizedBox(height: 15),
            Column(
              children: [
                Text(
                  'Empress',
                  style: TextStyle(
                    fontSize: 100,
                    color: Color(0xFFFFD700),
                    fontFamily: 'LuxScript',
                    height: 0.8,
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, 0),
                  child: Text(
                    'Reads',
                    style: TextStyle(
                      fontSize: 100,
                      color: Color(0xFFFFD700),
                      fontFamily: 'LuxScript',
                      height: 0.8,
                     ),
                  ),
                ),
              ],
             ),

            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login'); // This should go to a Login Page
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFC860),
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text('LOG IN', style: TextStyle(color: Colors.black)),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/create');
              },
              child: Text(
                "Don't have an account yet? Sign Up",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/forgot_pass');
              },
              child: Text(
                "Forget Password?",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
