import 'package:flutter/material.dart';
import 'package:qr_laser_sunmi/presentation/pages/tabs/page_home.dart';
import 'package:qr_laser_sunmi/presentation/pages/tabs/page_qrs.dart';
import 'package:qr_laser_sunmi/presentation/pages/tabs/page_inventary.dart';

class Routes extends StatelessWidget {
  final int index;
  const Routes({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const PageHome(),
      const PageInventary(),
      const PageQR(),
    ];
    return pages[index];
  }
}
