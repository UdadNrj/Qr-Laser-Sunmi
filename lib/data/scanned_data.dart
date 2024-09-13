import 'package:flutter/material.dart';
import 'package:qr_laser_sunmi/data/database.dart';

class ScannedQRList extends StatefulWidget {
  const ScannedQRList({super.key});

  @override
  State<ScannedQRList> createState() => _ScannedQRListState();
}

class _ScannedQRListState extends State<ScannedQRList> {
  final DatabaseHelper _dbHelper =
      DatabaseHelper(); // Instancia de DatabaseHelper

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QRs Escaneados'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _dbHelper.getScannedQrs(), // Obtener los códigos almacenados
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator()); // Indicador de carga
          }

          final qrCodes = snapshot.data!;
          if (qrCodes.isEmpty) {
            return const Center(
                child: Text(
                    'No hay códigos QR escaneados.')); // Mostrar mensaje si no hay códigos
          }

          return ListView.builder(
            itemCount: qrCodes.length,
            itemBuilder: (context, index) {
              final qr = qrCodes[index];
              return ListTile(
                title: Text(qr['data']),
                subtitle: Text('Escaneado el: ${qr['date_scanned']}'),
              );
            },
          );
        },
      ),
    );
  }
}
