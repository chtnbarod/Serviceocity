import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/model/DiscountModel.dart';

import '../../core/di/api_client.dart';

class OfferLogic extends GetxController {
  final ApiClient apiClient;
  OfferLogic({ required this.apiClient });

  dynamic argumentData = Get.arguments;
  String? categoryId;

  @override
  void onInit() {
    categoryId = argumentData?['category_id'];
    super.onInit();
  }


  bool inProcess = false;
  List<DiscountModel> discounts = [];
  getOffer() async{
    if(inProcess) return;
    discounts.clear();
    inProcess = true;
    await apiClient.postAPI(ApiProvider.getCouponDiscount, {
      'category_id' : categoryId
    }).then((value) => {
      if(value.statusCode == 200){
        value.body['data'].forEach((v) {
          discounts.add(DiscountModel.fromJson(v));
        }),
      }
    }).whenComplete(() => {
      inProcess = false,
      update(),
    });
  }

}
