import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/model/CategoryModel.dart';
import 'package:serviceocity/model/SubCategoryModel.dart';

import '../../../core/di/api_provider.dart';
import '../../../widget/common_image.dart';

class GridSubCategory extends StatelessWidget {
  final SubCategoryModel? categoryModel;
  final GestureTapCallback? onTap;
  const GridSubCategory({super.key, this.categoryModel,this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Column(
          children: [
            CommonImage(
              width: (width / 3) - 20,
              height: (width / 3) - 20,
              radius: (width / 3) - 20,
              imageUrl: "${ApiProvider.url}/${categoryModel?.image??""}",
            ),
            Text(categoryModel?.name??'',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold
              ),)
          ],
        ),
      ),
    );
  }
}
