import 'dart:async';

import 'package:get/get.dart';
import 'package:serviceocity/view/account/logic.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/di/api_provider.dart';
import '../../core/routes.dart';

class SplashLogic extends GetxController {
  final SharedPreferences sharedPreferences;
  SplashLogic({required this.sharedPreferences});

  checkLogin(){
    Timer(const Duration(seconds: 4),isLoggedIn);
  }

  isLoggedIn() async{
    // Get.offNamed(rsLoginPage); return;
    if(sharedPreferences.containsKey(ApiProvider.preferencesToken)){
      Get.find<AccountLogic>().getLoggedInUser();
    }else{
      Get.offNamed(rsLoginPage);
    }
  }
}
