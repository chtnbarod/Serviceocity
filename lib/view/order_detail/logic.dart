import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';

import '../../core/di/api_client.dart';
import '../../model/OrderDetailModel.dart';

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
}
