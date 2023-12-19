import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pbl6_aircnc/screens/barcode_scanner_zoom.dart';
import 'package:pbl6_aircnc/screens/result_qr_code_screen.dart';

class ScannQrCodeScreen extends StatefulWidget {
  const ScannQrCodeScreen({super.key});

  @override
  State<ScannQrCodeScreen> createState() => _ScannQrCodeScreenState();
}

class _ScannQrCodeScreenState extends State<ScannQrCodeScreen> {
  bool isScanCompleted = false;

  void closedScreen() {
    isScanCompleted = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: MobileScanner(
                    fit: BoxFit.contain,
                    controller: MobileScannerController(
                      returnImage: true,
                    ),
                    onDetect: (capture) {
                      print(isScanCompleted);
                      if (!isScanCompleted) {
                        final List<Barcode> barcodes = capture.barcodes;
                        final Uint8List? image = capture.image;
                        // isScanCompleted = true;
                        for (final barcode in barcodes) {
                          debugPrint('Barcode found! ${barcode.rawValue}');
                        }
                        if (image != null) {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                Image(image: MemoryImage(image)),
                          );
                          Future.delayed(const Duration(seconds: 5), () {
                            Navigator.pop(context);
                          });
                        }
                      }
                    },
                  ),
                ),
                flex: 4,
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Developed by Zoan Devs',
                  style: TextStyle(
                      color: Colors.black87, fontSize: 14, letterSpacing: 1),
                ),
              )),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const BarcodeScannerWithZoom(),
                    ),
                  );
                },
                child: const Text('MobileScanner with zoom slider'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
