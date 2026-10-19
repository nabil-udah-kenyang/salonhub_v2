import 'package:get/get.dart';
import 'package:salonhub_v2/app/models/barber.dart';
import 'package:salonhub_v2/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final selectedNavIndex = 0.obs;

  final nearbyBarbers = const [
    Barber(
      name: 'Alana Barbershop - Haircut massage & Spa',
      description: 'Bangun Sari',
      distance: '5 km',
      rating: '4.5',
      image: 'lib/assets/barbershop_interior_1.jpg',
    ),
    Barber(
      name: 'Hercha Barbershop - Haircut & Styling',
      description: 'Jalan Karya',
      distance: '8 km',
      rating: '5.0',
      image: 'lib/assets/barbershop_haircut_1.jpg',
    ),
    Barber(
      name: 'Barberking - Haircut styling & massage',
      description: 'Medan Kota',
      distance: '12 km',
      rating: '4.5',
      image: 'lib/assets/barbershop_interior_2.jpg',
    ),
  ];

  final recommendedBarbers = const [
    Barber(
      name: 'Masterpiece Barbershop - Haircut styling',
      description: 'Medan Kota',
      distance: '5.0 km',
      rating: '5.0',
      image: 'lib/assets/barbershop_haircut_2.jpg',
    ),
    Barber(
      name: 'Varcity Barbershop Jogja Ex The Varcoty',
      description: 'Medan Selayang',
      distance: '4.5 km',
      rating: '4.5',
      image: 'lib/assets/barbershop_haircut_3.jpg',
    ),
    Barber(
      name: 'Twinsky Monkey Barber & Men Stuff',
      description: 'Medan Baru',
      distance: '5.0 km',
      rating: '5.0',
      image: 'lib/assets/barbershop_exterior_1.jpg',
    ),
    Barber(
      name: 'Barreman - Haircut styling & massage',
      description: 'Medan Timur',
      distance: '4.5 km',
      rating: '4.5',
      image: 'lib/assets/barbershop_interior_1.jpg',
    ),
  ];

  void changeNavigation(int index) {
    selectedNavIndex.value = index;
  }

  void openRecommendedBarbers() {
    Get.toNamed(Routes.EXPLORE_BARBERS, arguments: recommendedBarbers);
  }
}
