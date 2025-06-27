//database.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Garante que haja apenas uma instância da classe (Singleton)
  static final DatabaseHelper instance = DatabaseHelper._init();

  // Variável estática para armazenar a instância do banco de dados
  static Database? _database;

  // Construtor privado para o padrão Singleton
  DatabaseHelper._init();

  // Getter para a instância do banco de dados.
  // Se o banco ainda não foi inicializado, ele chama _initDB.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(
      'eventos_pucmap.db',
    ); // Nome do arquivo do banco de dados de eventos
    return _database!;
  }

  // Inicializa o banco de dados
  Future<Database> _initDB(String filePath) async {
    final dbPath =
        await getDatabasesPath(); // Obtém o caminho padrão para bancos de dados
    final path = join(
      dbPath,
      filePath,
    ); // Combina o caminho com o nome do arquivo

    // Abre o banco de dados. Se não existir, ele será criado via _createDB.
    // Se a versão for maior que a existente, onUpgrade será chamado.
    return await openDatabase(
      path,
      version:
          2, // Aumenta a versão para garantir que onUpgrade seja chamado se já existir versão 1
      onCreate: _createDB,
      onUpgrade: _onUpgrade, // Adiciona o callback para upgrade
    );
  }

  // Cria a estrutura do banco de dados na primeira vez que é aberto
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE eventos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        local TEXT NOT NULL,
        dia TEXT NOT NULL,     -- Adicionada coluna 'dia' para a data
        horario TEXT NOT NULL,
        descricao TEXT NOT NULL
      )
    ''');
  }

  // Método chamado para fazer upgrade do banco de dados quando a versão muda
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Verifica se a coluna 'dia' já existe para evitar erro em reinstalações ou hot restarts
      List<Map> columns = await db.rawQuery("PRAGMA table_info(eventos)");
      bool diaExists = columns.any((column) => column['name'] == 'dia');

      if (!diaExists) {
        await db.execute('ALTER TABLE eventos ADD COLUMN dia TEXT;');
      }
    }
  }

  // Insere um novo evento no banco de dados
  Future<int> insertEvento(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('eventos', row);
  }

  // Retorna todos os eventos do banco de dados
  Future<List<Map<String, dynamic>>> getEventos() async {
    final db = await instance.database;
    return await db.query('eventos');
  }

  // Atualiza um evento existente no banco de dados
  Future<int> updateEvento(Map<String, dynamic> row) async {
    final db = await instance.database;
    int id =
        row['id']; // Assume que o mapa contém um 'id' para identificar o evento
    return await db.update('eventos', row, where: 'id = ?', whereArgs: [id]);
  }

  // Deleta um evento do banco de dados pelo ID
  Future<int> deleteEvento(int id) async {
    final db = await instance.database;
    return await db.delete('eventos', where: 'id = ?', whereArgs: [id]);
  }
}
