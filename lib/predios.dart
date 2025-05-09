//arquivo p ficar dentro do lib com o main do app
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Predio extends StatelessWidget {
  final String texto;
  var num = 1;
  final lista = [
    {
      'name': 'Prédio 01',
      'lugares0': 'PROGRAD',
      'lugares1': 'PROPPG',
      'lugares2': 'PROGEF',
      'lugares3': 'SEPLAN',
    },
    {
      'name': 'Prédio 02',
      'lugares0': 'Reitoria',
      'lugares1': 'Secretária de Comunicação - SECOM',
      'lugares2': 'Assesoria de Assuntos Estudantis',
      'lugares3': '',
    },
    {
      'name': 'Prédio 03',
      'lugares0': 'PRORH',
      'lugares1': 'Centro de Registros Acadêmicos - CRA',
      'lugares2': 'Setor de Matrículas - SEPLAN',
      'lugares3': 'Instituto Politécnico - IPUC',
    },
    {
      'name': 'Prédio 04',
      'lugares0': 'Instituto de Filosofia e Teologia – IFT',
      'lugares1': 'Auditório 1',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 05',
      'lugares0': 'Faculdade Mineira de Direito – FMD',
      'lugares1': 'Auditório 2',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 06',
      'lugares0': 'Instituto de Ciências Humanas – ICH',
      'lugares1': 'Setor de Formaturas – SECOM',
      'lugares2': 'Crédito Rotativo – PROGEF',
      'lugares3': 'Caixas Eletrônicos (subsolo)',
    },
    {
      'name': 'Prédio 07',
      'lugares0': 'Espaço Cultura e Fé',
      'lugares1': 'Lanchonete Boca do Forno',
      'lugares2': 'Banco Santander',
      'lugares3': '',
    },
    {
      'name': 'Prédio 08',
      'lugares0': 'Divisão de Apoio Comunitário – SECAC',
      'lugares1': 'Posto Médico',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 09',
      'lugares0': 'Laboratórios do IPUC',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 10',
      'lugares0': 'Laboratórios e Oficinas do IPUC',
      'lugares1': 'SIMCenter',
      'lugares2': 'Programa de Pós-graduação em Engenharia Mecânica',
      'lugares3': '',
    },
    {
      'name': 'Prédio 11',
      'lugares0': 'PROINFRA',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 12',
      'lugares0': 'Faculdade de Psicologia – FAPSI',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 13',
      'lugares0': 'Faculdade de Comunicação e Artes – FCA',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 14',
      'lugares0': 'ICEG Escola de Negócios',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 15',
      'lugares0': 'Laboratórios de Engenharia – IPUC',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 16',
      'lugares0': 'Cantina',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 17',
      'lugares0': 'PUC Carreiras',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 18',
      'lugares0': 'Divisão Financeira',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 20',
      'lugares0': 'Programa de Pós-graduação em Letras',
      'lugares1': 'Programa de Pós-graduação em Ensino',
      'lugares2': 'Escola de Teatro',
      'lugares3': '',
    },
    {
      'name': 'Prédio 21',
      'lugares0': 'Diretório Central dos Estudantes – DCE',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 23',
      'lugares0': 'Laboratórios de Fundamentação Biológica – ICBS',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 24',
      'lugares0': 'Laboratório de Zoologia – ICBS',
      'lugares1': 'Laboratório de Botânica – ICBS',
      'lugares2': 'Lab. de Trat. da Informação em Biologia – ICBS',
      'lugares3': '',
    },
    {
      'name': 'Prédio 25',
      'lugares0': 'Instituto de Ciências Biológicas e da Saúde – ICBS',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 26',
      'lugares0': 'Biblioteca',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 27',
      'lugares0': 'Laboratório de Biotecnologia e Genética – ICBS',
      'lugares1': 'Laboratório de Educação Ambiental – ICBS',
      'lugares2': 'Laboratório de Docência – ICBS',
      'lugares3': '',
    },
    {
      'name': 'Prédio 28',
      'lugares0': 'CEEFEL – ICBS',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 29',
      'lugares0': 'Cantina',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 30',
      'lugares0': 'Teatro João Paulo II',
      'lugares1': 'PROEX',
      'lugares2': 'Anima PUC Minas',
      'lugares3': '',
    },
    {
      'name': 'Prédio 33',
      'lugares0': 'Simulador Solar – GREEN PUC Minas',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 34',
      'lugares0': 'Instituto de Ciências Exatas e Informática – ICEI',
      'lugares1': 'Centro de Registros Computacionais – CRC',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 35',
      'lugares0': 'Divisão de Obras – PROINFRA',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 36',
      'lugares0': 'Divisão de Materiais – PROINFRA',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 37',
      'lugares0': 'Sistêmica – ICBS',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 38',
      'lugares0': 'Anexo do ICBS',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 40',
      'lugares0': 'Museu de Ciências Naturais PUC Minas',
      'lugares1': 'Auditório',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 41',
      'lugares0': 'Programa de Pós-graduação em Zoologia dos Vertebrados',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 42',
      'lugares0': 'Faculdade de Comunicação e Artes – FCA',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 43',
      'lugares0': 'Auditório 3',
      'lugares1': 'Sala Multiuso (105/106)',
      'lugares2': 'Núcleo de Apoio a Inclusão – SECAC',
      'lugares3': 'Assessoria de Relações Internacionais – SEPLAN',
    },
    {
      'name': 'Prédio 44',
      'lugares0': 'Clínica de Psicologia – FAPSI',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 45',
      'lugares0': 'Clínica de Odontologia – ICBS',
      'lugares1': 'Centro de Odontologia e Fisioterapia – ICBS',
      'lugares2': 'Centro Clínico de Fonoaudiologia – ICBS',
      'lugares3': '',
    },
    {
      'name': 'Prédio 46',
      'lugares0': 'Instituto de Ciências Sociais – ICS',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 47',
      'lugares0': 'Setor de Bolsas – PROGEF',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 49',
      'lugares0': 'CGTEP – ICEG',
      'lugares1': 'PUC Consultoria Júnior – ICEG',
      'lugares2': 'Núcleo de Apoio Contábil e Fiscal – ICEG',
      'lugares3': '',
    },
    {
      'name': 'Prédio 50',
      'lugares0': 'Grupo de Estudos em Energia – GREEN PUC Minas',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 54',
      'lugares0': 'Emaús – Programas de Pós-graduação',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 57',
      'lugares0': 'Trailer de Lanches',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 60',
      'lugares0': 'Cisal – ICBS',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 61',
      'lugares0': 'E-motion Audiovisual – SECOM',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 65',
      'lugares0': 'Edifício Centro Acadêmico de Esporte e Lazer – CAEL',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 84',
      'lugares0': 'Centro de Espiritualidade',
      'lugares1': 'Pastoral Universitária PUC Minas',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 86',
      'lugares0': 'Clínica de Odontologia CME/triagem – ICBS',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 94',
      'lugares0': 'Central de Informações',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    {
      'name': 'Prédio 93',
      'lugares0': 'Programa de Pós-graduação em Comunicação',
      'lugares1': 'Programa de Pós-graduação em Direito',
      'lugares2': 'PUC Minas Virtual',
      'lugares3': 'Redentoristas – Programas de Pós-graduação',
    },
    {
      'name': 'Prédio 95',
      'lugares0': 'Varanda Pastoral',
      'lugares1': '',
      'lugares2': '',
      'lugares3': '',
    },
    //add todos, ou criar um banco de dados com todos os predios
  ];

  //Construtor
  Predio({super.key, required this.texto}); // com required

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, num) {
                var predio = lista[num];
                return InkWell(
                  onTap: () {
                    // Definir o que acontece quando o prédio for clicado.
                    // Abrir o trajeto para o Prédio clicado.
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      title: Text(predio["name"].toString()),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          predio["lugares0"].toString().isNotEmpty &&
                                  predio["lugares0"].toString() != ' '
                              ? Text(predio["lugares0"].toString())
                              : SizedBox.shrink(),
                          predio["lugares1"].toString().isNotEmpty &&
                                  predio["lugares1"].toString() != ' '
                              ? Text(predio["lugares1"].toString())
                              : SizedBox.shrink(),
                          predio["lugares2"].toString().isNotEmpty &&
                                  predio["lugares2"].toString() != ' '
                              ? Text(predio["lugares2"].toString())
                              : SizedBox.shrink(),
                          predio["lugares3"].toString().isNotEmpty &&
                                  predio["lugares3"].toString() != ' '
                              ? Text(predio["lugares3"].toString())
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => Divider(),
              itemCount: lista.length,
            ),
          ),
        ],
      ),
    );
  }
}
