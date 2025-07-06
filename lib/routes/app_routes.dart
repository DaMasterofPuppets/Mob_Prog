import 'package:flutter/material.dart';
import '../screens/login/login_page.dart';
import '../screens/dashboard/dashboard_page.dart';

class AppRoutes {
  static const String login = '/';
  static const String dashboard = '/dashboard';

  static final routes = <String, WidgetBuilder>{
    login: (context) => const LoginPage(),
    dashboard: (context) => const DashboardPage(),
  };
}
