class Predio {
  final int? id;
  final String nome;
  final String descricao;
  final List<String> imagens;

  Predio({
    this.id,
    required this.nome,
    required this.descricao,
    required this.imagens,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'imagens': imagens.join(
        ',',
      ), // armazenar como string separada por vírgula
    };
  }

  factory Predio.fromMap(Map<String, dynamic> map) {
    return Predio(
      id: map['id'],
      nome: map['nome'],
      descricao: map['descricao'],
      imagens: map['imagens'].split(','),
    );
  }
  // Gera caminhos para imagens locais com base no ID do prédio e quantidade
  List<String> gerarImagensLocais(int quantidade) {
    if (id == null) return [];
    return List.generate(
      quantidade,
      (index) => 'assets/image/predios/$id/imagem${index + 1}.jpg',
    );
  }
}
