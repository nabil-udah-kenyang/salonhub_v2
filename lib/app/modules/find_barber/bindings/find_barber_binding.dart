import 'package:get/get.dart';

import '../../../providers/routing_provider.dart';
import '../controllers/find_barber_controller.dart';

class FindBarberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoutingProvider>(RoutingProvider.new);
    Get.lazyPut<FindBarberController>(
      () => FindBarberController(routingProvider: Get.find()),
    );
  }
}
