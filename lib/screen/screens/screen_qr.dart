import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScreenQr extends StatefulWidget {
  @override
  _ScreenQrState createState() => _ScreenQrState();
}

class _ScreenQrState extends State<ScreenQr> {
  static const MethodChannel _channel =
      MethodChannel('com.yourcompany.scanner');
  String _scannedCode = 'No se ha leído código';

  @override
  void initState() {
    super.initState();
    initScanner();
  }

  Future<void> initScanner() async {
    _channel.setMethodCallHandler(_handleMethod);
    try {
      await _channel.invokeMethod('startScan'); // Iniciar el escaneo
      print("Escaneo iniciado");
    } on PlatformException catch (e) {
      setState(() {
        _scannedCode = "Error al iniciar el escáner: ${e.message}";
      });
    }
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    if (call.method == 'onCodeScanned') {
      setState(() {
        _scannedCode = call.arguments; // Mostrar el código escaneado
      });
      print("Código escaneado: ${call.arguments}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escáner de Código'),
      ),
      body: Center(
        child: Text(
          _scannedCode, // Mostrar el estado actual (código o mensaje inicial)
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _channel
        .invokeMethod('stopScan'); // Detener el escaneo al cerrar la pantalla
    super.dispose();
  }
}
