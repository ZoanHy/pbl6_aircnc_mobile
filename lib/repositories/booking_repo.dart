import 'dart:convert';
import 'dart:developer';

import 'package:pbl6_aircnc/models/booking.dart';
import 'package:http/http.dart' as http;

class BookingRepo {
  static String baseUrl = 'pbl6.whitemage.tech';
  static var guestUrl = 'api/bookings/guest';

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
      final uri =
          Uri.https(baseUrl, '${guestUrl}/${guestId}', queryParameters);
      var headers = {"Content-Type": "application/json"};
      var response = await client.get(uri, headers: headers);

      List result = jsonDecode(response.body)['data'];
      print(result);

      for (int i = 0; i < result.length; i++) {
        Booking booking = Booking.fromJson(result[i] as Map<String, dynamic>);
        lstBooking.add(booking);
      }

      return lstBooking;
    } catch (e) {
      log(e.toString());
      throw Exception('Not get list property');
    }
  }
}
