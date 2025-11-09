import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'komunitas_overview.dart';

class KomunitasCardData {
  final String title;
  final String subtitle;
  final String headerImageUrl;
  final String description;
  final List<String> galleryImages;
  final String buttonText;

  KomunitasCardData({
    required this.title,
    required this.subtitle,
    required this.headerImageUrl,
    required this.description,
    required this.galleryImages,
    required this.buttonText,
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
      headerImageUrl: 'assets/images/galeri-aksi-komunitas.png',
      description: 'Mulai Berperan Penting Dalam Penyelamatan Penyu, Dengan Menjadi Salah Satu Komunitas Dari Penyuku Klik "Gabung Komunitas Untuk Bergabung".',
      galleryImages: [
        'assets/images/galeri-komunitas.png',
        'assets/images/galeri-komunitas2.png.jpg',
        'assets/images/galeri-komunitas3.jpg',
      ],
      buttonText: 'Gabung Komunitas',
    ),
    KomunitasCardData(
      title: 'Jadi Relawan Inti',
      subtitle: 'Naik Level: Jadi Relawan Inti',
      headerImageUrl: 'assets/images/jadi-relawan-inti.png',
      description:
          'Naik level dan jadilah relawan inti! Anda akan belajar cara menangani telur, merawat tukik, dan berpartisipasi langsung dalam aksi pelestarian yang lebih mendalam.',
      galleryImages: [
        'assets/images/relawan-inti-1.png',
        'assets/images/relawan-inti-2.jpeg',
        'assets/images/relawan-inti-3.jpeg',
      ],
      buttonText: 'Daftar Jadi Relawan',
    ),
    KomunitasCardData(
      title: 'Turun Tangan',
      subtitle: 'Kalender Aksi Kita',
      headerImageUrl: 'assets/images/turun-tangan.png',
      description:
          'Lihat jadwal aksi bersih-bersih pantai, pelepasan tukik, dan edukasi yang akan datang. Kehadiranmu sangat berarti bagi kami dan para penyu!',
      galleryImages: [
        'assets/images/turun-tangan-1.png',
        'assets/images/turun-tangan-2.jpg',
        'assets/images/turun-tangan-3.jpg',
      ],
      buttonText: 'Ajukan Turun Tangan',
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
          pinned: false,
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          flexibleSpace: SafeArea(
              child: FlexibleSpaceBar(
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
          )
          
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
                    fontSize: 12,
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventOverviewScreen(eventData: data),
            ),
          );
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
                image: AssetImage(data.headerImageUrl),
                fit: BoxFit.cover,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EventOverviewScreen(eventData: data),
                      ),
                    );
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
                          const Shadow(blurRadius: 5.0, color: Colors.black54),
                        ],
                      ),
                    ),
                    Text(
                      data.subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 6.0,
                  ),
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
