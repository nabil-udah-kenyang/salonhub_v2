import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class RoutingProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://router.project-osrm.org';
    httpClient.timeout = const Duration(seconds: 12);
    httpClient.userAgent = 'SalonHub/1.0';
    super.onInit();
  }

  Future<List<LatLng>> getDrivingRoute({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await get<Map<String, dynamic>>(
      '/route/v1/driving/'
      '${origin.longitude},${origin.latitude};'
      '${destination.longitude},${destination.latitude}',
      query: const {'overview': 'full', 'geometries': 'geojson'},
      headers: const {'Accept': 'application/json'},
    );

    if (!response.isOk || response.body == null) {
      throw Exception('Gagal mengambil rute jalan.');
    }

    final payload = response.body!;
    if (payload['code'] != 'Ok') {
      throw Exception('Rute jalan tidak ditemukan.');
    }

    final routes = payload['routes'] as List<dynamic>?;
    final geometry = routes?.isNotEmpty == true
        ? routes!.first['geometry'] as Map<String, dynamic>?
        : null;
    final coordinates = geometry?['coordinates'] as List<dynamic>?;

    if (coordinates == null || coordinates.isEmpty) {
      throw Exception('Geometry rute kosong.');
    }

    return coordinates.map((coordinate) {
      final point = coordinate as List<dynamic>;
      return LatLng((point[1] as num).toDouble(), (point[0] as num).toDouble());
    }).toList();
  }
}
