import 'package:flutter/material.dart';
import '../utils/database_helper.dart';
import '../models/predio_model.dart';

class PrediosPage extends StatefulWidget {
  const PrediosPage({super.key});

  @override
  State<PrediosPage> createState() => _PrediosPageState();
}

class _PrediosPageState extends State<PrediosPage> {
  List<Predio> predios = [];

  @override
  void initState() {
    super.initState();
    carregarPredios();
  }

  Future<void> carregarPredios() async {
    final lista = await DatabaseHelper.instance.getPredios();
    setState(() {
      predios = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: predios.length,
        itemBuilder: (context, index) {
          final predio = predios[index];

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                predio.nome,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(predio.descricao),
            ),
          );
        },
      ),
    );
  }
}
