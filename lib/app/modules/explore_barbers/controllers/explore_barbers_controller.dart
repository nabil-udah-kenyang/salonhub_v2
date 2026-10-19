import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonhub_v2/app/models/barber.dart';

class ExploreBarbersController extends GetxController {
  ExploreBarbersController({required this.barbers});

  final List<Barber> barbers;
  final searchController = TextEditingController();
  final searchQuery = ''.obs;
  final selectedCategory = 0.obs;

  final categories = const [
    'Semua Layanan',
    'Potong Rambut',
    'Basic Haircut',
    'Coloring',
    'Treatment',
  ];

  final _dummyBarbers = const [
    Barber(
      name: 'Northside Barber Club',
      description: 'Medan Petisah',
      distance: '6.0 km',
      rating: '4.8',
      image: 'lib/assets/barbershop_exterior_1.jpg',
    ),
    Barber(
      name: 'Gentlemen House Barbershop',
      description: 'Medan Polonia',
      distance: '7.5 km',
      rating: '4.7',
      image: 'lib/assets/barbershop_haircut_1.jpg',
    ),
    Barber(
      name: 'The Standard Barber',
      description: 'Medan Tuntungan',
      distance: '9.0 km',
      rating: '4.6',
      image: 'lib/assets/barbershop_interior_2.jpg',
    ),
  ];

  List<Barber> get filteredBarbers {
    final query = searchQuery.value.trim().toLowerCase();
    final allBarbers = [...barbers, ..._dummyBarbers];

    if (query.isEmpty) {
      return allBarbers;
    }

    return allBarbers.where((barber) {
      return barber.name.toLowerCase().contains(query) ||
          barber.description.toLowerCase().contains(query);
    }).toList();
  }

  void changeSearch(String value) {
    searchQuery.value = value;
  }

  void changeCategory(int index) {
    selectedCategory.value = index;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
