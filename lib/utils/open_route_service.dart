import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'chave_ors.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

Future<List<LatLng>> obterRotaORS(LatLng origem, LatLng destino) async {
  final url = Uri.parse(
    'https://api.openrouteservice.org/v2/directions/foot-walking',
  );
  final headers = {
    'Authorization': openRouteServiceApiKey,
    'Content-Type': 'application/json',
  };

  final body = jsonEncode({
    'coordinates': [
      [origem.longitude, origem.latitude],
      [destino.longitude, destino.latitude],
    ],
    "instructions": false,
    "geometry": true,
  });

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    final geometryEncoded = data['routes']?[0]?['geometry'];
    if (geometryEncoded == null) {
      throw Exception("Resposta sem geometria");
    }

    // Decodifica a polilinha
    PolylinePoints polylinePoints = PolylinePoints();
    final result = polylinePoints.decodePolyline(geometryEncoded);

    // Converte para LatLng
    final rota =
        result.map((point) => LatLng(point.latitude, point.longitude)).toList();

    return rota;
  } else {
    throw Exception('Erro ao obter rota: ${response.body}');
  }
}
