import 'package:flutter/material.dart';
import 'package:qr_laser_sunmi/presentation/pages/tabs/main_page.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro moderno
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Bienvenido',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28, // Tamaño de letra un poco más grande
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5, // Espaciado para darle modernidad
              ),
            ),
            const SizedBox(height: 50),
            // Primer botón (moderno, blanco con texto negro)
            _buildModernButton(
              context: context,
              label: 'Saber de QR Scanner',
              onPressed: () => _navigateWithModernAnimation(context),
            ),
            const SizedBox(height: 20),
            // Segundo botón (moderno, blanco con texto negro)
            _buildModernButton(
              context: context,
              label: 'Ingresar a Inventario',
              onPressed: () => _navigateWithModernAnimation(context),
            ),
          ],
        ),
      ),
    );
  }

  // Función para generar los botones con un estilo moderno
  Widget _buildModernButton({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Fondo blanco para el botón
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Bordes redondeados
        ),
        elevation: 5, // Sombra leve para darle más profundidad
        shadowColor: Colors.black.withOpacity(0.2), // Sombra más suave
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black, // Texto negro
          fontSize: 18,
          fontWeight:
              FontWeight.bold, // Texto en negrita para mejor legibilidad
        ),
      ),
    );
  }

  // Función que realiza la navegación con una animación moderna
  void _navigateWithModernAnimation(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => MainPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Definimos la animación de escala y desvanecimiento
          const begin = 0.8; // Comienza desde un tamaño más pequeño
          const end = 1.0; // Termina en tamaño normal
          const curve = Curves.easeInOut;

          var scaleTween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          var fadeTween = Tween(begin: 0.0, end: 1.0).chain(
            CurveTween(curve: curve),
          );

          return ScaleTransition(
            scale: animation.drive(scaleTween),
            child: FadeTransition(
              opacity: animation.drive(fadeTween),
              child: child,
            ),
          );
        },
        transitionDuration:
            Duration(milliseconds: 500), // Duración de la animación
      ),
    );
  }
}
