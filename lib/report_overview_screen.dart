import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:penyuku/controllers/report_controller.dart';

class LaporanOverviewScreen extends StatelessWidget {
  final Map<String, dynamic> reportData;
  final ReportController _reportController = ReportController();

  LaporanOverviewScreen({super.key, required this.reportData});

  Future<void> _launchMaps() async {
    final lat = reportData['latitude'];
    final long =  reportData['longitude'];

    final Uri googleMapsUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$long");

    try {
      if(!await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication)) {
        throw 'Could not open maps';
      } 
    } catch (e) {
      debugPrint('Error launching maps: $e');
    }
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context, 
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(
            "Hapus Laporan?",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: const Color(0xFF1A2B45))
          ),
          content: Text(
            "Laporan ini akan dihapus secara permanen. Tindakan ini tidak dapat dibatalkan.", 
            style: GoogleFonts.poppins(fontSize: 14)
          ),
          actions: [
            TextButton(
              onPressed: ()=> Navigator.of(dialogContext).pop(), 
              child: Text("Batal", style: GoogleFonts.poppins(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _handleDelete(context);
              }, 
              child: Text("Iya",style: GoogleFonts.poppins(color: Colors.red, fontWeight: FontWeight.bold))
            )
          ],
        );
      }
    );
  }

  Future<void> _handleDelete(BuildContext context) async {
    try {
      await _reportController.deleteLaporan(reportData['id'].toString());

      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Berhasil Menghapus Laporan', style: GoogleFonts.poppins(color: Colors.white),),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ), 
          )
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll("Exception: ", ""), style: GoogleFonts.poppins(color: Colors.white),),
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

  Future<void> _generatePdf(BuildContext context) async {
    final pdf = pw.Document();

    final netImage = reportData['image_url'] != null
      ? await networkImage(reportData['image_url'])
      : null;

    DateTime createdDate = DateTime.parse(reportData['created_at']).toLocal();
    String dateStr = DateFormat('dd MMMM yyyy, HH:mm').format(createdDate);
    String foundDateStr = DateFormat('dd MMMM yyyy').format(DateTime.parse(reportData['found_date']).toLocal());

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {

          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header Dokumen
              pw.Header(
                level: 0,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("LAPORAN PENYUKU", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                    pw.Text("ID: #${reportData['id'].toString().substring(0, 8)}", style: const pw.TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              if (netImage != null)
                pw.Container(
                  height: 200,
                  width: double.infinity,
                  decoration: pw.BoxDecoration(
                    image: pw.DecorationImage(image: netImage, fit: pw.BoxFit.cover),
                    borderRadius: pw.BorderRadius.circular(8),
                  ),
                ),
              pw.SizedBox(height: 20),

              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300),
                children: [
                  _buildPdfRow("Tanggal Lapor", dateStr),
                  _buildPdfRow("Jenis Penyu", reportData['turtle_type'] ?? '-'),
                  _buildPdfRow("Jenis Kelamin", reportData['gender'] ?? '-'),
                  _buildPdfRow("Jumlah Telur", "${reportData['egg_count']} Butir"),
                  _buildPdfRow("Tanggal Ditemukan", foundDateStr),
                  _buildPdfRow("Lokasi (Koordinat)", "${reportData['latitude']}, ${reportData['longitude']}"),
                ],
              ),

              pw.SizedBox(height: 30),
              pw.Divider(),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text("Dicetak otomatis oleh Sistem PenyuKu", style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey)),
              ),
            ]          
          );
        }
      )
    );
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'Laporan-Penyu-${reportData['id'].substring(0,6)}',
    );
  }

  pw.TableRow _buildPdfRow(String label, String value) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(label, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(value),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    DateTime createdDate = DateTime.parse(reportData['created_at']).toLocal();
    String formattedDate = DateFormat('dd MMMM yyyy, HH:mm').format(createdDate);
    String foundDateStr = DateFormat('dd MMMM yyyy').format(DateTime.parse(reportData['found_date']).toLocal());
    String shortId = "#${reportData['id'].toString().substring(0, 8)}";

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Detail Laporan", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              _showDeleteConfirmation(context);
            }, 
            icon: const Icon(Icons.delete_outlined, color: Colors.red,),
            tooltip: 'Hapus Laporan',
          ),
          const SizedBox(width: 8,)
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Dokumen
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Penyuku", style: GoogleFonts.kronaOne(fontSize: 18, color: const Color(0xFF1A2B45))),
                      Text("Pelaporan", style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey, letterSpacing: 2)),
                    ],
                  ),
                  const Divider(height: 30, thickness: 1),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ID Laporan", style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey)),
                          Text(shortId, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: const Color(0xFF1A2B45))),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Tanggal", style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey)),
                          Text(formattedDate, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: const Color(0xFF1A2B45))),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  if (reportData['image_url'] != null)
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(reportData['image_url']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  else
                    Container(
                      height: 100,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text("Tidak ada gambar", style: GoogleFonts.poppins(color: Colors.grey)),
                    ),
                  
                  const SizedBox(height: 24),
                  
                  Text("Data Penemuan", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 10),
                  _buildDetailRow("Jenis Penyu", reportData['turtle_type'] ?? '-'),
                  _buildDetailRow("Jenis Kelamin", reportData['gender'] ?? '-'),
                  _buildDetailRow("Jumlah Telur", "${reportData['egg_count']} Butir"),
                  _buildDetailRow("Tgl Ditemukan", foundDateStr),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Koordinat", style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 13)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${reportData['latitude']}, ${reportData['longitude']}",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 13)
                            ),
                            const SizedBox(height: 4),
                            GestureDetector(
                              onTap: _launchMaps,
                              child: Row(
                                children: [
                                  const Icon(Icons.map, size: 14, color: Colors.blueAccent),
                                  const SizedBox(width: 4),
                                  Text(
                                    "Lihat di Google Maps", 
                                    style: GoogleFonts.poppins(
                                      color: Colors.blueAccent, 
                                      fontSize: 11, 
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline
                                    )
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  Divider(
                    color: Colors.grey[300],
                    height: 20,
                    thickness: 1,
                  ),
                  Center(
                    child: Text(
                      "KONSERVASI PENYU CILACAP \nJl. Seloka Maya, Sawah,Ladang, Karangbenda, Kec. Adipala, Kabupaten Cilacap, Jawa Tengah 53271",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey, fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => _generatePdf(context),
                icon: const Icon(Icons.download_rounded, color: Colors.white),
                label: Text("Download PDF", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A2B45),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 13)),
          Text(value, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.black87, fontSize: 13)),
        ],
      ),
    );
  }
}