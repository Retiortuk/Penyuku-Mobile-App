import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController {
  final SupabaseClient _supabase = Supabase.instance.client;

  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes); 
    return digest.toString();
  }

  //Register Logic
  Future<void> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final exisitingUser = await _supabase
        .from('users')
        .select()
        .or('email.eq.$email, username.eq.$username');
      if(exisitingUser.isNotEmpty) {
        throw "Email atau Username Sudah Terdaftar";
      }
      
      await _supabase.from('users').insert({
        'name': name,
        'username': username,
        'email': email,
        'password': _hashPassword(password),
        'level': 'user', // default
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw e.toString();
    }
  }

  // Login Logic
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final hashedPassword = _hashPassword(password);

      final response = await _supabase
        .from('users')
        .select()
        .eq('email', email)
        .eq('password', hashedPassword)
        .maybeSingle();
      
      if(response == null) {
        throw "Email Atau Password Salah!";
      }
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  User? get currentUser => _supabase.auth.currentUser;

  // Logout Logic
  Future<void> logout() async {
    await _supabase.auth.signOut();
  }
}