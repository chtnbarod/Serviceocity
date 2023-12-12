import 'package:get/get.dart';

import 'logic.dart';

class ServiceDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ServiceDetailLogic(apiClient: Get.find()));
  }
}
