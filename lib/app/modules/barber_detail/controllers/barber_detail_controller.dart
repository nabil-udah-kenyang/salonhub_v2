import 'package:flutter/material.dart' show Color;
import 'package:get/get.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class ServiceBooking {
  const ServiceBooking({
    required this.time,
    required this.name,
    required this.service,
    required this.image,
    required this.color,
  });

  final String time;
  final String name;
  final String service;
  final String image;
  final Color color;
}

typedef BarberReview = ({
  String name,
  double rating,
  String comment,
  String image,
});

class BarberDetailController extends GetxController {
  final selectedTab = 0.obs;

  final shopName = 'Masterpiece Barbershop - Haircut styling';
  final shopImage = 'lib/assets/barbershop_haircut_2.jpg';
  final location = 'Joga Expo Centre (2 km)';
  final rating = '5.0  (24)';
  final description =
      'Di Masterpiece Barbershop, tim ahli cukur kami yang berpengalaman siap memberikan hasil terbaik dan mengubah penampilan rambutmu.';

  final openingHours = const [
    (day: 'Senin - Jumat', hours: '09.00 - 20.00'),
    (day: 'Sabtu - Minggu', hours: '09.00 - 21.00'),
  ];

  final services = const [
    (
      name: 'Basic haircut',
      description: 'Basic haircut & vitamint',
      price: 'Rp20.000',
      image: 'lib/assets/barbershop_haircut_3.jpg',
    ),
    (
      name: 'Kids haircut',
      description: 'Specialist kids haircut',
      price: 'Rp15.000',
      image: 'lib/assets/barbershop_exterior_1.jpg',
    ),
    (
      name: 'Hair coloring',
      description: 'Hair color treatment',
      price: 'Rp30.000',
      image: 'lib/assets/barbershop_haircut_1.jpg',
    ),
    (
      name: 'Hair treatment',
      description: 'Special full treatment',
      price: 'Rp10.000',
      image: 'lib/assets/barbershop_interior_2.jpg',
    ),
    (
      name: 'Special massage',
      description: 'Additional massage',
      price: 'Rp10.000',
      image: 'lib/assets/barbershop_interior_1.jpg',
    ),
  ];

  final scheduleDate = '28 Agu 2023';
  final scheduleTimes = const [
    '08.00',
    '08.30',
    '09.00',
    '09.30',
    '10.00',
    '10.30',
  ];

  final scheduleBookings = const [
    ServiceBooking(
      time: '08.30',
      name: 'Alam Carl',
      service: 'Basic haircut',
      image: 'lib/assets/barbershop_haircut_3.jpg',
      color: AppColors.secondary900,
    ),
    ServiceBooking(
      time: '09.00',
      name: 'Sergio Wirl',
      service: 'Hair coloring',
      image: 'lib/assets/barbershop_haircut_1.jpg',
      color: AppColors.primary600,
    ),
    ServiceBooking(
      time: '10.00',
      name: 'Sergio Wirl',
      service: 'Basic haircut',
      image: 'lib/assets/barbershop_interior_1.jpg',
      color: AppColors.primary600,
    ),
  ];

  final reviews = const <BarberReview>[
    (
      name: 'Alan Cartwright',
      rating: 4.0,
      comment: 'Good service, recommendation for barber shop seekers',
      image: 'lib/assets/barbershop_haircut_3.jpg',
    ),
    (
      name: 'Robert Gleichner',
      rating: 5.0,
      comment: 'Place is not too far and the shaving results are good',
      image: 'lib/assets/barbershop_haircut_1.jpg',
    ),
    (
      name: 'Sergio Wilderman',
      rating: 4.0,
      comment:
          'Price is quite affordable and the service is good, I am very satisfied',
      image: 'lib/assets/barbershop_interior_2.jpg',
    ),
    (
      name: 'Miss Erik VonRueden',
      rating: 5.0,
      comment:
          'Style of barbering here really follows the times, like the service',
      image: 'lib/assets/barbershop_interior_1.jpg',
    ),
  ];

  final teamMembers = const [
    (
      name: 'Luther Hammes',
      role: 'Specialist Haircut',
      rating: '5.0',
      image: 'lib/assets/barbershop_haircut_3.jpg',
    ),
    (
      name: 'Emanuel Bernier',
      role: 'Specialist Coloring',
      rating: '4.5',
      image: 'lib/assets/barbershop_haircut_1.jpg',
    ),
    (
      name: 'Karl Vandervort',
      role: 'Specialist Treatment',
      rating: '4.5',
      image: 'lib/assets/barbershop_interior_1.jpg',
    ),
  ];

  void selectTab(int index) {
    selectedTab.value = index;
  }

  void bookNow() {}
}
