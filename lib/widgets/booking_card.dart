// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pbl6_aircnc/blocs/property_bloc/property_bloc.dart';

import 'package:pbl6_aircnc/models/booking.dart';
import 'package:pbl6_aircnc/screens/payment_screen.dart';
import 'package:pbl6_aircnc/screens/property_detail_screen.dart';
import 'package:pbl6_aircnc/screens/result_qr_code_screen.dart';

class BookingCard extends StatefulWidget {
  final Booking booking;

  const BookingCard({
    Key? key,
    required this.booking,
  }) : super(key: key);

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  String formatDateFunc(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  final PropertyBloc propertyBloc = PropertyBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    propertyBloc
        .add(LoadAllDetailPropertyEvent(propertyId: widget.booking.propertyId));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;

    Color switchColorByBookingStatus(String status) {
      if (status == 'Pending') {
        return Color.fromRGBO(254, 178, 7, 5);
      } else if (status == 'Confirmed') {
        return Colors.green;
      } else if (status == 'CheckedIn') {
        return Colors.purple;
      }

      return Colors.black;
    }

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<PropertyBloc, PropertyState>(
                bloc: propertyBloc,
                builder: (context, state) {
                  if (state is LoadAllDetailPropertyState) {
                    print('load image property detail');
                    print(state.detailProperty.propertyImages[0].url);
                    return Stack(
                      children: [
                        Container(
                            clipBehavior: Clip.antiAlias,
                            width: size.width,
                            height: size.width - 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16)),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: state
                                  .detailProperty.propertyImages[0].url
                                  .toString(),
                              fit: BoxFit.cover,
                              errorWidget: (context, error, stackTrace) {
                                return Image(
                                  image: AssetImage(
                                      "assets/images/image_not_found.jpg"),
                                  fit: BoxFit.scaleDown,
                                );
                              },
                            )),
                      ],
                    );
                  }
                  return Container();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .push(MaterialPageRoute(
                              builder: (context) => PropertyDetailScreen(
                                propertyId: widget.booking.propertyId,
                              ),
                            ));
                          },
                          child: Text(
                            'Title: ',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${widget.booking.propertyName}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Host name: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${widget.booking.hostName}',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Check in: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${formatDateFunc(widget.booking.checkInDate)}',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Check out: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${formatDateFunc(widget.booking.checkOutDate)}',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Total Price: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${NumberFormat.currency(locale: 'vi_VN').format(widget.booking.totalPrice)}',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'State: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${widget.booking.status}',
                          style: TextStyle(
                              fontSize: 18,
                              color: switchColorByBookingStatus(
                                  '${widget.booking.status}')),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          widget.booking.status == 'Pending'
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue)),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .push(MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                              bookingId: widget.booking.id,
                            ),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Payment",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  ),
                )
              : SizedBox.shrink(),
          widget.booking.status == 'Confirmed'
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Canncel",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green)),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ResultQrCodeScreen(
                                    code: '${widget.booking.checkInCode}'),
                              ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "QR Code",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
