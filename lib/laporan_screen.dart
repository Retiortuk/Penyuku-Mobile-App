import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:penyuku/laporanOverview_screen.dart';

class Laporan {
  final String id;
  final String nama;
  final String tanggal;
  final String waktu;

  Laporan({
    required this.id,
    required this.nama,
    required this.tanggal,
    required this.waktu,
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
      waktu: '07:40',
    ),
    Laporan(
      id: '#239488',
      nama: 'Penyu Hijau',
      tanggal: '26/05/2025',
      waktu: '09:30',
    ),
    Laporan(
      id: '#239489',
      nama: 'Penyu Sisik',
      tanggal: '25/05/2025',
      waktu: '07:40',
    ),
    Laporan(
      id: '#239490',
      nama: 'Penyu Lekang',
      tanggal: '24/05/2025',
      waktu: '07:40',
    ),
    Laporan(
      id: '#239491',
      nama: 'Penyu Pipih',
      tanggal: '23/05/2025',
      waktu: '07:40',
    ),
    Laporan(
      id: '#239491',
      nama: 'Penyu Wibu',
      tanggal: '23/05/2025',
      waktu: '07:40',
    ),
    Laporan(
      id: '#239491',
      nama: 'Penyu Telon',
      tanggal: '23/05/2025',
      waktu: '07:40',
    ),
  ];

  final Color _darkBlue = const Color.fromARGB(255, 25, 44, 71);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
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
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 16.0),
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
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LaporanOverviewScreen(),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            color: const Color(0xFFD1D5DB).withOpacity(0.5), // Warna abu-abu background card
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon Dokumen (Clipboard)
              Icon(
                Icons.assignment_outlined, // Icon clipboard
                color: _darkBlue,
                size: 32,
              ),
              const SizedBox(width: 16),

              // Kolom Teks (Tanggal, Judul, ID)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tanggal & Waktu (Kecil, Abu-abu)
                    Text(
                      "${laporan.tanggal} – ${laporan.waktu}",
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    
                    // Nama Laporan (Bold, Biru Tua)
                    Text(
                      laporan.nama,
                      style: GoogleFonts.poppins(
                        color: _darkBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    
                    // ID Laporan (Kecil, Abu-abu)
                    Text(
                      "ID: ${laporan.id}",
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Panah Kanan
              Icon(
                Icons.arrow_forward_ios_rounded, 
                color: _darkBlue, 
                size: 20
              ),
            ],
          ),
        ),
      ),
    );
  }
}
