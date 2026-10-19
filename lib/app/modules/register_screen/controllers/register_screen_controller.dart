import 'package:get/get.dart';
import 'package:salonhub_v2/app/routes/app_pages.dart';

class RegisterScreenController extends GetxController {
  final isCreatePasswordObscured = true.obs;
  final isConfirmPasswordObscured = true.obs;

  void toggleCreatePasswordVisibility() {
    isCreatePasswordObscured.toggle();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured.toggle();
  }

  void register() {
    Get.toNamed(Routes.OTP_SCREEN);
  }

  void openLogin() {
    Get.toNamed(Routes.LOGIN_SCREEN);
  }
}
