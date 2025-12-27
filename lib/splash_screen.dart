import 'package:flutter/material.dart';
import 'package:penyuku/dashboard_screen.dart';
import 'login_screen.dart';
import 'package:penyuku/controllers/auth_controller.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _authController = AuthController();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3));

    bool isLoggedIn = await _authController.checkSession();

    if(mounted) {
      if(isLoggedIn) {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => const DashboardScreen())
        );
      } else {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => const LoginScreen())
        );
      }
    }
  }

  Widget _buildCircle({
    required double size,
    required Color color,
    double? top,
    double? left,
    double? right,
    double? bottom,
  }) {
    return Positioned(
      top: top,     
      left: left,   
      right: right, 
      bottom: bottom,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/splash_screen_background.png', fit: BoxFit.cover),

          _buildCircle(
            size: 225,
            color: Colors.white.withOpacity(0.75),
            top: -120, 
            right: -80, 
          ),

          _buildCircle(
            size: 225,
            color: Colors.white.withOpacity(0.75),
            bottom: -100,
            left: -80, 
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo-splashscreen.png',
                  width: 200,
                  height: 200,
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
