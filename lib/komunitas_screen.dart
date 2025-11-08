import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:penyuku/edukasi_detail_screen.dart'; // Import jika card mau di-tap

class KomunitasCardData {
  final String title;
  final String subtitle;
  final String imageUrl;

  KomunitasCardData({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}

class KomunitasScreen extends StatefulWidget {
  const KomunitasScreen({super.key});

  @override
  State<KomunitasScreen> createState() => _KomunitasScreenState();
}

class _KomunitasScreenState extends State<KomunitasScreen> {
  final List<KomunitasCardData> _cardList = [
    KomunitasCardData(
      title: 'Galeri Aksi Komunitas',
      subtitle: '"bukti" kalau komunitas ini beneran ada dan seru.',
      imageUrl: 'assets/images/galeri-aksi-komunitas.png', // Ganti dengan path aset Anda
    ),
    KomunitasCardData(
      title: 'Jadi Relawan Inti',
      subtitle: 'Naik Level: Jadi Relawan Inti',
      imageUrl: 'assets/images/jadi-relawan-inti.png', // Ganti dengan path aset Anda
    ),
    KomunitasCardData(
      title: 'Turun Tangan',
      subtitle: 'Kalender Aksi Kita',
      imageUrl: 'assets/images/turun-tangan.png', // Ganti dengan path aset Anda
    ),
  ];

  final Color _darkBlue = const Color.fromARGB(255, 25, 44, 71);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          pinned: true,
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,
            centerTitle: true,
            title: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              decoration: BoxDecoration(
                color: _darkBlue,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24.0),
                  bottomRight: Radius.circular(24.0),
                ),
              ),
              child: Image.asset(
                'assets/images/logo-penyu.png',
                height: 50,
                color: Colors.white,
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 4.0),
                child: Text(
                  'Komunitas Penyuku.',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _darkBlue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Selamat Datang, Pahlawan Penyu!',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Column(
                children: _cardList.map((data) {
                  return _buildKomunitasCard(data);
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKomunitasCard(KomunitasCardData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          // TODO: Arahkan ke halaman detail yang sesuai
          // Contoh:
          // Navigator.push(context, MaterialPageRoute(
          //   builder: (context) => EdukasiDetailScreen(item: ...),
          // ));
        },
        child: Card(
          elevation: 5,
          shadowColor: Colors.black.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          clipBehavior: Clip.antiAlias, 
          child: Stack(
            children: [
              Ink.image(
                height: 180,
                width: double.infinity,
                image: AssetImage(data.imageUrl), 
                fit: BoxFit.cover,
                child: InkWell(
                  onTap: () {
                     /* Aksi tap pada gambar jika perlu */
                  },
                ),
              ),

              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.4, 1.0],
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          const Shadow(blurRadius: 5.0, color: Colors.black54)
                        ],
                      ),
                    ),
                    Text(
                      data.subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                bottom: 12,
                right: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    "Selengkapnya",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _darkBlue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}