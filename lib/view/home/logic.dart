
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/model/BannerModel.dart';
import 'package:serviceocity/model/FeatureModel.dart';
import 'package:serviceocity/view/account/logic.dart';
import 'package:serviceocity/view/category/logic.dart';
import 'package:serviceocity/view/map/AddressListModel.dart';
import '../../core/di/api_client.dart';
import '../../model/RecentOrderModel.dart';
import '../../model/SettingModel.dart';

class HomeLogic extends GetxController implements GetxService{
  final ApiClient apiClient;
  HomeLogic({required this.apiClient});

  SettingModel? settingModel;

  List<FeatureModel> featureList = [];

  List<BannerModel> bannerList = [];
  String? topImage;
  String? middleImage;
  String? bottomImage;
  bool isEmptyCategory = false;
  setEmptyCategory(bool isEmpty){
    isEmptyCategory = isEmpty;
  }

  getSetting() async{
    if(settingModel != null) return;
    await apiClient
        .getAPI(ApiProvider.globalSetting).then((value) => {
          if(value.statusCode == 200){
           settingModel = SettingModel.fromJson(value.body['data']),
          }
    });
  }

  bool isPullProcess = false;
  pullRefresh({bool notify = false }) async{
    if(isPullProcess) return;
    addressUpdating = false;
    isPullProcess = true;
    if(notify){
      update();
    }

    await Get.find<CategoryLogic>().getCategory(notify: false);
    await getBanner();
    await getFeature();
    await getRecentOrder();
    await getSetting();
    isPullProcess = false;
    update();
  }

  getFeature() async{
    featureList.clear();
    await apiClient.getAPI(ApiProvider.getFeature).then((value) => {
      if(value.statusCode == 200){
        value.body['data'].forEach((v) {
          featureList.add(FeatureModel.fromJson(v));
        }),
      }
    });
  }

  List<RecentOrderModel> recentOrderModel = [];
  getRecentOrder() async{
    recentOrderModel.clear();
    await apiClient.getAPI(ApiProvider.getRecentOrders).then((value) => {
      if(value.statusCode == 200){
        value.body['recent_orders'].forEach((v) {
          recentOrderModel.add(RecentOrderModel.fromJson(v));
        }),
      }
    });
  }

  getBanner() async{
    topImage = null;
    middleImage = null;
    bottomImage = null;
    await apiClient.getAPI(ApiProvider.allBanners).then((value) => {
      if(value.statusCode == 200){
        value.body['data'].forEach((v) {
          if(v['order'].toString() == '1'){
            topImage = v['image'];
          }
          if(v['order'].toString() == '2'){
            middleImage = v['image'];
          }
          if(v['order'].toString() == '3'){
            bottomImage = v['image'];
          }
          bannerList.add(BannerModel.fromJson(v));
        }),
      }
    });
  }

  /// here Map work
 bool addressUpdating = false;
  updateUserAddress(BuildContext context,{AddressListModel? addressListModel}) async{
    addressUpdating = true;
    update();
    if(Get.find<AccountLogic>().userModel?.myaddress?.isEmpty??true){
      Navigator.of(context).pop();
      await  Get.find<AccountLogic>().addAddress(address: addressListModel?.toJson(),useUpdate: false,makePrimary: true).whenComplete(() => pullRefresh(notify: true));
    }else{
      await  Get.find<AccountLogic>().replacePrimaryAddress(address: addressListModel?.toJson()).whenComplete(() => pullRefresh(notify: true)
      );
    }
  }
}
