// To parse this JSON data, do
//
//     final property = propertyFromJson(jsonString);

import 'dart:convert';

Property propertyFromJson(String str) => Property.fromJson(json.decode(str));

String propertyToJson(Property data) => json.encode(data.toJson());

class Property {
  final int id;
  final String type;
  final int bedCount;
  final int bathroomCount;
  final int maxAdultCount;
  final int maxChildCount;
  final double latitude;
  final double longitude;
  final String address;
  final String city;
  bool isFavorite;
  final int hostId;
  final String hostName;
  final double rating;
  final int numberOfReviews;
  final String title;
  final String description;
  final int pricePerNight;
  final int cleaningFee;
  final List<PropertyImage> propertyImages;
  final List<PropertyUtility> propertyUtilities;
  final String status;
  final dynamic rejectionReason;

  Property({
    required this.id,
    required this.type,
    required this.bedCount,
    required this.bathroomCount,
    required this.maxAdultCount,
    required this.maxChildCount,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.city,
    required this.isFavorite,
    required this.hostId,
    required this.hostName,
    required this.rating,
    required this.numberOfReviews,
    required this.title,
    required this.description,
    required this.pricePerNight,
    required this.cleaningFee,
    required this.propertyImages,
    required this.propertyUtilities,
    required this.status,
    required this.rejectionReason,
  });

  Property copyWith({
    int? id,
    String? type,
    int? bedCount,
    int? bathroomCount,
    int? maxAdultCount,
    int? maxChildCount,
    double? latitude,
    double? longitude,
    String? address,
    String? city,
    bool? isFavorite,
    int? hostId,
    String? hostName,
    double? rating,
    int? numberOfReviews,
    String? title,
    String? description,
    int? pricePerNight,
    int? cleaningFee,
    List<PropertyImage>? propertyImages,
    List<PropertyUtility>? propertyUtilities,
    String? status,
    dynamic rejectionReason,
  }) =>
      Property(
        id: id ?? this.id,
        type: type ?? this.type,
        bedCount: bedCount ?? this.bedCount,
        bathroomCount: bathroomCount ?? this.bathroomCount,
        maxAdultCount: maxAdultCount ?? this.maxAdultCount,
        maxChildCount: maxChildCount ?? this.maxChildCount,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        address: address ?? this.address,
        city: city ?? this.city,
        isFavorite: isFavorite ?? this.isFavorite,
        hostId: hostId ?? this.hostId,
        hostName: hostName ?? this.hostName,
        rating: rating ?? this.rating,
        numberOfReviews: numberOfReviews ?? this.numberOfReviews,
        title: title ?? this.title,
        description: description ?? this.description,
        pricePerNight: pricePerNight ?? this.pricePerNight,
        cleaningFee: cleaningFee ?? this.cleaningFee,
        propertyImages: propertyImages ?? this.propertyImages,
        propertyUtilities: propertyUtilities ?? this.propertyUtilities,
        status: status ?? this.status,
        rejectionReason: rejectionReason ?? this.rejectionReason,
      );

  factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["id"],
        type: json["type"],
        bedCount: json["bedCount"],
        bathroomCount: json["bathroomCount"],
        maxAdultCount: json["maxAdultCount"],
        maxChildCount: json["maxChildCount"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        address: json["address"],
        city: json["city"],
        isFavorite: json["isFavorite"],
        hostId: json["hostId"],
        hostName: json["hostName"],
        rating: json["rating"]?.toDouble(),
        numberOfReviews: json["numberOfReviews"],
        title: json["title"],
        description: json["description"],
        pricePerNight: json["pricePerNight"],
        cleaningFee: json["cleaningFee"],
        propertyImages: List<PropertyImage>.from(
            json["propertyImages"].map((x) => PropertyImage.fromJson(x))),
        propertyUtilities: List<PropertyUtility>.from(
            json["propertyUtilities"].map((x) => PropertyUtility.fromJson(x))),
        status: json["status"],
        rejectionReason: json["rejectionReason"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "bedCount": bedCount,
        "bathroomCount": bathroomCount,
        "maxAdultCount": maxAdultCount,
        "maxChildCount": maxChildCount,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "city": city,
        "isFavorite": isFavorite,
        "hostId": hostId,
        "hostName": hostName,
        "rating": rating,
        "numberOfReviews": numberOfReviews,
        "title": title,
        "description": description,
        "pricePerNight": pricePerNight,
        "cleaningFee": cleaningFee,
        "propertyImages":
            List<dynamic>.from(propertyImages.map((x) => x.toJson())),
        "propertyUtilities":
            List<dynamic>.from(propertyUtilities.map((x) => x.toJson())),
        "status": status,
        "rejectionReason": rejectionReason,
      };
}

class PropertyImage {
  final int id;
  final String url;
  final int propertyId;

  PropertyImage({
    required this.id,
    required this.url,
    required this.propertyId,
  });

  PropertyImage copyWith({
    int? id,
    String? url,
    int? propertyId,
  }) =>
      PropertyImage(
        id: id ?? this.id,
        url: url ?? this.url,
        propertyId: propertyId ?? this.propertyId,
      );

  factory PropertyImage.fromJson(Map<String, dynamic> json) => PropertyImage(
        id: json["id"],
        url: json["url"],
        propertyId: json["propertyId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "propertyId": propertyId,
      };
}

class PropertyUtility {
  final bool isWifi;
  final bool isTv;
  final bool isKitchen;
  final bool isAirConditioning;
  final bool isLaptopFriendlyWorkspace;
  final bool isHotWater;
  final bool isBreakfast;
  final bool isRoomService;
  final bool isBar;
  final bool isSwimmingPool;
  final bool isGym;
  final bool isSpa;
  final bool isBeachFront;
  final bool isMountainView;
  final bool isLakeView;
  final bool isSeaView;
  final bool isLandmarkView;
  final bool isWheelchairAccessible;
  final bool isElevator;
  final bool isSecurityCamera;
  final bool isCamperFriendly;
  final int propertyId;

  PropertyUtility({
    required this.isWifi,
    required this.isTv,
    required this.isKitchen,
    required this.isAirConditioning,
    required this.isLaptopFriendlyWorkspace,
    required this.isHotWater,
    required this.isBreakfast,
    required this.isRoomService,
    required this.isBar,
    required this.isSwimmingPool,
    required this.isGym,
    required this.isSpa,
    required this.isBeachFront,
    required this.isMountainView,
    required this.isLakeView,
    required this.isSeaView,
    required this.isLandmarkView,
    required this.isWheelchairAccessible,
    required this.isElevator,
    required this.isSecurityCamera,
    required this.isCamperFriendly,
    required this.propertyId,
  });

  PropertyUtility copyWith({
    bool? isWifi,
    bool? isTv,
    bool? isKitchen,
    bool? isAirConditioning,
    bool? isLaptopFriendlyWorkspace,
    bool? isHotWater,
    bool? isBreakfast,
    bool? isRoomService,
    bool? isBar,
    bool? isSwimmingPool,
    bool? isGym,
    bool? isSpa,
    bool? isBeachFront,
    bool? isMountainView,
    bool? isLakeView,
    bool? isSeaView,
    bool? isLandmarkView,
    bool? isWheelchairAccessible,
    bool? isElevator,
    bool? isSecurityCamera,
    bool? isCamperFriendly,
    int? propertyId,
  }) =>
      PropertyUtility(
        isWifi: isWifi ?? this.isWifi,
        isTv: isTv ?? this.isTv,
        isKitchen: isKitchen ?? this.isKitchen,
        isAirConditioning: isAirConditioning ?? this.isAirConditioning,
        isLaptopFriendlyWorkspace:
            isLaptopFriendlyWorkspace ?? this.isLaptopFriendlyWorkspace,
        isHotWater: isHotWater ?? this.isHotWater,
        isBreakfast: isBreakfast ?? this.isBreakfast,
        isRoomService: isRoomService ?? this.isRoomService,
        isBar: isBar ?? this.isBar,
        isSwimmingPool: isSwimmingPool ?? this.isSwimmingPool,
        isGym: isGym ?? this.isGym,
        isSpa: isSpa ?? this.isSpa,
        isBeachFront: isBeachFront ?? this.isBeachFront,
        isMountainView: isMountainView ?? this.isMountainView,
        isLakeView: isLakeView ?? this.isLakeView,
        isSeaView: isSeaView ?? this.isSeaView,
        isLandmarkView: isLandmarkView ?? this.isLandmarkView,
        isWheelchairAccessible:
            isWheelchairAccessible ?? this.isWheelchairAccessible,
        isElevator: isElevator ?? this.isElevator,
        isSecurityCamera: isSecurityCamera ?? this.isSecurityCamera,
        isCamperFriendly: isCamperFriendly ?? this.isCamperFriendly,
        propertyId: propertyId ?? this.propertyId,
      );

  factory PropertyUtility.fromJson(Map<String, dynamic> json) =>
      PropertyUtility(
        isWifi: json["isWifi"],
        isTv: json["isTv"],
        isKitchen: json["isKitchen"],
        isAirConditioning: json["isAirConditioning"],
        isLaptopFriendlyWorkspace: json["isLaptopFriendlyWorkspace"],
        isHotWater: json["isHotWater"],
        isBreakfast: json["isBreakfast"],
        isRoomService: json["isRoomService"],
        isBar: json["isBar"],
        isSwimmingPool: json["isSwimmingPool"],
        isGym: json["isGym"],
        isSpa: json["isSpa"],
        isBeachFront: json["isBeachFront"],
        isMountainView: json["isMountainView"],
        isLakeView: json["isLakeView"],
        isSeaView: json["isSeaView"],
        isLandmarkView: json["isLandmarkView"],
        isWheelchairAccessible: json["isWheelchairAccessible"],
        isElevator: json["isElevator"],
        isSecurityCamera: json["isSecurityCamera"],
        isCamperFriendly: json["isCamperFriendly"],
        propertyId: json["propertyId"],
      );

  Map<String, dynamic> toJson() => {
        "isWifi": isWifi,
        "isTv": isTv,
        "isKitchen": isKitchen,
        "isAirConditioning": isAirConditioning,
        "isLaptopFriendlyWorkspace": isLaptopFriendlyWorkspace,
        "isHotWater": isHotWater,
        "isBreakfast": isBreakfast,
        "isRoomService": isRoomService,
        "isBar": isBar,
        "isSwimmingPool": isSwimmingPool,
        "isGym": isGym,
        "isSpa": isSpa,
        "isBeachFront": isBeachFront,
        "isMountainView": isMountainView,
        "isLakeView": isLakeView,
        "isSeaView": isSeaView,
        "isLandmarkView": isLandmarkView,
        "isWheelchairAccessible": isWheelchairAccessible,
        "isElevator": isElevator,
        "isSecurityCamera": isSecurityCamera,
        "isCamperFriendly": isCamperFriendly,
        "propertyId": propertyId,
      };
}
