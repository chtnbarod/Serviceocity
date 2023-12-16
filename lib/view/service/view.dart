import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/theme/app_colors.dart';
import 'package:serviceocity/utils/assets.dart';
import 'package:serviceocity/view/service/widget/vertical_service.dart';
import 'package:serviceocity/widget/not_found.dart';

import '../../widget/common_image.dart';
import '../../widget/loader.dart';
import 'logic.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<ServiceLogic>().getChildCategory();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Service"),
        centerTitle: true,
      ),
      backgroundColor: AppColors.whiteColor(),
      body: GetBuilder<ServiceLogic>(
        assignId: true,
        builder: (logic) {
          return SafeArea(
            child: Column(
              children: [

                if(logic.iaRefreshing)...[
                  const Loader()
                ]else...[
                  if(logic.selectedCategory == null)...[
                    const NotFound()
                  ]else...[
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: double.infinity,
                            decoration: const BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                border: Border(right: BorderSide(
                                    width: 1, color: Colors.black))
                              //   boxShadow: boxShadow(),
                            ),
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: logic.category.length,
                              padding: const EdgeInsets.only(top: 10),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    logic.setSelectedCategory(
                                        logic.category[index]);
                                  },
                                  child: CategoryItem(
                                    title: logic.category[index].name ?? "",
                                    icon: logic.category[index].image?[0] ?? "",
                                    isSelected: logic.category[index].id ==
                                        logic.selectedCategory?.id,
                                  ),
                                );
                              },
                            ),
                          ),

                          Expanded(child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                            child:
                            logic.serviceGating ?
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(strokeWidth: 2,)),
                              ],
                            ) :
                            Column(
                              children: [


                                if(logic.selectedCategory?.image?.isNotEmpty??false)
                                  CarouselSlider.builder(
                                    itemCount: logic.selectedCategory?.image?.length,
                                    options: CarouselOptions(
                                        autoPlay: (logic.selectedCategory?.image?.length??0) > 1,
                                        viewportFraction: 1,
                                        aspectRatio: 2,
                                        initialPage: 0,
                                        onPageChanged: (index, reason) {
                                          logic.setIndex(index);
                                        }
                                    ),
                                    itemBuilder: (context, index, realIdx) {
                                      return CommonImage(
                                        imageUrl: "${ApiProvider.url}/${logic.selectedCategory?.image?[index]}",
                                        // width: Get.size.width - 108,
                                        height: 130,
                                        radius: 10,
                                        assetPlaceholder: appPlaceholder,
                                        fit: BoxFit.contain,
                                      );
                                    },
                                  ),


                                Flexible(
                                  child: ListView.builder(
                                    itemCount: logic.service.length,
                                    itemBuilder: (context, index) {
                                      return VerticalService(serviceModel: logic.service[index],);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                    )
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

class CategoryItem extends StatelessWidget {
  final String title;
  final String icon;
  final bool isSelected;

  const CategoryItem(
      {Key? key, required this.title, required this.icon, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: const BoxDecoration(
        // border: Border(
        //   right: BorderSide(
        //     width: 2,
        //     color: isSelected ? AppColors.primary : AppColors.whiteColor(),
        //   ),
        //   top: BorderSide(
        //     width: 2,
        //     color: AppColors.whiteColor(),
        //   ),
        //   bottom: BorderSide(
        //     width: 2,
        //     color: AppColors.whiteColor(),
        //   ),
        //   left: BorderSide(
        //     width: 2,
        //     color: AppColors.whiteColor(),
        //   ),
        // ),
      ),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 70,
                width: 70,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: CommonImage(
                    imageUrl: "${ApiProvider.url}/$icon",
                    assetPlaceholder: appPlaceholder,
                    radius: 35,
                  ),
                ),
              ),
              const SizedBox(height: 3,),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: isSelected ? AppColors.primary : null,
                      )),
                ),
              ),
            ]),
      ),
    );
  }
}