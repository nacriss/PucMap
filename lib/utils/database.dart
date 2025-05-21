import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('eventos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE eventos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        local TEXT NOT NULL,
        horario TEXT NOT NULL,
        descricao TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertEvento(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('eventos', row);
  }

  Future<List<Map<String, dynamic>>> getEventos() async {
    final db = await instance.database;
    return await db.query('eventos');
  }

  Future<int> updateEvento(Map<String, dynamic> row) async {
    final db = await instance.database;
    int id = row['id'];
    return await db.update('eventos', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteEvento(int id) async {
    final db = await instance.database;
    return await db.delete('eventos', where: 'id = ?', whereArgs: [id]);
  }
}
