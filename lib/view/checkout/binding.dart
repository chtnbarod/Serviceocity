import 'package:get/get.dart';

import 'logic.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheckoutLogic(apiClient: Get.find()));
  }
}
