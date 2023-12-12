import 'package:get/get.dart';
import 'package:serviceocity/model/ServiceDetailsModel.dart';
import 'package:serviceocity/model/ServiceModel.dart';

import '../../core/di/api_client.dart';
import '../../core/di/api_provider.dart';
import '../../utils/toast.dart';

class ServiceDetailLogic extends GetxController {
  final ApiClient apiClient;
  ServiceDetailLogic({required this.apiClient});

  dynamic argumentData = Get.arguments;

  int? serviceId;
  int? subCategoryId;
  @override
  void onInit() {
      serviceId = argumentData?['id'];
      subCategoryId = argumentData?['sub_category_id'];
    super.onInit();
    getServiceDetails();
  }


  ServiceDetailsModel? serviceDetailsModel;

  getServiceDetails() async{
    await apiClient.getAPI("${ApiProvider.getServiceDetails}/$serviceId").then((value) => {
      serviceDetailsModel = ServiceDetailsModel.fromJson(value.body['data'])
    }).whenComplete(() => update());
  }



  bool addInCart = false;
  bool isIncrease = false;
  bool isDecrease = false;

  Future<void> addToCart() async{
    addInCart = true;
    update();
    await apiClient.postAPI(ApiProvider.addToCart, {
      'product_id' : serviceDetailsModel?.id,
      'quantity' : 1
    }).then((value) => {
      if(value.statusCode == 200){
        Toast.show(toastMessage: "Added in cart"),
        serviceDetailsModel?.cart = Cart.fromJson(value.body),
      }else{
        Toast.show(toastMessage: value.body['error']??"internal server error")
      }
    }).whenComplete(() => {
      addInCart = false,
      update(),
    });
  }


  updateCart({ required bool isIncrease  }) async{
    if(this.isIncrease) return;
    this.isIncrease = isIncrease;
    isDecrease = !isIncrease;
    update();

    dynamic body = {};

    if(isIncrease){
      body =  {
        "id" : serviceDetailsModel?.cart?.id,
        "quantity" : serviceDetailsModel?.cart?.quantity,
      };
    }else{
      body =  {
        "id" : serviceDetailsModel?.cart?.id,
        "quantityminus" : serviceDetailsModel?.cart?.quantity,
      };
    }
    await apiClient.putAPI(ApiProvider.updateCart,body).then((value) => {
      if(value.statusCode == 200){
        if(!isIncrease && serviceDetailsModel?.cart?.quantity == "1"){
          serviceDetailsModel?.cart = null,
        }else{
          serviceDetailsModel?.cart?.quantity = "${value.body['quantity']}",
        },
        Toast.show(toastMessage: "Successfully Quantity Updated"),
      }else{
        Toast.show(toastMessage: value.body['error'] ?? value.body['message'] ?? "Try Again",isError: true)
      }
    }).whenComplete(() => {
      this.isIncrease = false,
      isDecrease = false,
      update(),
    });
  }


}
