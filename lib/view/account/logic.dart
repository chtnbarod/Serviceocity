import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_client.dart';
import 'package:serviceocity/model/UserModel.dart';
import 'package:serviceocity/utils/toast.dart';
import 'package:serviceocity/view/home/logic.dart';

import '../../core/di/api_provider.dart';
import '../../core/routes.dart';
import '../../core/di/get_di.dart' as di;
import '../select_address/view.dart';

class AccountLogic extends GetxController implements GetxService{
  final ApiClient apiClient;
  AccountLogic({required this.apiClient});

  UserModel? userModel;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  init(){
    nameController.text = userModel?.name??"";
    emailController.text = userModel?.email??"";
    phoneController.text = userModel?.mobile??"";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      update();
    });
  }

  int? updatingPrimaryIndex;
  changePrimary(bool? isChecked,int index) async{
    if(updatingPrimaryIndex != null) return;
    updatingPrimaryIndex = index;
    update();
    await apiClient.postAPI("${ApiProvider.setPrimaryAddress}/${userModel?.myaddress?[index].id}", {}).then((value) => {
      if(value.statusCode == 200){
        userModel?.primaryAddress = PrimaryAddress.fromJson(value.body['data']),
        Toast.show(toastMessage: value.body['message']),
        Get.find<HomeLogic>().pullRefresh(notify: true),
      }
    }).whenComplete(() => {
      updatingPrimaryIndex = null,
      update(),
    });
  }

  bool updating = false;
  updateUser(File? file) async{
    if(nameController.text.isEmpty){
      Toast.show(toastMessage: "Please add your name",isError: true);
      return;
    }

    updating = true;
    update();

    dynamic body = {};

    if(file != null){
      body = {
        "name" : nameController.text,
        "email" : emailController.text,
        'image': MultipartFile(file, filename: 'user_image.jpg'),
      };
    }else{
      body = {
        "name" : nameController.text,
        "email" : emailController.text,
      };
    }

    FormData formData = FormData(body);

    await apiClient.postAPI(ApiProvider.updateProfile,formData).then((value) => {
      if(value.statusCode == 200){
        Toast.show(toastMessage: value.body['message']),
        userModel = UserModel.fromJson(value.body['data']),
      },
    }).whenComplete(() => {
      updating = false,
      update(),
    });

  }

  int? updatingIndex;
  updateAddress(int index, {dynamic address}) async{
    addingNow = true;
    updatingIndex = index;
    update();
    await apiClient.putAPI("${ApiProvider.updateAddress}/${userModel?.myaddress?[index].id}", address).then((value) => {
      addingNow = false,
      if(value.statusCode == 200){
        Toast.show(toastMessage: value.body['message']),
        userModel?.myaddress?[index] = Myaddress.fromJson(value.body['data'])
      },
    }).whenComplete(() => {
      addingNow = false,
      updatingIndex = null,
      update()
    });
  }

  // replease
 Future<void> replacePrimaryAddress({dynamic address}) async{
   await apiClient.putAPI("${ApiProvider.updateAddress}/${userModel?.primaryAddress?.id}", address).then((value) => {
      addingNow = false,
      if(value.statusCode == 200){
        Toast.show(toastMessage: value.body['message']),
        userModel?.primaryAddress = PrimaryAddress.fromJson(value.body['data'])
      },
    });
  }

  bool addingNow = false;
  Future<void> addAddress({dynamic address, bool useUpdate = true, bool makePrimary = false}) async{
    addingNow = true;
    update();
    await apiClient.postAPI(ApiProvider.addAddress, address).then((value) => {
      addingNow = false,
      if(value.statusCode == 200){
        Toast.show(toastMessage: value.body['message']),
        if(userModel!.myaddress == null){
          userModel!.myaddress = [ Myaddress.fromJson(value.body['data']) ],
        }else{
          userModel!.myaddress!.insert(0, Myaddress.fromJson(value.body['data'])),
        },
        if(makePrimary){
          userModel!.primaryAddress = PrimaryAddress.fromJson(value.body['data']),
        },
      },
    }).whenComplete(() => {
      addingNow = false,
      if(useUpdate){
        update()
      }
    });
  }

  getLoggedInUser() async{
    try{
      apiClient.getAPI(ApiProvider.user).then((value) => {
        if(value.statusCode == 200){
          userModel = UserModel.fromJson(value.body['data']),
          Get.offAllNamed(rsBasePage),
        }
      });
    }catch (e){
      Toast.show(toastMessage: "Try Again");
    }
  }
  

  saveLoginData(String token, dynamic json) async{
    await di.init();
    apiClient.updateHeader(token);
    await apiClient.sharedPreferences.setString(ApiProvider.preferencesToken,token);
    userModel = UserModel.fromJson(json);
    if(GetPlatform.isWeb){
      Get.offAllNamed(rsService,arguments: {
        'category_id' : 1,
        'sub_category_id' : 1,
      });
    }else{
      Get.offAllNamed(rsBasePage);
    }
  }

  // SelectAddress

  Future<void> logout() async{
    await apiClient.sharedPreferences.remove(ApiProvider.preferencesToken);
    //await FirebaseMessaging.instance.deleteToken();
    Get.offAllNamed(rsLoginPage);
  }

  int deleting = -1;
  deleteAddress({ required int index }) async{
    deleting = index;
    update();
    await apiClient.postAPI("${ApiProvider.deleteAddress}/${userModel?.myaddress?[index].id}", {}).then((value) => {
      if(value.statusCode == 200){
        userModel?.myaddress?.removeAt(index),
        Toast.show(toastMessage: value.body['message']??"Deleted")
      }else{
        Toast.show(toastMessage: value.body['error']??"Try Again")
      }
    }).whenComplete(() => {
      deleting = -1,
      update()
    });

  }

}
