import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:penyuku/controllers/report_controller.dart';
import 'package:flutter/services.dart';
import 'package:penyuku/report_overview_screen.dart';


class LaporanScreen extends StatefulWidget {
  const LaporanScreen({super.key});

  @override
  State<LaporanScreen> createState() => _LaporanScreenState();
}

class _LaporanScreenState extends State<LaporanScreen> {
  final Color _darkBlue = const Color.fromARGB(255, 25, 44, 71);
  final ReportController _controller = ReportController();

  List<Map<String, dynamic>> _reports = [];
  bool _isLoading = true;
  int _totalTelur = 0;

  @override
  void initState() {
    super.initState();
    _fetchReports();
  }

  Future<void> _fetchReports() async {
    try {
      final data =  await _controller.getLaporan();

      int telurCount = 0;
      for (var item in data) {
        telurCount += (item['egg_count'] as int? ?? 0);
      }

      setState(() {
        _reports = data;
        _totalTelur = telurCount;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        print("DEBUG: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${e.toString()}"),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ), 
          )
        );
        setState(() {
          _isLoading = false;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: ()=>_fetchReports(),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBackButton(context),
                  _buildSummaryCards(),
                  _buildLaporanTitle(),
                  _isLoading 
                    ? const Center(child: Padding(padding: EdgeInsets.all(50), child: CircularProgressIndicator()))
                    : _buildLaporanList(),
                ],
              ),
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
              icon: Icons.assessment_outlined,
              title: "Total Laporan",
              count: _reports.length,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildSummaryCard(
              icon: Icons.egg_outlined,
              title: "Total Tukik",
              count: _totalTelur,
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
                style: GoogleFonts.poppins(color: Colors.white70, fontSize: 10),
              ),
              Text(
                count.toString(),
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 12,
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

    if (_reports.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              Icon(Icons.folder_off_outlined, size: 50, color: Colors.grey[400]),
              const SizedBox(height: 10),
              Text("Belum ada laporan", style: GoogleFonts.poppins(color: Colors.grey)),
            ],
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: _reports.map((report) {
          return _buildLaporanItem(report);
        }).toList(),
      ),
    );
  }

  Widget _buildLaporanItem(Map<String, dynamic> report) {
    DateTime createdDate = DateTime.parse(report['created_at']).toLocal();
    String formattedDate = DateFormat('dd/MM/yyyy').format(createdDate);
    String formattedTime = DateFormat('HH:mm').format(createdDate);
    String shortId = "#${report['id'].toString().substring(0, 6)}";


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LaporanOverviewScreen(reportData: report),
              // LaporanOverviewScreen(data: report)
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
                      "$formattedDate – $formattedTime",
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    
                    // Nama Laporan (Bold, Biru Tua)
                    Text(
                      report['turtle_type'] ?? 'Jenis Penyu',
                      style: GoogleFonts.poppins(
                        color: _darkBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    
                    // ID Laporan (Kecil, Abu-abu)
                    Text(
                      "ID: $shortId",
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
