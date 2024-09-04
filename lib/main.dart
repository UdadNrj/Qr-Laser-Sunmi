import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_laser_sunmi/presentation/pages/main_page.dart';
import 'package:qr_laser_sunmi/providers/token_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => TokenProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(), // Cambiamos LoginPage por MainPage
    );
  }
}
