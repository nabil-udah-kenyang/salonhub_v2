import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpScreenController extends GetxController {
  final otpControllers = List.generate(4, (_) => TextEditingController());
  final otpFocusNodes = List.generate(4, (_) => FocusNode());

  String get otpCode => otpControllers.map((item) => item.text).join();

  void onOtpChanged(int index) {
    if (otpControllers[index].text.isNotEmpty && index < 3) {
      otpFocusNodes[index + 1].requestFocus();
    }

    if (otpControllers[index].text.isEmpty && index > 0) {
      otpFocusNodes[index - 1].requestFocus();
    }
  }

  void sendCode() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void onClose() {
    for (final item in otpControllers) {
      item.dispose();
    }
    for (final item in otpFocusNodes) {
      item.dispose();
    }
    super.onClose();
  }
}
