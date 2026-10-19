import 'package:get/get.dart';

import '../controllers/explore_barbers_controller.dart';

class ExploreBarbersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExploreBarbersController>(() {
      return ExploreBarbersController(barbers: Get.arguments ?? const []);
    });
  }
}
