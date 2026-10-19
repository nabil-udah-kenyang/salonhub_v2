import 'package:get/get.dart';

import '../controllers/splash_scree_controller.dart';

class SplashScreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashScreeController>(SplashScreeController());
  }
}
