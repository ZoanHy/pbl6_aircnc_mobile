// To parse this JSON data, do
//
//     final booking = bookingFromJson(jsonString);

import 'dart:convert';

Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));

String bookingToJson(Booking data) => json.encode(data.toJson());

class Booking {
  int id;
  int propertyId;
  String? propertyName;
  int? hostId;
  String? hostName;
  String? hostEmail;
  String? hostPhoneNumber;
  String? status;
  DateTime checkInDate;
  DateTime checkOutDate;
  int? numberOfDays;
  int? pricePerNight;
  int? cleaningFee;
  int? totalPrice;
  int? numberOfAdults;
  int? numberOfChildren;
  String? note;
  String? checkInCode;

  Booking({
    required this.id,
    required this.propertyId,
    required this.propertyName,
    required this.hostId,
    required this.hostName,
    required this.hostEmail,
    required this.hostPhoneNumber,
    required this.status,
    required this.checkInDate,
    required this.checkOutDate,
    required this.numberOfDays,
    required this.pricePerNight,
    required this.cleaningFee,
    required this.totalPrice,
    required this.numberOfAdults,
    required this.numberOfChildren,
    required this.note,
    required this.checkInCode,
  });

  Booking copyWith({
    int? id,
    int? propertyId,
    String? propertyName,
    int? hostId,
    String? hostName,
    String? hostEmail,
    String? hostPhoneNumber,
    String? status,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    int? numberOfDays,
    int? pricePerNight,
    int? cleaningFee,
    int? totalPrice,
    int? numberOfAdults,
    int? numberOfChildren,
    String? note,
    String? checkInCode,
  }) =>
      Booking(
        id: id ?? this.id,
        propertyId: propertyId ?? this.propertyId,
        propertyName: propertyName ?? this.propertyName,
        hostId: hostId ?? this.hostId,
        hostName: hostName ?? this.hostName,
        hostEmail: hostEmail ?? this.hostEmail,
        hostPhoneNumber: hostPhoneNumber ?? this.hostPhoneNumber,
        status: status ?? this.status,
        checkInDate: checkInDate ?? this.checkInDate,
        checkOutDate: checkOutDate ?? this.checkOutDate,
        numberOfDays: numberOfDays ?? this.numberOfDays,
        pricePerNight: pricePerNight ?? this.pricePerNight,
        cleaningFee: cleaningFee ?? this.cleaningFee,
        totalPrice: totalPrice ?? this.totalPrice,
        numberOfAdults: numberOfAdults ?? this.numberOfAdults,
        numberOfChildren: numberOfChildren ?? this.numberOfChildren,
        note: note ?? this.note,
        checkInCode: checkInCode ?? this.checkInCode,
      );

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        propertyId: json["propertyId"],
        propertyName: json["propertyName"],
        hostId: json["hostId"],
        hostName: json["hostName"],
        hostEmail: json["hostEmail"],
        hostPhoneNumber: json["hostPhoneNumber"],
        status: json["status"],
        checkInDate: DateTime.parse(json["checkInDate"]),
        checkOutDate: DateTime.parse(json["checkOutDate"]),
        numberOfDays: json["numberOfDays"],
        pricePerNight: json["pricePerNight"],
        cleaningFee: json["cleaningFee"],
        totalPrice: json["totalPrice"],
        numberOfAdults: json["numberOfAdults"],
        numberOfChildren: json["numberOfChildren"],
        note: json["note"],
        checkInCode: json["checkInCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "propertyId": propertyId,
        "propertyName": propertyName,
        "hostId": hostId,
        "hostName": hostName,
        "hostEmail": hostEmail,
        "hostPhoneNumber": hostPhoneNumber,
        "status": status,
        "checkInDate": checkInDate.toIso8601String(),
        "checkOutDate": checkOutDate.toIso8601String(),
        "numberOfDays": numberOfDays,
        "pricePerNight": pricePerNight,
        "cleaningFee": cleaningFee,
        "totalPrice": totalPrice,
        "numberOfAdults": numberOfAdults,
        "numberOfChildren": numberOfChildren,
        "note": note,
        "checkInCode": checkInCode,
      };
}
