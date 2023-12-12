import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/model/ChildCategoryModel.dart';
import 'package:serviceocity/model/ServiceModel.dart';

import '../../core/di/api_client.dart';

class CategoryLogic extends GetxController {
  final ApiClient apiClient;
  CategoryLogic({required this.apiClient});

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
  getChildCategory() async{
    category.clear();
    update();
    await apiClient.getAPI("${ApiProvider.getChildCategories}?category_id=$categoryId&sub_category_id=$subCategoryId").then((value) => {
      value.body['data'].forEach((v) {
        category.add(ChildCategoryModel.fromJson(v));
      }),
      initData()
    }).whenComplete(() => update());
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

}
