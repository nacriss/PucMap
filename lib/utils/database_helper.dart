import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/predio_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'predios.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE predios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        descricao TEXT,
        imagens TEXT
      )
    ''');
  }

  Future<int> insertPredio(Predio predio) async {
    final db = await database;
    return await db.insert('predios', predio.toMap());
  }

  Future<List<Predio>> getPredios() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('predios');
    return List.generate(maps.length, (i) => Predio.fromMap(maps[i]));
  }

  Future<void> deleteAll() async {
    final db = await database;
    await db.delete('predios');
  }

  Future<void> popularBancoInicial() async {
    final db = await database;
    final result = await db.query('predios');

    if (result.isEmpty) {
      await insertPredio(
        Predio(
          nome: 'Prédio 1',
          descricao: 'PROGRAD, PROPPG, PROGEF, SEPLAN',
          imagens: ["", ""],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 02',
          descricao:
              'Reitoria, Secretária de Comunicação - SECOM, Assesoria de Assuntos Estudantis',
          imagens: ['', ''],
        ),
      );

      await insertPredio(
        Predio(
          nome: 'Prédio 03',
          descricao:
              'PRORH, Centro de Registros Acadêmicos - CRA, Setor de Matrículas - SEPLAN, Instituto Politécnico - IPUC',
          imagens: ['', ''],
        ),
      );

      await insertPredio(
        Predio(
          nome: 'Prédio 04',
          descricao: 'Instituto de Filosofia e Teologia – IFT, Auditório 1',
          imagens: ['', ''],
        ),
      );

      await insertPredio(
        Predio(
          nome: 'Prédio 05',
          descricao: 'Faculdade Mineira de Direito – FMD, Auditório 2',
          imagens: ['', ''],
        ),
      );

      await insertPredio(
        Predio(
          nome: 'Prédio 06',
          descricao:
              'Instituto de Ciências Humanas – ICH, Setor de Formaturas – SECOM, Crédito Rotativo – PROGEF, Caixas Eletrônicos (subsolo)',
          imagens: ['', ''],
        ),
      );

      await insertPredio(
        Predio(
          nome: 'Prédio 07',
          descricao:
              'Espaço Cultura e Fé, Lanchonete Boca do Forno, Banco Santander',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 08',
          descricao: 'Divisão de Apoio Comunitário – SECAC, Posto Médico',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 09',
          descricao: 'Laboratórios do IPUC',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 10',
          descricao:
              'Laboratórios e Oficinas do IPUC, SIMCenter, Programa de Pós-graduação em Engenharia Mecânica',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(nome: 'Prédio 11', descricao: 'PROINFRA', imagens: ['', '']),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 12',
          descricao: 'Faculdade de Psicologia – FAPSI',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 13',
          descricao: 'Faculdade de Comunicação e Artes – FCA',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 14',
          descricao: 'ICEG Escola de Negócios',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 15',
          descricao: 'Laboratórios de Engenharia – IPUC',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(nome: 'Prédio 16', descricao: 'Cantina', imagens: ['', '']),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 17',
          descricao: 'PUC Carreiras',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 18',
          descricao: 'Divisão Financeira',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 20',
          descricao:
              'Programa de Pós-graduação em Letras, Programa de Pós-graduação em Ensino, Escola de Teatro',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 21',
          descricao: 'Diretório Central dos Estudantes – DCE',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 23',
          descricao: 'Laboratórios de Fundamentação Biológica – ICBS',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 24',
          descricao:
              'Laboratório de Zoologia – ICBS, Laboratório de Botânica – ICBS, Lab. de Trat. da Informação em Biologia – ICBS',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 25',
          descricao: 'Instituto de Ciências Biológicas e da Saúde – ICBS',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(nome: 'Prédio 26', descricao: 'Biblioteca', imagens: ['', '']),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 27',
          descricao:
              'Laboratório de Biotecnologia e Genética – ICBS, Laboratório de Educação Ambiental – ICBS, Laboratório de Docência – ICBS',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 28',
          descricao: 'CEEFEL – ICBS',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(nome: 'Prédio 29', descricao: 'Cantina', imagens: ['', '']),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 30',
          descricao: 'Teatro João Paulo II, PROEX, Anima PUC Minas',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 33',
          descricao: 'Simulador Solar – GREEN PUC Minas',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 34',
          descricao:
              'Instituto de Ciências Exatas e Informática – ICEI, Centro de Registros Computacionais – CRC',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 35',
          descricao: 'Divisão de Obras – PROINFRA',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 36',
          descricao: 'Divisão de Materiais – PROINFRA',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 37',
          descricao: 'Sistêmica – ICBS',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 38',
          descricao: 'Anexo do ICBS',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 40',
          descricao: 'Museu de Ciências Naturais PUC Minas, Auditório',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 41',
          descricao: 'Programa de Pós-graduação em Zoologia dos Vertebrados',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 42',
          descricao: 'Faculdade de Comunicação e Artes – FCA',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 43',
          descricao:
              'Auditório 3, Sala Multiuso (105/106), Núcleo de Apoio a Inclusão – SECAC, Assessoria de Relações Internacionais – SEPLAN',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 44',
          descricao: 'Clínica de Psicologia – FAPSI',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 45',
          descricao:
              'Clínica de Odontologia – ICBS, Centro de Odontologia e Fisioterapia – ICBS, Centro Clínico de Fonoaudiologia – ICBS',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 46',
          descricao: 'Instituto de Ciências Sociais – ICS',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 47',
          descricao: 'Setor de Bolsas – PROGEF',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 49',
          descricao:
              'CGTEP – ICEG, PUC Consultoria Júnior – ICEG, Núcleo de Apoio Contábil e Fiscal – ICEG',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 50',
          descricao: 'Grupo de Estudos em Energia – GREEN PUC Minas',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 54',
          descricao: 'Emaús – Programas de Pós-graduação',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 57',
          descricao: 'Trailer de Lanches',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(nome: 'Prédio 60', descricao: 'Cisal – ICBS', imagens: ['', '']),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 61',
          descricao: 'E-motion Audiovisual – SECOM',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 65',
          descricao: 'Edifício Centro Acadêmico de Esporte e Lazer – CAEL',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 84',
          descricao:
              'Centro de Espiritualidade, Pastoral Universitária PUC Minas',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 86',
          descricao: 'Clínica de Odontologia CME/triagem – ICBS',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 93',
          descricao:
              'Programa de Pós-graduação em Comunicação, Programa de Pós-graduação em Direito, PUC Minas Virtual, Redentoristas – Programas de Pós-graduação',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 94',
          descricao: 'Central de Informações',
          imagens: ['', ''],
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 95',
          descricao: 'Varanda Pastoral',
          imagens: ['', ''],
        ),
      );
    }
  }
}
