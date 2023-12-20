import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/model/ChildCategoryModel.dart';
import 'package:serviceocity/model/ServiceModel.dart';

import '../../core/di/api_client.dart';
import '../../utils/toast.dart';

class ServiceLogic extends GetxController {
  final ApiClient apiClient;
  ServiceLogic({required this.apiClient});

  dynamic argumentData = Get.arguments;

  int? categoryId;
  int? subCategoryId;
  @override
  void onInit() {
    if(GetPlatform.isAndroid){
      categoryId = argumentData?['category_id'];
      subCategoryId = argumentData?['sub_category_id'];
    }else{
      categoryId = 1;
      subCategoryId = 1;
    }
    super.onInit();
  }

  ChildCategoryModel? selectedCategory;
  int current = 0;
  setIndex(int index){
    current = index;
    update();
  }

  setSelectedCategory(ChildCategoryModel? selectedCategory){
    this.selectedCategory = selectedCategory;
    update();
    getService();
  }

  initData(){
    if(category.isNotEmpty){
      selectedCategory = category.first;
      getService();
    }
  }

  List<ChildCategoryModel> category = [];
  bool iaRefreshing = false;
  getChildCategory() async{
    if(iaRefreshing) return;
    category.clear();
    iaRefreshing = true;
    print("ABC: count");
    update();
    await apiClient.getAPI("${ApiProvider.getChildCategories}?category_id=$categoryId&sub_category_id=$subCategoryId").then((value) => {
      value.body['data'].forEach((v) {
        category.add(ChildCategoryModel.fromJson(v));
      }),
      initData()
    }).whenComplete(() => {
      iaRefreshing = false,
      update(),
    });
  }

  List<ServiceModel> service = [];
  bool serviceGating = false;
  getService() async{
    service.clear();
    serviceGating = true;
    update();
    await apiClient.getAPI("${ApiProvider.getService}?category_id=$categoryId&sub_category_id=$subCategoryId&sub_child_category_id=${selectedCategory?.id}").then((value) => {
      value.body['data'].forEach((v) {
        service.add(ServiceModel.fromJson(v));
      }),
    }).whenComplete(() => {
      serviceGating = false,
      update(),
    });
  }

  Future<void> updateCart({ required bool isIncrease, required int index }) async{
    dynamic body = {};

    if(isIncrease){
      body =  {
        "id" : service[index].cart?.id,
        "quantity" : service[index].cart?.quantity,
      };
    }else{
      body =  {
        "id" : service[index].cart?.id,
        "quantityminus" : service[index].cart?.quantity,
      };
    }

    await apiClient.putAPI(ApiProvider.updateCart,body).then((value) => {
      if(value.statusCode == 200){
        service[index].cart?.quantity = "${value.body['quantity']}",
      }
    });
  }


}
