import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SobreApp extends StatefulWidget {
  const SobreApp({super.key});

  @override
  State<SobreApp> createState() => _SobreAppState();
}

class _SobreAppState extends State<SobreApp>
    with SingleTickerProviderStateMixin {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    // Dispara a animação após a construção
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 1;
      });
    });
  }

  void _abrirGitHub() async {
    const url = 'https://github.com/nacriss/PucMap';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Não foi possível abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem animada
            Center(
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(seconds: 1),
                child: Image.asset(
                  'assets/image/puc_minas.jpg',
                  width: MediaQuery.of(context).size.width * 0.9,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Título 1
            const Text(
              'História do Aplicativo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'O PucMap é uma proposta de aplicação que visa facilitar a locomoção dentro do campus da PUC Coração Eucarístico, auxiliando alunos, professores e visitantes a encontrar a melhor rota até seu destino. Utilizando geolocalização, a aplicação calcula o caminho mais eficiente, garantindo uma navegação intuitiva e acessível para toda a comunidade acadêmica.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),

            const Divider(height: 40, thickness: 1.2),

            // Título 2
            const Text(
              'Equipe do PucMap',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Ana Cristina Martins Silva\n• Gabriel Reis Villela\n• Letícia Azevedo Cota Barbosa',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),

            const Divider(height: 40, thickness: 1.2),

            // Rodapé com link para o GitHub
            Center(
              child: TextButton.icon(
                onPressed: _abrirGitHub,
                icon: const Icon(Icons.link, color: Color(0xFF118E8F)),
                label: const Text(
                  'Acesse o projeto no GitHub',
                  style: TextStyle(color: Color(0xFF118E8F)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
