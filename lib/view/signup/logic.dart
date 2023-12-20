import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/di/api_client.dart';
import '../../core/di/api_provider.dart';
import '../../utils/toast.dart';
import '../account/logic.dart';

class SignupLogic extends GetxController {
  final ApiClient apiClient;
  SignupLogic({required this.apiClient});

  dynamic argumentData = Get.arguments;

  bool inProcess  = false;

  String? phone;

  @override
  void onInit() {
    phone = argumentData?['phone'];
    super.onInit();
    update();
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController refferController = TextEditingController();

  signUp(){
    if(!isValid()) return;

    inProcess = true;
    update();
    apiClient.postAPI(ApiProvider.register,
        {
          "mobile_number" : phone ,
          "name" : nameController.text ,
          "email" : emailController.text ,
          "refer_code" : refferController.text
        }).then((value) => {
      inProcess = false,
      print("value:: ${value.body}"),
      if(value.statusCode == 200){
        if(value.body['token'] != null){
          Toast.show(toastMessage: value.body['message']),
          Get.find<AccountLogic>().saveLoginData(value.body['token']??"",value.body['user']),
        }else{
          Toast.show(toastMessage: value.body['message'],isError: true),
          update()
        }
      }
    }).whenComplete(() => {
      inProcess = false,
      update()
    });
  }

  isValid(){
    if(phone?.isNotEmpty??false)
      if(nameController.text.isNotEmpty)
        return true;
      else
        Toast.show(toastMessage: "Enter name", isError: true);
    else
      Toast.show(toastMessage: "Number can`t be empty", isError: true);

    return false;
  }

}
