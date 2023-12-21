import 'dart:convert';

import 'package:equatable/equatable.dart';

Property PropertyFromJson(String str) =>
    Property.fromJson(json.decode(str));

String PropertyToJson(Property data) => json.encode(data.toJson());

class Property extends Equatable {
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
  final List<dynamic> propertyUtilities;
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
    List<dynamic>? propertyUtilities,
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
        propertyUtilities:
            List<dynamic>.from(json["propertyUtilities"].map((x) => x)),
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
            List<dynamic>.from(propertyUtilities.map((x) => x)),
        "status": status,
        "rejectionReason": rejectionReason,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        type,
        bedCount,
        bathroomCount,
        maxAdultCount,
        maxChildCount,
        latitude,
        longitude,
        address,
        city,
        isFavorite,
        hostId,
        hostName,
        rating,
        numberOfReviews,
        title,
        description,
        pricePerNight,
        cleaningFee,
        propertyImages,
        propertyUtilities,
        status,
        rejectionReason
      ];
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
