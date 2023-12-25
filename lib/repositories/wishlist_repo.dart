import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6_aircnc/models/property.dart';

class WishlistRepo {
  static String baseUrl = 'pbl6.whitemage.tech';
  static String wishlistUrl = 'api/wishlists';

  static final FlutterSecureStorage storage = const FlutterSecureStorage();

  static Future<List<Property>> getWishlists(
      {int? pageIndex,
      int? pageSize,
      bool? isDescending,
      String? search}) async {
    final queryParamerts = {
      if (pageIndex != null) 'PageIndex': pageIndex.toString(),
      if (pageSize != null) 'PageSize': pageSize.toString(),
      if (isDescending != null) 'IsDescending': isDescending.toString(),
      if (search != null) 'Search': search,
    };

    String? token = await storage.read(key: 'accessToken');
    List<Property> lstProperties = [];

    try {
      final uri = Uri.https(baseUrl, wishlistUrl, queryParamerts);
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(uri, headers: headers);

      List result = jsonDecode(response.body)['data'];

      for (int i = 0; i < result.length; i++) {
        Property property =
            Property.fromJson(result[i] as Map<String, dynamic>);
        lstProperties.add(property);
      }
      return lstProperties;
    } catch (e) {
      log(e.toString());
      throw Exception('get wish list error');
    }
  }

  static Future<int> getTotalPages() async {
    String? token = await storage.read(key: 'accessToken');

    try {
      var client = http.Client();
      final uri = Uri.parse('https://${baseUrl}/${wishlistUrl}');
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var response = await client.get(uri, headers: headers);

      int totalPages = jsonDecode(response.body)['totalPages'];

      return totalPages;
    } catch (e) {
      print(e.toString());
      throw Exception('Error total pages wishlist');
    }
  }

  static Future<List<List<Property>>> getAllPagesWishlist() async {
    int totalPages = await WishlistRepo.getTotalPages();

    print('total pages: ${totalPages}');

    List<List<Property>> totalPagesWishlist = [];

    for (int i = 1; i <= totalPages; i++) {
      List<Property> lstWishlist =
          await WishlistRepo.getWishlists(pageIndex: i);
      print(lstWishlist.length);
      totalPagesWishlist.add(lstWishlist);
    }

    return totalPagesWishlist;
  }

  static Future<bool> addAPropertyToWishlists(String idProperty) async {
    String? token = await storage.read(key: 'accessToken');

    try {
      final queryParameters = {'propertyId ': idProperty};
      final uri = Uri.https(
          baseUrl, '${wishlistUrl}/properties/${idProperty}', queryParameters);
      ;
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.post(uri, headers: headers);
      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      log(e.toString());
      throw Exception('get wish list error');
    }
  }

  static Future<bool> removeAPropertyToWishlists(String idProperty) async {
    String? token = await storage.read(key: 'accessToken');

    try {
      final queryParameters = {'propertyId ': idProperty};
      final uri = Uri.https(
          baseUrl, '${wishlistUrl}/properties/${idProperty}', queryParameters);
      ;
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.delete(uri, headers: headers);
      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      log(e.toString());
      throw Exception('get wish list error');
    }
  }
}
