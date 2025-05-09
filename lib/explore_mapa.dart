import 'package:flutter/material.dart';

class ExploreMapa extends StatefulWidget {
  const ExploreMapa({super.key});

  @override
  State<ExploreMapa> createState() => _ExploreMapaState();
}

class _ExploreMapaState extends State<ExploreMapa> {
  final TransformationController _controller = TransformationController();
  final double _initialScale = 5.0; // zoom inicial

  @override
  void initState() {
    super.initState();

    // Espera o layout carregar para aplicar o zoom centralizado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Size size = MediaQuery.of(context).size;

      final double dx = (size.width - (size.width * _initialScale)) / 2;
      final double dy = (size.height - (size.height * _initialScale)) / 2;

      _controller.value =
          Matrix4.identity()
            ..translate(dx, dy)
            ..scale(_initialScale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: _controller,
      panEnabled: true,
      scaleEnabled: true,
      minScale: 1.0,
      maxScale: 10.0,
      child: Center(
        child: Image.asset(
          './assets/image/mapa_coreu.jpg',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
