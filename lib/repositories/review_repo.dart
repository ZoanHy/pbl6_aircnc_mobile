import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pbl6_aircnc/models/booking.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6_aircnc/models/review.dart';
import 'package:pbl6_aircnc/models/review_host.dart';

class ReviewRepo {
  static String baseUrl = 'pbl6.whitemage.tech';
  static var reviewPropertyUrl = 'api/reviews/property';
  static var reviewHostUrl = 'api/reviews/host';

  static Future<List<Review>> getAllReviewOfProperty(
      {required int propertyId,
      String? orderBy,
      String? status,
      int? pageIndex,
      int? pageSize,
      bool? isDescending,
      String? search}) async {
    Map<String, dynamic> queryParameters = {
      'propertyId': propertyId.toString(),
      if (orderBy != null) 'OrderBy': orderBy,
      if (status != null) 'Status': status,
      if (pageIndex != null) 'PageIndex': pageIndex.toString(),
      if (pageSize != null) 'PageSize': pageSize.toString(),
      if (isDescending != null) 'IsDescending': isDescending.toString(),
      if (search != null) 'Search': search,
    };

    List<Review> lstReviews = [];

    try {
      var client = http.Client();
      final uri = Uri.https(
          baseUrl, '${reviewPropertyUrl}/${propertyId}', queryParameters);
      var headers = {"Content-Type": "application/json"};
      var response = await client.get(uri, headers: headers);

      List result = jsonDecode(response.body)['data'];

      for (int i = 0; i < result.length; i++) {
        Review review = Review.fromJson(result[i] as Map<String, dynamic>);
        lstReviews.add(review);
      }

      print(lstReviews);

      return lstReviews;
    } catch (e) {
      log('Booking: ${e.toString()}');
      throw Exception('Not get list review');
    }
  }

  static Future<List<ReviewHost>> getAllReviewOfHost(
      {required int hostId,
      String? orderBy,
      String? status,
      int? pageIndex,
      int? pageSize,
      bool? isDescending,
      String? search}) async {
    Map<String, dynamic> queryParameters = {
      'propertyId': hostId.toString(),
      if (orderBy != null) 'OrderBy': orderBy,
      if (status != null) 'Status': status,
      if (pageIndex != null) 'PageIndex': pageIndex.toString(),
      if (pageSize != null) 'PageSize': pageSize.toString(),
      if (isDescending != null) 'IsDescending': isDescending.toString(),
      if (search != null) 'Search': search,
    };

    List<ReviewHost> lstReviewHosts = [];

    try {
      var client = http.Client();
      final uri =
          Uri.https(baseUrl, '${reviewHostUrl}/${hostId}', queryParameters);
      var headers = {"Content-Type": "application/json"};
      var response = await client.get(uri, headers: headers);

      List result = jsonDecode(response.body)['data'];

      for (int i = 0; i < result.length; i++) {
        ReviewHost reviewHost =
            ReviewHost.fromJson(result[i] as Map<String, dynamic>);
        lstReviewHosts.add(reviewHost);
      }

      return lstReviewHosts;
    } catch (e) {
      log('Booking: ${e.toString()}');
      throw Exception('Not get list review host');
    }
  }
}
