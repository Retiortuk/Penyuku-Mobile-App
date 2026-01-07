import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:penyuku/add_activity_screen.dart';
import 'package:penyuku/controllers/activity_controller.dart';
import 'package:penyuku/controllers/chat_controller.dart';
import 'comunity_overview.dart';

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
  final TextEditingController _messageInputController = TextEditingController();
  final ChatController _chatController =  ChatController();
  final ActivityController _activityController = ActivityController();
  final ScrollController _scrollController = ScrollController();
  
  List<Map<String, dynamic>> _activities = [];
  List<Map<String, dynamic>> _submissions = []; 
  bool _isLoading = true;
  String _currentUserEmail = "";

  final Color _darkBlue = const Color.fromARGB(255, 25, 44, 71);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchAllData();
    _loadCurrentUser();
    
    // Refresh UI saat tab ganti (opsional)
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) setState(() {});
    });
  }

  Future<void> _loadCurrentUser() async {
    final email = await _chatController.getCurrentUserEmail();
    if(mounted) {
      setState(() => _currentUserEmail = email);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _messageInputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchAllData() async {
    setState(() => _isLoading = true);
    try {
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

  void _sendMessage() async {
    if (_messageInputController.text.trim().isEmpty) return;
    
    String msg = _messageInputController.text;
    _messageInputController.clear(); 

    try {
      await _chatController.sendMessage(msg);
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 50, 
          duration: const Duration(milliseconds: 300), 
          curve: Curves.easeOut
        );
      }
    } catch (e) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gagal kirim: $e")));
      }
    }
  }

  void _showConfirmationDialog(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Text("Konfirmasi Pengajuan", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: _darkBlue)),
          content: Text("Pilih tindakan untuk pengajuan '${item['title']}'?", style: GoogleFonts.poppins()),
          actions: [
            TextButton(
              child: Text("Tolak", style: GoogleFonts.poppins(color: Colors.redAccent, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _processSubmission(item, isApproved: false);
              },
            ),
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
    
    setState(() => _isLoading = true);
    
    try {
      if (isApproved) {
        await _activityController.approveSubmission(item);
        if (mounted) _showSnackbar("Pengajuan Berhasil Diterima!", Colors.green);
      } else {
        await _activityController.rejectSubmission(item['id']);
        if (mounted) _showSnackbar("Pengajuan Ditolak & Dihapus.", Colors.redAccent);
      }
      
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
        
        floatingActionButton: _tabController.index == 0
            ? Container(
                height: 60, width: 60,
                decoration: BoxDecoration(color: _darkBlue, borderRadius: BorderRadius.circular(16)),
                child: IconButton(
                  onPressed: () async {
                  
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
                    _buildPengajuanList(), 
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
      onTap: () => _showConfirmationDialog(item), 
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
              Container(
                width: 50, height: 50,
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: const Icon(Icons.person, color: Colors.black, size: 30),
              ),
              const SizedBox(width: 16),
              
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
                      item['submitter_email'] != null 
                          ? "Oleh: ${item['submitter_email']}" 
                          : (item['subtitle'] ?? 'Menunggu Persetujuan'),
                      style: GoogleFonts.poppins(fontSize: 12, color: _darkBlue.withOpacity(0.8)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              Icon(Icons.rule_folder_outlined, color: _darkBlue, size: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatTab() {
    return Column(
      children: [
        // 1. Header Chat
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          color: _darkBlue,
          child: Row(
            children: [
              Container(width: 40, height: 40, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.people_alt, color: Colors.grey, size: 24)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Komunitas Penyuku", style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                  Text("Online Member", style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
                ],
              )
            ],
          ),
        ),

        // 2. Chat Area (Stream Builder)
        Expanded(
          child: Container(
            color: const Color(0xFFF5F5F5), // Background abu muda
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _chatController.getMessageStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Center(child: Text("Error: ${snapshot.error}"));
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                final messages = snapshot.data!;

                if (messages.isEmpty) {
                  return Center(child: Text("Belum ada obrolan. Mulai sapa!", style: GoogleFonts.poppins(color: Colors.grey)));
                }

                // Otomatis scroll ke bawah saat pertama kali load
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollController.hasClients && _scrollController.position.atEdge) {
                     // Logic optional: hanya scroll jika user sudah di paling bawah
                  }
                });

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isMe = msg['sender_email'] == _currentUserEmail;
                    return _buildChatBubble(msg['content'], msg['sender_email'], isMe);
                  },
                );
              },
            ),
          ),
        ),

        // 3. Input Chat
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
                    controller: _messageInputController,
                    style: GoogleFonts.poppins(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: "Ketik pesan disini...",
                      hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 14),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(bottom: 8),
                    ),
                    onSubmitted: (_) => _sendMessage(), // Kirim saat tekan Enter di keyboard
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: _sendMessage,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: _darkBlue.withOpacity(0.1)),
                  child: Icon(Icons.send_rounded, color: _darkBlue, size: 24),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget Bubble Chat
  Widget _buildChatBubble(String message, String sender, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75), // Maksimal lebar 75% layar
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // Nama Pengirim (Hanya jika bukan saya)
            if (!isMe)
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 4),
                child: Text(sender.split('@')[0], style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[600], fontWeight: FontWeight.bold)),
              ),
            
            // Bubble Isi Pesan
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMe ? _darkBlue : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: isMe ? const Radius.circular(16) : Radius.zero, // Lancip di kiri bawah jika orang lain
                  bottomRight: isMe ? Radius.zero : const Radius.circular(16), // Lancip di kanan bawah jika saya
                ),
                boxShadow: [
                  if (!isMe) BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2, offset: const Offset(0, 1))
                ]
              ),
              child: Text(
                message,
                style: GoogleFonts.poppins(
                  color: isMe ? Colors.white : Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

