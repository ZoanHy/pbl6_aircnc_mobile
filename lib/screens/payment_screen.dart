// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pbl6_aircnc/blocs/booking_bloc/booking_bloc.dart';
import 'package:pbl6_aircnc/models/booking.dart';

class PaymentScreen extends StatefulWidget {
  final int bookingId;

  const PaymentScreen({
    Key? key,
    required this.bookingId,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final BookingBloc bookingBloc = BookingBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bookingBloc.add(LoadPaymentUrlEvent(bookingId: widget.bookingId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: BlocBuilder<BookingBloc, BookingState>(
        bloc: bookingBloc,
        builder: (context, state) {
          if (state is LoadPaymentUrlState) {
            print(state.urlPayment);
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      print('click to web');
                   
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Payment Process',
                          style: TextStyle(fontSize: 16)),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Go Bookingpage',
                          style: TextStyle(fontSize: 16)),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
