import 'package:flutter/material.dart';
import 'package:qr_laser_sunmi/data/database.dart'; // Asegúrate de usar la ruta correcta

class PageInventary extends StatefulWidget {
  const PageInventary({super.key});

  @override
  State<StatefulWidget> createState() => _PageInventaryState();
}

class _PageInventaryState extends State<PageInventary> {
  final DatabaseHelper _dbHelper =
      DatabaseHelper(); // Instancia de DatabaseHelper
  List<Map<String, dynamic>> scannedQrs = []; // Almacena los datos escaneados

  @override
  void initState() {
    super.initState();
    _loadScannedQrs(); // Cargar los códigos QR escaneados cuando se inicializa la pantalla
  }

  // Método para cargar los códigos QR de la base de datos
  Future<void> _loadScannedQrs() async {
    final data = await _dbHelper.getScannedQrs();
    setState(() {
      scannedQrs =
          data; // Actualiza la lista con los datos obtenidos de la base de datos
    });
  }

  // Método para eliminar un código QR
  Future<void> _deleteQR(int id) async {
    await _dbHelper.deleteScannedQR(id);
    _loadScannedQrs(); // Recargar la lista después de eliminar
  }

  // Método para editar un código QR
  Future<void> _editQR(int id, String newData) async {
    await _dbHelper.updateScannedQR(id, newData);
    _loadScannedQrs(); // Recargar la lista después de editar
  }

  // Mostrar diálogo de confirmación para eliminar
  void _showDeleteDialog(int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text('Confirmar Eliminación',
              style: TextStyle(color: Colors.white)),
          content: const Text(
              '¿Estás seguro de que deseas eliminar este código QR?',
              style: TextStyle(color: Colors.white70)),
          actions: [
            TextButton(
              child:
                  const Text('Cancelar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:
                  const Text('Eliminar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                _deleteQR(id); // Eliminar el código QR
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Mostrar un formulario para editar un código QR
  void _showEditDialog(int id, String currentData) {
    final TextEditingController _controller =
        TextEditingController(text: currentData);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text('Editar Código QR',
              style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Nuevo código QR',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              child:
                  const Text('Cancelar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:
                  const Text('Guardar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                _editQR(id, _controller.text); // Editar el código QR
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro
      body: Stack(
        children: [
          _buildGradientBackground(), // Fondo con degradado
          scannedQrs.isEmpty
              ? const Center(
                  child: Text(
                    'No hay códigos escaneados',
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: scannedQrs.length,
                    itemBuilder: (context, index) {
                      final qr = scannedQrs[index];
                      return Card(
                        color: Colors.grey[900], // Color oscuro para la tarjeta
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 4,
                        child: ListTile(
                          leading:
                              const Icon(Icons.qr_code, color: Colors.white),
                          title: Text(qr['data'],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text('Escaneado el: ${qr['date_scanned']}',
                              style: const TextStyle(color: Colors.white70)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.white),
                                onPressed: () {
                                  _showEditDialog(qr['id'],
                                      qr['data']); // Editar el código QR
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.white),
                                onPressed: () {
                                  _showDeleteDialog(
                                      qr['id']); // Confirmar la eliminación
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
}
