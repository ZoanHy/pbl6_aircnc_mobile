import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<BookingBloc, BookingState>(
        bloc: bookingBloc,
        listener: (context, state) {
          // TODO: implement listener
          if (state is ScanCodeQrFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              'Check in failed',
              style: TextStyle(color: Colors.green),
            )));
          } else if (state is ScanCodeQrSuccessAndReturnProfileState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              'Check in successfully',
              style: TextStyle(color: Colors.red),
            )));
            Navigator.pop(context);
          }
        },
        child: Container(
          child: Column(
            children: [
              Expanded(
                  flex: 5,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: onQRViewCamera,
                  )),
             Center(
                child: result != null
                    ? ElevatedButton(
                        onPressed: () {
                          bookingBloc.add(CheckInBookingEvent(
                              code: '${result?.code.toString()}'));
                        },
                        child: Text('Check in'))
                    : Text('Scan a code'),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Go back")),
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
