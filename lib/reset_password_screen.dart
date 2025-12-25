import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penyuku/controllers/auth_controller.dart';
import 'package:penyuku/login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email; // Menerima email dari halaman OTP
  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final AuthController _authController = AuthController();
  
  bool _isLoading = false;
  bool _isObscure1 = true;
  bool _isObscure2 = true;

  Future<void> _handleReset() async {
    if (_passController.text.isEmpty || _confirmPassController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: Text("Isi kedua kolom password"), 
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ), 
      )
    );
      return;
    }

    if (_passController.text != _confirmPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content: Text("Password tidak sama!"), 
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ), 
        )
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authController.resetPassword(widget.email, _passController.text);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Password berhasil diubah! Silakan Login."), 
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ), 
          ),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
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
        title: Text("Buat Password Baru", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // Hilangkan tombol back karena tidak boleh mundur saat proses ini
      ),
      body: Padding(
        padding: const EdgeInsetsGeometry.only(
          left: 24, 
          right: 24,
          top: 50
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            Text("Password Baru", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _passController,
              obscureText: _isObscure1,
              decoration: InputDecoration(
                filled: true, fillColor: Colors.grey[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                suffixIcon: IconButton(
                  icon: Icon(_isObscure1 ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _isObscure1 = !_isObscure1),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text("Konfirmasi Password", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _confirmPassController,
              obscureText: _isObscure2,
              decoration: InputDecoration(
                filled: true, fillColor: Colors.grey[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                suffixIcon: IconButton(
                  icon: Icon(_isObscure2 ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _isObscure2 = !_isObscure2),
                ),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleReset,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 16, 31, 53),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text("Simpan Password", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
