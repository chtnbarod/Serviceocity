import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/routes.dart';
import 'package:serviceocity/view/home/logic.dart';

import 'grid_sub_category.dart';

class SubCategory extends StatelessWidget {
  final int? categoryId;
  const SubCategory({super.key,this.categoryId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeLogic>(
      assignId: true,
      builder: (logic) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: Get.height/1.5,
            minHeight: Get.height/3,
          ),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

             if(logic.isGetFubCategories)
              Container(
                height: 1,
                margin: const EdgeInsets.only(left: 12,right: 12,top: 1),
                child: const LinearProgressIndicator(),
              ),

             if(logic.subCategories.isNotEmpty)
              GridView.builder(
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
                      'category_id' : logic.subCategories[index].id,
                      'sub_category_id' : categoryId,
                    });
                  },);
                },
              ),
            ],
          )
        );
      },
    );
  }
}
