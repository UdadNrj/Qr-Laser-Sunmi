import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_laser_sunmi/data/database.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_laser_sunmi/data/scanned_data.dart';
import 'package:qr_laser_sunmi/presentation/pages/tabs/main_page.dart';

class QRScaner extends StatefulWidget {
  const QRScaner({super.key});

  @override
  State<QRScaner> createState() => _QRScanerState();
}

class _QRScanerState extends State<QRScaner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  final DatabaseHelper _dbHelper =
      DatabaseHelper(); // Instancia de DatabaseHelper

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
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Escanear Código QR'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // Navegar a la pantalla de lista de códigos escaneados
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScannedQRList()),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          // Área de la cámara del QR
          Expanded(
              flex: 5,
              child: QRView(key: qrKey, onQRViewCreated: onQRViewCamera)),

          // Mostrar el resultado escaneado en tiempo real
          Expanded(
            flex: 1,
            child: Column(
              children: [
                (result != null)
                    ? Text('Data: ${result!.code}',
                        style: const TextStyle(fontSize: 18))
                    : const Text('Escanea un código QR',
                        style: TextStyle(fontSize: 18)),
              ],
            ),
          ),

          // Botón para cerrar el escáner y volver a la página principal
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

  // Lógica para manejar el escaneo de QR y almacenamiento en base de datos
  void onQRViewCamera(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) async {
      setState(() {
        result = event; // Actualiza el resultado del QR escaneado
      });

      // Guardar el resultado escaneado en la base de datos
      if (result != null) {
        await _dbHelper
            .saveScannedQR(result!.code!); // Almacena en la base de datos
        _showQRDataDialog(
            result!.code!); // Muestra el código QR escaneado en una alerta
      }
    });
  }

  // Función para mostrar un diálogo con el contenido escaneado
  void _showQRDataDialog(String qrData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Código QR Escaneado'),
          content: Text('Contenido: $qrData'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
