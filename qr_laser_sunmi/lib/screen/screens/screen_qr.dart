import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class screen_qr extends StatefulWidget {
  @override
  _screen_qrState createState() => _screen_qrState();
}

class _screen_qrState extends State<screen_qr> {
  static const MethodChannel _channel =
      MethodChannel('com.yourcompany.scanner');
  String _scannedCode = 'No code scanned yet';

  @override
  void initState() {
    super.initState();
    initScanner();
  }

  Future<void> initScanner() async {
    _channel.setMethodCallHandler(_handleMethod);
    try {
      await _channel.invokeMethod('startScan');
    } on PlatformException catch (e) {
      setState(() {
        _scannedCode = "Failed to start scanner: ${e.message}";
      });
    }
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'onCodeScanned':
        setState(() {
          _scannedCode = call.arguments;
        });
        break;
      default:
        throw MissingPluginException('notImplemented');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Code'),
      ),
      body: Center(
        child: Text(_scannedCode),
      ),
    );
  }

  @override
  void dispose() {
    _channel.invokeMethod('stopScan');
    super.dispose();
  }
}
