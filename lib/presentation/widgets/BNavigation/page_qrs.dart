import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/widgets/qr_scnner/qr_scaner.dart';
import 'package:sunmi_scanner/sunmi_scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class PageQR extends StatefulWidget {
  const PageQR({super.key});

  @override
  State<StatefulWidget> createState() => _PageQRState();
}

class _PageQRState extends State<PageQR> {
  // logic Code Scanner Camare
  bool qRCamare = false;
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

  // logic Code Scanner SUNMI

  String? scannedValue;

  void _setScannedValue(String value) {
    setState(() {
      scannedValue = value;
    });
  }

  @override
  void initState() {
    super.initState();
    SunmiScanner.onBarcodeScanned().listen((event) {
      _setScannedValue(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (!qRCamare)
            Center(
              child: scannedValue != null
                  ? Text(
                      scannedValue!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Text(
                      'No hay datos escaneados',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            )
          else
            Expanded(
                flex: 5,
                child: QRView(key: qrKey, onQRViewCreated: onQRViewCamera)),
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
                                builder: (context) => const QRScaner()));
                      },
                      backgroundColor: Colors.white,
                      child: Icon(
                        qRCamare ? Icons.close : Icons.camera_alt_sharp,
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

  // logic Code Scanner Camare
  void onQRViewCamera(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
      });
    });
  }

  // logic Code Scanner Camare
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
