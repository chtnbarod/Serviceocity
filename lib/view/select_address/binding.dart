import 'package:get/get.dart';

import 'logic.dart';

class SelectAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectAddressLogic());
  }
}
