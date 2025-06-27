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
  final GlobalKey<ExploreMapaState> _exploreKey = GlobalKey<ExploreMapaState>();

  void _onBuscar(String texto) {
    if (_indiceAtual == 0 && _exploreKey.currentState != null) {
      _exploreKey.currentState!.buscarPredio(texto);
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final telas = [
      ExploreMapa(key: _exploreKey),
      PrediosPage(),
      const Eventos(),
      const SobreApp(),
    ];

    final titulos = ['', 'Prédios', 'Eventos', 'Sobre'];

    return BaseLayout(
      body: telas[_indiceAtual],
      currentIndex: _indiceAtual,
      onTabTapped: _onTabTapped,
      mostrarBusca: _indiceAtual == 0,
      titulo: titulos[_indiceAtual],
      onBuscar: _onBuscar,
    );
  }
}
