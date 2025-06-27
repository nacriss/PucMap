import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../utils/database_helper.dart';
import '../models/predio_model.dart';
import '../utils/open_route_service.dart';
import '../utils/chave_mapbox.dart';

class ExploreMapa extends StatefulWidget {
  const ExploreMapa({super.key});

  @override
  State<ExploreMapa> createState() => ExploreMapaState();
}

class ExploreMapaState extends State<ExploreMapa> {
  //variaveis para recalculo de rota
  final Distance _distance = const Distance();
  bool _recalculando = false;

  final MapController _mapController = MapController();
  LatLng? _destino;
  LatLng? _localizacaoAtual;
  List<LatLng> _rota = [];
  StreamSubscription<Position>? _posicaoStream;

  @override
  void initState() {
    super.initState();
    iniciarStreamLocalizacao();
  }

  void iniciarStreamLocalizacao() async {
    bool servicoAtivo = await Geolocator.isLocationServiceEnabled();
    LocationPermission permissao = await Geolocator.checkPermission();

    if (permissao == LocationPermission.denied ||
        permissao == LocationPermission.deniedForever) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied ||
          permissao == LocationPermission.deniedForever) {
        return;
      }
    }

    final limiteArea = LatLngBounds(
      LatLng(-19.928408, -43.998667),
      LatLng(-19.915302, -43.986138),
    );

    if (servicoAtivo &&
        (permissao == LocationPermission.always ||
            permissao == LocationPermission.whileInUse)) {
      _posicaoStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 5,
        ),
      ).listen((Position pos) async {
        final novaLocalizacao = LatLng(pos.latitude, pos.longitude);
        setState(() {
          _localizacaoAtual = novaLocalizacao;
        });

        // Verifica se está dentro dos limites permitidos
        if (!limiteArea.contains(novaLocalizacao)) {
          if (mounted && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Você está fora do campus. Mapa limitado à área do campus.',
                ),
                duration: Duration(seconds: 4),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Color(0xFF118E8F),
              ),
            );
          }
          return; // Não move a câmera
        }

        // Atualiza a posição da câmera apenas se estiver dentro do campus
        _mapController.move(novaLocalizacao, 17.0);

        // Resto da lógica de recalculo de rota
        if (_rota.isNotEmpty && !_recalculando && _destino != null) {
          final estaNaRota = _rota.any(
            (ponto) => _distance(novaLocalizacao, ponto) <= 5,
          );

          if (!estaNaRota) {
            _recalculando = true;

            if (mounted && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Recalculando rota...'),
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Color(0xFF118E8F),
                ),
              );
            }

            try {
              final novaRota = await obterRotaORS(novaLocalizacao, _destino!);
              if (!mounted) return;

              setState(() {
                _rota = novaRota;
              });

              _mapController.move(novaLocalizacao, 17.0);
            } catch (e) {
              debugPrint("Erro ao recalcular rota: $e");
            } finally {
              Future.delayed(const Duration(seconds: 10), () {
                _recalculando = false;
              });
            }
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _posicaoStream?.cancel();
    super.dispose();
  }

  void mostrarMensagemPredioNaoEncontrado(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.teal[50],
            title: Row(
              children: [
                const Icon(Icons.error_outline, color: Color(0xFF118E8F)),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Prédio não encontrado',
                    style: TextStyle(
                      color: Color(0xFF118E8F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            content: const Text(
              'O prédio que você digitou não existe. Por favor, tente novamente.',
              style: TextStyle(color: Colors.black87),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF118E8F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  Future<void> buscarPredio(String termo) async {
    final predios = await DatabaseHelper.instance.getPredios();
    final predioEncontrado = predios.firstWhere(
      (p) =>
          p.nome.toLowerCase().contains(termo.toLowerCase()) ||
          p.nome.contains("Prédio $termo") ||
          p.nome.contains("Prédio 0$termo"),
      orElse:
          () => Predio(
            nome: '',
            descricao: '',
            imagens: [],
            latitude: 0.0,
            longitude: 0.0,
          ),
    );

    if (predioEncontrado.latitude == 0.0 && predioEncontrado.longitude == 0.0) {
      if (!mounted) return;
      mostrarMensagemPredioNaoEncontrado(context);
      return;
    }

    final origem = _localizacaoAtual;
    if (origem == null) return;

    final destino = LatLng(
      predioEncontrado.latitude,
      predioEncontrado.longitude,
    );

    try {
      final rotaCalculada = await obterRotaORS(origem, destino);

      if (!mounted) return;
      setState(() {
        _destino = destino;
        _rota = rotaCalculada;
      });

      _mapController.move(destino, 17.0);
    } catch (e) {
      debugPrint('Erro ao obter rota: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final limiteArea = LatLngBounds(
      LatLng(-19.928408, -43.998667),
      LatLng(-19.915302, -43.986138),
    );

    // Se ainda não temos a localização, mostra indicador de carregamento
    if (_localizacaoAtual == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _localizacaoAtual!,
        initialZoom: 18.0,
        maxZoom: 20,
        cameraConstraint: CameraConstraint.contain(bounds: limiteArea),
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://api.mapbox.com/styles/v1/mapbox/satellite-streets-v12/tiles/512/{z}/{x}/{y}?access_token=$mapboxToken',
          additionalOptions: {'accessToken': mapboxToken},
          maxZoom: 20,
          userAgentPackageName: 'com.example.pucmap',
          tileProvider: NetworkTileProvider(),
        ),
        if (_rota.isNotEmpty)
          PolylineLayer(
            polylines: [
              Polyline(
                points: _rota,
                color: const Color(0xFF118E8F),
                strokeWidth: 4.0,
              ),
            ],
          ),
        if (_destino != null)
          MarkerLayer(
            markers: [
              Marker(
                point: _destino!,
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_on,
                  color: Color(0xFF118E8F),
                  size: 40,
                ),
              ),
            ],
          ),
        MarkerLayer(
          markers: [
            Marker(
              point: _localizacaoAtual!,
              width: 25,
              height: 25,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF118E8F),
                  border: Border.all(color: Colors.white, width: 3),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
