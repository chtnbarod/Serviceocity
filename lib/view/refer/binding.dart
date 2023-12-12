import 'package:get/get.dart';

import 'logic.dart';

class ReferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReferLogic());
  }
}
