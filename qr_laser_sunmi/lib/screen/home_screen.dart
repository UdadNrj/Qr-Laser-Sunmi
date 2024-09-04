import 'package:flutter/material.dart';
import 'package:qr_laser_sunmi/screen/screens/screen_inventary.dart';
import 'package:qr_laser_sunmi/screen/screens/screen_qr.dart';
import 'package:qr_laser_sunmi/screen/screens/screen_repots.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF202B37),
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
        backgroundColor: Color(0xFF202B37),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      'assets/images/logo2.0.png',
                      height: 100,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => screen_qr()),
                    );
                  },
                  child: Text('Escanear QR',
                      style: TextStyle(shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        Shadow(),
                      ])),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF202B37), // Color del texto
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Color(0xFF202B37), width: 2),
                    ),
                    elevation: 8,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScreenInventary()),
                    );
                  },
                  child: Text('Inventary',
                      style: TextStyle(shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        Shadow(),
                      ])),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF202B37),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Color(0xFF202B37), width: 2),
                    ),
                    elevation: 8,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScreenRepots()),
                    );
                  },
                  child: Text('Reports',
                      style: TextStyle(shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        Shadow(),
                      ])),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF202B37),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Color(0xFF202B37), width: 2),
                    ),
                    elevation: 8,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
