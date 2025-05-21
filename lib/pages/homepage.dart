import 'package:flutter/material.dart';
import '../pages/predios.dart';
import '../pages/eventos.dart';
import '../pages/sobre.dart';
import '../widgets/barras_layout.dart';
import '../pages/explore_mapa.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indiceAtual = 0;

  final List<Widget> _telas = [
    const ExploreMapa(),
    PrediosPage(),
    const Eventos(),
    const SobreApp(),
  ];

  final List<String> _titulos = [
    '', // Página inicial (com busca)
    'Prédios',
    'Eventos',
    'Sobre',
  ];

  void _onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      body: _telas[_indiceAtual],
      currentIndex: _indiceAtual,
      onTabTapped: _onTabTapped,
      mostrarBusca: _indiceAtual == 0,
      titulo: _titulos[_indiceAtual],
    );
  }
}
