import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReportController {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Upload gambar ke storage supabase
  Future<String?> uploadImage(File imageFile) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final path = 'reports/$fileName';

      await _supabase.storage.from('report_images').upload(path, imageFile);
      final imageUrl = _supabase.storage.from('report_images').getPublicUrl(path);
      return imageUrl;
    } catch (e) {
      throw "Gagal Upload Gambar: $e";
    }
  }

  // Upload Laporan
  Future<void> submitReport({
    required String turtleType,
    required String gender,
    required int eggCount,
    required DateTime foundDate,
    required double lat,
    required double long,
    File? imageFile,
  }) async {
    try {
      String? imageUrl;

      if(imageFile != null) {
        imageUrl = await uploadImage(imageFile);
      }

      final userId = _supabase.auth.currentUser?.id;

      await _supabase.from('reports').insert({
        'user_id': userId,
        'turtle_type': turtleType,
        'gender': gender,
        'egg_count': eggCount,
        'found_date': foundDate.toIso8601String(),
        'latitude': lat,
        'longitude': long,
        'image_url': imageUrl,
      });
    } catch (e) {
      throw e.toString();
    }
  }
}