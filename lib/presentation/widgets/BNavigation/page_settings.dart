import 'package:flutter/material.dart';

class PageSettings extends StatefulWidget {
  const PageSettings({super.key});

  @override
  State<StatefulWidget> createState() => _PageSettingsState();
}

class _PageSettingsState extends State<PageSettings> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Settings'),
    );
  }
}
