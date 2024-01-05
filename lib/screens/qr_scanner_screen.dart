import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pbl6_aircnc/blocs/booking_bloc/booking_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  final BookingBloc bookingBloc = BookingBloc();

  @override
  void reassemble() {
    // TODO: implement reassemble
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<BookingBloc, BookingState>(
        bloc: bookingBloc,
        listener: (context, state) {
          // TODO: implement listener
          if (state is ScanCodeQrFailedState) {
            Fluttertoast.showToast(
                msg: 'Check in Failed',
                backgroundColor: Colors.red,
                timeInSecForIosWeb: 1,
                gravity: ToastGravity.BOTTOM);
          } else if (state is ScanCodeQrSuccessAndReturnProfileState) {
            Fluttertoast.showToast(
                msg: 'Check in Success',
                backgroundColor: Colors.green,
                timeInSecForIosWeb: 1,
                gravity: ToastGravity.BOTTOM);
            Navigator.pop(context);
          } 
        },
        child: Container(
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: onQRViewCamera,
                  )),
              SizedBox(
                height: 15,
              ),
              Center(
                child: (result != null)
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          bookingBloc.add(CheckInBookingEvent(
                              code: '${result?.code.toString()}'));
                        },
                        child: Text(
                          'Check in',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ))
                    : Text(
                        'Scan a code',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Go back",
                    style: TextStyle(fontSize: 16),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void onQRViewCamera(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    super.dispose();
  }
}
