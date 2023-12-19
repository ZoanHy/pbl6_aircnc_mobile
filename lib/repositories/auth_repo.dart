import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pbl6_aircnc/models/user.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  static String baseUrl = 'pbl6.whitemage.tech';
  static var signInUrl = 'api/auth/user/log-in';
  static var signUpUrl = 'api/auth/sign-up';
  static final FlutterSecureStorage storage = const FlutterSecureStorage();

  static Future<User?> signIn(String usernameOrEmail, String password) async {
    try {
      final uri = Uri.parse('https://${baseUrl}/${signInUrl}');
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      final body =
          jsonEncode({'identifier': usernameOrEmail, 'password': password});
      final response = await http.post(uri, headers: headers, body: body);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        User user = User.fromJson(result['user'] as Map<String, dynamic>);
        String accessToken = result['accessToken'];
        String role = result['role'];
        String refreshToken = result['refreshToken'];

        await storage.write(key: 'accessToken', value: accessToken);
        await storage.write(key: 'role', value: role);
        await storage.write(key: 'refresh_token', value: refreshToken);

        return user;
      }
      return null;
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to sign in');
    }
  }

  static Future<String> signUp(
      {required String username,
      required String fullName,
      required String email,
      required String password}) async {
    try {
      final uri = Uri.parse('https://${baseUrl}/${signUpUrl}');
      final headers = {"Content-Type": "application/json"};
      final body = json.encode({
        "username": username,
        "fullName": fullName,
        "email": email,
        "password": password
      });

      final response = await http.post(uri, headers: headers, body: body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return 'ok';
      }

      return result['detail'];
    } catch (e) {
      log(e.toString());
      throw Exception('Sign up error');
    }
  }
}
