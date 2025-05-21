import 'package:flutter/material.dart';
import '../utils/database.dart';

class Eventos extends StatefulWidget {
  const Eventos({super.key});

  @override
  _EventosState createState() => _EventosState();
}

class _EventosState extends State<Eventos> {
  List<Map<String, dynamic>> eventos = [];

  @override
  void initState() {
    super.initState();
    _loadEventos();
  }

  Future<void> _loadEventos() async {
    final data = await DatabaseHelper.instance.getEventos();
    setState(() {
      eventos = data;
    });
  }

  void _showForm({Map<String, dynamic>? evento}) {
    final nomeController = TextEditingController(text: evento?['nome']);
    final localController = TextEditingController(text: evento?['local']);
    final horarioController = TextEditingController(text: evento?['horario']);
    final descricaoController = TextEditingController(
      text: evento?['descricao'],
    );

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(evento == null ? 'Adicionar Evento' : 'Editar Evento'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: nomeController,
                    decoration: InputDecoration(labelText: 'Nome'),
                  ),
                  TextField(
                    controller: localController,
                    decoration: InputDecoration(labelText: 'Local'),
                  ),
                  TextField(
                    controller: horarioController,
                    decoration: InputDecoration(labelText: 'Horário'),
                  ),
                  TextField(
                    controller: descricaoController,
                    decoration: InputDecoration(labelText: 'Descrição'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  final nome = nomeController.text;
                  final local = localController.text;
                  final horario = horarioController.text;
                  final descricao = descricaoController.text;

                  if (evento == null) {
                    await DatabaseHelper.instance.insertEvento({
                      'nome': nome,
                      'local': local,
                      'horario': horario,
                      'descricao': descricao,
                    });
                  } else {
                    await DatabaseHelper.instance.updateEvento({
                      'id': evento['id'],
                      'nome': nome,
                      'local': local,
                      'horario': horario,
                      'descricao': descricao,
                    });
                  }

                  Navigator.of(context).pop();
                  _loadEventos();
                },
                child: Text('Salvar'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancelar'),
              ),
            ],
          ),
    );
  }

  void _deleteEvento(int id) async {
    await DatabaseHelper.instance.deleteEvento(id);
    _loadEventos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Eventos')),
      body:
          eventos.isEmpty
              ? Center(child: Text('Nenhum evento cadastrado!'))
              : ListView.builder(
                itemCount: eventos.length,
                itemBuilder: (context, index) {
                  final evento = eventos[index];
                  return ListTile(
                    title: Text(evento['nome']),
                    subtitle: Text(
                      '${evento['local']} - ${evento['horario']}\n${evento['descricao']}',
                    ),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _showForm(evento: evento),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteEvento(evento['id']),
                        ),
                      ],
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}
