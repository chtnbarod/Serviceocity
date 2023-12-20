import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:serviceocity/view/home/logic.dart';

import '../../core/di/api_client.dart';
import '../../core/di/api_provider.dart';
import '../../model/CategoryModel.dart';
import '../../model/SubCategoryModel.dart';

class CategoryLogic extends GetxController  implements GetxService{
 final ApiClient apiClient;
CategoryLogic({required this.apiClient});

 int pageIndex = 1;
 bool nextPage = false;

 RefreshController refreshController = RefreshController(initialRefresh: false);
 RefreshController refreshController2 = RefreshController(initialRefresh: false);

 List<CategoryModel> categories = [];
 bool inProgress = false;
  getCategory({ bool notify = true,bool onRefresh = true }) async{
    if(inProgress) return;

    if(onRefresh){
      inProgress = true;
      pageIndex = 1;
      categories.clear();
    }else{
      if(!nextPage){
        refreshController.loadComplete();
        return;
      }
      pageIndex++;
    }
    await apiClient.getAPI("${ApiProvider.getCategories}?page=$pageIndex").then((value) => {
      if(value.statusCode == 200){
        if(value.body['data']['next_page_url'] != null){
          nextPage = true,
        }else{
          nextPage = false
        },
        value.body['data']['data'].forEach((v) {
          categories.add(CategoryModel.fromJson(v));
        }),
      },
      if(value.statusCode == 404){
        Get.find<HomeLogic>().setEmptyCategory(true),
      }
    });
    inProgress = false;
    if(notify){
      if(onRefresh){
        refreshController.refreshCompleted();
      }else{
        refreshController.loadComplete();
      }
      update();
    }
  }

 List<SubCategoryModel> subCategories = [];
 int? forFubCategories;
 bool isGetFubCategories = false;
 int subCatPageIndex = 1;
 bool subCatNextPage = false;
 getSubCategory(int? id,{ bool onRefresh = true }) async{

   if(onRefresh){
     isGetFubCategories = true;
     subCatPageIndex = 1;
     subCategories.clear();
   }else{
     if(!subCatNextPage){
       refreshController2.loadComplete();
       return;
     }
     subCatPageIndex++;
   }

  await apiClient.getAPI("${ApiProvider.getSubCategories}?category_id=$id&page=$subCatPageIndex").then((value) => {
     if(value.statusCode == 200){
       if(value.body['data']['next_page_url'] != null){
         subCatNextPage = true,
       }else{
         subCatNextPage = false
       },
       value.body['data']['data'].forEach((v) {
         subCategories.add(SubCategoryModel.fromJson(v));
       }),
     }
   });

   isGetFubCategories = false;
   // if(subCategories.isEmpty){
   //  Get.back();
   //  return;
   // }
   if(onRefresh){
     refreshController2.refreshCompleted();
   }else{
     refreshController2.loadComplete();
   }
   update();
 }

}
