import 'package:flutter/material.dart';
import 'package:penyuku/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANONKEY'] ?? '',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Penyu ku',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins', 
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
