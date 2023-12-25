import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/model/DiscountModel.dart';
import 'package:serviceocity/utils/price_converter.dart';
import 'package:serviceocity/utils/toast.dart';
import 'package:serviceocity/view/cart/logic.dart';
import 'package:serviceocity/view/checkout/logic.dart';

import '../../core/di/api_client.dart';

class OfferLogic extends GetxController {
  final ApiClient apiClient;
  OfferLogic({ required this.apiClient });

  dynamic argumentData = Get.arguments;
  String? categoryId;

  @override
  void onInit() {
    categoryId = Get.find<CartLogic>().cartModels.first.categoryId;
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

 dynamic json;
 bool isSearch = false;
 Future<void> applyCouponCode(String? text) async{
   if(isSearch || (text?.length??0) < 3) return;
    isSearch = true;
    json = null;
    update();
    Response response = await apiClient.postAPI(ApiProvider.applyCoupon,{
      'coupon_identifier' : text//"ZD8A7X"//text
    });

    if(response.statusCode == 200){
      json = {
        "id" : response.body?['discount']?['id'],
        "amount" : response.body?['discount']?['amount'],
        "percent" : response.body?['discount']?['percent'],
        "type" : response.body?['discount']?['type'],
        "code" : response.body?['discount']?['code']
      };
    }else if(response.statusCode == 422){
      Toast.show(toastMessage: response.body?['message']?? response.body?['error']?? "Coupon can`t apply",isError: true);
    }
    isSearch = false;
    update();
  }

  int? isApplyIndex;
  Future<bool> applyCoupon(int index) async{

    isApplyIndex = index;
    update();

    try{
      CheckoutData data = Get.find<CheckoutLogic>().checkoutData;

      if(discounts[index].type != null){
        if(discounts[index].type == 'amount'){
          double d = double.tryParse(discounts[index].amount.toString())??0;
          if(data.price < d){
            Toast.show(toastMessage: "Your Order amount less then",isError: true);
            isApplyIndex = null;
            update();
            return false;
          }
        }
        if(discounts[index].type == 'percent'){
          if((double.tryParse(discounts[index].percent.toString())??0) <= 0){
            isApplyIndex = null;
            update();
            Toast.show(toastMessage: "Coupon can`t apply",isError: true);
            return false;
          }
        }
      }
    }catch(e){
      //
    }

   Response response = await apiClient.postAPI(ApiProvider.applyCoupon,{
     'coupon_identifier' : discounts[index].id
   });

    isApplyIndex = null;
    update();

    if(response.statusCode == 200){
      return true;
    }

    try{
      Toast.show(toastMessage: response.body?['message']?? response.body?['error']?? "Coupon can`t apply",isError: true);
    }catch(e){
      //
    }

    return false;
  }

}
