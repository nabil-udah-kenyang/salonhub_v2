import 'package:get/get.dart';
import 'package:salonhub_v2/app/routes/app_pages.dart';

class LoginScreenController extends GetxController {
  final isPasswordObscured = true.obs;

  void togglePasswordVisibility() {
    isPasswordObscured.toggle();
  }

  void openForgotPassword() {
    Get.toNamed(Routes.FORGOT_PASSWORD);
  }

  void openRegister() {
    Get.toNamed(Routes.REGISTER_SCREEN);
  }

  void login() {
    Get.offNamed(Routes.HOME);
  }
}
