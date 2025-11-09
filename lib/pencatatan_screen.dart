import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PencatatanScreen extends StatefulWidget {
  const PencatatanScreen({super.key});

  @override
  State<PencatatanScreen> createState() => _PencatatanScreenState();
}

class _PencatatanScreenState extends State<PencatatanScreen> {
  final _jenisPenyuController = TextEditingController();
  final _jenisKelaminController = TextEditingController();
  final _jumlahTelurController = TextEditingController();
  final _tanggalController = TextEditingController();

  @override
  void dispose() {
    _jenisPenyuController.dispose();
    _jenisKelaminController.dispose();
    _jumlahTelurController.dispose();
    _tanggalController.dispose();
    super.dispose();
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            "Konfirmasi",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 25, 44, 71)),
          ),
          content: Text(
            "Apakah Anda yakin ingin mengunggah data ini?",
            style: GoogleFonts.poppins(),
          ),
          actions: [
            Container(
              height: 1,
              color: Colors.grey[300],
              margin: const EdgeInsets.only(top: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                    ),
                    child: Text(
                      "Tidak",
                      style: GoogleFonts.poppins(color: Colors.redAccent),
                    ),
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                  ),
                ),
                Container(width: 1, height: 48, color: Colors.grey[300]),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                    ),
                    child: Text(
                      "Iya",
                      style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 25, 44, 71),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      _handleDataUpload();
                    },
                  ),
                ),
              ]
            ),
          ],
        );
      },
    );
  }

  void _handleDataUpload() {
    final jenisPenyu = _jenisPenyuController.text;
    print("Unggah data... Jenis: $jenisPenyu");
    // TODO: Tambahkan logika upload data ke server/database di sini

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Data Penyu $jenisPenyu berhasil ditambahkan!",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    _jenisPenyuController.clear();
    _jenisKelaminController.clear();
    _jumlahTelurController.clear();
    _tanggalController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBackButton(context),
            _buildImageToUpload(),
            _buildFormCard(),
            _buildButtonSubmit(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(top: 50.0, left: 16.0),
      child: Material(
        color: const Color.fromARGB(255, 25, 44, 71),
        borderRadius: BorderRadius.circular(24),
        elevation: 4,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            Navigator.of(context).pop(); // Aksi untuk kembali
          },
          child: Container(
            width: 50,
            height: 40,
            alignment: Alignment.center,
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildImageToUpload() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Color.fromARGB(127, 25, 44, 71), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline, // Ikon + besar
              color: Color.fromARGB(127, 25, 44, 71),
              size: 50,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  color: Color.fromARGB(127, 25, 44, 71),
                ),
                const SizedBox(width: 30),
                Icon(
                  Icons.image_outlined,
                  color: Color.fromARGB(127, 25, 44, 71),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 16.0,
        right: 16.0,
        bottom: 8.0,
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 25, 44, 71),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildTextField(
                label: "Jenis Penyu",
                hint: "Nama",
                controller: _jenisPenyuController,
              ),
              _buildTextField(
                label: "Jenis Kelamin",
                hint: "Jenis Kelamin Penyu",
                controller: _jenisKelaminController,
              ),
              _buildTextField(
                label: "Jumlah Telur",
                hint: "Total Telur",
                controller: _jumlahTelurController,
              ),
              _buildTextField(
                label: "Tanggal Ditemukan",
                hint: "Pilih Tanggal",
                suffixIcon: Icons.calendar_today_outlined,
                controller: _tanggalController,
                onIconTap: () {
                  // TODO create Pick a Date Logic
                  print("Tanggal Di Klik");
                },
              ),
              const SizedBox(height: 16),
              Text(
                "Lokasi GPS / Koordinat:",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                icon: Icon(
                  Icons.gps_fixed,
                  color: Color.fromARGB(255, 25, 44, 71),
                ),
                label: Text(
                  "Dapatkan Lokasi Saat Ini",
                  style: GoogleFonts.poppins(
                    color: Color.fromARGB(255, 25, 44, 71),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                onPressed: () {
                  // TODO: Tambahkan logika untuk get GPS
                  print("Get GPS tapped!");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonSubmit() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16.0,
        bottom: 50.0,
      ),
      child: ElevatedButton(
        onPressed: () {
          // TODO: Tambahkan logika untuk unggah data
          _showConfirmationDialog();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 25, 44, 71),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
        ),
        child: Text(
          "Unggah data",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    IconData? suffixIcon,
    VoidCallback? onIconTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: GoogleFonts.poppins(color: Colors.black),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 12),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            suffixIcon: suffixIcon != null
                ? IconButton(
                    icon: Icon(suffixIcon, color: Colors.grey[700]),
                    onPressed: onIconTap,
                  )
                : null,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
