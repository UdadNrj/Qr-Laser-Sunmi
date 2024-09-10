import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_laser_sunmi/providers/token_provider.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<StatefulWidget> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  List<Map<String, dynamic>> venues = [];
  late String tokenValue;

  @override
  void initState() {
    super.initState();
    tokenValue = context.read<TokenProvider>().token.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Texto principal con estilo
            Text(
              'Escoge tu tipo de escáner',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Selecciona el tipo de escaneo que deseas realizar.',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),

            // Imágenes de escáner con diferentes funcionalidades
            _buildScannerOption(context, 'assets/icons/qr_scanner_L2S.jpg',
                'Escáner QR', _showQRScannerDetails),
            const SizedBox(height: 20),
            _buildScannerOption(
                context,
                'assets/icons/barcode_scanner_V2pro.jpg',
                'Escáner de Barras',
                _showBarcodeScannerDetails),
            const SizedBox(height: 20),
            _buildScannerOption(context, 'assets/icons/laser_scanner.jpg',
                'Escáner Láser', _showLaserScannerDetails),
          ],
        ),
      ),
    );
  }

  // Widget para mostrar las imágenes con funcionalidad de click
  Widget _buildScannerOption(
      BuildContext context, String imagePath, String title, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Función que muestra detalles del escáner QR
  void _showQRScannerDetails(BuildContext context) {
    _showScannerDetails(context, 'Escáner QR',
        'El escáner QR Sunmi te permite escanear códigos QR rápidamente, utilizando la cámara integrada del dispositivo.');
  }

  // Función que muestra detalles del escáner de códigos de barras
  void _showBarcodeScannerDetails(BuildContext context) {
    _showScannerDetails(context, 'Escáner de Barras',
        'Este escáner está optimizado para leer códigos de barras de manera eficiente, soportando diferentes formatos de código de barras.');
  }

  // Función que muestra detalles del escáner láser
  void _showLaserScannerDetails(BuildContext context) {
    _showScannerDetails(context, 'Escáner Láser',
        'El escáner láser permite la lectura a larga distancia con gran precisión, ideal para grandes almacenes y tiendas.');
  }

  // Función que despliega el modal animado
  void _showScannerDetails(
      BuildContext context, String title, String description) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black.withOpacity(0.8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Características:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildFeatureItem('Alta velocidad de lectura'),
              _buildFeatureItem(
                  'Compatibilidad con diferentes tamaños y formatos'),
              _buildFeatureItem('Optimizado para entornos de baja luz'),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // Función auxiliar para construir elementos de la lista de características
  Widget _buildFeatureItem(String feature) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Icon(Icons.check, color: Colors.greenAccent, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              feature,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
