import 'package:get/get.dart';
import 'package:serviceocity/view/map/logic.dart';

class MyMapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyMapLogic());
  }
}
