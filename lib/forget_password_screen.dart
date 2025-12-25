import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penyuku/controllers/auth_controller.dart';
import 'package:penyuku/login_screen.dart';
import 'package:penyuku/otp_screen.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  final TextEditingController _emailController = TextEditingController();
  final AuthController _authController = AuthController();
  bool _isLoading = false;


  Future<void> _handleSubmit() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Harap isi email Anda"), 
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ), 
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authController.sendRecoveryEmail(_emailController.text.trim());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Kode OTP telah dikirim ke email Anda"), 
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ), 
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(email: _emailController.text.trim()),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = e.toString().replaceAll("Exception: ", "");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage), 
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ), 
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/login_background.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),

            // Konten utama
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    _buildForgetCard(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Form login di dalam card putih
  Widget _buildForgetCard(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    iconSize: 28.0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Opacity(
                    opacity: 0.4,
                    child: Text(
                      "Kembali",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 16, 31, 53),
                    Color.fromARGB(255, 65, 97, 145),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                ).createShader(bounds),
                child: Text(
                  "Verifikasi \nEmail Anda",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Email
            Align(
              alignment: Alignment.centerLeft,
              child: Opacity(
                opacity: 0.4,
                child: Text(
                  "Email",
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 12),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Tombol Kirim OTP
            Padding(
              padding: EdgeInsetsGeometry.only(bottom: 15),
              child: SizedBox(
                width: 135.0,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 16, 31, 53),
                          Color.fromARGB(255, 65, 97, 145),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: _isLoading 
                        ? const SizedBox(
                            height: 28,
                            width: 28,
                            child: CircularProgressIndicator(backgroundColor: Colors.white, strokeWidth: 2,),
                          )
                        : Text(
                            "Kirim OTP",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 15,
                          ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ingat Password ?",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      " Masuk",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
