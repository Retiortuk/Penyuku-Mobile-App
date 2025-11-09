import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penyuku/komunitas_screen.dart';

class EventOverviewScreen extends StatefulWidget {
  final KomunitasCardData eventData;

  const EventOverviewScreen({super.key, required this.eventData});

  @override
  State<EventOverviewScreen> createState() => _EventOverviewScreenState();
}

class _EventOverviewScreenState extends State<EventOverviewScreen> {
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            "Konfirmasi",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 25, 44, 71),
            ),
          ),
          content: Text(
            "Apakah Anda yakin dengan aksi ini?",
            style: GoogleFonts.poppins(),
          ),
          actions: [
            Container(
              height: 1,
              color: Colors.grey[300],
              margin: const EdgeInsets.only(top: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      "Tidak",
                      style: GoogleFonts.poppins(color: Colors.redAccent),
                    ),
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                  ),
                ),
                Container(width: 1, height: 48, color: Colors.grey[300]),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      "Iya",
                      style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 25, 44, 71),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      _handleDataUpload();
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _handleDataUpload() {
    print("Berhasil Di Ajukan!");

    String message = 'Permintaan berhasil diajukan!';
    if (widget.eventData.title == 'Galeri Aksi Komunitas') {
      message = 'Permintaan Gabung Komunitas Berhasil Diajukan!';
    } else if (widget.eventData.title == 'Jadi Relawan Inti') {
      message = 'Permintaan Jadi Relawan Berhasil Diajukan!';
    } else if (widget.eventData.title == 'Turun Tangan') {
      message = 'Pengajuan Turun Tangan Berhasil Diajukan';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.poppins(color: Colors.white)),
        duration: Duration(seconds: 4),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  final Color _darkBlue = const Color.fromARGB(255, 25, 44, 71);
  final Color _greyText = const Color(0xFF555555);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomScrollView(
            clipBehavior: Clip.none,
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                automaticallyImplyLeading: false,
                expandedHeight: 300,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  background: Image.asset(
                    widget.eventData.headerImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: _buildContentSheet(context, widget.eventData),
              ),
            ],
          ),

          _buildBackButton(context),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 16.0),
        child: Material(
          color: _darkBlue.withOpacity(0.8),
          borderRadius: BorderRadius.circular(15),
          elevation: 4,
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 50,
              height: 40,
              alignment: Alignment.center,
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentSheet(BuildContext context, KomunitasCardData data) {
    return Container(
      transform: Matrix4.translationValues(0.0, -20.0, 0.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              transform: Matrix4.translationValues(0.0, -40.0, 0.0),
              height: 45,
              width: MediaQuery.of(context).size.width * 0.85,
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _darkBlue,
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  data.description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: _greyText,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.galleryImages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 120,
                        margin: const EdgeInsets.only(right: 12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(data.galleryImages[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 60),

                ElevatedButton(
                  onPressed: () {
                    _showConfirmationDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _darkBlue,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    data.buttonText,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
