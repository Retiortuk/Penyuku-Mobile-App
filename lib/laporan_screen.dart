import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penyuku/laporanOverview_screen.dart';

class Laporan {
  final String id;
  final String nama;
  final String tanggal;
  final String imageUrl;

  Laporan({
    required this.id,
    required this.nama,
    required this.tanggal,
    required this.imageUrl,
  });
}

class LaporanScreen extends StatefulWidget {
  const LaporanScreen({super.key});

  @override
  State<LaporanScreen> createState() => _LaporanScreenState();
}

class _LaporanScreenState extends State<LaporanScreen> {
  final List<Laporan> _laporanList = [
    Laporan(
      id: '#239487',
      nama: 'Penyu Madura',
      tanggal: '27/05/2025',
      imageUrl: 'assets/images/penyu-tentang.jpg',
    ),
    Laporan(
      id: '#239488',
      nama: 'Penyu Hijau',
      tanggal: '26/05/2025',
      imageUrl: 'assets/images/penyu-tentang.jpg',
    ),
    Laporan(
      id: '#239489',
      nama: 'Penyu Sisik',
      tanggal: '25/05/2025',
      imageUrl: 'assets/images/penyu-tentang.jpg',
    ),
    Laporan(
      id: '#239490',
      nama: 'Penyu Lekang',
      tanggal: '24/05/2025',
      imageUrl: 'assets/images/penyu-tentang.jpg',
    ),
    Laporan(
      id: '#239491',
      nama: 'Penyu Pipih',
      tanggal: '23/05/2025',
      imageUrl: 'assets/images/penyu-tentang.jpg',
    ),
    Laporan(
      id: '#239491',
      nama: 'Penyu Wibu',
      tanggal: '23/05/2025',
      imageUrl: 'assets/images/penyu-tentang.jpg',
    ),
    Laporan(
      id: '#239491',
      nama: 'Penyu Telon',
      tanggal: '23/05/2025',
      imageUrl: 'assets/images/penyu-tentang.jpg',
    ),
  ];

  final Color _darkBlue = const Color.fromARGB(255, 25, 44, 71);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBackButton(context),
            _buildSummaryCards(),
            _buildLaporanTitle(),
            _buildLaporanList(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, left: 16.0),
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

  Widget _buildSummaryCards() {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 14, right: 14),
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryCard(
              icon: Icons.shield_outlined,
              title: "Total Penyu",
              count: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSummaryCard(
              icon: Icons.egg_outlined,
              title: "Total Tukik",
              count: 97,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required IconData icon,
    required String title,
    required int count,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _darkBlue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: _darkBlue, size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12),
              ),
              Text(
                count.toString(),
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLaporanTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
      child: Text(
        "Laporan",
        style: GoogleFonts.poppins(
          color: _darkBlue,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLaporanList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: _laporanList.map((laporan) {
          return _buildLaporanItem(laporan);
        }).toList(),
      ),
    );
  }

  Widget _buildLaporanItem(Laporan laporan) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LaporanOverviewScreen(),
            ),
          );
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey[300],
                backgroundImage: AssetImage(laporan.imageUrl),
              ),
              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      laporan.nama,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "ID: ${laporan.id}",
                      style: GoogleFonts.poppins(
                        color: _darkBlue,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.circle, size: 8, color: Colors.black),
                      SizedBox(width: 4),
                      Text(
                        "Tanggal",
                        style: GoogleFonts.poppins(
                          color: _darkBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    laporan.tanggal,
                    style: GoogleFonts.poppins(color: _darkBlue, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(width: 15),

              // Panah
              Icon(Icons.chevron_right, color: _darkBlue, size: 30),
            ],
          ),
        ),
      ),
    );
  }
}
