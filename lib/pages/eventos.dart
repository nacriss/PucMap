//eventos.dart:
import 'package:flutter/material.dart'; // Importa o pacote fundamental para construir interfaces Flutter.
import '../utils/database.dart'; // Importa o helper do banco de dados, responsável pelas operações CRUD.

// Definição da classe principal do widget, que é um StatefulWidget.
class Eventos extends StatefulWidget {
  const Eventos({
    super.key,
  }); // Construtor com chave opcional para identificação do widget.

  @override
  EventosState createState() => EventosState(); // Cria e retorna a classe de estado associada a este widget.
}

// Classe de estado para o widget Eventos. Ela gerencia os dados e o ciclo de vida da UI.
class EventosState extends State<Eventos> {
  // Lista que armazenará os eventos carregados do banco de dados para exibição na UI.
  List<Map<String, dynamic>> eventos = [];

  // === INÍCIO DO GERENCIAMENTO ROBUSTO DOS CONTROLADORES ===
  // Declaração de todos os TextEditingControllers como variáveis de instância (late).
  late TextEditingController _nomeController;
  late TextEditingController _localController;
  late TextEditingController _descricaoController;
  late TextEditingController
  _dateTextController; // Controlador para exibir a data formatada
  late TextEditingController
  _horarioTextController; // Controlador para exibir a hora formatada

  // Variáveis para armazenar a data e hora selecionadas pelos seletores (DatePicker/TimePicker).
  // Estas variáveis guardam os objetos DateTime e TimeOfDay.
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  // === FIM DO GERENCIAMENTO ROBUSTO DOS CONTROLADORES ===

  @override
  void initState() {
    super.initState(); // Chama o initState da classe pai.
    // Inicializa todos os TextEditingControllers no initState.
    _nomeController = TextEditingController();
    _localController = TextEditingController();
    _descricaoController = TextEditingController();
    _dateTextController = TextEditingController();
    _horarioTextController = TextEditingController();

    _loadEventos(); // Chama a função para carregar os eventos do banco de dados.
  }

  @override
  void dispose() {
    // Isso libera os recursos da memória e evita o erro '_dependents.isEmpty'.
    _nomeController.dispose();
    _localController.dispose();
    _descricaoController.dispose();
    _dateTextController.dispose();
    _horarioTextController
        .dispose(); // Garante que este também seja descartado.
    super.dispose(); // Chama o dispose da classe pai.
  }

  // Função assíncrona para carregar os eventos do banco de dados.
  Future<void> _loadEventos() async {
    // Obtém a lista de eventos usando o DatabaseHelper.
    final data = await DatabaseHelper.instance.getEventos();
    // Atualiza o estado do widget com os novos dados.
    setState(() {
      eventos = data; // Atribui os dados carregados à lista de eventos.
      // Ordena os eventos por data e hora para exibição cronológica.
      eventos.sort((a, b) {
        // Assegura que o parse da data ocorra corretamente para a ordenação.
        final DateTime dateA = _parseDateString(a['dia'], a['horario']);
        final DateTime dateB = _parseDateString(b['dia'], b['horario']);
        return dateA.compareTo(dateB); // Compara as datas para ordenação.
      });
    });
  }

  // Função auxiliar para converter strings de data ("DD/MM/YYYY") e hora ("HH:mm") em um objeto DateTime.
  // Usada principalmente para ordenação e para inicializar os seletores de data/hora na edição.
  DateTime _parseDateString(String dateStr, String timeStr) {
    try {
      // Divide a string de data em dia, mês e ano.
      final List<String> dateParts = dateStr.split('/');
      final int day = int.parse(dateParts[0]);
      final int month = int.parse(dateParts[1]);
      final int year = int.parse(dateParts[2]);

      // Divide a string de hora em hora e minuto.
      final List<String> timeParts = timeStr.split(':');
      final int hour = int.parse(timeParts[0]);
      final int minute = int.parse(timeParts[1]);

      // Retorna um objeto DateTime combinado.
      return DateTime(year, month, day, hour, minute);
    } catch (e) {
      // Debug: Imprime erro se o parse da data/hora falhar.
      debugPrint('Erro ao parsear data/hora: $dateStr $timeStr - $e');
      return DateTime.now(); // Retorna a data/hora atual como fallback em caso de erro.
    }
  }

  void _showForm({Map<String, dynamic>? evento}) {
    // Limpar e pré-preencher os controladores de texto com os dados do evento (ou vazios).
    _nomeController.text = evento?['nome'] ?? '';
    _localController.text = evento?['local'] ?? '';
    _descricaoController.text = evento?['descricao'] ?? '';

    // Pré-preencher as variáveis _selectedDate e _selectedTime com base nos dados existentes ou null.
    _selectedDate =
        evento != null && evento['dia'] != null
            ? _parseDateString(evento['dia'], evento['horario'] ?? '00:00')
            : null;
    _selectedTime =
        evento != null && evento['horario'] != null
            ? TimeOfDay.fromDateTime(
              _parseDateString('01/01/2000', evento['horario']),
            )
            : null;

    // Atualizar o texto dos controladores de data/hora com os valores pré-selecionados e formatados.
    _dateTextController.text =
        _selectedDate != null
            ? '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}'
            : '';
    _horarioTextController.text =
        _selectedTime != null
            ? '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}'
            : '';

    // Exibe um diálogo (pop-up) com o formulário.
    showDialog(
      context: context,
      // Usamos StatefulBuilder para que o AlertDialog possa ter seu próprio estado interno
      // e ser atualizado (com setState) quando a data ou hora são selecionadas,
      // sem afetar o widget EventosState principal.
      builder:
          (dialogContext) => StatefulBuilder(
            // Use um nome diferente para o contexto do builder para evitar confusão.
            builder: (context, setStateInDialog) {
              // O 'setStateInDialog' aqui é específico para o StatefulBuilder.
              return AlertDialog(
                title: Text(
                  evento == null ? 'Adicionar Evento' : 'Editar Evento',
                ), // Título do diálogo.
                content: SingleChildScrollView(
                  // Permite que o conteúdo seja rolado se for muito grande.
                  child: Column(
                    // Organiza os campos do formulário verticalmente.
                    mainAxisSize:
                        MainAxisSize
                            .min, // A coluna ocupa apenas o espaço mínimo necessário.
                    children: [
                      // Campo para o Nome do Evento (texto livre).
                      TextField(
                        controller:
                            _nomeController, // Atribui o controlador de instância.
                        decoration: const InputDecoration(labelText: 'Nome'),
                      ),
                      // Campo para o Local do Evento (texto livre).
                      TextField(
                        controller:
                            _localController, // Atribui o controlador de instância.
                        decoration: const InputDecoration(labelText: 'Local'),
                      ),
                      // === INÍCIO DA ACEITAÇÃO DE DATA (DD/MM/AAAA) ===
                      TextFormField(
                        controller:
                            _dateTextController, // Atribui o controlador de instância.
                        readOnly:
                            true, // Torna o campo somente leitura para forçar a seleção via DatePicker.
                        decoration: const InputDecoration(
                          labelText: 'Dia (DD/MM/AAAA)',
                          suffixIcon: Icon(
                            Icons.calendar_today,
                          ), // Ícone de calendário.
                        ),
                        onTap: () async {
                          // Ação ao tocar no campo.
                          final DateTime? pickedDate = await showDatePicker(
                            // Exibe o seletor de data.
                            context: context,
                            initialDate:
                                _selectedDate ??
                                DateTime.now(), // Data inicial sugerida.
                            firstDate: DateTime(2000), // Data mínima permitida.
                            lastDate: DateTime(2101), // Data máxima permitida.
                          );
                          if (pickedDate != null) {
                            setStateInDialog(() {
                              // Atualiza o estado DO DIÁLOGO.
                              _selectedDate =
                                  pickedDate; // Armazena a data selecionada.
                              // Formata a data para exibir no campo de texto.
                              _dateTextController.text =
                                  '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}';
                            });
                          }
                        },
                      ),
                      // === FIM DA ACEITAÇÃO DE DATA ===

                      // === INÍCIO DA ACEITAÇÃO DE HORA (HH:MM - 24h) ===
                      TextFormField(
                        controller:
                            _horarioTextController, // Atribui o controlador de instância.
                        readOnly:
                            true, // Torna o campo somente leitura para forçar a seleção via TimePicker.
                        decoration: const InputDecoration(
                          labelText: 'Horário (HH:MM)',
                          suffixIcon: Icon(
                            Icons.access_time,
                          ), // Ícone de relógio.
                        ),
                        onTap: () async {
                          // Ação ao tocar no campo.
                          final TimeOfDay? pickedTime = await showTimePicker(
                            // Exibe o seletor de hora.
                            context: context,
                            initialTime:
                                _selectedTime ??
                                TimeOfDay.now(), // Hora inicial sugerida.
                            // O builder garante que o seletor de hora seja no formato de 24h,
                            // independentemente das configurações do dispositivo.
                            builder: (context, child) {
                              return MediaQuery(
                                data: MediaQuery.of(
                                  context,
                                ).copyWith(alwaysUse24HourFormat: true),
                                child: child!,
                              );
                            },
                          );
                          if (pickedTime != null) {
                            setStateInDialog(() {
                              // Atualiza o estado DO DIÁLOGO.
                              _selectedTime =
                                  pickedTime; // Armazena a hora selecionada.
                              // Formata a hora para exibir no campo de texto.
                              _horarioTextController.text =
                                  '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}';
                            });
                          }
                        },
                      ),
                      // === FIM DA ACEITAÇÃO DE HORA ===

                      // Campo para a Descrição do Evento (texto livre, múltiplas linhas).
                      TextField(
                        controller:
                            _descricaoController, // Atribui o controlador de instância.
                        decoration: const InputDecoration(
                          labelText: 'Descrição',
                        ),
                        maxLines:
                            3, // Permite que a descrição ocupe até 3 linhas.
                      ),
                    ],
                  ),
                ),
                // Botões de ação do diálogo.
                actions: [
                  TextButton(
                    onPressed: () async {
                      // Ação ao pressionar o botão 'Salvar'.
                      // Obtém os valores dos controladores, removendo espaços em branco extras.
                      final nome = _nomeController.text.trim();
                      final local = _localController.text.trim();
                      final descricao = _descricaoController.text.trim();

                      // Validação para garantir que todos os campos obrigatórios foram preenchidos.
                      // Agora verifica se _selectedDate e _selectedTime estão preenchidos.
                      if (nome.isEmpty ||
                          local.isEmpty ||
                          _selectedDate == null ||
                          _selectedTime == null) {
                        // Exibe uma SnackBar informando o usuário sobre a validação.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Por favor, preencha todos os campos obrigatórios (Nome, Local, Dia, Horário).',
                            ),
                          ),
                        );
                        return; // Retorna para impedir o salvamento.
                      }

                      // === FORMATAÇÃO PARA SALVAR NO BANCO DE DADOS ===
                      // Formata a data para o formato DD/MM/AAAA.
                      final String formattedDate =
                          '${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}';
                      // Formata o horário para o formato HH:mm (24h).
                      final String formattedHorario =
                          '${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}';
                      // === FIM DA FORMATAÇÃO ===

                      // Cria um mapa com os dados a serem salvos no banco de dados.
                      final Map<String, dynamic> dataToSave = {
                        'nome': nome,
                        'local': local,
                        'dia': formattedDate, // Salvando no formato DD/MM/AAAA.
                        'horario':
                            formattedHorario, // Salvando no formato HH:mm.
                        'descricao': descricao,
                      };

                      try {
                        // Verifica se é um novo evento (evento == null) ou uma edição.
                        if (evento == null) {
                          final id = await DatabaseHelper.instance.insertEvento(
                            dataToSave,
                          ); // Insere o novo evento.
                          // Debug: Mensagem com o ID do evento inserido.
                          debugPrint(
                            'EventosState: Evento inserido com ID: $id',
                          );
                        } else {
                          dataToSave['id'] =
                              evento['id']; // Adiciona o ID para a operação de atualização.
                          final rowsAffected = await DatabaseHelper.instance
                              .updateEvento(dataToSave); // Atualiza o evento.
                          // Debug: Mensagem com as linhas afetadas pela atualização.
                          debugPrint(
                            'EventosState: Evento atualizado. Linhas afetadas: $rowsAffected',
                          );
                        }
                      } catch (e) {
                        // Debug: Captura e imprime qualquer erro no processo de salvar no banco de dados.
                        debugPrint(
                          'EventosState: Erro ao salvar no banco de dados: $e',
                        );
                        // Exibe uma SnackBar com a mensagem de erro.
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Erro ao salvar evento: ${e.toString()}',
                            ),
                          ),
                        );
                      }

                      // Verifica se o widget ainda está montado antes de realizar operações de UI.
                      // Isso previne erros se o contexto for perdido (ex: tela fechada) antes do await.
                      if (!mounted) {
                        // Debug: Mensagem indicando que o widget não está mais montado.
                        debugPrint(
                          'EventosState: Widget não está mais montado. Abortando navegação e recarregamento.',
                        );
                        return;
                      }

                      // Fecha o diálogo (AlertDialog). Note que 'dialogContext' é o contexto do dialog.
                      // Usamos dialogContext.pop() para garantir que o dialog correto seja fechado.
                      // ignore: use_build_context_synchronously
                      Navigator.of(dialogContext).pop();
                      _loadEventos(); // Chama _loadEventos para atualizar a lista na tela principal.
                    },
                    child: const Text('Salvar'), // Texto do botão 'Salvar'.
                  ),
                  TextButton(
                    onPressed: () {
                      // Fecha o diálogo. Usamos dialogContext.pop() aqui também.
                      Navigator.of(dialogContext).pop();
                    },
                    child: const Text('Cancelar'), // Texto do botão 'Cancelar'.
                  ),
                ],
              );
            },
          ),
    );
  }

  // Função para deletar um evento do banco de dados.
  void _deleteEvento(int id) async {
    // Exibe um diálogo de confirmação antes de deletar permanentemente.
    final bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'), // Título da confirmação.
          content: const Text(
            'Tem certeza que deseja excluir este evento?',
          ), // Conteúdo da confirmação.
          actions: <Widget>[
            TextButton(
              onPressed:
                  () => Navigator.of(
                    context,
                  ).pop(false), // Retorna false se o usuário cancelar.
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed:
                  () => Navigator.of(
                    context,
                  ).pop(true), // Retorna true se o usuário confirmar.
              child: const Text(
                'Excluir',
                style: TextStyle(color: Colors.red),
              ), // Botão de exclusão em vermelho.
            ),
          ],
        );
      },
    );

    // Se o usuário confirmou a exclusão.
    if (confirmDelete == true) {
      try {
        final rowsAffected = await DatabaseHelper.instance.deleteEvento(
          id,
        ); // Chama o método de exclusão do DB.
        // Debug: Mensagem indicando que o evento foi deletado e quantas linhas foram afetadas.
        debugPrint(
          'EventosState: Evento deletado. Linhas afetadas: $rowsAffected',
        );
        _loadEventos(); // Recarrega a lista de eventos para atualizar a UI.
      } catch (e) {
        // Debug: Captura e imprime qualquer erro no processo de deletar.
        debugPrint('EventosState: Erro ao deletar evento: $e');
        // Exibe uma SnackBar com a mensagem de erro.
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao deletar evento: ${e.toString()}')),
        );
      }
    } else {
      // Debug: Mensagem se a exclusão foi cancelada.
      debugPrint('EventosState: Exclusão cancelada.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Debug: Mensagem indicando que o build foi chamado e a quantidade atual de eventos na lista.
    debugPrint(
      'EventosState: build() chamado. Eventos na lista: ${eventos.length}',
    );
    return Scaffold(
      // A AppBar foi removida daqui, pois o BaseLayout (na HomePage) já a fornece,
      // evitando a duplicação de barras de título.
      body:
          eventos
                  .isEmpty // Verifica se a lista de eventos está vazia.
              ? const Center(
                child: Text('Nenhum evento cadastrado!'),
              ) // Exibe mensagem se não houver eventos.
              : ListView.builder(
                // Constrói uma lista rolavel dos eventos.
                padding: const EdgeInsets.all(
                  8.0,
                ), // Preenchimento ao redor da lista.
                itemCount: eventos.length, // Número de itens na lista.
                itemBuilder: (context, index) {
                  // Construtor para cada item da lista.
                  final evento = eventos[index]; // Obtém o evento atual.
                  return Card(
                    // Cada evento é exibido dentro de um Card para melhor visualização.
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 4.0,
                    ), // Margens do Card.
                    elevation: 4, // Sombra do Card.
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ), // Bordas arredondadas.
                    child: Padding(
                      // Preenchimento dentro do Card.
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        // Organiza os detalhes do evento verticalmente.
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start, // Alinha o conteúdo à esquerda.
                        children: [
                          Text(
                            // Nome do evento.
                            evento['nome'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(
                                0xFF118E8F,
                              ), // Cor personalizada para o título.
                            ),
                          ),
                          const SizedBox(height: 4), // Espaçamento.
                          Text(
                            // Local do evento.
                            'Local: ${evento['local']}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            // Data do evento.
                            'Data: ${evento['dia']}', // Exibe a data no formato DD/MM/AAAA.
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            // Horário do evento.
                            'Horário: ${evento['horario']}', // Exibe o horário no formato HH:mm.
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          // Exibe a descrição somente se ela não for nula e não estiver vazia.
                          if (evento['descricao'] != null &&
                              evento['descricao'].isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Descrição: ${evento['descricao']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          Align(
                            // Alinha os botões de ação à direita.
                            alignment: Alignment.bottomRight,
                            child: Row(
                              // Botões de editar e deletar.
                              mainAxisSize:
                                  MainAxisSize
                                      .min, // Ocupa o mínimo de espaço horizontal.
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Color(0xFF118E8F),
                                  ), // Ícone de editar.
                                  tooltip:
                                      'Editar Evento', // Texto que aparece ao segurar o botão.
                                  onPressed:
                                      () => _showForm(
                                        evento: evento,
                                      ), // Chama o formulário para edição.
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ), // Ícone de deletar.
                                  tooltip:
                                      'Excluir Evento', // Texto que aparece ao segurar o botão.
                                  onPressed:
                                      () => _deleteEvento(
                                        evento['id'],
                                      ), // Chama a função de exclusão.
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      // Botão de ação flutuante para adicionar novos eventos.
      floatingActionButton: FloatingActionButton(
        onPressed:
            () =>
                _showForm(), // Chama o formulário para adicionar um novo evento.
        backgroundColor: const Color(0xFF118E8F), // Cor do botão.
        child: const Icon(Icons.add, color: Colors.white), // Ícone de adição.
      ),
    );
  }
}
