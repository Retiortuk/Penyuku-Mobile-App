import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutItem {
  final String title;
  final String mainImageUrl;
  final String origin;
  final String description;
  final String habitatImageUrl;
  final String habitatCaption;

  AboutItem({
    required this.title,
    required this.mainImageUrl,
    required this.origin,
    required this.description,
    required this.habitatImageUrl,
    required this.habitatCaption,
  });
}

class AboutusScreen extends StatelessWidget {
  static final AboutItem dummyData = AboutItem(
    title: "Penangkaran Nagaraja Cilacap",
    mainImageUrl:
        "assets/images/konservasi.JPG",
    origin: "Cilacap, Jawa Tengah",
    description:
        "Penangkaran Penyu Nagaraja Cilacap merupakan tempat konservasi yang didirikan untuk melindungi dan melestarikan populasi penyu yang semakin terancam di pesisir selatan Jawa. Berlokasi di kawasan pantai yang alami, penangkaran ini berfokus pada kegiatan pelestarian seperti penetasan telur penyu, pelepasan tukik ke laut, serta edukasi kepada masyarakat dan wisatawan tentang pentingnya menjaga ekosistem laut.",
    habitatImageUrl: "assets/images/dev-team-goes-to.jpg",
    habitatCaption: "Team Dev Penyuku Berkunjung Ke Penangkaran",
  );

  final AboutItem item;
  AboutusScreen({super.key, AboutItem? item}) : item = item ?? dummyData;

  final Color _darkBlue = const Color.fromARGB(255, 25, 44, 71);
  final Color _greyText = const Color.fromARGB(255, 25, 44, 71);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  background: _buildBackgroundImage(item.mainImageUrl),
                ),
              ),

              SliverToBoxAdapter(
                child: _buildContentSheet(context, item),
              ),
            ],
          ),
      
          _buildTopButtons(context),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(String imageUrl) {
    return Container(
      height: 350, 
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
    );
  }

  Widget _buildTopButtons(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              color: _darkBlue.withOpacity(0.8),
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
            Material(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(24),
              elevation: 4,
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {
                  // TODO: Tambah ke favorit
                },
                child: Container(
                  width: 50,
                  height: 40,
                  alignment: Alignment.center,
                  child: Icon(Icons.favorite_border, color: Colors.red[700]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentSheet(BuildContext context, AboutItem item) {
    return Container(
      // transform: Matrix4.translationValues(0.0, -20.0, 0.0),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.only(top: 15, bottom: 20),
              decoration: BoxDecoration(
                color: _darkBlue,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _darkBlue,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      "🇮🇩",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.origin,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  item.description,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: _greyText,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Penangkaran Nagaraja",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _darkBlue,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(item.habitatImageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item.habitatCaption,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey[700],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}