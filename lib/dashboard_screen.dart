import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _buildTopContent(),

          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.4,  
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 25, 44, 71),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    _buildHaloUser(),
                    const SizedBox(height: 30,),
                    _buildActionButtons(),
                    const SizedBox(height: 20,),
                    _buildWelcomeCard(),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          "Konten Lain di Sini",
                          style: GoogleFonts.poppins(color: Colors.white54),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTopContent() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsGeometry.only(top: 60.0, bottom: 20.0),
          child: Image.asset('assets/images/logo-penyu.png', height: 50,),
        ),

        // Komunitas
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Info Seputar Komunitas",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Icon(Icons.notifications_none, color: Colors.grey[700]),
            ],
          ),
        ),
        const SizedBox(height: 20,),

        Container(
          height: 250, // Beri tinggi pasti untuk PageView
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.8), // Kartu terlihat sebagian
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    // Ganti dengan gambar dinamis
                    image: NetworkImage("https://placehold.co/600x400/grey/white?text=Info+Komunitas"),
                    fit: BoxFit.cover,
                  )
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Sosialisasi Keberadaan\nBak Peneluran Penyu",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        shadows: [Shadow(blurRadius: 10.0, color: Colors.black54)]
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHaloUser() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A3959), // Warna biru lebih muda
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hallo, Kevin",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Data Keseluruhan Pada Tahun ini",
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          // Progress Bar
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const LinearProgressIndicator(
                    value: 0.5, // 50%
                    backgroundColor: Colors.white24,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    minHeight: 12,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "50%",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "20 Juli 2025",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "view all",
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(Icons.note_add_outlined, "Pencatatan"),
        _buildActionButton(Icons.description_outlined, "Laporan"),
        _buildActionButton(Icons.map_outlined, "Letak Penelusuran"),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFF2A3959),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: Colors.white, size: 40),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A3959),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selamat datang di Penangkaran Penyu Cilacap",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Bersama melestarikan penyu untuk generasi mendatang...",
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: [
                    Chip(label: Text('Gabung komunitas', style: GoogleFonts.poppins(fontSize: 10)), padding: EdgeInsets.zero),
                    Chip(label: Text('Pelajari penyu', style: GoogleFonts.poppins(fontSize: 10)), padding: EdgeInsets.zero),
                  ],
                )
              ],
            ),
          ),
          Image.asset(
            'assets/images/logo-penyu.png', 
            height: 70,
            color: Colors.white, 
          ),
        ],
      ),
    );
  }
}
