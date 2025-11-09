import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LaporanOverviewScreen extends StatelessWidget {
  const LaporanOverviewScreen({super.key});

  final Color _darkBlue = const Color.fromARGB(255, 25, 44, 71);
  final Color _greyCard = const Color(0xFFE0E0E0);
  final Color _greyText = const Color.fromARGB(255, 25, 44, 71);

  void _showDownloadToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Laporan PDF berhasil diunduh!",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.green, 
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBackButton(context),
              const SizedBox(height: 20),
              _buildHeaderInfo(),
              const SizedBox(height: 30),
              _buildDetailCard(),
              const SizedBox(height: 40),
              _buildDownloadButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 16.0),
      child: Material(
        color: _darkBlue,
        borderRadius: BorderRadius.circular(24),
        elevation: 4,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            Navigator.of(context).pop(); 
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

  Widget _buildHeaderInfo() {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
            backgroundImage: NetworkImage('assets/images/penyu-tentang.jpg'),
          ),
          const SizedBox(height: 16),
          Text(
            "Penyu Madura",
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _darkBlue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "ID: #1293898",
            style: GoogleFonts.poppins(fontSize: 14, color: _greyText),
          ),
          Text(
            "Tanggal: 27/05/2025",
            style: GoogleFonts.poppins(fontSize: 14, color: _greyText),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: _greyCard.withOpacity(0.5), 
          borderRadius: BorderRadius.circular(12), 
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(12), 
                image: DecorationImage(
                  image: NetworkImage('assets/images/penyu-tentang.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),

            Text(
              "Penyu Madura",
              style: GoogleFonts.poppins(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
                color: _darkBlue,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              "Unduh Laporan Untuk Lihat Lebih Detail",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: _greyText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ElevatedButton(
        onPressed: () {
          _showDownloadToast(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _darkBlue,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
        ),
        child: Text(
          "Unduh Laporan PDF",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}