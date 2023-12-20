import 'package:get/get.dart';
import 'package:serviceocity/view/account/logic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../view/cart/logic.dart';
import '../../view/category/logic.dart';
import '../../view/home/logic.dart';
import '../../view/verify_otp/logic.dart';
import 'api_client.dart';
import 'api_provider.dart';

Future<void> init() async {

  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put(sharedPreferences, permanent: true);
  Get.put(ApiClient(sharedPreferences: Get.find(),apkBaseUrl: ApiProvider.baseUrl), permanent: true);

  // Repository

  // Controller

  // Service
  Get.lazyPut(() => AccountLogic(apiClient: Get.find()));
  Get.lazyPut(() => HomeLogic(apiClient: Get.find()));
  Get.lazyPut(() => CategoryLogic(apiClient: Get.find()));
  Get.lazyPut(() => CartLogic(apiClient: Get.find()));
  Get.lazyPut(() => VerifyOtpLogic(apiClient: Get.find()));

}