import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

//supabase integration time
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://tzyrhyxaecvbvlebxrab.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR6eXJoeXhhZWN2YnZsZWJ4cmFiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjEzNDA5NTcsImV4cCI6MjA3NjkxNjk1N30.zIMXKMyClYxWMTgTtjCYqGknI0UMPDVXozxqQjnLc9M', 
  );

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
