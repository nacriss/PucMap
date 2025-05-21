import 'package:flutter/material.dart';

class BarraInferior extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BarraInferior({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: const Color(0xFF118E8F),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      elevation: 8,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.place), label: "Explore"),
        BottomNavigationBarItem(icon: Icon(Icons.apartment), label: "Prédios"),
        BottomNavigationBarItem(icon: Icon(Icons.event), label: "Eventos"),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_outward_rounded),
          label: "Sobre",
        ),
      ],
    );
  }
}
