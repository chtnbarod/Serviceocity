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

  /// SessionController
  isLoggedIn() async{
    if(GetPlatform.isWeb){
      login();
      return;
    }

    if(sharedPreferences.containsKey(ApiProvider.preferencesToken)){
      Get.find<AccountLogic>().getLoggedInUser();
    }else{
      Get.offNamed(rsLoginPage);
    }
  }

  // for web only
  login(){
    Get.find<AccountLogic>().saveLoginData(
        "59|6ifbDnbt3p6AAQ2Jr5RxvwBj5jd9XZNX1VOu41x8ec53c81e",
        {
          "id": 21,
          "name": "chetan",
          "mobile": "6263563402",
          "email": "6263563402",
          "email_verified_at": null,
          "image": null,
          "country_code": null,
          "address": {
            "id": 1,
            "user_id": "21",
            "address1": "Mahesh Nagar , 452001",
            "address2": null,
            "name": "",
            "landmark": "",
            "type": "",
            "city": "Indore",
            "latitude": "22.715651896923",
            "longitude": "75.838224405186",
            "state": "Madhya Pradesh",
            "country": "India",
            "city_id": "1",
            "zone_id": null,
            "is_active": "1",
            "is_primary": "1",
            "created_at": "2023-11-29T06:02:29.000000Z",
            "updated_at": "2023-12-03T18:58:02.000000Z",
            "deleted_at": null
          },
          "city": null,
          "refer_code": null,
          "otp": null,
          "status": "0",
          "role_id": "5",
          "created_at": "2023-11-28T12:46:30.000000Z",
          "updated_at": "2023-11-28T12:46:30.000000Z",
          "deleted_at": null,
          "my_refer_code": "MjEtNQ==",
          "primary_address": {
            "id": 1,
            "user_id": "21",
            "address1": "Mahesh Nagar , 452001",
            "address2": null,
            "name": "",
            "landmark": "",
            "type": "",
            "city": "Indore",
            "latitude": "22.715651896923",
            "longitude": "75.838224405186",
            "state": "Madhya Pradesh",
            "country": "India",
            "city_id": "1",
            "zone_id": null,
            "is_active": "1",
            "is_primary": "1",
            "created_at": "2023-11-29T06:02:29.000000Z",
            "updated_at": "2023-12-03T18:58:02.000000Z",
            "deleted_at": null
          },
          "myaddress": [
            {
              "id": 1,
              "user_id": "21",
              "address1": "Mahesh Nagar , 452001",
              "address2": null,
              "name": "",
              "landmark": "",
              "type": "",
              "city": "Indore",
              "latitude": "22.715651896923",
              "longitude": "75.838224405186",
              "state": "Madhya Pradesh",
              "country": "India",
              "city_id": "1",
              "zone_id": null,
              "is_active": "1",
              "is_primary": "1",
              "created_at": "2023-11-29T06:02:29.000000Z",
              "updated_at": "2023-12-03T18:58:02.000000Z",
              "deleted_at": null
            }
          ]
        }
    );
  }

}
