import 'package:flutter/material.dart';

// Settings
import 'package:tarot_app/screens/settings/settings_dashboard.dart';

import 'package:tarot_app/screens/settings/delete_account/account_deleted_success.dart';
import 'package:tarot_app/screens/settings/change_email/change_email.dart';
import 'package:tarot_app/screens/settings/delete_account/delete_account.dart';
import 'package:tarot_app/screens/settings/change_email/change_email_confirmation_code.dart';
import 'package:tarot_app/screens/settings/change_email/change_email_success.dart';

// Settings Password
  import 'package:tarot_app/screens/settings/change_password/change_password.dart';
  import 'package:tarot_app/screens/settings/change_password/change_password_success.dart';

// Login
import 'package:tarot_app/screens/login/forgot_password/fp_resetpass.dart';
import 'package:tarot_app/screens/login/forgot_password/fp_verify.dart';
import 'package:tarot_app/screens/login/load_screen.dart';
import 'package:tarot_app/screens/login/sign_up/create_account_screen.dart';
import 'package:tarot_app/screens/login/sign_up/confirmation_screen.dart';
import 'package:tarot_app/screens/login/sign_up/account_created.dart';
import 'package:tarot_app/screens/login/login.dart';
import 'package:tarot_app/screens/login/forgot_password/forgot_password.dart';

// Dashboard
import 'package:tarot_app/Screens/dashboard/dashboard_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  // Login
  '/': (context) => const LoadScreen(),
  '/create': (context) => const CreateAccountScreen(),
  '/confirm': (context) => const ConfirmationScreen(),
  '/acc_created': (context) => const AccountCreatedPage(),
  '/login': (context) => const LoginPage(),
  '/dashboard': (context) => const DashboardPage(),
  '/forgot_pass': (context) => const ForgotPassword(),
  '/fpverify': (context) => const ForgotPassVerify(),
  '/fp_resetpass': (context) => const ForgotPassReset(),

  // Settings
  '/acc_info': (context) => const AccountInformation(),
  '/acc_delete': (context) => const DeleteAccount(),
  '/acc_delete_succ': (context) => const AccountDeletedSuccess(),
  '/change_email': (context) => const EditEmailPage(),
  '/change_email_code': (context) => const ChangeEmailConfirmationCodePage(),
  '/change_email_success': (context) => const EmailSuccessPage(),
  '/change_password': (_) => const ChangePasswordPage(),
  '/password_changed': (_) => const PasswordChangedPage(),
};
