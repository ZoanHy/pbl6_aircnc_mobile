import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pbl6_aircnc/models/booking.dart';
import 'package:pbl6_aircnc/models/user.dart';
import 'package:pbl6_aircnc/repositories/booking_repo.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<LoadAllBookingEvent>(_onLoadAllBookingEvent);
    on<ClickToShowQrCodeEvent>(_onClickToShowQrCodeEvent);
    on<CheckInBookingEvent>(_onCheckInBookingEvent);
  }

  FutureOr<void> _onLoadAllBookingEvent(
      LoadAllBookingEvent event, Emitter<BookingState> emit) async {
    User user = event.user;

    List<List<Booking>> lstBookingPages =
        await BookingRepo.getAllPagesBooking(guestId: user.id);

    emit(LoaddAllBookingState(lstBookingPages: lstBookingPages));
  }

  FutureOr<void> _onClickToShowQrCodeEvent(
      ClickToShowQrCodeEvent event, Emitter<BookingState> emit) {
    emit(NavigateToQrCodeState(code: event.code));
  }

  FutureOr<void> _onCheckInBookingEvent(
      CheckInBookingEvent event, Emitter<BookingState> emit) async {
    bool checkQrResult = await BookingRepo.checkIn(codeQr: event.code);
    if (checkQrResult) {
      emit(ScanCodeQrSuccessAndReturnProfileState());
    } else {
      emit(ScanCodeQrFailedState());
    }
  }
}
