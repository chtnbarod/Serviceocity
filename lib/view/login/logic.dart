import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_client.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/utils/toast.dart';

import '../../core/routes.dart';
import '../account/logic.dart';
import 'package:telephony/telephony.dart';

class LoginLogic extends GetxController {
  final ApiClient apiClient;
  LoginLogic({required this.apiClient});

  final TextEditingController numberController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController()..text = '+91';
  bool inProcess  = false;

  sendOTP() async{
     // if(kDebugMode){
     //   goToLogin(); return;
     // }
    if(!isValid()) return;
    inProcess = true;
    update();

    await Telephony.instance.requestPhoneAndSmsPermissions;

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: countryCodeController.text + numberController.text,
      verificationCompleted: (PhoneAuthCredential credential) {
        Toast.show(toastMessage: "verificationCompleted");
        print("verificationCompleted $credential");
      },
      verificationFailed: (FirebaseAuthException e) {
        print("verificationFailed $e");
        inProcess = false;
        Toast.show(title: "OTP sending Failed",toastMessage: "Please retry");
        update();
      },
      timeout: const Duration(seconds: 120),
      codeSent: (String verificationId, int? resendToken) {
        inProcess = false;
        update();
        Get.offNamed(rsVerifyOtpPage, arguments: {
          'phone' : numberController.text,
          'country' : countryCodeController.text,
          'verificationId' : verificationId
        } );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  isValid(){
    if(numberController.text.isNotEmpty)
        return true;
    else
      Toast.show(toastMessage: "Enter number", isError: true);

    return false;
  }

  goToLogin(){
    Get.find<AccountLogic>().saveLoginData("59|6ifbDnbt3p6AAQ2Jr5RxvwBj5jd9XZNX1VOu41x8ec53c81e",
        {
          "id": 21,
          "name": "k0",
          "mobile": "6263563402",
          "email": "info@kp.in",
          "email_verified_at": null,
          "image": "uploads/images/21/1701854125WhatsApp Image 2023-02-08 at 6.49.51 PM.png",
          "country_code": null,
          "address": {
            "id": 68,
            "user_id": "21",
            "address1": "MJQ8+C7H, Indore - Dhar Rd, Near Radhe Electronics, Kushwah Mohalla, Betma, Madhya Pradesh 453001, India",
            "address2": null,
            "name": null,
            "landmark": null,
            "type": "Other",
            "city": "Indore",
            "latitude": "22.688539328691",
            "longitude": "75.615781098604",
            "state": "Madhya Pradesh",
            "country": "India",
            "city_id": "1",
            "zone_id": null,
            "is_active": "1",
            "is_primary": "0",
            "created_at": "2023-12-18T10:09:44.000000Z",
            "updated_at": "2023-12-18T10:09:44.000000Z",
            "deleted_at": null
          },
          "city": null,
          "refer_code": null,
          "otp": null,
          "status": "0",
          "role_id": "5",
          "player_id": "fv5wjjYQThW9a6MmwLatN2:APA91bGeJYj0FkVuM7AT5KbvQD0i5KgIkv3Q7XccFkAbxZPQHxL5ZaWE7OqEhYY6rMz62MVG8OJLqrHUp6ajkOsPufyBi49ApZOZ2P-P1xvu-EsWFXmcK8TgTZBBzNv3yYzHrD-5vibS",
          "created_at": "2023-11-28T07:16:30.000000Z",
          "updated_at": "2023-12-24T06:48:12.000000Z",
          "deleted_at": null,
          "my_refer_code": "MjEtNQ==",
          "primary_address": {
            "id": 56,
            "user_id": "21",
            "address1": "18/2, opposite HP Gas, Girdhar Nagar, North Rajmohalla, Mahesh Nagar, Indore, Madhya Pradesh 452001, India",
            "address2": null,
            "name": null,
            "landmark": null,
            "type": "Home",
            "city": "Indore",
            "latitude": "22.715651896923",
            "longitude": "75.838224405186",
            "state": "Madhya Pradesh",
            "country": "India",
            "city_id": "1",
            "zone_id": null,
            "is_active": "1",
            "is_primary": "1",
            "created_at": "2023-12-14T01:45:25.000000Z",
            "updated_at": "2023-12-14T06:27:21.000000Z",
            "deleted_at": null
          },
          "myaddress": [
            {
              "id": 68,
              "user_id": "21",
              "address1": "MJQ8+C7H, Indore - Dhar Rd, Near Radhe Electronics, Kushwah Mohalla, Betma, Madhya Pradesh 453001, India",
              "address2": null,
              "name": null,
              "landmark": null,
              "type": "Other",
              "city": "Indore",
              "latitude": "22.688539328691",
              "longitude": "75.615781098604",
              "state": "Madhya Pradesh",
              "country": "India",
              "city_id": "1",
              "zone_id": null,
              "is_active": "1",
              "is_primary": "0",
              "created_at": "2023-12-18T10:09:44.000000Z",
              "updated_at": "2023-12-18T10:09:44.000000Z",
              "deleted_at": null
            },
            {
              "id": 62,
              "user_id": "21",
              "address1": "JVVM+MJ Indore, Madhya Pradesh, India",
              "address2": null,
              "name": null,
              "landmark": null,
              "type": "Office",
              "city": "Indore",
              "latitude": "22.644171631198",
              "longitude": "75.884037204087",
              "state": "Madhya Pradesh",
              "country": "India",
              "city_id": "1",
              "zone_id": null,
              "is_active": "1",
              "is_primary": "0",
              "created_at": "2023-12-14T05:11:54.000000Z",
              "updated_at": "2023-12-14T06:27:21.000000Z",
              "deleted_at": null
            },
            {
              "id": 61,
              "user_id": "21",
              "address1": "HWQF+233, Joshi Guradiya, Madhya Pradesh 452020, India",
              "address2": null,
              "name": null,
              "landmark": null,
              "type": "Home",
              "city": "Indore",
              "latitude": "22.587568158445",
              "longitude": "75.922655984759",
              "state": "Madhya Pradesh",
              "country": "India",
              "city_id": "1",
              "zone_id": null,
              "is_active": "1",
              "is_primary": "0",
              "created_at": "2023-12-14T04:55:40.000000Z",
              "updated_at": "2023-12-14T06:27:21.000000Z",
              "deleted_at": null
            },
            {
              "id": 60,
              "user_id": "21",
              "address1": "Opposite St. Mary's Convent School, HQ26+7VW, Dr. Ambedkar Nagar, Madhya Pradesh 453441, India",
              "address2": null,
              "name": null,
              "landmark": null,
              "type": "Home",
              "city": "Indore",
              "latitude": "22.5507459",
              "longitude": "75.7622123",
              "state": "Madhya Pradesh",
              "country": "India",
              "city_id": "1",
              "zone_id": null,
              "is_active": "1",
              "is_primary": "0",
              "created_at": "2023-12-14T04:45:19.000000Z",
              "updated_at": "2023-12-14T06:27:21.000000Z",
              "deleted_at": null
            },
            {
              "id": 59,
              "user_id": "21",
              "address1": "83, Kailash Marg, North Rajmohalla, Malharganj, Indore, Madhya Pradesh 452002, India",
              "address2": null,
              "name": null,
              "landmark": null,
              "type": "Other",
              "city": "Indore",
              "latitude": "22.717452836242",
              "longitude": "75.841399803758",
              "state": "Madhya Pradesh",
              "country": "India",
              "city_id": "1",
              "zone_id": null,
              "is_active": "1",
              "is_primary": "0",
              "created_at": "2023-12-14T02:36:36.000000Z",
              "updated_at": "2023-12-14T06:27:21.000000Z",
              "deleted_at": null
            },
            {
              "id": 57,
              "user_id": "21",
              "address1": "7C76+PR3, Railway Colony, Bhopal, Madhya Pradesh 462001, India",
              "address2": null,
              "name": null,
              "landmark": null,
              "type": "Office",
              "city": "Bhopal",
              "latitude": "23.2642598",
              "longitude": "77.412038",
              "state": "Madhya Pradesh",
              "country": "India",
              "city_id": "55",
              "zone_id": null,
              "is_active": "1",
              "is_primary": "0",
              "created_at": "2023-12-14T01:46:22.000000Z",
              "updated_at": "2023-12-14T06:27:21.000000Z",
              "deleted_at": null
            },
            {
              "id": 56,
              "user_id": "21",
              "address1": "18/2, opposite HP Gas, Girdhar Nagar, North Rajmohalla, Mahesh Nagar, Indore, Madhya Pradesh 452001, India",
              "address2": null,
              "name": null,
              "landmark": null,
              "type": "Home",
              "city": "Indore",
              "latitude": "22.715651896923",
              "longitude": "75.838224405186",
              "state": "Madhya Pradesh",
              "country": "India",
              "city_id": "1",
              "zone_id": null,
              "is_active": "1",
              "is_primary": "1",
              "created_at": "2023-12-14T01:45:25.000000Z",
              "updated_at": "2023-12-14T06:27:21.000000Z",
              "deleted_at": null
            }
          ]
        }
    );
  }

}
