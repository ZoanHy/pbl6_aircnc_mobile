import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pbl6_aircnc/models/booking.dart';
import 'package:pbl6_aircnc/models/property.dart';
import 'package:pbl6_aircnc/models/user.dart';
import 'package:pbl6_aircnc/repositories/booking_repo.dart';
import 'package:pbl6_aircnc/repositories/property_repo.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<LoadAllBookingEvent>(_onLoadAllBookingEvent);
    on<ClickToShowQrCodeEvent>(_onClickToShowQrCodeEvent);
    on<CheckInBookingEvent>(_onCheckInBookingEvent);
    on<OrderBookingEvent>(_onOrderBookingEvent);
  }

  FutureOr<void> _onLoadAllBookingEvent(
      LoadAllBookingEvent event, Emitter<BookingState> emit) async {
    User user = event.user;

    List<List<Booking>> lstBookingPages =
        await BookingRepo.getAllPagesBooking(guestId: user.id);
    List<List<Property>> lstAllPageProperties =
        await PropertyRepo.getAllPagesProperty();
    emit(LoaddAllBookingState(
        lstBookingPages: lstBookingPages, lstProperties: lstAllPageProperties));
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

  FutureOr<void> _onOrderBookingEvent(
      OrderBookingEvent event, Emitter<BookingState> emit) async {
    bool checkOrder = await BookingRepo.orderBooking(
        event.propertyId,
        event.checkInDate,
        event.checkOutDate,
        event.numberOfAdults,
        event.numberOfChildren,
        event.note);

    emit(OrderBookingSuccessState());
  }
}
