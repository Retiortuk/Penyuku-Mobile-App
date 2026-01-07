import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatController {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String> getCurrentUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userSession = prefs.getString('user_session');
    if (userSession != null) {
      final userData = jsonDecode(userSession);
      return userData['email'] ?? "Guest";
    }
    return "Guest";
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    try {
      final email = await getCurrentUserEmail();
      
      await _supabase.from('messages').insert({
        'content': message,
        'sender_email': email,
      });
    } catch (e) {
      throw "Gagal mengirim pesan: $e";
    }
  }

  Stream<List<Map<String, dynamic>>> getMessageStream() {
    return _supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: true)
        .map((data) => List<Map<String, dynamic>>.from(data));
  }
}