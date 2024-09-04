import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/pages/main_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

class QRScaner extends StatefulWidget {
  const QRScaner({super.key});

  @override
  State<QRScaner> createState() => _QRScanerState();
}

class _QRScanerState extends State<QRScaner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 5,
              child: QRView(key: qrKey, onQRViewCreated: onQRViewCamera)),
          Expanded(
              child: (result != null)
                  ? Text('Data: ${result!.code}')
                  : const Text('Scan a code')),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(width: 16.0),
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainPage()));
                      },
                      backgroundColor: Colors.white,
                      child: const Icon(
                        Icons.close,
                        color: Colors.pinkAccent,
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  void onQRViewCamera(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
