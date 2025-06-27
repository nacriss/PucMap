import 'package:flutter/material.dart';

class BarraSuperior extends StatefulWidget {
  final Function(String) onSearch; // callback para enviar texto da busca

  const BarraSuperior({super.key, required this.onSearch});

  @override
  State<BarraSuperior> createState() => _BarraSuperiorState();
}

class _BarraSuperiorState extends State<BarraSuperior> {
  final TextEditingController _controller = TextEditingController();

  // Método será chamado sempre que o texto mudar
  void _onTextoMudou(String texto) {
    widget.onSearch(texto.trim());
  }

  void _handleSearch() {
    final textoBusca = _controller.text.trim();
    if (textoBusca.isNotEmpty) {
      widget.onSearch(textoBusca);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF118E8F),
      padding: const EdgeInsets.only(top: 40, left: 12, right: 12, bottom: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(51),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            const Icon(Icons.menu, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Buscar...",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: _onTextoMudou,
                onSubmitted: (_) => _handleSearch(),
              ),
            ),
            GestureDetector(
              onTap: _handleSearch,
              child: const Icon(Icons.search, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
