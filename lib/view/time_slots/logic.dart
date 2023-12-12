import 'dart:convert';

import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/model/CartModel.dart';
import 'package:serviceocity/model/UserModel.dart';
import 'package:serviceocity/utils/toast.dart';
import 'package:serviceocity/view/checkout/logic.dart';

import '../../core/di/api_client.dart';
import '../../model/TimeslotsModel.dart';

class TimeSlotsLogic extends GetxController {
  final ApiClient apiClient;
  TimeSlotsLogic({ required this.apiClient });

  String? selectedDate;
  String? selectedTime;

  // category_id
  dynamic argumentData = Get.arguments;
  String? categoryId;

  @override
  void onInit() {
    categoryId = argumentData?['category_id'];
    super.onInit();
    getTimeSlot();
  }


  Address? address;
  setAddress({ dynamic json }){
    address = Address.fromJson(json);
    update();
  }

  orderNow(){
    if(address == null){
      Toast.show(title: "Please Select Address",isError: true);
      return;
    }

    if(selectedDate == null){
      Toast.show(toastMessage: "Please Select Date",isError: true);
      return;
    }

    if(selectedTime == null){
      Toast.show(toastMessage: "Please Select Time",isError: true);
      return;
    }

    CartModel? cartModel = Get.find<CheckoutLogic>().cartModel;
    dynamic offer = Get.find<CheckoutLogic>().json;

    dynamic body = {
      "address_id" : address?.id,
      'service_id' : cartModel?.productId,
      'coupon' : offer['code'],
      'tax' : cartModel?.tax,
      'date' : selectedDate,
      'time' : selectedTime
    };

    print("order::: $body");
  }

  List<TimeslotsModel> list = [];
  bool inProcess = false;
  getTimeSlot() async{
    list.clear();
    selectedTime = null;
    inProcess = true;
    update();

    await apiClient.getAPI("${ApiProvider.getTimeslots}?category_id=1&selected_date=${getDate(day: selectedDate)}").then((value) => {
      value.body.forEach((v) {
        selectedDate ??= v['days'][0];
        list.add(TimeslotsModel.fromJson(v));
      }),
    }).whenComplete(() => {
      inProcess = false,
      update(),
    });
    
  }
}
String getDate({ String? day }) {
  DateTime dateTime = DateTime.now();
  String y = dateTime.year.toString();
  String m = dateTime.month.toString().padLeft(2, '0');
  String d = dateTime.day.toString().padLeft(2, '0');
  if(day != null){
     d = day.split(' ')[1];
  }
  return "$y-$m-$d";
}

