// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:penyuku/add_activity_screen.dart';
// import 'package:penyuku/controllers/activity_controller.dart';
// import 'comunity_overview.dart'; 

// class KomunitasCardData {
//   final String id;
//   final String title;
//   final String subtitle;
//   final String headerImageUrl;
//   final String secondaryImageUrl;
//   final String description;
//   final List<String> galleryImages;
//   final String buttonText;

//   KomunitasCardData({
//     required this.id,
//     required this.title,
//     required this.subtitle,
//     required this.headerImageUrl,
//     this.secondaryImageUrl = 'assets/images/penyu-tentang.jpg', 
//     required this.description,
//     required this.galleryImages,
//     required this.buttonText,
//   });
// }

// class KomunitasScreen extends StatefulWidget {
//   const KomunitasScreen({super.key});

//   @override
//   State<KomunitasScreen> createState() => _KomunitasScreenState();
// }

// class _KomunitasScreenState extends State<KomunitasScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final TextEditingController _chatController = TextEditingController();
//   final ActivityController _activityController = ActivityController();
  
//   List<Map<String, dynamic>> _activities = [];
//   bool _isLoading = true;

//   final Color _darkBlue = const Color.fromARGB(255, 25, 44, 71);

//   final List<Map<String, String>> _pengajuanList = [
//     {'title': 'Jadi Relawan Inti', 'email': 'user: auliagazzam@gmail.com'},
//     {'title': 'Jadi Relawan Inti', 'email': 'user: ghazazidane@gmail.com'},
//     {'title': 'Turun Tangan', 'email': 'user: satriaramdhn@gmail.com'},
//     {'title': 'Galeri Aksi Komunitas', 'email': 'user: kelvinferdinnd@gmail.com'},
//     {'title': 'Galeri Aksi Komunitas', 'email': 'user: kevinjnsn@gmail.com'},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _fetchActivities();
//     _tabController = TabController(length: 3, vsync: this);
//     _tabController.addListener(() {
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchActivities() async {
//     try {
//       final data = await _activityController.getActivities();
//       setState(() {
//         _activities = data;
//         _isLoading = false;
//       });
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Gagal load data: $e"),
//             backgroundColor: Colors.red,
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   void _showConfirmationDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
//           title: Text("Konfirmasi", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: _darkBlue)),
//           content: Text("Apakah Anda yakin ingin menerima pengajuan ini?", style: GoogleFonts.poppins()),
//           actions: [
//             TextButton(
//               child: Text("Iya", style: GoogleFonts.poppins(color: _darkBlue, fontWeight: FontWeight.bold)),
//               onPressed: () {
//                 Navigator.of(dialogContext).pop();
//                 _handleAcc();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _handleAcc() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Berhasil Menerima Pengajuan User!"), backgroundColor: Colors.green),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       floatingActionButton: _tabController.index == 0
//           ? Container(
//               height: 60, width: 60,
//               decoration: BoxDecoration(color: _darkBlue, borderRadius: BorderRadius.circular(16)),
//               child: IconButton(
//                 onPressed: () async {
//                   final result = await Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const AddActivityScreen()),
//                   );
//                   if (result == true) {
//                     setState(() => _isLoading = true);
//                     _fetchActivities();
//                   }
//                 },
//                 icon: const Icon(Icons.add, color: Colors.white, size: 32),
//               ),
//             )
//           : null,
      
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
//               child: Text(
//                 'Komunitas Penyuku.',
//                 style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: _darkBlue),
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
//               child: TabBar(
//                 controller: _tabController,
//                 labelColor: _darkBlue,
//                 unselectedLabelColor: Colors.grey[400],
//                 indicatorColor: _darkBlue,
//                 indicatorWeight: 3,
//                 labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12),
//                 tabs: const [
//                   Tab(text: 'Aktivitas'),
//                   Tab(text: 'Pengajuan'),
//                   Tab(text: 'Chat'),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   _buildAktivitasList(),
//                   _buildPengajuanList(),
//                   _buildChatTab(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAktivitasList() {
//     if (_isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }
//     if (_activities.isEmpty) {
//       return Center(child: Text("Belum ada aktivitas komunitas.", style: GoogleFonts.poppins()));
//     }
    
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: _activities.length,
//       itemBuilder: (context, index) {
//         final item = _activities[index];

//         final data = KomunitasCardData(
//           id: item['id'].toString(),
//           title: item['title'] ?? 'Tanpa Judul',
//           subtitle: item['subtitle'] ?? 'Event',
          
//           headerImageUrl: item['thumbnail_url'] ?? '', 
          
//           description: item['description'] ?? '',
          
//           galleryImages: (item['gallery_urls'] as List<dynamic>?)
//               ?.map((e) => e.toString())
//               .toList() ?? [],
              
//           buttonText: item['button_text'] ?? 'Selengkapnya',
//         );

//         return _buildKomunitasCard(data);
//       },
//     );
//   }

//   Widget _buildKomunitasCard(KomunitasCardData data) {
    
//     ImageProvider imageProvider;
//     if (data.headerImageUrl.startsWith('http')) {
//       imageProvider = NetworkImage(data.headerImageUrl);
//     } else {
//       imageProvider = const AssetImage('assets/images/placeholder.png'); 
//     }

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
//       child: GestureDetector(
//         onTap: () async {
          
//           final result = await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => EventOverviewScreen(eventData: data),
//             ),
//           );

//           if(result==true) {
//             setState(() => _isLoading = true);
//             _fetchActivities();
//           }
//         },
//         child: Container(
//           height: 180,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             image: DecorationImage(
//               image: imageProvider, 
//               fit: BoxFit.cover,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Stack(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Colors.black.withOpacity(0.6),
//                       Colors.transparent,
//                       Colors.black.withOpacity(0.7),
//                     ],
//                   ),
//                 ),
//               ),

//               Positioned(
//                 top: 20, left: 20, right: 20,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       data.title,
//                       style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       data.subtitle,
//                       style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.9), fontSize: 12, fontWeight: FontWeight.w500),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 bottom: 16, right: 16,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.25),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
//                   ),
//                   child: Text(
//                     data.buttonText,
//                     style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPengajuanList() {
//     return ListView.builder(
//       padding: const EdgeInsets.only(top: 16, bottom: 16),
//       itemCount: _pengajuanList.length,
//       itemBuilder: (context, index) {
//         return _buildPengajuanCard(_pengajuanList[index]);
//       },
//     );
//   }

//   Widget _buildPengajuanCard(Map<String, String> data) {
//     return GestureDetector(
//       onTap: () {
//         _showConfirmationDialog();
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: const Color(0xFFD1D5DB),
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Row(
//             children: [
//               Container(
//                 width: 50, height: 50,
//                 decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
//                 child: const Icon(Icons.person, color: Colors.black, size: 30),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(data['title']!, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: _darkBlue)),
//                     const SizedBox(height: 2),
//                     Text(data['email']!, style: GoogleFonts.poppins(fontSize: 12, color: _darkBlue.withOpacity(0.8)), overflow: TextOverflow.ellipsis),
//                   ],
//                 ),
//               ),
//               Icon(Icons.arrow_forward_ios_rounded, color: _darkBlue, size: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildChatTab() {
//     return Column(
//       children: [
//         // Header Chat
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//           color: _darkBlue,
//           child: Row(
//             children: [
//               Container(
//                 width: 40, height: 40,
//                 decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
//                 child: const Icon(Icons.circle, color: Colors.grey, size: 40),
//               ),
//               const SizedBox(width: 12),
//               Text("Komunitas Penyuku", style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
//             ],
//           ),
//         ),
//         Expanded(child: Container(color: const Color(0xFFD1D5DB))), // Area Chat Kosong
//         // Input Chat
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, -2))],
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   height: 45,
//                   decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(24)),
//                   child: TextField(
//                     controller: _chatController,
//                     style: GoogleFonts.poppins(fontSize: 14),
//                     decoration: InputDecoration(
//                       hintText: "Ketik pesan disini...",
//                       hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 14),
//                       border: InputBorder.none,
//                       contentPadding: const EdgeInsets.only(bottom: 8),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               GestureDetector(
//                 onTap: () => _chatController.clear(),
//                 child: Icon(Icons.send_rounded, color: _darkBlue, size: 28),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:penyuku/add_activity_screen.dart';
import 'package:penyuku/controllers/activity_controller.dart';
import 'comunity_overview.dart';

// Model Data Aktivitas
class KomunitasCardData {
  final String id;
  final String title;
  final String subtitle;
  final String headerImageUrl;
  final String secondaryImageUrl;
  final String description;
  final List<String> galleryImages;
  final String buttonText;

  KomunitasCardData({
    required this.id,
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

class _KomunitasScreenState extends State<KomunitasScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _chatController = TextEditingController();
  final ActivityController _activityController = ActivityController();
  
  // State Data
  List<Map<String, dynamic>> _activities = [];
  List<Map<String, dynamic>> _submissions = []; // List Pengajuan dari DB
  bool _isLoading = true;

  final Color _darkBlue = const Color.fromARGB(255, 25, 44, 71);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchAllData(); // Ambil Aktivitas & Pengajuan
    
    // Refresh UI saat tab ganti (opsional)
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _chatController.dispose();
    super.dispose();
  }

  // --- LOGIC FETCH DATA (Aktivitas & Pengajuan) ---
  Future<void> _fetchAllData() async {
    setState(() => _isLoading = true);
    try {
      // Ambil keduanya secara paralel agar cepat
      final results = await Future.wait([
        _activityController.getActivities(),
        _activityController.getSubmissions(),
      ]);

      setState(() {
        _activities = results[0];
        _submissions = results[1];
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red));
        setState(() => _isLoading = false);
      }
    }
  }

  // --- LOGIC ACC / REJECT PENGAJUAN ---
  void _showConfirmationDialog(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Text("Konfirmasi Pengajuan", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: _darkBlue)),
          content: Text("Pilih tindakan untuk pengajuan '${item['title']}'?", style: GoogleFonts.poppins()),
          actions: [
            // Tombol Tolak (Hapus)
            TextButton(
              child: Text("Tolak", style: GoogleFonts.poppins(color: Colors.redAccent, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _processSubmission(item, isApproved: false);
              },
            ),
            // Tombol Terima (ACC)
            TextButton(
              child: Text("Terima (ACC)", style: GoogleFonts.poppins(color: Colors.green, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _processSubmission(item, isApproved: true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _processSubmission(Map<String, dynamic> item, {required bool isApproved}) async {
    // Tampilkan loading overlay atau indikator sederhana
    setState(() => _isLoading = true);
    
    try {
      if (isApproved) {
        // ACC: Pindah ke table Activities
        await _activityController.approveSubmission(item);
        if (mounted) _showSnackbar("Pengajuan Berhasil Diterima!", Colors.green);
      } else {
        // REJECT: Hapus dari table Submissions
        await _activityController.rejectSubmission(item['id']);
        if (mounted) _showSnackbar("Pengajuan Ditolak & Dihapus.", Colors.redAccent);
      }
      
      // Refresh Data setelah aksi
      _fetchAllData();

    } catch (e) {
      if (mounted) {
        _showSnackbar("Gagal memproses: $e", Colors.red);
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSnackbar(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg, style: GoogleFonts.poppins(color: Colors.white)), backgroundColor: color, behavior: SnackBarBehavior.floating),
    );
  }

  // Helper Image Provider
  ImageProvider _getImageProvider(String? url) {
    if (url != null && url.startsWith('http')) {
      return NetworkImage(url);
    }
    return const AssetImage('assets/images/placeholder.png');
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        
        // FAB untuk Tab Aktivitas
        floatingActionButton: _tabController.index == 0
            ? Container(
                height: 60, width: 60,
                decoration: BoxDecoration(color: _darkBlue, borderRadius: BorderRadius.circular(16)),
                child: IconButton(
                  onPressed: () async {
                    // Navigasi ke Add Activity
                    // NOTE: Jika ingin user biasa masuk ke submissions, AddActivityScreen perlu diubah logicnya
                    // Untuk sekarang asumsi ini menambah ke aktivitas langsung (admin mode)
                    final result = await Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const AddActivityScreen())
                    );
                    if (result == true) _fetchAllData();
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
                child: Text('Komunitas Penyuku.', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: _darkBlue)),
              ),
              Container(
                decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
                child: TabBar(
                  controller: _tabController,
                  labelColor: _darkBlue,
                  unselectedLabelColor: Colors.grey[400],
                  indicatorColor: _darkBlue,
                  indicatorWeight: 3,
                  labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12),
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
                    _buildPengajuanList(), // Tab Pengajuan Dinamis
                    _buildChatTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- TAB 1: LIST AKTIVITAS ---
  Widget _buildAktivitasList() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_activities.isEmpty) return Center(child: Text("Belum ada aktivitas.", style: GoogleFonts.poppins()));

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _activities.length,
      itemBuilder: (context, index) {
        final item = _activities[index];
        final data = KomunitasCardData(
          id: item['id'].toString(),
          title: item['title'] ?? 'Tanpa Judul',
          subtitle: item['subtitle'] ?? 'Event',
          headerImageUrl: item['thumbnail_url'] ?? '',
          description: item['description'] ?? '',
          galleryImages: (item['gallery_urls'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
          buttonText: item['button_text'] ?? 'Selengkapnya',
        );
        return _buildKomunitasCard(data);
      },
    );
  }

  Widget _buildKomunitasCard(KomunitasCardData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: GestureDetector(
        onTap: () async {
          final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => EventOverviewScreen(eventData: data)));
          if (result == true) _fetchAllData();
        },
        child: Container(
          height: 180, width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(image: _getImageProvider(data.headerImageUrl), fit: BoxFit.cover),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.black.withOpacity(0.6), Colors.transparent, Colors.black.withOpacity(0.7)]),
                ),
              ),
              Positioned(
                top: 20, left: 20, right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.title, style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(data.subtitle, style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.9), fontSize: 12, fontWeight: FontWeight.w500), maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              Positioned(
                bottom: 16, right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.25), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white.withOpacity(0.5), width: 1)),
                  child: Text(data.buttonText, style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- TAB 2: LIST PENGAJUAN (DINAMIS DARI DB) ---
  Widget _buildPengajuanList() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_submissions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 50, color: Colors.grey[400]),
            const SizedBox(height: 10),
            Text("Tidak ada pengajuan baru.", style: GoogleFonts.poppins(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: _submissions.length,
      itemBuilder: (context, index) {
        final item = _submissions[index];
        return _buildPengajuanCard(item);
      },
    );
  }

  Widget _buildPengajuanCard(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () => _showConfirmationDialog(item), // Klik untuk ACC/Reject
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFD1D5DB),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              // Avatar
              Container(
                width: 50, height: 50,
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                // Jika ada foto user bisa ditampilkan, jika tidak pakai icon default
                child: const Icon(Icons.person, color: Colors.black, size: 30),
              ),
              const SizedBox(width: 16),
              
              // Teks Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] ?? 'Pengajuan Tanpa Judul',
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: _darkBlue),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      // Tampilkan email submitter atau subtitle
                      item['submitter_email'] != null 
                          ? "Oleh: ${item['submitter_email']}" 
                          : (item['subtitle'] ?? 'Menunggu Persetujuan'),
                      style: GoogleFonts.poppins(fontSize: 12, color: _darkBlue.withOpacity(0.8)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              // Icon Status / Panah
              Icon(Icons.rule_folder_outlined, color: _darkBlue, size: 24),
            ],
          ),
        ),
      ),
    );
  }

  // --- TAB 3: CHAT (STATIC) ---
  Widget _buildChatTab() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          color: _darkBlue,
          child: Row(
            children: [
              Container(width: 40, height: 40, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.circle, color: Colors.grey, size: 40)),
              const SizedBox(width: 12),
              Text("Komunitas Penyuku", style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        Expanded(child: Container(color: const Color(0xFFD1D5DB))),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, -2))]),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 45,
                  decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(24)),
                  child: TextField(
                    controller: _chatController,
                    style: GoogleFonts.poppins(fontSize: 14),
                    decoration: InputDecoration(hintText: "Ketik pesan disini...", hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 14), border: InputBorder.none, contentPadding: const EdgeInsets.only(bottom: 8)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(onTap: () => _chatController.clear(), child: Icon(Icons.send_rounded, color: _darkBlue, size: 28)),
            ],
          ),
        ),
      ],
    );
  }
}

