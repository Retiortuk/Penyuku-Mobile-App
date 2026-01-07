import 'dart:convert';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:crypto/crypto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Future<void> login({
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

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_session', jsonEncode(response));
    } catch (e) {
      throw e.toString();
    }
  }

  //Check Session User
  Future<bool> checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('user_session');
  }

  //Ambil data User
  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('user_session');

    if(data != null) {
      return jsonDecode(data);
    }
    return null;
  }

  User? get currentUser => _supabase.auth.currentUser;

  // Logout Logic
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_session');
  }

  // Forget Password
  Future<void> sendRecoveryEmail(String email) async {
    final userCheck = await _supabase
        .from('users')
        .select()
        .eq('email', email)
        .maybeSingle();

    if (userCheck == null) {
      throw "Email tidak terdaftar!";
    }

    final otp = (Random().nextInt(9000) + 1000).toString();

    await _supabase.from('password_resets').delete().eq('email', email);
    await _supabase.from('password_resets').insert({
      'email': email,
      'otp': otp,
      'created_at': DateTime.now().toIso8601String(),
    });
    
    String username = dotenv.env['USER_EMAIL'] ?? '';
    String password = dotenv.env['APP_PASSWORD'] ?? '';

    if(username.isEmpty || password.isEmpty) {
      throw "Konfigurasi Email Server (SMTP) belum diatur di file .env";
    }

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Tim Penyuku')
      ..recipients.add(email)
      ..subject = 'Kode OTP Reset Password'
      ..text = 'Kode OTP Anda adalah: $otp\n\nJangan berikan kode ini ke siapa pun.';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } catch (e) {
      print('Message not sent. \n' + e.toString());
      print("DEV MODE - OTP ANDA ADALAH: $otp");
      throw "Gagal mengirim email (Cek Console untuk OTP Dev Mode)";
    }
  }

  Future<void> verifyOtp(String email, String otpInput) async {
    final response = await _supabase
        .from('password_resets')
        .select()
        .eq('email', email)
        .eq('otp', otpInput)
        .maybeSingle();

    if (response == null) {
      throw "Kode OTP salah atau kadaluarsa!";
    }
    
    //OTP expired max 10 menit
    DateTime created = DateTime.parse(response['created_at']);
    if (DateTime.now().difference(created).inMinutes > 10) throw "OTP Kadaluarsa";
  }

  Future<void> resetPassword(String email, String newPassword) async {
    final hashedPassword = _hashPassword(newPassword);

    await _supabase
        .from('users')
        .update({'password': hashedPassword})
        .eq('email', email);

    await _supabase.from('password_resets').delete().eq('email', email);
  }
}
