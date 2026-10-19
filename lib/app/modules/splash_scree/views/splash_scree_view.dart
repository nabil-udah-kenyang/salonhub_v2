import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

import '../controllers/splash_scree_controller.dart';

class SplashScreeView extends GetView<SplashScreeController> {
  const SplashScreeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary900,
      body: Center(
        child: Image.asset(
          'lib/assets/logo.png',
          width: 180,
          height: 180,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
