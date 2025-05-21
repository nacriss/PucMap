import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final Function(int) onTabTapped;
  final bool mostrarBusca; // true para barra de busca
  final String?
  titulo; // título para AppBar simples (se mostrarBusca for false)

  const BaseLayout({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.onTabTapped,
    this.mostrarBusca = false,
    this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          mostrarBusca
              ? PreferredSize(
                preferredSize: const Size.fromHeight(100),
                child: Container(
                  color: const Color(0xFF118E8F),
                  padding: const EdgeInsets.only(
                    top: 40,
                    left: 12,
                    right: 12,
                    bottom: 12,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.menu, color: Colors.white),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Buscar...",
                              hintStyle: TextStyle(color: Colors.white70),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(Icons.search, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              )
              : AppBar(
                backgroundColor: const Color(0xFF118E8F),
                elevation: 0,
                title: Text(titulo ?? ""),
                foregroundColor: Colors.white,
              ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabTapped,
        backgroundColor: const Color(0xFF118E8F),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.place), label: "Explore"),
          BottomNavigationBarItem(
            icon: Icon(Icons.apartment),
            label: "Prédios",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Eventos"),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_outward_rounded),
            label: "Sobre",
          ),
        ],
      ),
    );
  }
}
