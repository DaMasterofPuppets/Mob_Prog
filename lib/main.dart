import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

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
      routes: appRoutes,
    );
  }
}
