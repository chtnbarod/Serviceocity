import 'package:get/get.dart';

import 'logic.dart';

class VerifyOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyOtpLogic(apiClient: Get.find()));
  }
}
