import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/widgets/BNavigation/page_home.dart';
import 'package:flutter_application_1/presentation/widgets/BNavigation/page_qrs.dart';
import 'package:flutter_application_1/presentation/widgets/BNavigation/page_settings.dart';

class Routes extends StatelessWidget {
  final int index;
  const Routes({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const PageHome(),
      const PageSettings(), 
      const PageQR(),
    ];
    return pages[index];
  }
}
