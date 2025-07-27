import 'package:flutter/material.dart';
//Setting Pages
import 'package:tarot_app/screens/settings/account_deleted_success.dart';
import 'package:tarot_app/screens/settings/account_information.dart';
import 'package:tarot_app/screens/settings/change_email.dart';
import 'package:tarot_app/screens/settings/change_profile.dart';
import 'package:tarot_app/screens/settings/delete_account.dart';
import 'package:tarot_app/screens/settings/change_email_confirmation_code.dart';
import 'package:tarot_app/screens/settings/change_email_success.dart';
import 'package:tarot_app/screens/settings/change_password.dart';
import 'package:tarot_app/screens/settings/change_password_success.dart';

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
        '/acc_info': (context) => const AccountInformation(),
        '/acc_delete': (context) => const DeleteAccount(),
        '/acc_delete_succ': (context) => const AccountDeletedSuccess(),
        '/change_prof': (context) => const ChangeProfile(),
        '/change_email': (context) => const EditEmailPage(),
        '/change_email_code': (context) => const ChangeEmailConfirmationCodePage(),
        '/change_email_success': (context) => const EmailSuccessPage(),
        '/change_password': (_) => const ChangePasswordPage(),
        '/password_changed': (_) => const PasswordChangedPage(),
      },
    );
  }
}
