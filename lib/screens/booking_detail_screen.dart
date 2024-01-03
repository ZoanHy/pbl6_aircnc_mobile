// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pbl6_aircnc/blocs/booking_bloc/booking_bloc.dart';

import 'package:pbl6_aircnc/models/property.dart';
import 'package:pbl6_aircnc/screens/payment_screen.dart';

class BookingDetailScreen extends StatefulWidget {
  Property property;
  BookingDetailScreen({
    Key? key,
    required this.property,
  }) : super(key: key);

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  DateTime startDate = DateTime.now().add(Duration(days: 3));

  DateTime endDate = DateTime.now().add(Duration(days: 5));

  int numberOfAdults = 0;
  int numberOfChildren = 0;

  final BookingBloc bookingBloc = BookingBloc();

  late var difference;
  TextEditingController descriptionController = TextEditingController();

  // function to get the differnce of dates in days
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round() + 1;
  }

  String formatDateFunc(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      // update the result
      difference = daysBetween(startDate, endDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Confirm and pay'),
        ),
        body: BlocConsumer<BookingBloc, BookingState>(
          bloc: bookingBloc,
          listener: (context, state) {
            // TODO: implement listener
            if (state is OrderBookingSuccessState) {
              print('order success');

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PaymentScreen(
                  bookingId: state.bookingId,
                ),
              ));
            } else if (state is OrderBookingFailedState) {
              Fluttertoast.showToast(
                  msg: state.message, textColor: Colors.red, fontSize: 16);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your strip',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Choose date',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return CalendarDatePicker2WithActionButtons(
                                        config:
                                            CalendarDatePicker2WithActionButtonsConfig(
                                                firstDayOfWeek: 1,
                                                calendarType:
                                                    CalendarDatePicker2Type
                                                        .range,
                                                selectedDayTextStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
                                                selectedDayHighlightColor:
                                                    Colors.blue[800],
                                                centerAlignModePicker: true,
                                                customModePickerIcon:
                                                    SizedBox(),
                                                weekdayLabels: [
                                                  'Sun',
                                                  'Mon',
                                                  'Tue',
                                                  'Wed',
                                                  'Thu',
                                                  'Fri',
                                                  'Sat'
                                                ],
                                                weekdayLabelTextStyle:
                                                    TextStyle(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                // controlsHeight: 50,
                                                controlsTextStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                        value: [startDate, endDate],
                                        onValueChanged: (dates) {
                                          setState(() {
                                            startDate = DateTime.parse(
                                                dates[0].toString());
                                            endDate = DateTime.parse(
                                                dates[1].toString());
                                            setState(() {
                                              // update the result
                                              difference = daysBetween(
                                                  startDate, endDate);
                                            });
                                          });
                                          print(dates);
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('Change date'),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Text(
                          'Start date:  ${formatDateFunc(startDate)}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'End date:    ${formatDateFunc(endDate)}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Choose number of people',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        _buildGuestsQuanitySelector(
                            context, 'Adults', 'Ages 13 or above', () {
                          setState(() {
                            numberOfAdults += 1;
                          });
                        }, () {
                          setState(() {
                            if (numberOfAdults > 0) {
                              numberOfAdults -= 1;
                            }
                          });
                        }, numberOfAdults),
                        SizedBox(
                          height: 10,
                        ),
                        _buildGuestsQuanitySelector(
                            context, 'Children', 'Ages 2-12', () {
                          setState(() {
                            numberOfChildren += 1;
                          });
                        }, () {
                          setState(() {
                            if (numberOfChildren > 0) {
                              numberOfChildren -= 1;
                            }
                          });
                        }, numberOfChildren),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                          height: 3,
                          thickness: 3,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Price details',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${NumberFormat.currency(locale: 'vi_VN').format(widget.property.pricePerNight)} \nx ${difference} nights',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w100),
                            ),
                            Text(
                              '${NumberFormat.currency(locale: 'vi_VN').format(widget.property.pricePerNight * difference)}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w100),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cleaning fees: ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w100),
                            ),
                            Text(
                              '${NumberFormat.currency(locale: 'vi_VN').format(widget.property.cleaningFee)}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w100),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                          height: 3,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total (VND)',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${NumberFormat.currency(locale: 'vi_VN').format(widget.property.cleaningFee + widget.property.pricePerNight * difference)}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w100),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Divider(
                          height: 3,
                          thickness: 3,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Description or Note',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextField(
                          autofocus: true,
                          controller: descriptionController,
                          minLines: 3,
                          maxLines: 5,
                          decoration: const InputDecoration(
                              label: Text(
                                'Description',
                                style: TextStyle(fontSize: 16),
                              ),
                              border: OutlineInputBorder()),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Do you confirm your choice'),
                              actionsAlignment: MainAxisAlignment.spaceBetween,
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red)),
                                    child: Container(
                                      color: Colors.red,
                                      padding: EdgeInsets.all(10),
                                      child: Text('Cancel'),
                                    )),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      bookingBloc.add(OrderBookingEvent(
                                          propertyId: widget.property.id,
                                          checkInDate: startDate,
                                          checkOutDate: endDate,
                                          numberOfAdults: numberOfAdults,
                                          numberOfChildren: numberOfChildren,
                                          note: descriptionController.text));
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.green)),
                                    child: Container(
                                      color: Colors.green,
                                      padding: EdgeInsets.all(10),
                                      child: Text('Confirm'),
                                    ))
                              ],
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text('Order Room'),
                        ))
                  ],
                ),
              ),
            );
          },
        ));
  }

  Container _buildGuestsQuanitySelector(
    BuildContext context,
    String title,
    String subtitle,
    VoidCallback onIncrement,
    VoidCallback onDecrement,
    int value,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
              SizedBox(
                height: 5,
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: onIncrement,
                icon: const Icon(
                  Icons.add,
                  size: 20,
                ),
              ),
              Text(
                value.toString(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: onDecrement,
                icon: const Icon(
                  Icons.remove,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
