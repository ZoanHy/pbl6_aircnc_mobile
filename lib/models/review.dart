// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

Review reviewFromJson(String str) => Review.fromJson(json.decode(str));

String reviewToJson(Review data) => json.encode(data.toJson());

class Review {
  final int id;
  final int propertyId;
  final int guestId;
  final int userId;
  final String guestName;
  final String guestAvatarUrl;
  final int cleanliness;
  final int communication;
  final int checkIn;
  final int accuracy;
  final int location;
  final int value;
  final double averageRating;
  final String content;
  final DateTime reviewTime;

  Review({
    required this.id,
    required this.propertyId,
    required this.guestId,
    required this.userId,
    required this.guestName,
    required this.guestAvatarUrl,
    required this.cleanliness,
    required this.communication,
    required this.checkIn,
    required this.accuracy,
    required this.location,
    required this.value,
    required this.averageRating,
    required this.content,
    required this.reviewTime,
  });

  Review copyWith({
    int? id,
    int? propertyId,
    int? guestId,
    int? userId,
    String? guestName,
    String? guestAvatarUrl,
    int? cleanliness,
    int? communication,
    int? checkIn,
    int? accuracy,
    int? location,
    int? value,
    double? averageRating,
    String? content,
    DateTime? reviewTime,
  }) =>
      Review(
        id: id ?? this.id,
        propertyId: propertyId ?? this.propertyId,
        guestId: guestId ?? this.guestId,
        userId: userId ?? this.userId,
        guestName: guestName ?? this.guestName,
        guestAvatarUrl: guestAvatarUrl ?? this.guestAvatarUrl,
        cleanliness: cleanliness ?? this.cleanliness,
        communication: communication ?? this.communication,
        checkIn: checkIn ?? this.checkIn,
        accuracy: accuracy ?? this.accuracy,
        location: location ?? this.location,
        value: value ?? this.value,
        averageRating: averageRating ?? this.averageRating,
        content: content ?? this.content,
        reviewTime: reviewTime ?? this.reviewTime,
      );

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        propertyId: json["propertyId"],
        guestId: json["guestId"],
        userId: json["userId"],
        guestName: json["guestName"],
        guestAvatarUrl: json["guestAvatarUrl"],
        cleanliness: json["cleanliness"],
        communication: json["communication"],
        checkIn: json["checkIn"],
        accuracy: json["accuracy"],
        location: json["location"],
        value: json["value"],
        averageRating: json["averageRating"]?.toDouble(),
        content: json["content"],
        reviewTime: DateTime.parse(json["reviewTime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "propertyId": propertyId,
        "guestId": guestId,
        "userId": userId,
        "guestName": guestName,
        "guestAvatarUrl": guestAvatarUrl,
        "cleanliness": cleanliness,
        "communication": communication,
        "checkIn": checkIn,
        "accuracy": accuracy,
        "location": location,
        "value": value,
        "averageRating": averageRating,
        "content": content,
        "reviewTime": reviewTime.toIso8601String(),
      };
}
