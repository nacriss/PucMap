//arquivo p ficar dentro do lib com o main do app
import 'package:flutter/material.dart';

class Predio extends StatelessWidget {
  final String texto;
  final lista = [
    {
      //Prédio 01,
      'lugares0': 'PROGRAD',
      'lugares1': 'PROPPG',
      'lugares2': 'PROGEF',
      'lugares3': 'SEPLAN',
    },
    {
      //Prédio 02,
      'lugares0': 'Reitoria',
      'lugares1': 'Secretária de Cominucação - SECOM',
      'lugares2': 'Assesoria de Assuntos Estudantis',
      'lugares3': '',
    },
    {
      //Prédio 03,
      'lugares0': 'PRORH',
      'lugares1': 'Centro de Registros Acadêmicos - CRA',
      'lugares2': 'Setor de Matrículas - SEPLAN',
      'lugares3': 'Instituto Politécnico - IPUC',
    },
    //add todos, ou criar um banco de dados com todos os predios
  ];

  Predio(this.texto);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Prédios'),
        ), //AppBar
        body: Padding(
            padding: const EdgeInsets.all(24.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(width: double.infinity, height: 120, child: Card()),
              SizedBox(
                height: 600,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var predio = lista[index];
                    return ListTile(
                      title: Text('Predio $index'),
                      subtitle: Column(
                        children: [
                          Text(predio["lugares0"].toString()),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (__, _) => const Divider(),
                  itemCount: 95,
                ),
              )
            ])));
  }
}
