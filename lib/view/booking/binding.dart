import 'package:get/get.dart';

import 'logic.dart';

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookingLogic(apiClient: Get.find()));
  }
}
