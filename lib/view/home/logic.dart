import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/model/BannerModel.dart';
import 'package:serviceocity/model/CategoryModel.dart';
import 'package:serviceocity/model/FeatureModel.dart';
import 'package:serviceocity/utils/toast.dart';
import 'package:serviceocity/view/account/logic.dart';

import '../../core/di/api_client.dart';

import 'package:geocoding/geocoding.dart';

import '../../model/SubCategoryModel.dart';
import '../../utils/assets.dart';

class HomeLogic extends GetxController implements GetxService{
  final ApiClient apiClient;
  HomeLogic({required this.apiClient});


  List<FeatureModel> featureList = [];
  List<CategoryModel> categories = [];
  List<BannerModel> bannerList = [];
  String? topImage;
  String? middleImage;
  String? bottomImage;

  bool isPullProcess = false;
  pullRefresh() async{
    if(isPullProcess) return;
   isPullProcess = true;
   await getCategory();
   await getFeature();
   await getBanner();
  }

  getFeature(){
    featureList.clear();
    apiClient.getAPI("${ApiProvider.getFeature}?city_id=1").then((value) => {
      if(value.statusCode == 200){
        value.body['data'].forEach((v) {
          featureList.add(FeatureModel.fromJson(v));
        }),
      }
    });
  }
  

  bool isEmpty = false;
  getCategory(){
    categories.clear();
    apiClient.getAPI(ApiProvider.getCategories).then((value) => {
      if(value.statusCode == 200){
        print("SDSDDDS ${value.body}"),
        value.body['data'].forEach((v) {
          categories.add(CategoryModel.fromJson(v));
        }),
      },
      if(value.statusCode == 404){
        isEmpty = true,
      }
    });
  }

  getBanner(){
    categories.clear();
    apiClient.getAPI(ApiProvider.allBanners).then((value) => {
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
    }).whenComplete(() => {
      isPullProcess = false,
      update()
    });
  }

  List<SubCategoryModel> subCategories = [];
  int? forFubCategories;
  bool isGetFubCategories = false;
  getSubCategory(int? id){
    subCategories.clear();
    isGetFubCategories = true;
    update();
    apiClient.getAPI("${ApiProvider.getSubCategories}?category_id=$id",).then((value) => {
      if(value.statusCode == 200){
        value.body['data'].forEach((v) {
          subCategories.add(SubCategoryModel.fromJson(v));
        }),
      }
    }).whenComplete(() => {
      isGetFubCategories = false,
      if(subCategories.isEmpty){
        Get.back()
      },
      update(),
    });
  }

  bool setHeight = false;

  emptyAddress(){
    return Get.find<AccountLogic>().userModel?.address?.id == null;
  }

  /// here Map work

  GoogleMapController? _controller;

  void onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  Placemark? place;

  Set<Marker> markers = {};
  MarkerId markerId = const MarkerId("MARKER@1");

  LatLng latLong = const LatLng(22.715651896922722, 75.83822440518583);

  void initMap({ double? lat, double? long }){
    if(lat != null && long != null){
      latLong = LatLng(lat, long);
    }
    markers.add(
      Marker(markerId: markerId,
        position: latLong,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),),);
      WidgetsBinding.instance.addPostFrameCallback((_) {
          update();
      });
  }

  void onCameraMove(LatLng position){

    _moveToLocation(position);

    latLong = position;

    markers.clear();
    markers.add(
      Marker(markerId: markerId,
        position: position,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),),);

    update();
    getAddressLocation();
  }

  // Function to move the camera to a specific location
  Future<void> _moveToLocation(LatLng location) async {
    if (_controller != null) {
      await _controller?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: location,
          zoom: 15.0, // You can set the desired zoom level
        ),
      ));
    }
  }

  bool process = false;
  Future<void> getAddressLocation() async{
    print("STEP::A");
    if(process) return;
    process = true;
    update();
    await placemarkFromCoordinates(latLong.latitude, latLong.longitude).then((value) => {
      place = value[0],
      update(),
      print("STEP::AC ${value[0]}")
    }).catchError((e){
      process = false;
      print("STEP::Ax $e");
    }).whenComplete(() => {
      process = false,
    update(),
      print("STEP::AZ")
    });
  }

  bool addingNow = false;
  String? addingIndex;
  addUserAddress(String index,BuildContext context,{String? landmark,String? name,String? address}) async{
    if(place == null) return;
    addingNow = true;
    addingIndex = index;
    update();

    dynamic body = {
      "address1": "${place!.subLocality??""} ${place!.thoroughfare??""}, ${place!.postalCode ?? ""}".trim(),
      "city": place!.locality,
      "latitude": latLong.latitude,
      "longitude": latLong.longitude,
      "state": place!.administrativeArea,
      "country": place!.country,
      "type": addingIndex?.toLowerCase(),
      "landmark": landmark,
      "name": name,
      "address2": address
    };
   if(Get.find<AccountLogic>().userModel?.myaddress?.isEmpty??true){
    await  Get.find<AccountLogic>().addAddress(address: body,useUpdate: false).then((value) => {
        addingNow = false,
        addingIndex = null,
        Navigator.pop(context),

      });
    }else{
      await  Get.find<AccountLogic>().replacePrimaryAddress(address: body).whenComplete(() => {
        addingNow = false,
        addingIndex = null,
        update(),
        Navigator.pop(context),
      });
    }
  }

  getPlaceData(String? placeId) async{
    var url = "https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$googleAPIKey";
    await Dio().get(url).then((value) => {
      if(value.statusCode == 200 && value.data?['result']?['geometry']?['location'] != null){
        onCameraMove(LatLng(value.data['result']['geometry']['location']['lat'], value.data['result']['geometry']['location']['lng'])),
      }
    });
  }


}
