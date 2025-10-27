import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget { 
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isPasswordVisible = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Image.asset(
              'asset/images/background.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            // Lingkaran-lingkaran putih dekoratif di background
            Positioned(top: -80, left: -40, child: _buildCircle(180)),
            Positioned(top: 100, right: -60, child: _buildCircle(120)),
            Positioned(bottom: 100, left: -70, child: _buildCircle(150)),
            Positioned(bottom: -60, right: -30, child: _buildCircle(160)),

            // Konten utama
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLogo(),
                    const SizedBox(height: 40),
                    _buildLoginCard(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Lingkaran putih background
  Widget _buildCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        shape: BoxShape.circle,
      ),
    );
  }

  // Logo Penyu
  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          width: 195,
          height: 195,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF4DA6FF),
          ),
          child: Center(
            child: Image.asset(
              'asset/images/logo_penyu.png', // pastikan path-nya sesuai
              width: 130,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Penyu ku.",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'KronaOne-Regular', // opsional
          ),
        ),
      ],
    );
  }

  // Form Register di dalam card putih
  Widget _buildLoginCard(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Email
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Email",
                style: GoogleFonts.poppins(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'email',
                prefixIcon: const Icon(
                  Icons.person_outline,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Username
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Username",
                style: GoogleFonts.poppins(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'username',
                prefixIcon: const Icon(
                  Icons.person_outline,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Password
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Password",
                style: GoogleFonts.poppins(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                hintText: '********',
                prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 30),

             Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                    "Sudah Memiliki Akun? Masuk",
                      style: GoogleFonts.poppins(
                        color: Colors.blue,
                        
                      ),
                    ),
                  ),  
                ],
              ),
            ),

            // Tombol Register
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  final username = _usernameController.text;
                  final password = _passwordController.text;
                  print("Register attempt: $username | $password");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007BFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                child: Text(
                  "Register",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
