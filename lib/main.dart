import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'routes/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<File> _crashFile() async {
  final dir = await getApplicationDocumentsDirectory();
  return File('${dir.path}/crash_log.txt');
}

Future<void> _writeCrash(String text) async {
  try {
    final f = await _crashFile();
    final timestamp = DateTime.now().toIso8601String();
    await f.writeAsString('[$timestamp]\n$text\n\n', mode: FileMode.append, flush: true);
  } catch (_) {}
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) async {
    final text = 'FLUTTER ERROR: ${details.exceptionAsString()}\n${details.stack ?? ''}';
    await _writeCrash(text);
    if (kDebugMode) FlutterError.dumpErrorToConsole(details);
  };

  await runZonedGuarded<Future<void>>(() async {
    await Supabase.initialize(
      url: 'https://tzyrhyxaecvbvlebxrab.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR6eXJoeXhhZWN2YnZsZWJ4cmFiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjEzNDA5NTcsImV4cCI6MjA3NjkxNjk1N30.zIMXKMyClYxWMTgTtjCYqGknI0UMPDVXozxqQjnLc9M',
    );
    runApp(const EmpressReadsApp());
  }, (error, stack) async {
    final text = 'UNCAUGHT ERROR: $error\n$stack';
    await _writeCrash(text);
    if (kDebugMode) print(text);
  });
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
