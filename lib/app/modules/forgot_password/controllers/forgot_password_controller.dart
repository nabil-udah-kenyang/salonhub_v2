import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:salonhub_v2/app/routes/app_pages.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void sendCode() {
    Get.toNamed(Routes.OTP_SCREEN);
  }
}
