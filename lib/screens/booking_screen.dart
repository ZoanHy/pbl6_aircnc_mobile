// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pbl6_aircnc/blocs/booking_bloc/booking_bloc.dart';
import 'package:pbl6_aircnc/models/user.dart';
import 'package:pbl6_aircnc/screens/result_qr_code_screen.dart';
import 'package:pbl6_aircnc/widgets/booking_card.dart';

// ignore: must_be_immutable
class BookingScreen extends StatefulWidget {
  User user;

  BookingScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final BookingBloc bookingBloc = BookingBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookingBloc.add(LoadAllBookingEvent(user: widget.user));
  }

  @override
  Widget build(BuildContext context) {
    print('booking screen');
    print(widget.user);

    return BlocConsumer<BookingBloc, BookingState>(
      bloc: bookingBloc,
      buildWhen: (previous, current) => current is! BookingActionState,
      listenWhen: (previous, current) => current is BookingActionState,
      listener: (context, state) {
        if (state is NavigateToQrCodeState) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ResultQrCodeScreen(code: state.code),
          ));
        }
      },
      builder: (context, state) {
        if (state is LoaddAllBookingState) {
          return Scaffold(
            appBar: AppBar(title: Text('Booking')),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(
                    Duration(seconds: 1),
                    () {
                      bookingBloc.add(LoadAllBookingEvent(user: widget.user));
                    },
                  );
                },
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: state.bookings.length,
                  itemBuilder: (context, index) {
                    final booking = state.bookings[index];
                    return BookingCard(booking: booking);
                  },
                ),
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
