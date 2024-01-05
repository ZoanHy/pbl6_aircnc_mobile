// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'booking_bloc.dart';

sealed class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class LoadAllBookingEvent extends BookingEvent {
  final User user;

  LoadAllBookingEvent({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class ClickToShowQrCodeEvent extends BookingEvent {
  final String code;

  ClickToShowQrCodeEvent({
    required this.code,
  });

  @override
  List<Object> get props => [code];
}

class CheckInBookingEvent extends BookingEvent {
  final String code;

  CheckInBookingEvent({
    required this.code,
  });

  @override
  List<Object> get props => [code];
}

class OrderBookingEvent extends BookingEvent {
  final int propertyId;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int numberOfAdults;
  final int numberOfChildren;
  final String note;

  OrderBookingEvent({
    required this.propertyId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.numberOfAdults,
    required this.numberOfChildren,
    required this.note,
  });
}

class LoadPaymentUrlEvent extends BookingEvent {
  final int bookingId;
  LoadPaymentUrlEvent({
    required this.bookingId,
  });
}

class LoadBookingDateEvent extends BookingEvent {
  final int propertyId;
  LoadBookingDateEvent({
    required this.propertyId,
  });
  
}
