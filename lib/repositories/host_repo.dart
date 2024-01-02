import 'dart:convert';
import 'dart:developer';

import 'package:pbl6_aircnc/models/host.dart';
import 'package:http/http.dart' as http;

class HostRepo {
  static String baseUrl = 'pbl6.whitemage.tech';
  static var hostUrl = 'api/hosts';

  static Future<Host> getHostDetail({required int hostId}) async {
    final queryParameters = {'hostId': hostId.toString()};

    try {
      var client = http.Client();
      final uri = Uri.https(baseUrl, '${hostUrl}/${hostId}', queryParameters);

      var response = await client.get(uri);

      var result = jsonDecode(response.body);

      Host host = Host.fromJson(result as Map<String, dynamic>);

      return host;
    } catch (e) {
      log(e.toString());
      throw Exception('get detail property failed');
    }
  }
}
