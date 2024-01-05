// To parse this JSON data, do
//
//     final bookingDate = bookingDateFromJson(jsonString);

import 'dart:convert';

BookingDate bookingDateFromJson(String str) => BookingDate.fromJson(json.decode(str));

String bookingDateToJson(BookingDate data) => json.encode(data.toJson());

class BookingDate {
    final int id;
    final DateTime checkInDate;
    final DateTime checkOutDate;
    final String status;

    BookingDate({
        required this.id,
        required this.checkInDate,
        required this.checkOutDate,
        required this.status,
    });

    BookingDate copyWith({
        int? id,
        DateTime? checkInDate,
        DateTime? checkOutDate,
        String? status,
    }) => 
        BookingDate(
            id: id ?? this.id,
            checkInDate: checkInDate ?? this.checkInDate,
            checkOutDate: checkOutDate ?? this.checkOutDate,
            status: status ?? this.status,
        );

    factory BookingDate.fromJson(Map<String, dynamic> json) => BookingDate(
        id: json["id"],
        checkInDate: DateTime.parse(json["checkInDate"]),
        checkOutDate: DateTime.parse(json["checkOutDate"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "checkInDate": checkInDate.toIso8601String(),
        "checkOutDate": checkOutDate.toIso8601String(),
        "status": status,
    };
}
