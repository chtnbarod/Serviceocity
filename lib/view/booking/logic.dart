import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/model/OrderModel.dart';

import '../../core/di/api_client.dart';

class BookingLogic extends GetxController {
  final ApiClient apiClient;
  BookingLogic({ required this.apiClient });


  @override
  void onInit() {
    super.onInit();
    getOrder();
  }

  bool inProgress = false;

  List<OrderModel> list = [];
  getOrder() async{
    list.clear();
    inProgress = true;
    update();
    await apiClient.getAPI(ApiProvider.userOrders).then((value) => {
      if(value.statusCode == 200){
        value.body['data']['order_details'].forEach((v) {
          list.add(OrderModel.fromJson(v));
        }),
      }
    });

    inProgress = false;
    update();
  }
}
