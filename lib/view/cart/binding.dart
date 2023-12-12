import 'package:get/get.dart';

import 'logic.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartLogic(apiClient: Get.find()));
  }
}
