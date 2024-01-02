import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pbl6_aircnc/models/user.dart' as UserModel;
import 'package:http/http.dart' as http;

class AuthRepo {
  static String baseUrl = 'pbl6.whitemage.tech';
  static var signInUrl = 'api/auth/log-in';
  static var signUpUrl = 'api/auth/sign-up';
  static final FlutterSecureStorage storage = const FlutterSecureStorage();

  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<UserModel.User?> signIn(
      String usernameOrEmail, String password) async {
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

        UserModel.User user =
            UserModel.User.fromJson(result['user'] as Map<String, dynamic>);
        String accessToken = result['accessToken'];
        String role = result['role'];
        String refreshToken = result['refreshToken'];

        await storage.write(key: 'accessToken', value: accessToken);
        await storage.write(key: 'role', value: role);
        await storage.write(key: 'refresh_token', value: refreshToken);

        print(user);
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
      print('hi');
      final uri = Uri.parse('https://${baseUrl}/${signUpUrl}');
      final headers = {
        "Content-Type": "application/json",
        'Accept': 'application/json',
      };
      final body = json.encode({
        "username": username,
        "fullName": fullName,
        "email": email,
        "password": password
      });

      final response = await http.post(uri, headers: headers, body: body);
      print(response.body);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return 'ok';
      }

      if (response.statusCode == 400) {
        return result['Email'][0];
      }

      return result['detail'];
    } catch (e) {
      log(e.toString());
      throw Exception('Sign up error');
    }
  }

  static Future<void> deleteAllTokenWhenLogout() async {
    await storage.deleteAll();
  }

  static Future<bool> signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        await _firebaseAuth.signInWithCredential(credential);

        return true;
      }

      return false;
    } catch (e) {
      log(e.toString());
      throw Exception('Sign up error');
    }
  }
}
