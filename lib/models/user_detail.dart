// To parse this JSON data, do
//
//     final userDetail = userDetailFromJson(jsonString);

import 'dart:convert';

UserDetail userDetailFromJson(String str) =>
    UserDetail.fromJson(json.decode(str));

String userDetailToJson(UserDetail data) => json.encode(data.toJson());

class UserDetail {
  final int id;
  final String fullName;
  final String username;
  String? introduction;
  String? phoneNumber;
  final String email;
  final String city;
  String? address;
  String? avatarUrl;
  final DateTime createdAt;
  final bool isDeleted;
  final bool isHost;

  UserDetail({
    required this.id,
    required this.fullName,
    required this.username,
    required this.introduction,
    required this.phoneNumber,
    required this.email,
    required this.city,
    required this.address,
    required this.avatarUrl,
    required this.createdAt,
    required this.isDeleted,
    required this.isHost,
  });

  UserDetail copyWith({
    int? id,
    String? fullName,
    String? username,
    String? introduction,
    String? phoneNumber,
    String? email,
    String? city,
    String? address,
    String? avatarUrl,
    DateTime? createdAt,
    bool? isDeleted,
    bool? isHost,
  }) =>
      UserDetail(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        username: username ?? this.username,
        introduction: introduction ?? this.introduction,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        city: city ?? this.city,
        address: address ?? this.address,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        createdAt: createdAt ?? this.createdAt,
        isDeleted: isDeleted ?? this.isDeleted,
        isHost: isHost ?? this.isHost,
      );

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["id"],
        fullName: json["fullName"],
        username: json["username"],
        introduction: json["introduction"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        city: json["city"],
        address: json["address"],
        avatarUrl: json["avatarUrl"],
        createdAt: DateTime.parse(json["createdAt"]),
        isDeleted: json["isDeleted"],
        isHost: json["isHost"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "username": username,
        "introduction": introduction,
        "phoneNumber": phoneNumber,
        "email": email,
        "city": city,
        "address": address,
        "avatarUrl": avatarUrl,
        "createdAt": createdAt.toIso8601String(),
        "isDeleted": isDeleted,
        "isHost": isHost,
      };
}
