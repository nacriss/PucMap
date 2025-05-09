// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class Eventos extends StatelessWidget {
  final String texto;

  //Construtor
  Eventos({super.key, required this.texto}); // com required

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Não há eventos disponiveis no momento!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.red, // Cor vermelha
            fontSize: 20, // Tamanho da fonte
          ),
        ),
      ),
    );
  }
}
