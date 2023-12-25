import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/core/routes.dart';
import 'package:serviceocity/theme/app_colors.dart';
import 'package:serviceocity/utils/assets.dart';
import 'package:serviceocity/utils/date_converter.dart';
import 'package:serviceocity/view/cart/logic.dart';
import 'package:serviceocity/view/service/widget/vertical_service.dart';
import 'package:serviceocity/widget/not_found.dart';

import '../../model/ServiceDetailsModel.dart';
import '../../widget/common_image.dart';
import '../../widget/custom_button.dart';
import '../../widget/loader.dart';
import 'logic.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<ServiceLogic>().getChildCategory();
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<ServiceLogic>(
          assignId: true,
          builder: (logic) {
            return Text((logic.toolbarName??"Service").toCapitalizeFirstLetter());
          },
        ),
      ),
      backgroundColor: AppColors.whiteColor(),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          GetBuilder<CartLogic>(
            assignId: true,
            builder: (logic) {
              return
                logic.cartModels.isEmpty && !logic.cartInProgress
                    ? Container()
                    :
                Container(
                  decoration: const BoxDecoration(
                      border: Border(top: BorderSide(width: 0.5))
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 5),
                  child: Column(
                    children: [
                      if(logic.cartInProgress)...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primary,
                            minHeight: 2,),
                        )
                      ],
                      CustomButton(
                        height: 40,
                        isEnable: !logic.cartInProgress,
                        label: Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 2),
                                  child: Text("${logic.cartModels.length} Item",
                                    style: const TextStyle(
                                        color: Colors.black
                                    ),),
                                ),
                                const Row(
                                  children: [
                                    // Icon(Icons.shopping_cart,
                                    //   color: Colors.white,),
                                    // SizedBox(width: 5,),
                                    Text("Checkout",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        fontSize: 17
                                      ),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          Get.toNamed(rsCheckoutPage)?.then((value) =>
                          {
                            Get.find<ServiceLogic>().getChildCategory()
                          });
                        },
                      ),
                    ],
                  ),
                );
            },
          ),

        ],
      ),
      body: GetBuilder<ServiceLogic>(
        assignId: true,
        builder: (logic) {
          return SafeArea(
            child: Column(
              children: [

                if(logic.iaRefreshing)...[
                  const Loader()
                ] else
                  ...[
                    if(logic.selectedCategory == null)...[
                      const NotFound()
                    ] else
                      ...[
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
                                        icon: logic.category[index].image?[0] ??
                                            "",
                                        isSelected: logic.category[index].id ==
                                            logic.selectedCategory?.id,
                                      ),
                                    );
                                  },
                                ),
                              ),

                              Expanded(child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child:
                                logic.serviceGating ?
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,)),
                                  ],
                                ) :
                                Column(
                                  children: [


                                    if(logic.selectedCategory?.image
                                        ?.isNotEmpty ?? false)
                                      CarouselSlider.builder(
                                        itemCount: logic.selectedCategory?.image
                                            ?.length,
                                        options: CarouselOptions(
                                            autoPlay: (logic.selectedCategory
                                                ?.image?.length ?? 0) > 1,
                                            viewportFraction: 1,
                                            aspectRatio: 2,
                                            initialPage: 0,
                                            onPageChanged: (index, reason) {
                                              logic.setIndex(index);
                                            }
                                        ),
                                        itemBuilder: (context, index, realIdx) {
                                          return CommonImage(
                                            imageUrl: "${ApiProvider
                                                .url}/${logic.selectedCategory
                                                ?.image?[index]}",
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
                                          return VerticalService(
                                            serviceModel: logic.service[index],
                                            onRefresh: () {
                                              logic.getChildCategory();
                                            },
                                            onUpdate: (dynamic json) {
                                              logic.service[index].cart
                                                  ?.quantity =
                                              "${json['quantity']}";
                                              logic.update();
                                            },
                                            onAddToCart: (dynamic json) {
                                              logic.service[index].cart =
                                                  Cart.fromJson(json);
                                              logic.update();
                                            },
                                            onAddToCart2: (dynamic json,
                                                int i) {
                                              logic.service[index].addons![i]
                                                  .cart = Cart.fromJson(json);
                                              logic.update();
                                            },
                                            onUpdate2: (dynamic json, int i) {
                                              logic.service[index].addons![i]
                                                  .cart?.quantity =
                                              "${json['quantity']}";
                                              logic.update();
                                            },
                                          );
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