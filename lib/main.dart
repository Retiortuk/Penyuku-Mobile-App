import 'package:flutter/material.dart';
import 'login_screen.dart'; // pastikan nama dan lokasi file sama

void main() {
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
        fontFamily: 'Poppins', // optional, biar tampilannya halus
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(), // Halaman pertama yang dibuka
    );
  }
}
