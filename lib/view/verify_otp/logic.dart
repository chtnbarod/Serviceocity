import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_client.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/core/routes.dart';
import 'package:serviceocity/utils/date_converter.dart';
import 'package:serviceocity/utils/toast.dart';
import 'package:serviceocity/view/account/logic.dart';
import 'package:serviceocity/view/verify_otp/otp_view.dart';
import 'package:telephony/telephony.dart';

import '../../main.dart';

class VerifyOtpLogic extends GetxController implements GetxService{
  final ApiClient apiClient;
  VerifyOtpLogic({required this.apiClient});

  dynamic argumentData = Get.arguments;

  String? phone;
  String? country;
  String? verificationId;

  bool inProcess  = false;


  @override
  void onInit() {
    phone = argumentData?['phone'];
    country = argumentData?['country'];
    verificationId = argumentData?['verificationId'];
    time.value = 120;
    super.onInit();
    update();
    startTimer();
  }


  GlobalKey<OtpViewState> otpKey = GlobalKey<OtpViewState>();
  List<int> otpString = [ -1 , -1 , -1 , -1 , -1 , -1];
  var time = 0.obs;

 String getTime(){
    return "${time.value}".toSecToMS();
  }

  Timer? _timer;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec,
          (Timer timer) {
        if (time.value == 0) {
          timer.cancel();
        } else {
          time.value--;
        }
      },
    );
  }

  Future<void> initPlatformState() async {
    final telephony = Telephony.instance;
    bool? result = await telephony.requestPhoneAndSmsPermissions;
    if (result != null && result) {

      telephony.listenIncomingSms(
        onNewMessage: onMessage,
        listenInBackground: false
      );
    }
  }
  onMessage(SmsMessage message) async {
    String sms = message.body.toString();
   if (message.body!.contains('serviceocitynewpro.firebaseapp.com')) {
    String otpCode = sms.replaceAll(RegExp(r'[^0-9]'), '');
    otpKey.currentState?.setOTP(otpCode.split(""));
   }

  }

  verifyOtp() async{
    if(!validateLoginData()) return;

    inProcess = true;
    update();

    FirebaseAuth auth = FirebaseAuth.instance;

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId??"", smsCode: getOtp());

    // Sign the user in (or link) with the credential
    await auth.signInWithCredential(credential).then((value) => {
      if(value.user != null){
        login()
      }else{
         Toast.show(toastMessage: "Try Again",isError: true)
      },
    }).whenComplete(() => {
      inProcess = false,
      update()
    });

  }

  login(){
    apiClient.postAPI(ApiProvider.login,
        {  "mobile_number" : phone , "token" : "s6d54fdf654"}).then((value) => {
      if(value.statusCode == 200){
        if(value.body['token'] != null){
          Toast.show(toastMessage: value.body['message']),
          Get.find<AccountLogic>().saveLoginData(value.body['token'],value.body['user']),
        }else{
          Toast.show(toastMessage: value.body['message'],isError: true),
          inProcess = false,
          update()
        }
      }else if(value.statusCode == 404){
        Get.offNamed(rsSignupPage, arguments: {
          'phone' : phone,
        }),
      }
    }).whenComplete(() => {
      inProcess = false,
      update()
    });
  }

  bool resentOtpProgress = false;
  reSendOTP() async{
    resentOtpProgress = true;
    update();
    otpString = [ -1 , -1 , -1 , -1 , -1 , -1];
    otpKey.currentState?.refreshData();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "$country$phone",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        resentOtpProgress = false;
        Toast.show(title: "OTP sending Failed",toastMessage: "Please retry");
        update();
      },
      timeout: const Duration(seconds: 120),
      codeSent: (String verificationId, int? resendToken) {
        resentOtpProgress = false;
        time.value = 120;
        this.verificationId = verificationId;
        Toast.show(title: "OTP resent Successfully",toastMessage: "Please check your phone");
        startTimer();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        resentOtpProgress = false;
        Toast.show(title: "Time out",toastMessage: "Please retry");
        update();
      },
    );
  }

  String getOtp(){
    String otp = "";
    for(int h =  0 ; h < otpString.length ; h ++ ){
      if(otpString[h] != -1){
        otp = otp + otpString[h].toString();
      }
    }
    return otp;
  }

  validateLoginData(){
    if(!otpString.contains(-1)) {
      return true;
    } else {
      Toast.show(toastMessage: "Please Enter Valid OTP",isError: true);
      return false;
    }
  }


}
