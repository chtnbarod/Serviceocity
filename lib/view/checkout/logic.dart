import 'package:get/get.dart';
import 'package:serviceocity/model/CartModel.dart';
import 'package:serviceocity/view/cart/logic.dart';

import '../../core/di/api_client.dart';
import '../../utils/price_converter.dart';

class CheckoutData{
  final double price;
  final double tax;
  final double total;
  final double discount;
  CheckoutData({ required this.price,required this.tax,required this.total,required this.discount});
}

class CheckoutLogic extends GetxController {
  final ApiClient apiClient;
  CheckoutLogic({ required this.apiClient });

  dynamic argumentData = Get.arguments;


  CheckoutData checkoutData = CheckoutData(
    discount: 0,
    price: 0,
    total: 0,
    tax: 0,
  );


  int? cartIndex;
  @override
  void onInit() {
    if(argumentData?['index'] != null){
      cartIndex = argumentData?['index'];
    }
    super.onInit();
    getCheckoutData(json: {},notify: true);
  }

  dynamic json = {};
  applyCode(dynamic json){
    getCheckoutData(json: json);
    if((checkoutData.discount) > 0){
      this.json = json;
    }
    update();
  }

  void getCheckoutData({ bool notify = false ,required dynamic json }){
    double price = 0;
    double tax = 0;
    double discount = 0;

   List<CartModel> model =  Get.find<CartLogic>().getCheckoutModel(index: cartIndex);

    for(int i = 0;i < (model.length??0);i++){
      double salePrice2 = double.tryParse("${model[i].salePrice}")??0;
      double price2 = double.tryParse("${model[i].price}")??0;
      double tax2 = double.tryParse("${model[i].catTax}")??0;
      print("tax2:: $tax2");
      double quantity2 = double.tryParse("${model[i].quantity}")??1;

      if(salePrice2 > 0){
        price2 = PriceConverter.removeDecimalZeroFormat(salePrice2*quantity2);
      }else{
        price2 = PriceConverter.removeDecimalZeroFormat(price2*quantity2);
      }

      price += price2;

      if(tax2 > 0){
        tax += (price2 * tax2) / 100;
      }
    }

    print("FDdsdfsfdf A: ${json}");
    if(json['type'] != null){

      if(json['type'] == 'amount'){
        double d = double.tryParse(json['amount'].toString())??0;
        if(price > d){
          discount = d;
        }
      }
      if(json['type'] == 'percent'){
        discount = (price * (double.tryParse(json['percent'].toString())??0)) / 100;
      }
    }

    checkoutData = CheckoutData(
        price: PriceConverter.removeDecimalZeroFormat(price),
        tax: PriceConverter.removeDecimalZeroFormat(tax),
        total: PriceConverter.removeDecimalZeroFormat((price + tax) - discount),
        discount: PriceConverter.removeDecimalZeroFormat(discount)
    );

    if(notify){
      update();
    }
  }


  getOrderBody({ String mode = "COD",
    required String addressId,
    required String date,
    required String time}){
    List<Map<String, dynamic>> mapList = [];

    List<CartModel> cartModel = Get.find<CartLogic>().getCheckoutModel(index: cartIndex);
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
