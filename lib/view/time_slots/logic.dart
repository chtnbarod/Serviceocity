
import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/model/UserModel.dart';
import 'package:serviceocity/utils/toast.dart';
import 'package:serviceocity/view/checkout/logic.dart';

import '../../core/di/api_client.dart';
import '../../model/TimeslotsModel.dart';
import '../cart/logic.dart';
import '../order_detail/binding.dart';
import '../order_detail/view.dart';

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
    categoryId = Get.find<CartLogic>().cartModels.first.categoryId;
    super.onInit();
    getTimeSlot();
  }


  Address? address;
  setAddress({ dynamic json }){
    address = Address.fromJson(json);
    update();
  }


  bool orderInProcess = false;
  orderNow() async{

    if(address == null){
      Toast.show(toastMessage: "Please Select Address",isError: true);
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

    // ThankYou

    orderInProcess = true;
    update();

    dynamic body = Get.find<CheckoutLogic>().getOrderBody(
      addressId: "${address?.id}",
      date: selectedDate!,
      time: selectedTime!
    );

    await apiClient.postAPI(ApiProvider.orderPlace, {"orders" : body}).then((value) => {
      if(value.statusCode == 200){

        Get.to(() => const OrderDetailPage(fromOrder: true,),binding: OrderDetailBinding(),arguments: { "order_id" : value.body['order_ids']  }),
        Toast.show(toastMessage: value.body?['message']??"Order Successfully Place")
      }else if(value.statusCode == 404){
        Toast.show(toastMessage: value.body?['message']??"Try Again",isError: true)
      }
    }).whenComplete(() => {
      orderInProcess = false,
      update()
    });
  }



  List<TimeslotsModel> list = [];
  bool inProcess = false;
  bool slotNotFound = false;
  getTimeSlot() async{
    list.clear();
    selectedTime = null;
    inProcess = true;
    slotNotFound = false;
    update();

    await apiClient.getAPI("${ApiProvider.getTimeslots}?category_id=$categoryId&selected_date=${getDate(day: selectedDate)}").then((value) => {
      if(value.statusCode == 200){
        value.body.forEach((v) {
          selectedDate ??= v['days'][0];
          list.add(TimeslotsModel.fromJson(v));
        }),
      }else if(value.statusCode == 404){
        slotNotFound = true
      }
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

