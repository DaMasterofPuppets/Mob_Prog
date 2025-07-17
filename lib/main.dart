import 'package:flutter/material.dart';
import 'screens/login/fp_resetpass.dart';
import 'screens/login/fp_verify.dart';
import 'screens/login/load_screen.dart';
import 'screens/login/create_account_screen.dart';
import 'screens/login/confirmation_screen.dart';
import 'screens/login/account_created.dart';
import 'screens/login/login.dart';
import 'screens/login/forgot_password.dart';
import 'screens/dashboard/dashboard_page.dart';

void main() {
  runApp(const EmpressReadsApp());
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
        '/': (context) => const LoadScreen(),
        '/create': (context) => const CreateAccountScreen(),
        '/confirm': (context) => const ConfirmationScreen(),
        '/acc_created': (context) => const AccountCreatedPage(),
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/forgot_pass': (context) => const ForgotPassword(),
        '/fpverify': (context) => const ForgotPassVerify(),
        '/fp_resetpass': (context) => const ForgotPassReset(),
      },
    );
  }
}
