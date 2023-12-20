import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:serviceocity/widget/loader.dart';
import 'package:serviceocity/widget/not_found.dart';

import '../../theme/app_colors.dart';
import '../../widget/bottom_sheet.dart';
import '../home/widget/grid_category.dart';
import '../home/widget/sub_category.dart';
import 'logic.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: GetBuilder<CategoryLogic>(
        assignId: true,
        builder: (logic) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [

                if(logic.inProgress)...[
                  const Loader(),
                ]else...[
                  if(logic.categories.isEmpty)...[
                    const NotFound()
                  ]else...[
                    
                    const SizedBox(height: 20,),

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
                          logic.getCategory();
                        },
                        onLoading: () {
                          logic.getCategory(onRefresh: false);
                        },
                        controller: logic.refreshController,
                        child: GridView.builder(
                          itemCount: logic.categories.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0,
                              childAspectRatio: 0.75
                          ),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context,
                              int index) {
                            return GridCategory(
                              categoryModel: logic
                                  .categories[index],
                              onTap: () {
                                logic.getSubCategory(
                                    logic.categories[index].id);
                                Get.bottomSheet(
                                  buildBottomSheet(
                                    child: SubCategory(
                                        categoryId: logic
                                            .categories[index]
                                            .id),
                                  ),
                                  enableDrag: true,
                                  isScrollControlled: true,
                                  barrierColor: Colors.black38,
                                  isDismissible: false,
                                );
                              },);
                          },
                        ),
                      ),
                    ),
                  ],
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
