import 'package:flutter/material.dart';
import 'package:qr_laser_sunmi/data/database.dart';

class ScannedQRList extends StatefulWidget {
  const ScannedQRList({super.key});

  @override
  State<ScannedQRList> createState() => _ScannedQRListState();
}

class _ScannedQRListState extends State<ScannedQRList> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QRs Escaneados'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _dbHelper.getScannedQrs(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final qrCodes = snapshot.data!;
          if (qrCodes.isEmpty) {
            return Center(child: Text('No hay códigos QR escaneados.'));
          }

          return ListView.builder(
            itemCount: qrCodes.length,
            itemBuilder: (context, index) {
              final qr = qrCodes[index];
              return ListTile(
                title: Text(qr['data']),
                subtitle: Text(qr['date_scanned']),
              );
            },
          );
        },
      ),
    );
  }
}
