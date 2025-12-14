import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:penyuku/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Color _darkBlue = const Color.fromARGB(255, 25, 44, 71);

  final Color _greyText = const Color(0xFF555555);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: 
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Center(child: _buildProfileHeader()),
                const SizedBox(height: 24),
                _buildStatsCard(),
                const SizedBox(height: 24),
                _buildTentangSaya(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        )
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey[300],
          child: Icon(Icons.person, size: 60, color: Colors.grey[600]),
        ),
        const SizedBox(height: 16),
        Text(
          "Kevin",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: _darkBlue,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "@kevinmccallister_03",
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          "Member Sejak: 20/08/25",
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          child: Text(
            "Keluar",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.red[700],
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Card(
        elevation: 2,
        shadowColor: Colors.grey.withOpacity(0.2),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem("Status", "Petugas"),
              SizedBox(
                height: 40,
                child: VerticalDivider(color: Colors.grey[300]),
              ),
              _buildStatItem("Bergabung", "10 Juni 2025"),
              SizedBox(
                height: 40,
                child: VerticalDivider(color: Colors.grey[300]),
              ),
              _buildStatItem("Laporan", "12"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: _darkBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTentangSaya() {
    const String aboutText =
        "Saya adalah Kevin, seorang penangkar penyu yang berdomisili di Cilacap. Sejak lama saya memiliki kecintaan terhadap laut dan satwa yang hidup di dalamnya, terutama penyu yang kini semakin langka. Dari rasa peduli itu, saya memutuskan\n \nuntuk mendirikan penangkaran penyu dengan tujuan melestarikan spesies ini sekaligus memberikan edukasi kepada masyarakat tentang pentingnya menjaga ekosistem laut. Setiap hari saya merawat telur, mengawasi proses penetasan, hingga melepaskan tukik ke laut lepas.";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tentang Saya",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _darkBlue,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            aboutText,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: _greyText,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
