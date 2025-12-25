import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penyuku/controllers/auth_controller.dart';
import 'package:penyuku/reset_password_screen.dart';

class OtpScreen extends StatefulWidget {
  final String email; 
  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final AuthController _authController = AuthController();
  bool _isLoading = false;

  // Logika Verifikasi OTP
  Future<void> _handleVerify() async {
    if (_otpController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Masukkan kode OTP"), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authController.verifyOtp(widget.email, _otpController.text.trim());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("OTP Valid"),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ), 
          )
        );
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPasswordScreen(email: widget.email),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll("Exception: ", "")), 
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
      appBar: AppBar(
        title: Text("Verifikasi OTP", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Masukkan 4 digit kode yang dikirim ke \n${widget.email}",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 24, letterSpacing: 8, fontWeight: FontWeight.bold),
              maxLength: 4,
              decoration: InputDecoration(
                counterText: "",
                hintText: "----",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleVerify,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 16, 31, 53),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text("Verifikasi", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
