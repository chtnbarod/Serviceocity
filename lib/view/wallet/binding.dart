import 'package:get/get.dart';

import 'logic.dart';

class WalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletLogic());
  }
}
