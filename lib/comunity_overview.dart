import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:penyuku/comunity_screen.dart';
import 'package:penyuku/controllers/activity_controller.dart'; 

class EventOverviewScreen extends StatefulWidget {
  final KomunitasCardData eventData;

  const EventOverviewScreen({super.key, required this.eventData});

  @override
  State<EventOverviewScreen> createState() => _EventOverviewScreenState();
}

class _EventOverviewScreenState extends State<EventOverviewScreen> {
  final Color _darkBlue = const Color.fromARGB(255, 25, 44, 71);
  final Color _greyText = const Color(0xFF555555);
  final ActivityController _activityController = ActivityController();

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



  Future<void> _handleAction(String actionType) async {
    String message = "";
    Color snackBarColor = Colors.green;

    if (actionType == "delete") {
      try {
        await _activityController.deleteActivity(widget.eventData.id);
        
        message = "Aktivitas berhasil dihapus";
        snackBarColor = Colors.redAccent;

        if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message, style: GoogleFonts.poppins(color: Colors.white)),
              backgroundColor: snackBarColor,
              behavior: SnackBarBehavior.floating,
            ),
          );
          
          Navigator.pop(context); 
        }
        return; 

      } catch (e) {
        message = "Gagal menghapus: $e";
        snackBarColor = Colors.red;
      }

    } else {

      try {
        await _activityController.submitActivity(title: widget.eventData.title, subtitle: widget.eventData.subtitle, description: widget.eventData.description, buttonText: widget.eventData.buttonText);
        message = "Permintaan '${widget.eventData.title}' Berhasil Diajukan!";

        if(mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message, style: GoogleFonts.poppins(color: Colors.white),),
              backgroundColor: snackBarColor,
              behavior: SnackBarBehavior.floating,
            )
          );
          Navigator.pop(context, true);
        }
        return;
      } catch (e) {
        message = "Gagal menghapus: $e";
        snackBarColor = Colors.red;
      }
    }
  }

  ImageProvider _getImageProvider(String url) {
    if (url.startsWith('http')) {
      return NetworkImage(url);
    } else {
      return AssetImage(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
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
                    background: Image(
                      image: _getImageProvider(widget.eventData.headerImageUrl),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(color: Colors.grey[300], child: const Icon(Icons.broken_image));
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: _buildContentSheet(context),
                ),
              ],
            ),

            Positioned(
              top: 0, left: 0,
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
                        width: 50, height: 40,
                        alignment: Alignment.center,
                        child: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            Positioned(
              top: 0, right: 0,
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
                        width: 50, height: 40,
                        alignment: Alignment.center,
                        child: const Icon(Icons.delete_forever_rounded, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: ElevatedButton(
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
                      widget.eventData.buttonText,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentSheet(BuildContext context) {
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
                  widget.eventData.title,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _darkBlue,
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  widget.eventData.description,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: _greyText,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
                
                if (widget.eventData.galleryImages.isNotEmpty)
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.eventData.galleryImages.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 120,
                          margin: const EdgeInsets.only(right: 12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: _getImageProvider(widget.eventData.galleryImages[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                
                const SizedBox(height: 60), 
              ],
            ),
          ),
        ],
      ),
    );
  }
}
