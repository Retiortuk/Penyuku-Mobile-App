import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:penyuku/controllers/report_controller.dart';

class StatistikScreen extends StatefulWidget {
  const StatistikScreen({super.key});

  @override
  State<StatistikScreen> createState() => _StatistikScreenState();
}

class _StatistikScreenState extends State<StatistikScreen> {
  final Color _darkBlue = const Color.fromARGB(255, 25, 44, 71);
  final Color _lightGreyBg = const Color(0xFFF7F8FA);

  final ReportController _reportController =ReportController();
  
  int _totalTelur = 0;

  @override
  void initState() {
    super.initState();
    _fetchAllData();
  }

  Future<void> _fetchAllData() async {
    try {
      final data = await _reportController.getLaporan();

      int totalEgg = 0;
      for (var item in data) {
        totalEgg += (item['egg_count'] as int? ?? 0);
      }

      setState(() {
        _totalTelur = totalEgg;
      });

    } catch (e) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal Mengambil Data: Error: ${e.toString()}"),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ), 
          )
        );
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBackButton(context),
                _buildHeader(),
                _buildChartCard(),
                const SizedBox(height: 16),
                _buildPenyuCard(),
                const SizedBox(height: 16),
                _buildTelurCard(),
                const SizedBox(height: 20),
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
          onTap: () => Navigator.of(context).pop(),
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 16.0),
      child: Text(
        "Statistik Penyu",
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: _darkBlue,
        ),
      ),
    );
  }

  Widget _buildChartCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _darkBlue),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Charts",
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: _darkBlue,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(height: 200, child: BarChart(_mainBarChartData())),
          ],
        ),
      ),
    );
  }

  Widget _buildPenyuCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _darkBlue),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Penyu",
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: _darkBlue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "75",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _darkBlue,
              ),
            ),
            const SizedBox(height: 12),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: _lightGreyBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  height: 12,
                  width: (MediaQuery.of(context).size.width - 72) * 0.75,
                  decoration: BoxDecoration(
                    color: _darkBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Positioned(
                  left: (MediaQuery.of(context).size.width - 72) * 0.75 - 25,
                  bottom: 15,
                  child: Text(
                    "75%",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _darkBlue,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 15,
                  child: Text(
                    "75/100",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "Kapasitas penangkaran",
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTelurCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _darkBlue),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Telur penyu",
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: _darkBlue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _totalTelur.toString(),
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: _darkBlue,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const SizedBox(width: 4),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Telur Saat ini Berdasarkan Laporan",
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  BarChartData _mainBarChartData() {
    final List<double> chartData = [
      300,
      750,
      800,
      780,
      150,
      450,
      300,
      550,
      530,
    ];

    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: 1000,
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 35,
            getTitlesWidget: _leftTitles,
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            getTitlesWidget: _bottomTitles,
          ),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      // Data Bar
      barGroups: List.generate(chartData.length, (index) {
        return BarChartGroupData(
          x: index + 1,
          barRods: [
            BarChartRodData(
              toY: chartData[index],
              color: _darkBlue,
              width: 16,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _leftTitles(double value, TitleMeta meta) {
    if (value == 0 ||
        value == 250 ||
        value == 500 ||
        value == 750 ||
        value == 1000) {
      return Text(
        value.toInt().toString(),
        style: GoogleFonts.poppins(color: Colors.grey[700], fontSize: 10),
      );
    }
    return Container();
  }

  Widget _bottomTitles(double value, TitleMeta meta) {
    return Text(
      value.toInt().toString(),
      style: GoogleFonts.poppins(color: Colors.grey[700], fontSize: 10),
    );
  }
}
