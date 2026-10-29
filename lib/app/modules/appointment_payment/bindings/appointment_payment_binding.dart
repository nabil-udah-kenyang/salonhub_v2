import 'package:get/get.dart';

import '../controllers/appointment_payment_controller.dart';

class AppointmentPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentPaymentController>(AppointmentPaymentController.new);
  }
}
