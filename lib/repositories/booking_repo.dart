import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pbl6_aircnc/models/booking.dart';
import 'package:http/http.dart' as http;

class BookingRepo {
  static String baseUrl = 'pbl6.whitemage.tech';
  static var guestUrl = 'api/bookings/guest';
  static var checkInUrl = 'api/check-in';
  static final FlutterSecureStorage storage = const FlutterSecureStorage();

  static Future<List<Booking>> getAllBookingOfGuest(
      {required int guestId,
      String? orderBy,
      String? status,
      int? pageIndex,
      int? pageSize,
      bool? isDescending,
      String? search}) async {
    Map<String, dynamic> queryParameters = {
      'hostId': guestId.toString(),
      if (orderBy != null) 'OrderBy': orderBy,
      if (status != null) 'Status': status,
      if (pageIndex != null) 'PageIndex': pageIndex.toString(),
      if (pageSize != null) 'PageSize': pageSize.toString(),
      if (isDescending != null) 'IsDescending': isDescending.toString(),
      if (search != null) 'Search': search,
    };

    List<Booking> lstBooking = [];

    try {
      var client = http.Client();
      final uri = Uri.https(baseUrl, '${guestUrl}/${guestId}', queryParameters);
      var headers = {"Content-Type": "application/json"};
      var response = await client.get(uri, headers: headers);

      List result = jsonDecode(response.body)['data'];

      print(result);

      for (int i = 0; i < result.length; i++) {
        Booking booking = Booking.fromJson(result[i] as Map<String, dynamic>);
        lstBooking.add(booking);
      }

      print(lstBooking);

      return lstBooking;
    } catch (e) {
      log('Booking: ${e.toString()}');
      throw Exception('Not get list property');
    }
  }

  static Future<int> getTotalPages({required int guestId}) async {
    Map<String, dynamic> queryParameters = {
      'hostId': guestId.toString(),
    };

    try {
      var client = http.Client();
      final uri = Uri.https(baseUrl, '${guestUrl}/${guestId}', queryParameters);
      var headers = {"Content-Type": "application/json"};
      var response = await client.get(uri, headers: headers);

      int totalPages = jsonDecode(response.body)['totalPages'];

      return totalPages;
    } catch (e) {
      log('Booking: ${e.toString()}');
      throw Exception('Error total pages booking');
    }
  }

  static Future<List<List<Booking>>> getAllPagesBooking(
      {required int guestId}) async {
    int totalPages = await BookingRepo.getTotalPages(guestId: guestId);

    List<List<Booking>> totalPagesBooking = [];

    for (int i = 1; i <= totalPages; i++) {
      List<Booking> lstBooking = await BookingRepo.getAllBookingOfGuest(
          pageIndex: i, guestId: guestId);
      totalPagesBooking.add(lstBooking);
    }

    return totalPagesBooking;
  }

  static Future<bool> checkIn({required String codeQr}) async {
    final queryParameters = {'codeQr': codeQr};

    String? token = await storage.read(key: 'accessToken');
    try {
      var client = http.Client();
      final uri =
          Uri.https(baseUrl, '${checkInUrl}/${codeQr}', queryParameters);

      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var response = await client.post(uri, headers: headers);

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      log('Check in: ${e.toString()}');
      throw Exception('Not check in');
    }
  }
}
