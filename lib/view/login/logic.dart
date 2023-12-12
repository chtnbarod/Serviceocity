import 'package:firebase_auth/firebase_auth.dart';
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

}
