import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAktivitasScreen extends StatefulWidget {
  const AddAktivitasScreen({super.key});

  @override
  State<AddAktivitasScreen> createState() => _AddAktivitasScreenState();
}

class _AddAktivitasScreenState extends State<AddAktivitasScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _taglineController = TextEditingController();
  final TextEditingController _deskripsiControlller = TextEditingController();

  final Color _darkBlue = const Color.fromARGB(255, 25, 44, 71);
  final Color _greyBorder = const Color(0xFFE0E0E0);

  @override
  void dispose() {
    _namaController.dispose();
    _taglineController.dispose();
    _deskripsiControlller.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    print("Nama Aktivitas: ${_namaController.text}");
    print("Tagline Aktivitas: ${_taglineController}");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Aktivitas Berhasil Ditambahkan!",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBackButton(context),
              const SizedBox(height: 24),
              _buildSectionLabel("Upload Thumbnail Aktivitas"),
              const SizedBox(height: 12),
              _buildUploadBox(height: 180),
              const SizedBox(height: 24),
              // Input Nama Aktivitas
              _buildTextField(
                label: "Nama Aktivitas", 
                controller: _namaController, 
                hint: "Masukan nama aktivitas"
              ),
              const SizedBox(height: 16),
              // Input Tagline
              _buildTextField(
                label: "Deskripsi Singkat", 
                controller: _taglineController, 
                hint: "Masukan deskripsi singkat"
              ),
              const SizedBox(height: 16),
              // Input Deskripsi
              _buildTextField(
                label: "Deskripsi Aktivitas Dan Tanggal", 
                controller: _taglineController, 
                hint: "Masukan deskripsi secara detail",
                maxLines: 5,
              ),
              const SizedBox(height: 24),
              _buildSectionLabel("Upload Thumbnail Aktivitas"),
              const SizedBox(height: 12),
              _buildUploadBox(height: 150),
              const SizedBox(height: 40),
              // Button buat add aktivitas
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: _handleSubmit, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _darkBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(15)
                    )
                  ),
                  child: Text(
                    "Tambah Aktivitas",
                    style: GoogleFonts.poppins(
                      color: Colors.white, 
                      fontSize: 12, 
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 50,
        height: 40,
        decoration: BoxDecoration(
          color: _darkBlue,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(Icons.arrow_back, color: Colors.white),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: _darkBlue,
      ),
    );
  }

  Widget _buildUploadBox({required double height}) {
    return GestureDetector(
      onTap: () {
        print("Upload Gambar Di Tap");
      },
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9).withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: _darkBlue, width: 2),
              ),
              child: Icon(Icons.add, color: _darkBlue, size: 32),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.grey[700],
                  size: 20,
                ),
                const SizedBox(width: 12),
                Icon(Icons.image_outlined, color: Colors.grey[700], size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF333333), 
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: GoogleFonts.poppins(fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 12),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey), 
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _darkBlue, width: 1.5),
            ),
            filled: true,
            fillColor: Colors.white, 
          ),
        ),
      ],
    );
  }
}
