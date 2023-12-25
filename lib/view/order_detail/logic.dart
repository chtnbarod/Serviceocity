import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/utils/toast.dart';
import 'package:serviceocity/view/booking/logic.dart';

import '../../core/di/api_client.dart';
import '../../model/OrderDetailModel.dart';
import '../time_slots/logic.dart';

class OrderDetailLogic extends GetxController {
  final ApiClient apiClient;
  OrderDetailLogic({required this.apiClient});

  dynamic argumentData = Get.arguments;
  String? orderId;

  @override
  void onInit() {
    orderId = argumentData?['order_id'];
    super.onInit();
    getOrderDetail();
  }

  List<OrderDetailModel> orders = [];
  bool inProcess = false;
  getOrderDetail() async{
    inProcess = true;
    orders.clear();
    update();
    await apiClient.postAPI(ApiProvider.orderDetails,{ "order_id" : orderId }).then((value) => {
      if(value.statusCode == 200){
        value.body['data']['place_orders'].forEach((v) {
          orders.add(OrderDetailModel.fromJson(v));
        }),
      }
    }).whenComplete(() => {
      inProcess = false,
      update()
    });
  }

  Future<void> reschedule(String date,time) async{
    await apiClient.postAPI(ApiProvider.reschedule, {
      "new_delivery_date" : date,
      "new_delivery_time" : time,
      "order_id" : orderId,
    }).then((value) => {
      if(value.statusCode == 200){
        getOrderDetail()
      }else if (value.statusCode == 422){
        Toast.show(toastMessage: value.body['message']??"Internal server error",isError: true)
      }
    });
  }

  bool isCancelBooking = false;
  cancelBooking(String reason) async{
    if(isCancelBooking) return;
    isCancelBooking = true;
    update();
    await apiClient.postAPI(ApiProvider.cancelBooking, {
      "order_id" : orderId
    }).then((value) => {
      if(value.statusCode == 200){
        getOrderDetail(),
      }else if(value.statusCode == 422){
        Toast.show(toastMessage: value.body['error']??value.body['message']??"try again",isError: true)
      }
    }).whenComplete(() => {
      isCancelBooking = false,
      update(),
      Get.find<BookingLogic>().getOrder()
    });
  }
}
