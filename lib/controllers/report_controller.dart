import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReportController {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String?> _getLocalUserId() async {
    final prefs = await SharedPreferences.getInstance();
    String? sessionData = prefs.getString('user_session');

    if(sessionData != null) {
      final userMap = jsonDecode(sessionData);
      return userMap['id'];
    }
    return null;
  }

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

      final userId = await _getLocalUserId();
      if(userId == null) {
        throw "Sesi Habis Silahkan Login Kembali";
      }

      String? imageUrl;
      if(imageFile != null) {
        imageUrl = await uploadImage(imageFile);
      }


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