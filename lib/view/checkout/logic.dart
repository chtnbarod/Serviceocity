import 'package:get/get.dart';
import 'package:serviceocity/model/CartModel.dart';

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

  CartModel? cartModel;
  @override
  void onInit() {
    cartModel = CartModel.fromJson(argumentData['cart']??{});
    super.onInit();
    checkoutData = PriceConverter.getCheckoutData(
        price: cartModel?.price,
        salePrice: cartModel?.salePrice,
        quantity: cartModel?.quantity,
        tax: cartModel?.tax,
        offerJson: {}
    );
    update();
  }

  dynamic json = {};
  applyCode(dynamic json){
    checkoutData = PriceConverter.getCheckoutData(
        price: cartModel?.price,
        salePrice: cartModel?.salePrice,
        quantity: cartModel?.quantity,
        tax: cartModel?.tax,
        offerJson: json
    );
    if((checkoutData.discount??0) > 0){
      this.json = json;
    }
    update();
  }
}
