import 'package:get/get.dart';

import 'logic.dart';

class OfferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OfferLogic(apiClient: Get.find()));
  }
}
