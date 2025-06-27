import 'package:geolocator/geolocator.dart';

Future<Position> obterLocalizacaoAtual() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Permissão de localização negada');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception('Permissão de localização permanentemente negada');
  }

  return await Geolocator.getCurrentPosition();
}
