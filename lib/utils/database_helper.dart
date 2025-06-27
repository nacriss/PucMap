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
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'predios.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        //garante nova versao do bd com latitude e longitude inclusos como coluna
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE predios ADD COLUMN latitude REAL;');
          await db.execute('ALTER TABLE predios ADD COLUMN longitude REAL;');
        }
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE predios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        descricao TEXT,
        imagens TEXT,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL
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
      print(
        "Populating initial database data...",
      ); // Debug: Indica que a população está ocorrendo
      await insertPredio(
        Predio(
          nome: 'Prédio 1',
          descricao: 'PROGRAD, PROPPG, PROGEF, SEPLAN',
          imagens: ["", ""],
          latitude: -19.923615816720226,
          longitude: -43.99178567338048,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 02',
          descricao:
              'Reitoria, Secretária de Comunicação - SECOM, Assesoria de Assuntos Estudantis',
          imagens: ['', ''],
          latitude: -19.924284111077387,
          longitude: -43.992376745745965,
        ),
      );

      await insertPredio(
        Predio(
          nome: 'Prédio 03',
          descricao:
              'PRORH, Centro de Registros Acadêmicos - CRA, Setor de Matrículas - SEPLAN, Instituto Politécnico - IPUC',
          imagens: ['', ''],
          latitude: -19.924138607357737,
          longitude: -43.99302520505389,
        ),
      );

      await insertPredio(
        Predio(
          nome: 'Prédio 04',
          descricao: 'Instituto de Filosofia e Teologia – IFT, Auditório 1',
          imagens: ['', ''],
          latitude: -19.923167322121767,
          longitude: -43.992816967972466,
        ),
      );

      await insertPredio(
        Predio(
          nome: 'Prédio 05',
          descricao: 'Faculdade Mineira de Direito – FMD, Auditório 2',
          imagens: ['', ''],
          latitude: -19.922965832036212,
          longitude: -43.99262920376234,
        ),
      );

      await insertPredio(
        Predio(
          nome: 'Prédio 06',
          descricao:
              'Instituto de Ciências Humanas – ICH, Setor de Formaturas – SECOM, Crédito Rotativo – PROGEF, Caixas Eletrônicos (subsolo)',
          imagens: ['', ''],
          latitude: -19.923037155989114,
          longitude: -43.99203177218225,
        ),
      );

      await insertPredio(
        Predio(
          nome: 'Prédio 07',
          descricao:
              'Espaço Cultura e Fé, Lanchonete Boca do Forno, Banco Santander',
          imagens: ['', ''],
          latitude: -19.92361398728386,
          longitude: -43.992482216620225,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 08',
          descricao: 'Divisão de Apoio Comunitário – SECAC, Posto Médico',
          imagens: ['', ''],
          latitude: -19.92296593836307,
          longitude: -43.993297346550385,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 09',
          descricao: 'Laboratórios do IPUC',
          imagens: ['', ''],
          latitude: -19.92455968316996,
          longitude: -43.99401499068663,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 10',
          descricao:
              'Laboratórios e Oficinas do IPUC, SIMCenter, Programa de Pós-graduação em Engenharia Mecânica',
          imagens: ['', ''],
          latitude: -19.9249752913963,
          longitude: -43.993858236220156,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 11',
          descricao: 'PROINFRA',
          imagens: ['', ''],
          latitude: -19.92190876899976,
          longitude: -43.9926647583101,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 12',
          descricao: 'Faculdade de Psicologia – FAPSI',
          imagens: ['', ''],
          latitude: -19.922549016529025,
          longitude: -43.99231708079163,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 13',
          descricao: 'Faculdade de Comunicação e Artes – FCA',
          imagens: ['', ''],
          latitude: -19.922333101961875,
          longitude: -43.99259777456319,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 14',
          descricao: 'ICEG Escola de Negócios',
          imagens: ['', ''],
          latitude: -19.922730415154152,
          longitude: -43.991618771450646,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 15',
          descricao: 'Laboratórios de Engenharia – IPUC',
          imagens: ['', ''],
          latitude: -19.92461570688746,
          longitude: -43.99330374530707,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 16',
          descricao: 'Cantina',
          imagens: ['', ''],
          latitude: -19.92251473606605,
          longitude: -43.992987517191324,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 17',
          descricao: 'PUC Carreiras',
          imagens: ['', ''],
          latitude: -19.92308526438658,
          longitude: -43.993411429032996,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 18',
          descricao: 'Divisão Financeira',
          imagens: ['', ''],
          latitude: -19.92331247580242,
          longitude: -43.99318637774099,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 20',
          descricao:
              'Programa de Pós-graduação em Letras, Programa de Pós-graduação em Ensino, Escola de Teatro',
          imagens: ['', ''],
          latitude: -19.92325097192233,
          longitude: -43.99558709022201,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 21',
          descricao: 'Diretório Central dos Estudantes – DCE',
          imagens: ['', ''],
          latitude: -19.9234646434677,
          longitude: -43.99385830591466,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 23',
          descricao: 'Laboratórios de Fundamentação Biológica – ICBS',
          imagens: ['', ''],
          latitude: -19.924868538702984,
          longitude: -43.99426224290554,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 24',
          descricao:
              'Laboratório de Zoologia – ICBS, Laboratório de Botânica – ICBS, Lab. de Trat. da Informação em Biologia – ICBS',
          imagens: ['', ''],
          latitude: -19.925339026463895,
          longitude: -43.99424613943586,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 25',
          descricao: 'Instituto de Ciências Biológicas e da Saúde – ICBS',
          imagens: ['', ''],
          latitude: -19.92419822430608,
          longitude: -43.994392744339024,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 26',
          descricao: 'Biblioteca',
          imagens: ['', ''],
          latitude: -19.920643512559625,
          longitude: -43.99319274351172,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 27',
          descricao:
              'Laboratório de Biotecnologia e Genética – ICBS, Laboratório de Educação Ambiental – ICBS, Laboratório de Docência – ICBS',
          imagens: ['', ''],
          latitude: -19.921270487798242,
          longitude: -43.992193296017554,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 28',
          descricao: 'CEEFEL – ICBS',
          imagens: ['', ''],
          latitude: -19.92279012597926,
          longitude: -43.99022257324505,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 29',
          descricao: 'Cantina',
          imagens: ['', ''],
          latitude: -19.923009827178838,
          longitude: -43.991401373935844,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 30',
          descricao: 'Teatro João Paulo II, PROEX, Anima PUC Minas',
          imagens: ['', ''],
          latitude: -19.92322399487588,
          longitude: -43.99100892391698,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 33',
          descricao: 'Simulador Solar – GREEN PUC Minas',
          imagens: ['', ''],
          latitude: -19.921409608066224,
          longitude: -43.99406762578201,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 34',
          descricao:
              'Instituto de Ciências Exatas e Informática – ICEI, Centro de Registros Computacionais – CRC',
          imagens: ['', ''],
          latitude: -19.923094407627563,
          longitude: -43.99434579113177,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 35',
          descricao: 'Divisão de Obras – PROINFRA',
          imagens: ['', ''],
          latitude: -19.92006244182749,
          longitude: -43.99393176471283,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 36',
          descricao: 'Divisão de Materiais – PROINFRA',
          imagens: ['', ''],
          latitude: -19.92024480585904,
          longitude: -43.994233996336554,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 37',
          descricao: 'Sistêmica – ICBS',
          imagens: ['', ''],
          latitude: -19.920978500890694,
          longitude: -43.992235658853225,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 38',
          descricao: 'Anexo do ICBS',
          imagens: ['', ''],
          latitude: -19.924036233714332,
          longitude: -43.9941527997777,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 40',
          descricao: 'Museu de Ciências Naturais PUC Minas, Auditório',
          imagens: ['', ''],
          latitude: -19.921963052454544,
          longitude: -43.98982529469905,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 41',
          descricao: 'Programa de Pós-graduação em Zoologia dos Vertebrados',
          imagens: ['', ''],
          latitude: -19.923751378890337,
          longitude: -43.994360244173144,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 42',
          descricao: 'Faculdade de Comunicação e Artes – FCA',
          imagens: ['', ''],
          latitude: -19.922213243787844,
          longitude: -43.99289103914561,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 43',
          descricao:
              'Auditório 3, Sala Multiuso (105/106), Núcleo de Apoio a Inclusão – SECAC, Assessoria de Relações Internacionais – SEPLAN',
          imagens: ['', ''],
          latitude: -19.923559823223727,
          longitude: -43.99338054228667,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 44',
          descricao: 'Clínica de Psicologia – FAPSI',
          imagens: ['', ''],
          latitude: -19.922957142077408,
          longitude: -43.99472298789233,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 45',
          descricao:
              'Clínica de Odontologia – ICBS, Centro de Odontologia e Fisioterapia – ICBS, Centro Clínico de Fonoaudiologia – ICBS',
          imagens: ['', ''],
          latitude: -19.923411044407676,
          longitude: -43.994889284850125,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 46',
          descricao: 'Instituto de Ciências Sociais – ICS',
          imagens: ['', ''],
          latitude: -19.923827120401615,
          longitude: -43.99514141249882,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 47',
          descricao: 'Setor de Bolsas – PROGEF',
          imagens: ['', ''],
          latitude: -19.925019865533628,
          longitude: -43.99342211652457,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 49',
          descricao:
              'CGTEP – ICEG, PUC Consultoria Júnior – ICEG, Núcleo de Apoio Contábil e Fiscal – ICEG',
          imagens: ['', ''],
          latitude: -19.92283610123685,
          longitude: -43.99128439593881,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 50',
          descricao: 'Grupo de Estudos em Energia – GREEN PUC Minas',
          imagens: ['', ''],
          latitude: -19.921539949711462,
          longitude: -43.994069869999805,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 54',
          descricao: 'Emaús – Programas de Pós-graduação',
          imagens: ['', ''],
          latitude: -19.918707929270546,
          longitude: -43.99364616131853,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 57',
          descricao: 'Trailer de Lanches',
          imagens: ['', ''],
          latitude: -19.92383342457466,
          longitude: -43.99406450556876,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 60',
          descricao: 'Cisal – ICBS',
          imagens: ['', ''],
          latitude: -19.92094977297861,
          longitude: -43.99228636176263,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 61',
          descricao: 'E-motion Audiovisual – SECOM',
          imagens: ['', ''],
          latitude: -19.922326744322636,
          longitude: -43.99407538716728,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 65',
          descricao: 'Edifício Centro Acadêmico de Esporte e Lazer – CAEL',
          imagens: ['', ''],
          latitude: -19.922409960173038,
          longitude: -43.991068630850236,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 84',
          descricao:
              'Centro de Espiritualidade, Pastoral Universitária PUC Minas',
          imagens: ['', ''],
          latitude: -19.924064181495666,
          longitude: -43.99193766657889,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 86',
          descricao: 'Clínica de Odontologia CME/triagem – ICBS',
          imagens: ['', ''],
          latitude: -19.92359893348818,
          longitude: -43.99501952472942,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 93',
          descricao:
              'Programa de Pós-graduação em Comunicação, Programa de Pós-graduação em Direito, PUC Minas Virtual, Redentoristas – Programas de Pós-graduação',
          imagens: ['', ''],
          latitude: -19.925990722269596,
          longitude: -43.994170605573714,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 94',
          descricao: 'Central de Informações',
          imagens: ['', ''],
          latitude: -19.92441721426018,
          longitude: -43.99182367268963,
        ),
      );
      await insertPredio(
        Predio(
          nome: 'Prédio 95',
          descricao: 'Varanda Pastoral',
          imagens: ['', ''],
          latitude: -19.924114966751265,
          longitude: -43.99151857942062,
        ),
      );
      print("Database populated successfully."); // Debug: Confirma a população
    } else {
      print(
        "Database already populated, skipping initial insertion.",
      ); // Debug: Indica que a população foi pulada
    }
  }

  // Função auxiliar para remover acentos e converter para minúsculas
  String _normalizeString(String text) {
    return text
        .toLowerCase()
        .replaceAll('á', 'a')
        .replaceAll('à', 'a')
        .replaceAll('ã', 'a')
        .replaceAll('â', 'a')
        .replaceAll('e', 'é')
        .replaceAll('ê', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ô', 'o')
        .replaceAll('õ', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ü', 'u')
        .replaceAll('ç', 'c');
  }

  Future<List<Predio>> buscarPrediosPorNomeOuNumero(String texto) async {
    final db = await database;
    // 1. Obtém todos os prédios do banco de dados (eficiente para seu número de prédios)
    final List<Map<String, dynamic>> allMaps = await db.query('predios');
    List<Predio> allPredios = List.generate(
      allMaps.length,
      (i) => Predio.fromMap(allMaps[i]),
    );

    print(
      "All Predios from DB: ${allPredios.map((p) => p.nome).toList()}",
    ); // Debug: Veja todos os nomes dos prédios

    if (texto.isEmpty) {
      print(
        "Search text is empty, returning empty list.",
      ); // Debug: Texto de busca vazio
      return []; // Retorna lista vazia se o termo de busca estiver vazio
    }

    // 2. Normaliza o termo de busca fornecido pelo usuário
    final String termoBuscaNormalizado = _normalizeString(texto.trim());
    print(
      "Normalized search term: '$termoBuscaNormalizado'",
    ); // Debug: Termo de busca normalizado

    // 3. Tenta converter o termo de busca para um número inteiro
    int? numeroPredio = int.tryParse(termoBuscaNormalizado);

    // 4. Filtra os prédios em Dart (em memória)
    List<Predio> filteredPredios = allPredios.where((predio) {
      // Normaliza o nome do prédio do banco de dados para comparação
      final String predioNomeNormalizado = _normalizeString(predio.nome);
      print(
        "  Comparing '${predio.nome}' (normalized: '$predioNomeNormalizado') with '$termoBuscaNormalizado'",
      ); // Debug: Comparação individual

      // Critério 1: Se o termo de busca é um número e corresponde ao ID
      if (numeroPredio != null && predio.id == numeroPredio) {
        print("    Match by ID: ${predio.id}"); // Debug: Match por ID
        return true;
      }

      // Critério 2: Se o termo de busca é um número e o nome do prédio
      // normalizado começa com "predio X" (ex: "predio 1")
      // Usa startsWith para ser mais preciso com o formato "Prédio X"
      if (numeroPredio != null &&
          predioNomeNormalizado.startsWith('predio $numeroPredio')) {
        print(
          "    Match by 'predio X' format: ${predio.nome}",
        ); // Debug: Match por "predio X"
        return true;
      }

      // Critério 3: O nome normalizado do prédio contém o termo de busca normalizado
      // (ignora maiúsculas/minúsculas e acentos, busca parcial)
      if (predioNomeNormalizado.contains(termoBuscaNormalizado)) {
        print(
          "    Match by partial name: ${predio.nome}",
        ); // Debug: Match por nome parcial
        return true;
      }

      return false; // Não houve match
    }).toList();

    print("Filtered Predios found:"); // Debug
    for (var p in filteredPredios) {
      print("  - ID: ${p.id}, Nome: ${p.nome}"); // Debug: List filtered prédios
    }
    print(
      "Filtered Predios count: ${filteredPredios.length}",
    ); // Debug: Quantidade de resultados
    return filteredPredios;
  }
}
