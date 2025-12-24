import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penyuku/comunity_screen.dart';
import 'package:flutter/services.dart';

class EventOverviewScreen extends StatefulWidget {
  final KomunitasCardData eventData;

  const EventOverviewScreen({super.key, required this.eventData});

  @override
  State<EventOverviewScreen> createState() => _EventOverviewScreenState();
}

class _EventOverviewScreenState extends State<EventOverviewScreen> {
  void _showConfirmationDialog(String actionType) {
    String titleText = "Konfirmasi";
    String contentText = "Apakah Anda yakin dengan aksi ini?";
    String confirmText = "Iya";
    Color confirmColor = const Color.fromARGB(255, 25, 44, 71);

    if (actionType == "delete") {
      titleText = "Hapus Aktivitas";
      contentText = "Apakah Anda yakin ingin menghapus aktivitas ini?";
      confirmText = "Hapus";
      confirmColor = Colors.redAccent;
    } else {
      contentText = "Apakah Anda yakin ingin mengajukan permintaan ini?";
    }

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            titleText,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: _darkBlue,
            ),
          ),
          content: Text(contentText, style: GoogleFonts.poppins()),
          actionsPadding: EdgeInsets.zero,
          actions: [
            Column(
              children: [
                Container(height: 1, color: Colors.grey[300]),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                        ),
                        child: Text(
                          "Tidak",
                          style: GoogleFonts.poppins(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                      ),
                    ),
                    Container(width: 1, height: 50, color: Colors.grey[300]),
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                        ),
                        child: Text(
                          confirmText,
                          style: GoogleFonts.poppins(
                            color: confirmColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(dialogContext).pop();

                          _handleAction(actionType);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _handleAction(String actionType) {
    String message = "";
    Color snackBarColor = Colors.green;
    print("Berhasil Di Ajukan!");

    if (actionType == "delete") {
      message = "Aktivitas berhasil dihapus";
      snackBarColor = Colors.redAccent;
    } else {
      if (widget.eventData.title == 'Galeri Aksi Komunitas') {
        message = 'Permintaan Gabung Komunitas Berhasil Diajukan!';
      } else if (widget.eventData.title == 'Jadi Relawan Inti') {
        message = 'Permintaan Jadi Relawan Berhasil Diajukan!';
      } else if (widget.eventData.title == 'Turun Tangan') {
        message = 'Pengajuan Turun Tangan Berhasil Diajukan';
      } else {
        message = 'Permintaan berhasil diajukan!';
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.poppins(color: Colors.white)),
        duration: Duration(seconds: 4),
        backgroundColor: snackBarColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    if (actionType == 'delete') {
      Navigator.pop(context);
    }
  }

  final Color _darkBlue = const Color.fromARGB(255, 25, 44, 71);
  final Color _greyText = const Color(0xFF555555);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                clipBehavior: Clip.none,
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    expandedHeight: 350,
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

              Positioned(
                top: 0,
                left: 0,
                child: SafeArea(
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
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 0,
                right: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, right: 16.0),
                    child: Material(
                      color: Colors.red.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(15),
                      elevation: 4,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () => _showConfirmationDialog("delete"),
                        child: Container(
                          width: 50,
                          height: 40,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.delete_forever_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _darkBlue,
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  data.description,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
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
                            image: AssetImage(data.galleryImages[index]),
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
                    _showConfirmationDialog("submit");
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
                      fontSize: 12,
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
