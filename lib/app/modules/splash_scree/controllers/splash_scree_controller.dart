import 'dart:async';

import 'package:get/get.dart';
import 'package:salonhub_v2/app/routes/app_pages.dart';

class SplashScreeController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onInit
    super.onReady();

    Timer(const Duration(seconds: 1), () {
      Get.offNamed(Routes.INTRO_SCREEN);
    });
  }
}
