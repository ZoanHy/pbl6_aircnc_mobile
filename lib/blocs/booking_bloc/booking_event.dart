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
