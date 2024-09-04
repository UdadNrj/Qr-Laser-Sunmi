import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/token_provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
    getVeues();
  }

  Future<void> getVeues() async {
    const String nextUrl = "https://api-dev.woutick.com/back/v1/venue/";
    final nextResponse = await http.get(Uri.parse(nextUrl), headers: {
      'Authorization': 'Bearer $tokenValue',
    });

    if (nextResponse.statusCode == 200) {
      String nextResponseBody = utf8.decode(nextResponse.bodyBytes);
      final jsonData = jsonDecode(nextResponseBody);
      setState(() {
        venues = List<Map<String, dynamic>>.from(jsonData);
        print(venues);
      });
    } else {
      throw Exception("Fallo al hacer la siguiente petición");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 40, 0, 30),
          height: 600,
          child: ListView.builder(
              itemCount: venues.length,
              itemBuilder: (context, index) {
                final venue = venues[index]['name'];
                return ListTile(
                  title: Text(venue),
                );
              }),
        ),
      ),
    );
  }
}
