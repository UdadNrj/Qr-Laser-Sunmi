import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/pages/main_page.dart';
import 'package:flutter_application_1/providers/token_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String gmail = '';
  String password = '';

  Future<String> askToken() async {
    const String url = "https://api-dev.woutick.com/back/v1/account/login/";
    final response = await http
        .post(Uri.parse(url), body: {'email': gmail, 'password': password});
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      return jsonData["access"];
    } else {
      throw Exception("Fallo a la hora de pedir los datos");
    }
  }

  @override
  void initState() {
    debugPrint('Estamos en login');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'assets/icons/woutick_w.svg',
            width: 30,
            height: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          bottom:
                              20.0), // Margen inferior entre los dos TextField
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            gmail = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: '@ woutick!',
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: '@ woutick',
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          bottom:
                              20.0), // Margen inferior entre los dos TextField
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.pinkAccent), // Color de fondo del botón
                            foregroundColor: MaterialStateProperty.all(
                                Colors.white), // Color del texto del botón
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 100)), // Relleno del botón
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Borde redondeado del botón
                              ),
                            ),
                          ),
                          onPressed: () async {
                            final token = await askToken();
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            if (token != "") {
                              debugPrint(token);
                              setState(() {
                                prefs.setString('token', token);
                                context.read<TokenProvider>().change(token);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MainPage()));
                              });
                            }
                          },
                          child: const Text(
                            'Login',
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
