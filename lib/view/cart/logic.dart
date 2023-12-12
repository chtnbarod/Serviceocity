import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/utils/toast.dart';

import '../../core/di/api_client.dart';
import '../../model/CartModel.dart';

class CartLogic extends GetxController implements GetxService{
  final ApiClient apiClient;
  CartLogic({required this.apiClient});

  Future<void> addToCart({ int? serviceId, int? quantity = 1 }) async{
    await apiClient.postAPI(ApiProvider.addToCart, {
      'product_id' : serviceId,
      'quantity' : quantity
    }).then((value) => {
      print("DDDDDDDDDDDDD ${value.statusCode}"),
      if(value.statusCode == 200){
        Toast.show(toastMessage: "Added in cart")
      }else{
        Toast.show(toastMessage: value.body['error']??"internal server error")
      },
    }).catchError((onError){
      return onError;
    });
  }

  //

  List<CartModel> cartModels = [];
  bool cartInProgress = false;
  getCart() async{
    cartModels.clear();
    cartInProgress = true;
    update();
    await apiClient.getAPI(ApiProvider.viewCart).then((value) => {
      print("valuevalue ${value.body}"),
      if(value.statusCode == 200){
        value.body.forEach((v) {
          cartModels.add(CartModel.fromJson(v));
        }),
      }
    }).catchError((onError){
      return onError;
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
          Get.back()
        }else{
          cartModels.removeAt(index),
          update()
        }
      }
    }).whenComplete(() => deletingIndex = null);
  }

  //

  int? increaseIndex;
  cartIncrease({ String? serviceId, int quantity = 1 ,int? index  }) async{
    if(increaseIndex != null) return;
    increaseIndex = index;
    update();
    await apiClient.putAPI(ApiProvider.updateCart, {
      "id" : serviceId,
      "quantity" : quantity,
    }).then((value) => {
      if(value.statusCode == 200){
        Toast.show(toastMessage: "Successfully Quantity Updated"),
        if(index != null){
          cartModels[index].quantity = "${value.body['quantity']}",
        }
      }else{
        Toast.show(toastMessage: value.body['message'] ?? "Try Again",isError: true)
      }
    }).whenComplete(() => {
      increaseIndex = null,
      update(),
    });
  }

  int? decreaseIndex;
  cartDecrease({ String? serviceId, int quantity = 1 ,int? index  }) async{
    if(decreaseIndex != null) return;
    decreaseIndex = index;
    update();
    await apiClient.putAPI(ApiProvider.updateCart, {
      "id" : serviceId,
      "quantityminus" : quantity,
    }).then((value) => {
      if(value.statusCode == 200){
        Toast.show(toastMessage: value.body['message']??"Successfully Quantity Updated"),
        if(index != null){
          if(value.body['quantity'] == null){
            cartModels.removeAt(index)
          }else{
            cartModels[index].quantity = ("${value.body['quantity']}"),
          },
        }
      }else{
        Toast.show(toastMessage: value.body['message'] ?? "Try Again",isError: true)
      }
    }).whenComplete(() => {
      decreaseIndex = null,
      update(),
    });
  }

}
