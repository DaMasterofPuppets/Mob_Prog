import 'package:flutter/material.dart';
import 'screens/load_screen.dart';
import 'screens/create_account_screen.dart';
import 'screens/confirmation_screen.dart';
import 'screens/account_created.dart';
import 'screens/login.dart';

void main() {
  runApp(EmpressReadsApp());
}

class EmpressReadsApp extends StatelessWidget {
  const EmpressReadsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Empress Reads',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Inter'),
      initialRoute: '/',
      routes: {
        '/': (context) => LoadScreen(),
        '/create': (context) => CreateAccountScreen(),
        '/confirm': (context) => ConfirmationScreen(),
        '/acc_created': (context) => AccountCreatedPage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}
