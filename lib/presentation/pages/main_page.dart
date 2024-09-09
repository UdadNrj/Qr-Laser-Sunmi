import 'package:flutter/material.dart';
import 'package:qr_laser_sunmi/presentation/pages/page_home.dart';
import 'package:qr_laser_sunmi/presentation/pages/page_qrs.dart';
import 'package:qr_laser_sunmi/presentation/pages/page_settings.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const PageHome(),
    const PageSettings(),
    const PageQR(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E), // Fondo negro suave
      appBar: AppBar(
        title: const Text('Sunmi QR & Laser App'),
        elevation: 0, // Sin sombra
      ),
      body: Column(
        children: [
          // Botones de Tab personalizados (similares a los de la imagen)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTabButton('Home', _selectedIndex == 0, 0),
                _buildTabButton('Settings', _selectedIndex == 1, 1),
                _buildTabButton('QRS', _selectedIndex == 2, 2),
              ],
            ),
          ),
          Expanded(
            child: _pages[_selectedIndex], // Muestra la página seleccionada
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, bool isSelected, int index) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? const Color(0xFF007AFF)
            : Colors.white, // Azul eléctrico cuando está seleccionado
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        shadowColor: Colors.black.withOpacity(0.3),
      ),
      onPressed: () {
        _onTabSelected(index);
      },
      child: Text(
        label,
        style: TextStyle(
          color: isSelected
              ? Colors.white
              : Colors.black, // Texto blanco si está seleccionado
          fontSize: 16,
        ),
      ),
    );
  }
}
