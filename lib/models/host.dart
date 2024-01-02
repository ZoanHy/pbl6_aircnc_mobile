// To parse this JSON data, do
//
//     final host = hostFromJson(jsonString);

import 'dart:convert';

Host hostFromJson(String str) => Host.fromJson(json.decode(str));

String hostToJson(Host data) => json.encode(data.toJson());

class Host {
  final int id;
  final int userId;
  final String name;
  final String introduction;
  String? avatarUrl;
  final String address;
  final String city;
  final DateTime joinedAt;
  final int numberOfReviews;
  final double rating;

  Host({
    required this.id,
    required this.userId,
    required this.name,
    required this.introduction,
    required this.avatarUrl,
    required this.address,
    required this.city,
    required this.joinedAt,
    required this.numberOfReviews,
    required this.rating,
  });

  Host copyWith({
    int? id,
    int? userId,
    String? name,
    String? introduction,
    String? avatarUrl,
    String? address,
    String? city,
    DateTime? joinedAt,
    int? numberOfReviews,
    double? rating,
  }) =>
      Host(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        introduction: introduction ?? this.introduction,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        address: address ?? this.address,
        city: city ?? this.city,
        joinedAt: joinedAt ?? this.joinedAt,
        numberOfReviews: numberOfReviews ?? this.numberOfReviews,
        rating: rating ?? this.rating,
      );

  factory Host.fromJson(Map<String, dynamic> json) => Host(
        id: json["id"],
        userId: json["userId"],
        name: json["name"],
        introduction: json["introduction"],
        avatarUrl: json["avatarUrl"],
        address: json["address"],
        city: json["city"],
        joinedAt: DateTime.parse(json["joinedAt"]),
        numberOfReviews: json["numberOfReviews"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "name": name,
        "introduction": introduction,
        "avatarUrl": avatarUrl,
        "address": address,
        "city": city,
        "joinedAt": joinedAt.toIso8601String(),
        "numberOfReviews": numberOfReviews,
        "rating": rating,
      };
}
