// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   late PageController _pageController;

//   int _currentPageIndex = 1;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             pinned: true,
//             automaticallyImplyLeading: false,
//             toolbarHeight: 80,

//             flexibleSpace: FlexibleSpaceBar(
//               titlePadding: EdgeInsets.zero,
//               centerTitle: true,
//               title: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
//                 decoration: const BoxDecoration(
//                   color: Color.fromARGB(255, 25, 44, 71),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(10.0),
//                     bottomRight: Radius.circular(10.0),
//                   ),
//                 ),
//                 child: Image.asset(
//                   'assets/images/logo-penyu.png',
//                   height: 50,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),

//           SliverToBoxAdapter(child: _buildInfoKomunitas()),

//           SliverFillRemaining(
//             hasScrollBody: false,
//             child: Container(
//               decoration: const BoxDecoration(
//                 color: Color.fromARGB(255, 25, 44, 71),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(24.0),
//                   topRight: Radius.circular(24.0),
//                 ),
//               ),
//               child: _buildBottomContent(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoKomunitas() {
//     return Column(
//       children: [
//         const SizedBox(height: 20),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Info Seputar Komunitas",
//                 style: GoogleFonts.poppins(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               Icon(Icons.notifications_none, color: Colors.grey[700]),
//             ],
//           ),
//         ),
//         const SizedBox(height: 20),

//         Container(
//           height: 200,
//           child: PageView.builder(
//             controller: _pageController,
//             itemCount: 3,
//             onPageChanged: (int index) {
//               setState(() {
//                 _currentPageIndex = index;
//               });
//             },

//             itemBuilder: (context, index) {
//               return Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 8.0),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(16),
//                   image: const DecorationImage(
//                     image: NetworkImage('assets/images/penyu-tentang.jpg'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: Align(
//                   alignment: Alignment.bottomLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(
//                       "Penyu Berkelana Jauh?\nYuk Pelajari Penyu Madura",
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         shadows: [
//                           Shadow(blurRadius: 10.0, color: Colors.black87),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 25),
//         _buildPageIndicator(),
//         const SizedBox(height: 40),
//       ],
//     );
//   }

//   Widget _buildBottomContent() {
//     return SingleChildScrollView(
//       child: Container(
//         margin: const EdgeInsets.only(top: 30.0),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(24.0),
//             topRight: Radius.circular(24.0),
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Center(
//                 child: Container(
//                   width: 40,
//                   height: 5,
//                   margin: const EdgeInsets.only(bottom: 15),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[400],
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),

//               _buildHaloUser(),
//               const SizedBox(height: 40),
//               _buildActionButtons(),
//               const SizedBox(height: 40),
//               _buildWelcomeCard(),
//               const SizedBox(height: 20),
//               _buildEduCard(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHaloUser() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 25, 44, 71),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Hallo, Kevin",
//             style: GoogleFonts.poppins(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             "Data Keseluruhan Pada Tahun ini",
//             style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
//           ),

//           const SizedBox(height: 16),
//           Row(
//             children: [
//               Expanded(
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: const LinearProgressIndicator(
//                     value: 0.5,
//                     backgroundColor: Colors.white24,
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                     minHeight: 12,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Text(
//                 "50%",
//                 style: GoogleFonts.poppins(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "20 Juli 2025",
//                 style: GoogleFonts.poppins(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 "view all",
//                 style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButtons() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           _buildActionButton(Icons.note_add_outlined, "Pencatatan"),
//           _buildActionButton(Icons.description_outlined, "Laporan"),
//           _buildActionButton(Icons.map_outlined, "Letak Penelusuran"),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButton(IconData icon, String label) {
//     return Column(
//       children: [
//         Container(
//           width: 80,
//           height: 80,
//           decoration: BoxDecoration(
//             color: const Color.fromARGB(255, 25, 44, 71),
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Icon(icon, color: Colors.white, size: 40),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           label,
//           style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
//         ),
//       ],
//     );
//   }

//   Widget _buildWelcomeCard() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 25, 44, 71),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Selamat datang di Penangkaran Penyu Cilacap",
//                   style: GoogleFonts.poppins(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   "Bersama melestarikan penyu untuk generasi\nmendatang bersama Penangkaran Nagaraja",
//                   style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
//                 ),
//                 const SizedBox(height: 12),
//                 Wrap(
//                   spacing: 10.0,
//                   runSpacing: 4.0,
//                   children: [
//                     // Chip(label: Text('Gabung komunitas', style: GoogleFonts.poppins(fontSize: 11)), padding: EdgeInsets.all(8.0)),
//                     Chip(
//                       label: Text(
//                         'Tentang Penangkaran',
//                         style: GoogleFonts.poppins(fontSize: 11),
//                       ),
//                       padding: EdgeInsets.all(8.0),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Image.asset(
//             'assets/images/logo-penyu.png',
//             height: 70,
//             color: Colors.white,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEduCard() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 25, 44, 71),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Penyu Terbesar di Dunia!",
//                   style: GoogleFonts.poppins(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   "Tahukah Kamu Bahwa Penyu Madura Adalah Penyu Terbesar di Dunia dan Suka Berkelana Jauh Dari Selat Jawa Hingga Australia, Yuk Belajar!",
//                   style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
//                 ),
//                 const SizedBox(height: 12),
//                 Wrap(
//                   spacing: 10.0,
//                   runSpacing: 4.0,
//                   children: [
//                     // Chip(label: Text('Gabung komunitas', style: GoogleFonts.poppins(fontSize: 11)), padding: EdgeInsets.all(8.0)),
//                     Chip(
//                       label: Text(
//                         'Pelajari Penyu Madura',
//                         style: GoogleFonts.poppins(fontSize: 11),
//                       ),
//                       padding: EdgeInsets.all(8.0),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Image.asset(
//             'assets/images/logo-penyu.png',
//             height: 70,
//             color: Colors.white,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPageIndicator() {
//     int itemCount = 3;

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(itemCount, (index) {
//         bool isActive = index == _currentPageIndex;
//         return AnimatedContainer(
//           duration: const Duration(milliseconds: 150),
//           margin: const EdgeInsets.symmetric(horizontal: 4.0),
//           height: 8.0,
//           width: isActive ? 24.0 : 8.0,
//           decoration: BoxDecoration(
//             color: isActive
//                 ? const Color.fromARGB(255, 25, 44, 71)
//                 : Colors.grey[300],
//             borderRadius: BorderRadius.circular(12),
//           ),
//         );
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PageController _pageController;

  int _currentPageIndex = 1;

  int _bottomNavIndex = 0; 

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 1, 
      viewportFraction: 0.8, 
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            pinned: true, 
            automaticallyImplyLeading: false,
            toolbarHeight: 80,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              centerTitle: true,
              title: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 25, 44, 71),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0), // Disesuaikan dari 24
                      bottomRight: Radius.circular(10.0), // Disesuaikan dari 24
                    )),
                child: Image.asset(
                  'assets/images/logo-penyu.png',
                  height: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          
          SliverToBoxAdapter(
            child: _buildInfoKomunitas(),
          ),

          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 25, 44, 71),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
              child: _buildBottomContent(),
            ),
          ),
        ],
      ),

      Center(
        child: Text(
          'Komunitas',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),

      Center(
        child: Text(
          'Profile',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      body: screens[_bottomNavIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _bottomNavIndex, 
        onTap: (int index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
        selectedItemColor: const Color.fromARGB(255, 25, 44, 71), // Warna biru tua
        unselectedItemColor: Colors.grey[400],
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group), 
            label: 'Komunitas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), 
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoKomunitas() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Info Seputar Komunitas",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Icon(Icons.notifications_none, color: Colors.grey[700]),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          child: PageView.builder(
            controller: _pageController, 
            itemCount: 3,
            onPageChanged: (int index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'assets/images/penyu-tentang.jpg'), // Pastikan ini URL atau aset lokal
                      fit: BoxFit.cover,
                    )),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Penyu Berkelana Jauh?\nYuk Pelajari Penyu Madura", // Teks diganti
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          shadows: [
                            Shadow(blurRadius: 10.0, color: Colors.black87) // Shadow diganti
                          ]),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 25),
        _buildPageIndicator(),

        const SizedBox(height: 40), 
      ],
    );
  }

  Widget _buildBottomContent() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 30.0),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              _buildHaloUser(),
              const SizedBox(
                height: 40,
              ), 
              _buildActionButtons(),
              const SizedBox(
                height: 40,
              ), 
              _buildWelcomeCard(),
              const SizedBox(height: 20),
              _buildEduCard(), 
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHaloUser() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 25, 44, 71), // Warna disamakan
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hallo, Kevin",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Data Keseluruhan Pada Tahun ini",
            style: GoogleFonts.poppins(
              color: Colors.white, 
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          // Progress Bar
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const LinearProgressIndicator(
                    value: 0.5, // 50%
                    backgroundColor: Colors.white24,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    minHeight: 12,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "50%",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "20 Juli 2025",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Text(
              //   "view all",
              //   style: GoogleFonts.poppins(
              //     color: Colors.white, 
              //     fontSize: 12,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionButton(Icons.note_add_outlined, "Pencatatan"),
          _buildActionButton(Icons.description_outlined, "Laporan"),
          _buildActionButton(Icons.map_outlined, "Statistik"),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 25, 44, 71),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: Colors.white, size: 40),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 25, 44, 71), 
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selamat datang di Penangkaran Penyu Cilacap",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Bersama melestarikan penyu untuk generasi\nmendatang bersama Penangkaran Nagaraja", // Teks diganti
                  style: GoogleFonts.poppins(
                    color: Colors.white, 
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10.0, 
                  runSpacing: 4.0,
                  children: [
                    Chip(
                      label: Text(
                        'Tentang Penangkaran', 
                        style: GoogleFonts.poppins(fontSize: 11), 
                      ),
                      padding: EdgeInsets.all(8.0), 
                    ),
                  ],
                )
              ],
            ),
          ),
          Image.asset(
            'assets/images/logo-penyu.png',
            height: 70,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildEduCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 25, 44, 71),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Penyu Terbesar di Dunia!",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Tahukah Kamu Bahwa Penyu Madura Adalah Penyu Terbesar di Dunia dan Suka Berkelana Jauh Dari Selat Jawa Hingga Australia, Yuk Belajar!",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 4.0,
                  children: [
                    Chip(
                      label: Text(
                        'Pelajari Penyu Madura',
                        style: GoogleFonts.poppins(fontSize: 11),
                      ),
                      padding: EdgeInsets.all(8.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/images/logo-penyu.png',
            height: 70,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    int itemCount = 3;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        bool isActive = index == _currentPageIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: 8.0,
          width: isActive ? 24.0 : 8.0, 
          decoration: BoxDecoration(
            color: isActive
                ? const Color.fromARGB(255, 25, 44, 71)
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }
}