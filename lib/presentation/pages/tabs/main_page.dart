import 'package:flutter/material.dart';
import 'package:qr_laser_sunmi/presentation/pages/tabs/page_home.dart';
import 'package:qr_laser_sunmi/presentation/pages/tabs/page_qrs.dart';
import 'package:qr_laser_sunmi/presentation/pages/tabs/page_inventary.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const PageHome(),
    const PageInventary(), // Cambiado a PageInventario
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
        backgroundColor: Colors.black, // Color negro para el AppBar
        elevation: 0, // Sin sombra
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTabButton('Home', Icons.home, _selectedIndex == 0, 0),
                _buildTabButton(
                    'Inventario', Icons.inventory, _selectedIndex == 1, 1),
                _buildTabButton('QRS', Icons.qr_code, _selectedIndex == 2, 2),
              ],
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              child: _pages[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(
      String label, IconData icon, bool isSelected, int index) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? const Color(0xFF007AFF) : const Color(0xFF2C2C2C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
      onPressed: () {
        _onTabSelected(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.grey[500],
            size: 24,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[500],
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
