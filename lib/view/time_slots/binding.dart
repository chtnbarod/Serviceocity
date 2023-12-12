import 'package:get/get.dart';

import 'logic.dart';

class TimeSlotsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TimeSlotsLogic(apiClient: Get.find()));
  }
}
