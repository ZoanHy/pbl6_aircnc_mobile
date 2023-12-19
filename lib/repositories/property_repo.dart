import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pbl6_aircnc/models/property.dart';

class PropertyRepo {
  static final baseUrl = 'pbl6.whitemage.tech';
  static final propertyUrl = 'api/properties';
  static final FlutterSecureStorage storage = const FlutterSecureStorage();

  static Future<List<Property>> filterListProperties(
      {List<String>? type,
      String? orderBy,
      double? minPrice,
      double? maxPrice,
      int? minBedroomCount,
      int? maxBedroomCount,
      int? minBedCount,
      int? maxBedCount,
      int? minBathroomCount,
      int? maxBathroomCount,
      String? city,
      String? checkInDate,
      String? checkOutDate,
      int? adultCount,
      int? childCount,
      String? status,
      int? pageIndex,
      int? pageSize,
      bool? isDescending,
      String? search}) async {
    Map<String, dynamic> queryParameters = {
      if (type != null) 'Type': type,
      if (orderBy != null) 'OrderBy': orderBy,
      if (minPrice != null) 'MinPrice': minPrice.toString(),
      if (maxPrice != null) 'MaxPrice': maxPrice.toString(),
      if (minBedroomCount != null)
        'MinBedroomCount': minBedroomCount.toString(),
      if (maxBedroomCount != null)
        'MaxBedroomCount': maxBedroomCount.toString(),
      if (minBedCount != null) 'MinBedCount': minBedCount.toString(),
      if (maxBedCount != null) 'MaxBedCount': maxBedCount.toString(),
      if (minBathroomCount != null)
        'MinBathroomCount': minBathroomCount.toString(),
      if (maxBathroomCount != null)
        'MaxBathroomCount': maxBathroomCount.toString(),
      if (maxPrice != null) 'MaxPrice': maxPrice.toString(),
      if (city != null) 'City': city,
      if (checkInDate != null) 'CheckInDate': checkInDate,
      if (checkOutDate != null) 'CheckOutDate': checkOutDate,
      if (adultCount != null) 'AdultCount': adultCount.toString(),
      if (childCount != null) 'ChildCount': childCount.toString(),
      if (status != null) 'Status': status,
      if (pageIndex != null) 'PageIndex': pageIndex.toString(),
      if (pageSize != null) 'PageSize': pageSize.toString(),
      if (isDescending != null) 'IsDescending': isDescending.toString(),
      if (search != null) 'Search': search,
    };

    List<Property> lstProperties = [];

    try {
      var client = http.Client();
      final uri = Uri.https(baseUrl, propertyUrl, queryParameters);
      var headers = {"Content-Type": "application/json"};
      var response = await client.get(uri, headers: headers);

      List result = jsonDecode(response.body)['data'];

      for (int i = 0; i < result.length; i++) {
        Property property =
            Property.fromJson(result[i] as Map<String, dynamic>);
        lstProperties.add(property);
      }

      return lstProperties;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  static Future<List<Property>> filterListPropertiesOfHost(
      {required int hostId,
      List<String>? type,
      String? orderBy,
      double? minPrice,
      double? maxPrice,
      int? minBedroomCount,
      int? maxBedroomCount,
      int? minBedCount,
      int? maxBedCount,
      int? minBathroomCount,
      int? maxBathroomCount,
      String? city,
      String? checkInDate,
      String? checkOutDate,
      int? adultCount,
      int? childCount,
      String? status,
      int? pageIndex,
      int? pageSize,
      bool? isDescending,
      String? search}) async {
    Map<String, dynamic> queryParameters = {
      'hostId': hostId.toString(),
      if (type != null) 'Type': type,
      if (orderBy != null) 'OrderBy': orderBy,
      if (minPrice != null) 'MinPrice': minPrice.toString(),
      if (maxPrice != null) 'MaxPrice': maxPrice.toString(),
      if (minBedroomCount != null)
        'MinBedroomCount': minBedroomCount.toString(),
      if (maxBedroomCount != null)
        'MaxBedroomCount': maxBedroomCount.toString(),
      if (minBedCount != null) 'MinBedCount': minBedCount.toString(),
      if (maxBedCount != null) 'MaxBedCount': maxBedCount.toString(),
      if (minBathroomCount != null)
        'MinBathroomCount': minBathroomCount.toString(),
      if (maxBathroomCount != null)
        'MaxBathroomCount': maxBathroomCount.toString(),
      if (maxPrice != null) 'MaxPrice': maxPrice.toString(),
      if (city != null) 'City': city,
      if (checkInDate != null) 'CheckInDate': checkInDate,
      if (checkOutDate != null) 'CheckOutDate': checkOutDate,
      if (adultCount != null) 'AdultCount': adultCount.toString(),
      if (childCount != null) 'ChildCount': childCount.toString(),
      if (status != null) 'Status': status,
      if (pageIndex != null) 'PageIndex': pageIndex.toString(),
      if (pageSize != null) 'PageSize': pageSize.toString(),
      if (isDescending != null) 'IsDescending': isDescending.toString(),
      if (search != null) 'Search': search,
    };

    List<Property> lstProperties = [];

    try {
      var client = http.Client();
      final uri =
          Uri.https(baseUrl, '${propertyUrl}/host/${hostId}', queryParameters);
      var headers = {"Content-Type": "application/json"};
      var response = await client.get(uri, headers: headers);

      List result = jsonDecode(response.body)['data'];
      print(result);

      for (int i = 0; i < result.length; i++) {
        Property property =
            Property.fromJson(result[i] as Map<String, dynamic>);
        lstProperties.add(property);
      }

      return lstProperties;
    } catch (e) {
      print(e.toString());
      throw Exception('Not get list property');
    }
  }

  static Future<bool> postAProperty() async {
    final body = json.encode({
      "type": "Room",
      "bedCount": "10",
      "bedroomCount": "10",
      "bathroomCount": "10",
      "maxAdultCount": "10",
      "maxChildCount": "10",
      "title": "Test Room 1",
      "description": "string",
      "latitude": "10",
      "longitude": "10",
      "address": "string",
      "city": "string",
      "pricePerNight": "1000",
      "cleaningFee": "444",
      "cancellationPolicyType": "Flexible",
      "propertyImages": [
        {"url": "string"}
      ],
      "propertyUtilities": {
        "isWifi": true,
        "isTv": true,
        "isKitchen": true,
        "isAirConditioning": true,
        "isLaptopFriendlyWorkspace": true,
        "isHotWater": true,
        "isBreakfast": true,
        "isRoomService": true,
        "isBar": true,
        "isSwimmingPool": true,
        "isGym": true,
        "isSpa": true,
        "isBeachFront": true,
        "isMountainView": true,
        "isLakeView": true,
        "isSeaView": true,
        "isLandmarkView": true,
        "isWheelchairAccessible": true,
        "isElevator": true,
        "isSecurityCamera": true,
        "isCamperFriendly": true
      },
      "paymentInfo": {
        "bankName": "BIDV",
        "accountNumber": "1111111111111145",
        "accountHolder": "Zoan Zoan"
      }
    });

    String? token = await storage.read(key: 'accessToken');

    try {
      var client = http.Client();
      final uri = Uri.parse('https://${baseUrl}/${propertyUrl}');
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var response = await client.post(uri, headers: headers, body: body);
      // print(response.body);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
