import 'package:get/get.dart';
import 'package:serviceocity/model/CartModel.dart';
import 'package:serviceocity/utils/toast.dart';
import 'package:serviceocity/view/cart/logic.dart';

import '../../core/di/api_client.dart';
import '../../utils/price_converter.dart';

class CheckoutLogic extends GetxController {
  final ApiClient apiClient;
  CheckoutLogic({ required this.apiClient });

  dynamic argumentData = Get.arguments;


  CheckoutData checkoutData = CheckoutData(
    discount: 0,
    price: 0,
    total: 0,
    tax: 0
  );

  List<CartModel> cartModel = [];

  @override
  void onInit() {
    cartModel.clear();
    if(argumentData?['cart'] != null){
      print("PART A");
      cartModel.add(CartModel.fromJson(argumentData['cart']??{}));
    }else{
      print("PART B");
      cartModel.addAll(Get.find<CartLogic>().cartModels);
    }

    super.onInit();
    checkoutData = PriceConverter.getCheckoutData(model: cartModel, offerJson: {});
    update();
  }

  bool isValidOrder(){
    if(cartModel.isEmpty || (double.tryParse(cartModel[0].minCharges.toString())??0) > checkoutData.total){
      Toast.show(toastMessage: "Order Must be greater then ${cartModel[0].minCharges??100}");
      return false;
    }
    return true;
  }

  dynamic json = {};
  applyCode(dynamic json){
    checkoutData = PriceConverter.getCheckoutData(model: cartModel,offerJson: json);
    if((checkoutData.discount) > 0){
      this.json = json;
    }
    update();
  }

  getOrderBody({ String mode = "COD",
    required String addressId,
    required String date,
    required String time}){
    List<Map<String, dynamic>> mapList = [];
    for(int i = 0; i < cartModel.length;i++){

      double salePrice = double.tryParse("${cartModel[i].salePrice}")??0;
      double price = double.tryParse("${cartModel[i].price}")??0;
      double tax = double.tryParse("${cartModel[i].catTax}")??0;
      double unitCost = salePrice > 0 ? salePrice : price;

      mapList.add({
        "service_id": cartModel[i].id,
        "address_id": addressId,
        "unit_cost": unitCost,
        "total_amt": PriceConverter.getSingleDigit(tax > 0 ? (unitCost + ((unitCost * tax) / 100)) : unitCost),
        "quantity": cartModel[i].quantity,
        "category_id": cartModel[i].categoryId,
        "tax": cartModel[i].catTax,
        "coupon_id": json['id']??0,
        "date": date,
        "time": time,
        "type": mode,
        "subtotal_amt": unitCost
      });
    }
    return mapList;
  }
}
