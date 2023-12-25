import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/utils/toast.dart';

import '../../core/di/api_client.dart';
import '../../model/CartModel.dart';

class CartLogic extends GetxController implements GetxService{
  final ApiClient apiClient;
  CartLogic({required this.apiClient});

  @override
  void onInit() {
    super.onInit();
    getCart();
  }

  List<CartModel> cartModels = [];
  bool cartInProgress = false;
  getCart({ bool notify = true }) async{
    if(cartInProgress) return;
    cartModels.clear();
    cartInProgress = true;
    if(notify){
      update();
    }
    await apiClient.getAPI(ApiProvider.viewCart).then((value) => {
      if(value.statusCode == 200){
        value.body.forEach((v) {
          cartModels.add(CartModel.fromJson(v));
        }),
      }
    }).whenComplete(() => {
      cartInProgress = false,
      update(),
    });
  }

  int? deletingIndex;
  deleteCart(int index) async{
    deletingIndex = index;
    update();
    await apiClient.postAPI("${ApiProvider.deleteCart}/${cartModels[index].cartId}", {}).then((value) => {
      if(value.statusCode == 200){
        if(cartModels.length == 1){
          cartModels.clear(),
          update(),
          Get.back()
        }else{
          cartModels.removeAt(index),
          update()
        }
      }
    }).whenComplete(() => deletingIndex = null);
  }

  bool isValidOrder(double total){
    if(cartModels.isEmpty || (double.tryParse(cartModels[0].minCharges.toString())??0) > total){
      Toast.show(toastMessage: "Order Must be greater then ${cartModels[0].minCharges??100}");
      return false;
    }
    return true;
  }

  List<CartModel> getCheckoutModel({ int? index }){
    if(index != null) {
     return  [ cartModels[index] ];
    }
    return cartModels;
  }

  //

  int? increaseIndex;
 Future<void> cartIncrease({ String? serviceId, int quantity = 1 ,int? index  }) async{
    if(increaseIndex != null) return;
    increaseIndex = index;
    update();
    await apiClient.putAPI(ApiProvider.updateCart, {
      "id" : serviceId,
      "quantity" : quantity,
    }).then((value) => {
      if(value.statusCode == 200){
        if(index != null){
          cartModels[index].quantity = "${value.body['quantity']}",
        }
      }
    }).whenComplete(() => {
      increaseIndex = null,
      update(),
    });
  }

  int? decreaseIndex;
  Future<void>  cartDecrease({ String? serviceId, int quantity = 1 ,int? index , bool useBack = false }) async{
    if(decreaseIndex != null) return;
    decreaseIndex = index;
    update();
    await apiClient.putAPI(ApiProvider.updateCart, {
      "id" : serviceId,
      "quantityminus" : quantity,
    }).then((value) => {
      if(value.statusCode == 200){
        if(index != null){
          if(value.body['quantity'] == null){
            cartModels.removeAt(index)
          }else{
            cartModels[index].quantity = ("${value.body['quantity']}"),
          },
        }
      }
    }).whenComplete(() => {
      decreaseIndex = null,
      if(useBack && cartModels.isEmpty){
        Get.back(),
      },
      update(),
    });
  }


 Future<Response> updateCart({ required bool isIncrease,String? serviceId, int quantity = 1   }) async{
    dynamic body = {};

    if(isIncrease){
      body =  {
        "id" : serviceId,
        "quantity" : quantity,
      };
    }else{
      body =  {
        "id" : serviceId,
        "quantityminus" : quantity,
      };
    }

   Response response = await apiClient.putAPI(ApiProvider.updateCart,body);

    return response;
  }

}
