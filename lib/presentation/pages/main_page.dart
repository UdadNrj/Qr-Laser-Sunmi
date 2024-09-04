import 'package:flutter/material.dart';
import 'package:qr_laser_sunmi/presentation/widgets/BNavigation/bottom_nav.dart';
import 'package:qr_laser_sunmi/presentation/widgets/BNavigation/routers.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  String token = "";
  BNavigator? bottomRoute;

  @override
  void initState() {
    super.initState();
    bottomRoute = BNavigator(currentIndex: (route) {
      setState(() {
        index = route;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: bottomRoute, body: Routes(index: index));
  }
}
