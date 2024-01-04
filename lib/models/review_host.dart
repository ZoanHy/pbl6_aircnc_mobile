// To parse this JSON data, do
//
//     final reviewHost = reviewHostFromJson(jsonString);

import 'dart:convert';

ReviewHost reviewHostFromJson(String str) => ReviewHost.fromJson(json.decode(str));

String reviewHostToJson(ReviewHost data) => json.encode(data.toJson());

class ReviewHost {
    final int id;
    final int reviewerId;
    final int userId;
    final String reviewerName;
    final String reviewerAvatarUrl;
    final DateTime reviewTime;
    final String content;
    final int rating;

    ReviewHost({
        required this.id,
        required this.reviewerId,
        required this.userId,
        required this.reviewerName,
        required this.reviewerAvatarUrl,
        required this.reviewTime,
        required this.content,
        required this.rating,
    });

    ReviewHost copyWith({
        int? id,
        int? reviewerId,
        int? userId,
        String? reviewerName,
        String? reviewerAvatarUrl,
        DateTime? reviewTime,
        String? content,
        int? rating,
    }) => 
        ReviewHost(
            id: id ?? this.id,
            reviewerId: reviewerId ?? this.reviewerId,
            userId: userId ?? this.userId,
            reviewerName: reviewerName ?? this.reviewerName,
            reviewerAvatarUrl: reviewerAvatarUrl ?? this.reviewerAvatarUrl,
            reviewTime: reviewTime ?? this.reviewTime,
            content: content ?? this.content,
            rating: rating ?? this.rating,
        );

    factory ReviewHost.fromJson(Map<String, dynamic> json) => ReviewHost(
        id: json["id"],
        reviewerId: json["reviewerId"],
        userId: json["userId"],
        reviewerName: json["reviewerName"],
        reviewerAvatarUrl: json["reviewerAvatarUrl"],
        reviewTime: DateTime.parse(json["reviewTime"]),
        content: json["content"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "reviewerId": reviewerId,
        "userId": userId,
        "reviewerName": reviewerName,
        "reviewerAvatarUrl": reviewerAvatarUrl,
        "reviewTime": reviewTime.toIso8601String(),
        "content": content,
        "rating": rating,
    };
}
