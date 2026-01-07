import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ActivityController {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String?> uploadSingleImage(File imageFile) async {
    try {
      final fileName = 'thumb_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final path = 'thumbnails/$fileName';
      
      await _supabase.storage.from('activity_images').upload(path, imageFile);
      return _supabase.storage.from('activity_images').getPublicUrl(path);
    } catch (e) {
      throw "Gagal Upload Thumbnail: $e";
    }
  }

  Future<List<String>> uploadGalleryImages(List<File> images) async {
    List<String> urls = [];
    try {
      for (var image in images) {
        final fileName = 'gallery_${DateTime.now().millisecondsSinceEpoch}_${images.indexOf(image)}.jpg';
        final path = 'gallery/$fileName';

        await _supabase.storage.from('activity_images').upload(path, image);
        final url = _supabase.storage.from('activity_images').getPublicUrl(path);
        urls.add(url);
      }
      return urls;
    } catch (e) {
      throw "Gagal upload galeri: $e";
    }
  }

  Future<void> submitActivity({
    required String title,
    required String subtitle,
    required String description,
    required String buttonText,
    File? thumbnailFile,
    List<File> galleryFiles = const [],
  }) async {
    try {
      String? thumbnailUrl;
      List<String> galleryUrls = [];

      if(thumbnailFile != null) {
        thumbnailUrl = await uploadSingleImage(thumbnailFile);
      }

      if(galleryFiles.isNotEmpty) {
        galleryUrls = await uploadGalleryImages(galleryFiles);
      }

      await _supabase.from('activities').insert({
        'title': title,
        'subtitle': subtitle,
        'description': description,
        'button_text': buttonText,
        'thumbnail_url': thumbnailUrl,
        'gallery_urls': galleryUrls,
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Map<String, dynamic>>> getActivities() async {
    try {
      final response = await _supabase.from('activities').select().order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch(e) {
      throw "Gagal Mengambil data Aktivitas: $e";
    }
  }

  Future<void> deleteActivity(String id) async {
    try {
      await _supabase.from('activities').delete().eq('id', id);
    
    } catch (e) {
      throw "Gagal menghapus aktivitas: $e";
    }
  }

  Future<void> submitApplication({
    required String title,
    required String subtitle,
    required String description,
    required String headerImageUrl,
    required String buttonText,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? userSession = prefs.getString('user_session');
      
      String userEmail = "Guest"; 
      
      if (userSession != null) {
        final userData = jsonDecode(userSession);
        userEmail = userData['email'] ?? userData['username'] ?? "Unknown User";
      }

      await _supabase.from('submissions').insert({
        'title': title,
        'subtitle': subtitle,
        'description': description,
        'thumbnail_url': headerImageUrl, 
        'button_text': buttonText,
        'submitter_email': userEmail, 
        'created_at': DateTime.now().toIso8601String(),
      });

    } catch (e) {
      throw "Gagal mengirim pengajuan: $e";
    }
  }

  Future<List<Map<String, dynamic>>> getSubmissions() async {
    try {
      final response = await _supabase
          .from('submissions')
          .select()
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw "Gagal mengambil pengajuan: $e";
    }
  }

  Future<void> rejectSubmission(String id) async {
    try {
      await _supabase.from('submissions').delete().eq('id', id);
    } catch (e) {
      throw "Gagal menolak pengajuan: $e";
    }
  }

  Future<void> approveSubmission(Map<String, dynamic> submissionData) async {
    try {
      final activityData = {
        'title': submissionData['title'],
        'subtitle': submissionData['subtitle'],
        'description': submissionData['description'],
        'thumbnail_url': submissionData['thumbnail_url'],
        'gallery_urls': submissionData['gallery_urls'],
        'button_text': submissionData['button_text'],
      };

      await _supabase.from('activities').insert(activityData);

      await _supabase.from('submissions').delete().eq('id', submissionData['id']);
      
    } catch (e) {
      throw "Gagal menyetujui pengajuan: $e";
    }
  }

}
