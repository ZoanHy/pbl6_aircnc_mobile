import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pbl6_aircnc/models/booking.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6_aircnc/models/user_detail.dart';

class UserRepo {
  static String baseUrl = 'pbl6.whitemage.tech';
  static String userUrl = 'api/users';

  static Future<UserDetail> getUserDetail(int userId) async {
    final queryParameters = {'id': userId.toString()};

    try {
      var client = http.Client();
      final uri = Uri.https(baseUrl, '${userUrl}/${userId}', queryParameters);
      var headers = {"Content-Type": "application/json"};
      var response = await client.get(uri, headers: headers);

      var result = jsonDecode(response.body);
      UserDetail userDetail =
          UserDetail.fromJson(result as Map<String, dynamic>);

      return userDetail;
    } catch (e) {
      log('User: ${e.toString()}');
      throw Exception('Not get user detail');
    }
  }
}
