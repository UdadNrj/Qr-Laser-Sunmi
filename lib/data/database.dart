import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDb();
    return _db!;
  }

  DatabaseHelper.internal();

  // Inicialización de la base de datos
  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'qr_scanner.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE scanned_qrs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT NOT NULL,
            date_scanned TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // Guardar un código QR escaneado en la base de datos
  Future<int> saveScannedQR(String data) async {
    var dbClient = await db;
    return await dbClient.insert('scanned_qrs', {
      'data': data,
      'date_scanned': DateTime.now().toIso8601String(),
    });
  }

  // Obtener todos los códigos QR escaneados
  Future<List<Map<String, dynamic>>> getScannedQrs() async {
    var dbClient = await db;
    return await dbClient.query('scanned_qrs', orderBy: 'date_scanned DESC');
  }

  // Eliminar un código QR por su id
  Future<int> deleteScannedQR(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'scanned_qrs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Actualizar un código QR por su id
  Future<int> updateScannedQR(int id, String newData) async {
    var dbClient = await db;
    return await dbClient.update(
      'scanned_qrs',
      {
        'data': newData,
        'date_scanned': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
