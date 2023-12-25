import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/model/UserModel.dart';
import 'package:serviceocity/theme/app_colors.dart';
import 'package:serviceocity/view/account/logic.dart';
import 'package:serviceocity/view/category/logic.dart';
import 'package:serviceocity/view/home/widget/grid_category.dart';
import 'package:serviceocity/view/home/widget/order.dart';
import 'package:serviceocity/view/home/widget/recent_order.dart';
import 'package:serviceocity/view/home/widget/sub_category.dart';
import 'package:serviceocity/view/map/AddressListModel.dart';
import 'package:serviceocity/widget/bottom_sheet.dart';

import '../../core/routes.dart';
import '../../services/init_fcm.dart';
import '../../utils/assets.dart';
import '../../utils/price_converter.dart';
import '../../widget/common_image.dart';
import '../../widget/not_found.dart';
import '../map/binding.dart';
import '../map/view.dart';
import 'logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void checkLocation() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            title: const Text("Location"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 20,),
                    Flexible(
                      child: Text(
                        "Your current location is required for better suggestions",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                        ),),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () {
                      showLocationDialog();
                    }, child: const Text("ok"),)
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showLocationDialog({ PrimaryAddress? primaryAddress }) {
    Get.to(MyMap(
      addressListModel: AddressListModel.fromJson(primaryAddress?.toJson()),
      callback: (AddressListModel? addressListModel) {
        Get.find<HomeLogic>().updateUserAddress(
            context, addressListModel: addressListModel);
      },
    ), binding: MyMapBinding());
  }


  @override
  void initState() {
    super.initState();
    if (GetPlatform.isAndroid) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Get.find<AccountLogic>().userModel?.primaryAddress == null) {
          checkLocation();
        }
      });
    }
    Get.find<HomeLogic>().pullRefresh();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double box = (width / 3) - 20;
    print("SDFDF ${PriceConverter.getFlag()}");
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            Get.find<HomeLogic>().pullRefresh(notify: true);
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: GetBuilder<HomeLogic>(
              assignId: true,
              builder: (logic) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    InkWell(
                      onTap: () {
                        showLocationDialog(primaryAddress: Get
                            .find<AccountLogic>()
                            .userModel
                            ?.primaryAddress);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GetBuilder<AccountLogic>(
                          assignId: true,
                          builder: (account) {
                            return Row(
                              children: [
                                if(logic.addressUpdating)...[
                                  const SizedBox(
                                    height: 35,
                                    width: 35,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ] else
                                  ...[
                                    const SizedBox(
                                      height: 35,
                                      width: 35,
                                      child: Icon(
                                        Icons.location_on, color: Colors.blue,
                                        size: 35,),
                                    ),
                                  ],

                                const SizedBox(width: 10,),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width / 2.7,
                                          child: Text(
                                            "${account.userModel?.primaryAddress
                                                ?.address1 ??
                                                ""}${account.userModel
                                                ?.primaryAddress
                                                ?.address1 ?? ""}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700
                                            ),),
                                        ),
                                        const SizedBox(width: 5,),
                                        const Icon(
                                            Icons.keyboard_arrow_down_sharp),
                                      ],
                                    ),
                                    SizedBox(
                                      width: width / 2.7,
                                      child: Text(
                                        account.userModel?.primaryAddress
                                            ?.city ??
                                            "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 12
                                        ),),
                                    ),
                                  ],
                                ),

                                const Spacer(),

                                Row(
                                  children: [
                                    // Container(
                                    //     width: 35,
                                    //     height: 35,
                                    //     decoration: BoxDecoration(
                                    //       color: Colors.white,
                                    //       borderRadius: BorderRadius.circular(5),
                                    //       boxShadow: [
                                    //         const BoxShadow(
                                    //           color: Color(0xffDDDDDD),
                                    //           blurRadius: 6.0,
                                    //           spreadRadius: 2.0,
                                    //           offset: Offset(0.0, 0.0),
                                    //         )
                                    //       ],
                                    //     ),
                                    //     child: const Icon(
                                    //       Icons.translate, color: Colors
                                    //         .black,)),

                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(rsCartPage);
                                      },
                                      child: Container(
                                          width: 40,
                                          height: 40,
                                          margin: const EdgeInsets.only(
                                              left: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                20),
                                            boxShadow: [
                                              const BoxShadow(
                                                color: Color(0xffDDDDDD),
                                                blurRadius: 6.0,
                                                spreadRadius: 2.0,
                                                offset: Offset(0.0, 0.0),
                                              )
                                            ],
                                          ),
                                          child: Icon(Icons.shopping_cart,
                                            color: AppColors.blackColor(),)),
                                    ),

                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(rsProfilePage);
                                      },
                                      child: Container(
                                          width: 40,
                                          height: 40,
                                          margin: const EdgeInsets.only(
                                              left: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                20),
                                            // boxShadow: [
                                            //   const BoxShadow(
                                            //     color: Color(0xffDDDDDD),
                                            //     blurRadius: 6.0,
                                            //     spreadRadius: 2.0,
                                            //     offset: Offset(0.0, 0.0),
                                            //   )
                                            // ],
                                          ),
                                          child: CommonImage(
                                            width: 40,
                                            height: 40,
                                            radius: 40,
                                            assetPlaceholder: appUser,
                                            imageUrl: "${ApiProvider
                                                .url}/${account
                                                .userModel?.image}",
                                          )),
                                    ),

                                  ],
                                ),

                              ],
                            );
                          },
                        ),
                      ),
                    ),

                    if(logic.isPullProcess)...[
                      SizedBox(height: Get.height / 3,),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,)),
                        ],
                      ),
                    ] else
                      ...[
                        if(logic.isEmptyCategory)...[
                          const NotFound(
                              message: "Our service is not available in your location"),
                        ] else
                          ...[

                            InkWell(
                              onTap: (){
                                Get.toNamed(rsSearchPage);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.appBackground.withOpacity(0.3),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                      width: 0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    const Row(
                                      children: [

                                        Icon(Icons.search, color: Colors.blue,),
                                        SizedBox(width: 10,),
                                        Text("Search",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black
                                          ),)
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        Container(
                                          width: 1,
                                          height: 25,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 2),
                                          decoration: const BoxDecoration(
                                              border: Border(right: BorderSide(
                                                  width: 1, color: Colors.grey))
                                          ),
                                        ),

                                        const Icon(
                                          Icons.mic_none_rounded,
                                          color: Colors.blue,)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),

                           if(logic.topImage?.isNotEmpty??false)
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  height: 250,
                                  margin: const EdgeInsets.only(top: 10),
                                  child: CommonImage(
                                    imageUrl: "${ApiProvider.url}/${logic
                                        .topImage ??
                                        ""}",
                                  ),
                                ),
                                Positioned(
                                  bottom: -80,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [

                                      Container(
                                          width: box,
                                          height: box,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: CommonImage(
                                            width: box,
                                            height: box,
                                            radius: 0,
                                            assetPlaceholder: "assets/images/box_1.png",
                                          )
                                      ),


                                      Container(
                                          width: box,
                                          height: box,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: CommonImage(
                                            width: box,
                                            height: box,
                                            radius: 0,
                                            assetPlaceholder: "assets/images/box_2.png",
                                          )
                                      ),

                                      Container(
                                          width: box,
                                          height: box,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: CommonImage(
                                            width: box,
                                            height: box,
                                            radius: 0,
                                            assetPlaceholder: "assets/images/box_3.png",
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 110,),

                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                 if(logic.recentOrderModel.isNotEmpty)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Recent Orders",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16
                                        ),),

                                      const SizedBox(height: 10,),
                                      SizedBox(
                                        height: 130,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis
                                              .horizontal,
                                          child: Row(
                                            children: [
                                              for(int i = 0; i < logic.recentOrderModel.length; i++)...[
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      right: 10),
                                                  child: RecentOrder(
                                                      recentOrderModel: logic
                                                          .recentOrderModel[i]),
                                                ),
                                              ]
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  if(logic.middleImage?.isNotEmpty??false)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: CommonImage(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      radius: 0,
                                      fit: BoxFit.fitWidth,
                                      imageUrl: "${ApiProvider.url}/${logic
                                          .middleImage ??
                                          ""}",
                                    ),
                                  ),

                                  // const SizedBox(height: 30,),
                                  //
                                  // const Text("Newly Lunched",
                                  //   style: TextStyle(
                                  //       fontWeight: FontWeight.w700,
                                  //       fontSize: 16
                                  //   ),),
                                  // const SizedBox(height: 10,),
                                  // const SingleChildScrollView(
                                  //   scrollDirection: Axis.horizontal,
                                  //   child: Row(
                                  //     children: [
                                  //       Order(isNew: true),
                                  //       SizedBox(width: 10,),
                                  //       Order(isNew: true),
                                  //     ],
                                  //   ),
                                  // ),

                                  const SizedBox(height: 30,),

                                  const Text("Category",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16
                                    ),),

                                  const SizedBox(height: 30,),


                                  GetBuilder<CategoryLogic>(
                                    assignId: true,
                                    builder: (logic) {
                                      return GridView.builder(
                                        itemCount: logic.categories.length,
                                        physics: const NeverScrollableScrollPhysics(),
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 4.0,
                                            mainAxisSpacing: 4.0,
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
                                      );
                                    },
                                  ),

                                  const SizedBox(height: 20,),

                                  InkWell(
                                    onTap: (){
                                      Get.toNamed(rsCategoryPage);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blue, width: 1),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Text("See More",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold
                                            ),),
                                          SizedBox(width: 10,),
                                          Icon(Icons.keyboard_arrow_down)
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 10,),

                                  ListView.builder(
                                    itemCount: logic.featureList.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [

                                          const SizedBox(height: 20),

                                          if(logic.featureList[index]
                                              .featureServices
                                              ?.isNotEmpty ?? false)
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [

                                                Text(
                                                  logic.featureList[index]
                                                      .title ??
                                                      "Feature Service",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),

                                                SizedBox(
                                                  height: 130,
                                                  child: SingleChildScrollView(
                                                    scrollDirection: Axis
                                                        .horizontal,
                                                    child: Row(
                                                      children: [
                                                        for(int i = 0; i <
                                                            (logic
                                                                .featureList[index]
                                                                .featureServices
                                                                ?.length ??
                                                                0); i++)...[
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .only(
                                                                right: 10),
                                                            child: Order(
                                                                featureServices: logic
                                                                    .featureList[index]
                                                                    .featureServices?[i]),
                                                          ),
                                                        ]
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),


                                          if(logic.featureList[index]
                                              .featureCats
                                              ?.isNotEmpty ?? false)
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [

                                                const SizedBox(height: 20),

                                                const Text("Explore Categories",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                  ),
                                                ),

                                                const SizedBox(height: 5,),

                                                for(int i = 0; i <
                                                    (logic.featureList[index]
                                                        .featureCats
                                                        ?.length ?? 0); i++)...[
                                                  Column(
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          CommonImage(
                                                            // width: MediaQuery
                                                            //     .of(context)
                                                            //     .size
                                                            //     .width,
                                                            // height: 200,
                                                            width: Get.width,
                                                            imageUrl: "${ApiProvider
                                                                .url}/${logic
                                                                .featureList[index]
                                                                .featureCats?[i]
                                                                .image}",
                                                          ),
                                                          const Positioned(
                                                            top: 0,
                                                            left: 10,
                                                            right: 10,
                                                            bottom: 0,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Icon(
                                                                    Icons
                                                                        .arrow_back_ios),
                                                                Icon(Icons
                                                                    .arrow_forward_ios),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text(
                                                                logic
                                                                    .featureList[index]
                                                                    .featureCats?[i]
                                                                    .name ?? "",
                                                                style: const TextStyle(
                                                                    fontWeight: FontWeight
                                                                        .bold
                                                                ),),
                                                              const Text(
                                                                "Feel The Aroma",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight
                                                                        .normal
                                                                ),),
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .blue,
                                                                    borderRadius: BorderRadius
                                                                        .circular(
                                                                        5)
                                                                ),
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal: 5),
                                                                child: const Row(
                                                                  children: [
                                                                    Text("4.8",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          color: Colors
                                                                              .white
                                                                      ),),
                                                                    Icon(Icons
                                                                        .star,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 14,)
                                                                  ],
                                                                ),
                                                              ),
                                                              Text(
                                                                "Starting from ${PriceConverter
                                                                    .getFlag()} ${logic
                                                                    .featureList[index]
                                                                    .featureCats?[i]
                                                                    .minCharges}",
                                                                style: const TextStyle(
                                                                    fontWeight: FontWeight
                                                                        .normal
                                                                ),),
                                                            ],
                                                          )
                                                        ],)
                                                    ],
                                                  )
                                                ]
                                              ],
                                            ),

                                          const SizedBox(height: 10),

                                        ],
                                      );
                                    },
                                  ),


                                  const SizedBox(height: 20,),

                                  // const Text("Explore Categories",
                                  //   style: TextStyle(
                                  //       fontWeight: FontWeight.w700,
                                  //       fontSize: 16
                                  //   ),),
                                  //
                                  // const SizedBox(height: 10,),

                                  // Column(
                                  //   children: [
                                  //     Stack(
                                  //       children: [
                                  //         CommonImage(
                                  //           width: MediaQuery
                                  //               .of(context)
                                  //               .size
                                  //               .width,
                                  //           height: 200,
                                  //         ),
                                  //         const Positioned(
                                  //           top: 0,
                                  //           left: 10,
                                  //           right: 10,
                                  //           bottom: 0,
                                  //           child: Row(
                                  //             mainAxisAlignment: MainAxisAlignment
                                  //                 .spaceBetween,
                                  //             children: [
                                  //               Icon(Icons.arrow_back_ios),
                                  //               Icon(Icons.arrow_forward_ios),
                                  //             ],
                                  //           ),
                                  //         )
                                  //       ],
                                  //     ),
                                  //     const SizedBox(height: 10,),
                                  //     Row(
                                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //       children: [
                                  //         const Column(
                                  //           crossAxisAlignment: CrossAxisAlignment.start,
                                  //           children: [
                                  //             Text("Be Relax at Home",
                                  //               style: TextStyle(
                                  //                   fontWeight: FontWeight.bold
                                  //               ),),
                                  //             Text("Feel The Aroma",
                                  //               style: TextStyle(
                                  //                   fontWeight: FontWeight.normal
                                  //               ),),
                                  //           ],
                                  //         ),
                                  //         Column(
                                  //           crossAxisAlignment: CrossAxisAlignment.start,
                                  //           children: [
                                  //             Container(
                                  //               decoration: BoxDecoration(
                                  //                   color: Colors.blue,
                                  //                   borderRadius: BorderRadius.circular(5)
                                  //               ),
                                  //               padding: const EdgeInsets.symmetric(
                                  //                   horizontal: 5),
                                  //               child: const Row(
                                  //                 children: [
                                  //                   Text("4.8",
                                  //                     style: TextStyle(
                                  //                         fontWeight: FontWeight.bold,
                                  //                         color: Colors.white
                                  //                     ),),
                                  //                   Icon(Icons.star, color: Colors.white,
                                  //                     size: 14,)
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //             const Text("Starting from \u{20b9} 499",
                                  //               style: TextStyle(
                                  //                   fontWeight: FontWeight.normal
                                  //               ),),
                                  //           ],
                                  //         )
                                  //       ],)
                                  //   ],
                                  // )


                                  if(logic.bottomImage?.isNotEmpty??false)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: CommonImage(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width,
                                        radius: 0,
                                        fit: BoxFit.fitWidth,
                                        imageUrl: "${ApiProvider.url}/${logic.bottomImage ?? ""}",
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                      ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
