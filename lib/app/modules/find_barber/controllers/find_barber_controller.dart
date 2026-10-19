import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:salonhub_v2/app/models/barber.dart';
import 'package:salonhub_v2/app/providers/routing_provider.dart';

class FindBarberController extends GetxController {
  FindBarberController({required this.routingProvider});

  final RoutingProvider routingProvider;
  final locationSearchController = TextEditingController();
  final selectedMarker = (-1).obs;
  final isSearching = false.obs;
  final showSuccessToast = false.obs;
  final selectedRecentSearch = 0.obs;
  final locationQuery = ''.obs;
  final routePoints = <LatLng>[].obs;
  final isRouting = false.obs;
  final sheetController = DraggableScrollableController();

  final currentLocation = const LatLng(-7.7508, 110.3794);

  // Data ini sengaja lokal dulu supaya halaman tetap fokus pada tampilan.
  // Nanti bisa diganti dengan hasil pencarian lokasi dari backend.
  final markerPositions = const [
    LatLng(-7.7489, 110.3778),
    LatLng(-7.7448, 110.3819),
    LatLng(-7.7532, 110.3848),
    LatLng(-7.7583, 110.3782),
    LatLng(-7.7502, 110.3705),
  ];

  final nearbyBarbers = const [
    Barber(
      name: 'Masterpiece Barbershop',
      description: 'Jl. Kaliurang',
      distance: '1 km',
      rating: '5.0',
      image: 'lib/assets/barbershop_haircut_2.jpg',
    ),
    Barber(
      name: 'Northside Barber Club',
      description: 'Jl. Kaliurang',
      distance: '1,8 km',
      rating: '4.8',
      image: 'lib/assets/barbershop_exterior_1.jpg',
    ),
    Barber(
      name: 'Gentlemen House',
      description: 'Sleman',
      distance: '2,4 km',
      rating: '4.7',
      image: 'lib/assets/barbershop_haircut_1.jpg',
    ),
  ];

  final recentSearches = const [
    (name: 'Alfamart Jakal', address: 'Jl. Kaliurang Km. 9,5, Ngaglik, Sleman'),
    (
      name: 'Sentrum Space',
      address: 'Jl. Kaliurang Timur No.KM 10, Ngaglik, Sleman',
    ),
    (
      name: 'Kantor Pos Ngaglik',
      address: 'Jl. Kaliurang No.10, Ngaglik, Sleman',
    ),
  ];

  List<({String name, String address})> get filteredRecentSearches {
    final query = locationQuery.value.trim().toLowerCase();

    if (query.isEmpty) {
      return recentSearches;
    }

    return recentSearches.where((location) {
      return location.name.toLowerCase().contains(query) ||
          location.address.toLowerCase().contains(query);
    }).toList();
  }

  void selectMarker(int index) {
    selectedMarker.value = index;
    routePoints.clear();
    _loadRoadRoute(index);
  }

  Future<void> _loadRoadRoute(int index) async {
    if (index < 0 || index >= markerPositions.length) {
      return;
    }

    final destination = markerPositions[index];
    isRouting.value = true;

    try {
      final points = await routingProvider.getDrivingRoute(
        origin: currentLocation,
        destination: destination,
      );

      if (selectedMarker.value != index) {
        return;
      }
      routePoints.assignAll(points);
    } catch (_) {
      // Jika layanan routing sedang tidak tersedia, jangan menggambar
      // garis lurus palsu. Rute akan dicoba lagi saat marker dipilih ulang.
    } finally {
      if (selectedMarker.value == index) {
        isRouting.value = false;
      }
    }
  }

  void openSearch() {
    isSearching.value = true;
    _animateSheet(.58);
  }

  void changeLocationQuery(String value) {
    locationQuery.value = value;
  }

  void closeSearch() {
    isSearching.value = false;
    _animateSheet(.34);
  }

  void selectRecentSearch(int index) {
    selectedRecentSearch.value = index;
  }

  Timer? _toastTimer;

  void showLocationSuccess() {
    _toastTimer?.cancel();
    showSuccessToast.value = true;
    _toastTimer = Timer(const Duration(seconds: 4), hideSuccessToast);
  }

  void hideSuccessToast() {
    _toastTimer?.cancel();
    _toastTimer = null;
    showSuccessToast.value = false;
  }

  void _animateSheet(double size) {
    if (!sheetController.isAttached) {
      return;
    }

    sheetController.animateTo(
      size,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void onClose() {
    _toastTimer?.cancel();
    locationSearchController.dispose();
    sheetController.dispose();
    super.onClose();
  }
}
