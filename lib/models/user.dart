import 'dart:convert';

import 'package:equatable/equatable.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User extends Equatable {
  final int id;
  final String userName;
  final String email;
  final String fullName;
  final dynamic avatarUrl;
  final bool isHost;

  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.fullName,
    required this.avatarUrl,
    required this.isHost,
  });

  User copyWith({
    int? id,
    String? userName,
    String? email,
    String? fullName,
    dynamic avatarUrl,
    bool? isHost,
  }) =>
      User(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        email: email ?? this.email,
        fullName: fullName ?? this.fullName,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        isHost: isHost ?? this.isHost,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userName: json["userName"],
        email: json["email"],
        fullName: json["fullName"],
        avatarUrl: json["avatarUrl"],
        isHost: json["isHost"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "email": email,
        "fullName": fullName,
        "avatarUrl": avatarUrl,
        "isHost": isHost,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id, userName, email, fullName, avatarUrl, isHost];
}
