import 'package:get/get.dart';

import 'logic.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryLogic(apiClient: Get.find()));
  }
}
