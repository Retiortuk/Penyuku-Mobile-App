import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'komunitas_overview.dart';

class KomunitasCardData {
  final String title;
  final String subtitle;
  final String headerImageUrl;
  final String secondaryImageUrl;
  final String description;
  final List<String> galleryImages;
  final String buttonText;

  KomunitasCardData({
    required this.title,
    required this.subtitle,
    required this.headerImageUrl,
    this.secondaryImageUrl = 'assets/images/penyu-tentang.jpg',
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

class _KomunitasScreenState extends State<KomunitasScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _chatController = TextEditingController();

  final Color _darkBlue = const Color.fromARGB(255, 25, 44, 71);

  final List<KomunitasCardData> _cardList = [
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
    KomunitasCardData(
      title: 'Galeri Aksi Komunitas',
      subtitle: '"bukti" kalau komunitas ini beneran ada dan seru.',
      headerImageUrl: 'assets/images/galeri-aksi-komunitas.png',
      description:
          'Mulai Berperan Penting Dalam Penyelamatan Penyu, Dengan Menjadi Salah Satu Komunitas Dari Penyuku.',
      galleryImages: [
        'assets/images/galeri-komunitas.png',
        'assets/images/galeri-komunitas2.png.jpg',
        'assets/images/galeri-komunitas3.jpg',
      ],
      buttonText: 'Gabung Komunitas',
    ),
  ];

  final List<Map<String, String>> _pengajuanList = [
    {'title': 'Jadi Relawan Inti', 'email': 'user: auliagazzam@gmail.com'},
    {'title': 'Jadi Relawan Inti', 'email': 'user: ghazazidane@gmail.com'},
    {'title': 'Turun Tangan', 'email': 'user: satriaramdhn@gmail.com'},
    {
      'title': 'Galeri Aksi Komunitas',
      'email': 'user: kelvinferdinnd@gmail.com',
    },
    {'title': 'Galeri Aksi Komunitas', 'email': 'user: kevinjnsn@gmail.com'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      floatingActionButton: _tabController.index == 0
          ? Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: _darkBlue,
                borderRadius: BorderRadius.circular(16),
              ),
              child: IconButton(
                onPressed: () {
                  // TODO: Aksi tambah postingan/aktivitas
                  print("FAB Pressed");
                },
                icon: const Icon(Icons.add, color: Colors.white, size: 32),
              ),
            )
          : null,

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Text(
                'Komunitas Penyuku.',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _darkBlue,
                ),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: _darkBlue,
                unselectedLabelColor: Colors.grey[400],
                indicatorColor: _darkBlue,
                indicatorWeight: 3,
                labelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                unselectedLabelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                tabs: const [
                  Tab(text: 'Aktivitas'),
                  Tab(text: 'Pengajuan'),
                  Tab(text: 'Chat'),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAktivitasList(),

                  _buildPengajuanList(),

                  _buildChatTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAktivitasList() {
    return ListView.builder(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 16,
      ),
      itemCount: _cardList.length,
      itemBuilder: (context, index) {
        return _buildKomunitasCard(_cardList[index]);
      },
    );
  }

  Widget _buildKomunitasCard(KomunitasCardData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventOverviewScreen(eventData: data),
            ),
          );
        },
        child: Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(data.headerImageUrl),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.6), 
                      Colors.transparent,
                      Colors.black.withOpacity(0.7), 
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.subtitle,
                      style: GoogleFonts.poppins(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              Positioned(
                bottom: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25), 
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    "Selengkapnya",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
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

  Widget _buildPengajuanList() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      itemCount: _pengajuanList.length,
      itemBuilder: (context, index) {
        return _buildPengajuanCard(_pengajuanList[index]);
      },
    );
  }

  Widget _buildPengajuanCard(Map<String, String> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFD1D5DB), 
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: Colors.black, size: 30),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title']!,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    data['email']!,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: _darkBlue.withOpacity(0.8),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            Icon(Icons.arrow_forward_ios_rounded, color: _darkBlue, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildChatTab() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          color: _darkBlue,
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.circle, color: Colors.grey, size: 40), 
              ),
              const SizedBox(width: 12),
              Text(
                "Komunitas Penyuku",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: Container(
            color: const Color(0xFFD1D5DB), 
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: TextField(
                    controller: _chatController,
                    style: GoogleFonts.poppins(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: "Ketik pesan disini...",
                      hintStyle: GoogleFonts.poppins(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(bottom: 8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  // TODO: Kirim Pesan
                  print("Send: ${_chatController.text}");
                  _chatController.clear();
                },
                child: Icon(
                  Icons.send_rounded, 
                  color: _darkBlue,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
