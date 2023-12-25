// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'booking_bloc.dart';

sealed class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

final class BookingInitial extends BookingState {}

class BookingActionState extends BookingState {}

class LoaddAllBookingState extends BookingState {
  final List<List<Booking>> lstBookingPages;

  LoaddAllBookingState({
    required this.lstBookingPages,
  });

  @override
  List<Object> get props => [lstBookingPages];
}

class NavigateToQrCodeState extends BookingActionState {
  String code;

  NavigateToQrCodeState({
    required this.code,
  });

  @override
  List<Object> get props => [code];
}

class ScanCodeQrSuccessAndReturnProfileState extends BookingActionState {}

class ScanCodeQrFailedState extends BookingActionState {}
