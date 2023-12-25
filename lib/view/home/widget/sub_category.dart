import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:serviceocity/core/routes.dart';
import 'package:serviceocity/view/category/logic.dart';
import 'package:serviceocity/widget/not_found.dart';

import '../../../theme/app_colors.dart';
import 'grid_sub_category.dart';

class SubCategory extends StatelessWidget {
  final int? categoryId;
  const SubCategory({super.key,this.categoryId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryLogic>(
      assignId: true,
      builder: (logic) {
        return Container(
          height: Get.height/1.4,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
          ),
          child: Column(
            children: [

             if(logic.isGetFubCategories)...[
               Container(
                 height: 3,
                 margin: const EdgeInsets.only(right: 10,left: 10),
                 child: const LinearProgressIndicator(),
               ),
             ]else...[
               if(logic.subCategories.isNotEmpty)...[
                 Flexible(
                   child: SmartRefresher(
                     enablePullDown: true,
                     enablePullUp: true,
                     header: WaterDropHeader(
                       waterDropColor: Colors.transparent,
                       idleIcon: Container(
                         height: 40,
                         width: 40,
                         decoration: BoxDecoration(
                             color: AppColors.whiteColor(),
                             shape: BoxShape.circle
                         ),
                         child: Icon(Icons.refresh, color: Theme
                             .of(context)
                             .primaryColor),
                       ),
                     ),
                     footer: CustomFooter(
                       builder: (BuildContext context, LoadStatus? mode) {
                         Widget body;
                         if (mode == LoadStatus.loading) {
                           body = const CupertinoActivityIndicator();
                         } else {
                           body = Container();
                         }
                         return Container(
                           padding: const EdgeInsets.all(20),
                           child: body,
                         );
                       },
                     ),
                     onRefresh: () {
                       logic.getSubCategory(categoryId);
                     },
                     onLoading: () {
                       logic.getSubCategory(categoryId,onRefresh: false);
                     },
                     controller: logic.refreshController2,
                     child: GridView.builder(
                       itemCount: logic.subCategories.length,
                       padding: const EdgeInsets.all(20),
                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 3,
                           crossAxisSpacing: 4.0,
                           mainAxisSpacing: 4.0,
                           childAspectRatio: 0.75
                       ),
                       shrinkWrap: true,
                       itemBuilder: (BuildContext context, int index) {
                         return GridSubCategory(categoryModel: logic.subCategories[index],onTap: (){
                           Get.back();
                           Get.toNamed(rsService,arguments: {
                             'toolbar_name' : logic.subCategories[index].name,
                             'category_id' : logic.subCategories[index].id,
                             'sub_category_id' : categoryId,
                           });
                         },);
                       },
                     ),
                   ),
                 ),
               ]else...[
                 const NotFound()
               ]
             ],
            ],
          )
        );
      },
    );
  }
}
