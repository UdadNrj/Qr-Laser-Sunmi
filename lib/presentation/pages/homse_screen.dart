import 'package:flutter/material.dart';
import 'package:qr_laser_sunmi/presentation/pages/tabs/main_page.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _buildGradientBackground(), // Fondo con degradado
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Bienvenido',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30, // Tamaño más grande para un efecto moderno
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2, // Aumentar el espacio entre letras
                  ),
                ),
                const SizedBox(height: 50),
                // Primer botón
                _buildModernButton(
                  context: context,
                  label: 'Saber de QR Scanner',
                  onPressed: () =>
                      _navigateWithSlideAnimation(context, MainPage()),
                ),
                const SizedBox(height: 20),
                // Segundo botón
                _buildModernButton(
                  context: context,
                  label: 'Ingresar a Inventario',
                  onPressed: () =>
                      _navigateWithSlideAnimation(context, MainPage()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Función para generar un fondo con degradado
  Widget _buildGradientBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Colors.grey[900]!],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  // Función para crear botones con estilo moderno
  Widget _buildModernButton({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Fondo blanco
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Bordes redondeados
        ),
        elevation: 8, // Más sombra para profundidad
        shadowColor: Colors.white.withOpacity(0.3), // Sombra blanca tenue
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black, // Texto negro
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Función que realiza la navegación con una animación de deslizamiento
  void _navigateWithSlideAnimation(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(
              1.0, 0.0); // Empieza fuera de la pantalla, desde la derecha
          const end = Offset.zero; // Termina en su posición original
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration:
            Duration(milliseconds: 500), // Duración de la animación
      ),
    );
  }
}
