import 'package:get/get.dart';

import 'logic.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupLogic(apiClient: Get.find()));


  }
}
