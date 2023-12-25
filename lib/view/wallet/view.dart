import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/theme/app_colors.dart';
import 'package:serviceocity/utils/assets.dart';
import 'package:serviceocity/utils/price_converter.dart';
import 'package:serviceocity/widget/common_image.dart';
import 'package:serviceocity/widget/loader.dart';
import 'package:serviceocity/widget/not_found.dart';

import '../cart/view.dart';
import 'logic.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<WalletLogic>().getWallet();
    return Scaffold(
      backgroundColor: AppColors.whiteColor(),
      appBar: AppBar(
        title: const Text("My Wallet"),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<WalletLogic>(
          assignId: true,
          builder: (logic) {
            return Column(
              children: [

                if(logic.inProcess)...[
                  const Loader()
                ]else...[

                  const SizedBox(height: 20,),

                  Stack(
                    children: [
                      CommonImage(
                        width: Get.width-10,
                        assetPlaceholder: walletCard,
                      ),
                      Positioned(
                          right: 50,
                          top: 50,
                          child: Column(
                            children: [
                              const Text("Balance",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),),

                              Text("${PriceConverter.getFlag()}${logic.wallet?.balance??0}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),),
                            ],
                          )),

                      Positioned(
                          left: 35,
                          bottom: 20,
                          child: Column(
                            children: [
                              Text("Powered by $appName",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                ),),
                            ],
                          ))
                    ],
                  ),

                  const SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: boxShadow()
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white,width: 2),
                                        shape: BoxShape.circle
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: const Icon(
                                      Icons.keyboard_arrow_down, color: Colors.white,)),

                                const SizedBox(width: 20,),

                                Column(
                                  children: [
                                    const Text("Income",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.5
                                      ),),
                                    const SizedBox(height: 5,),
                                    Text("${PriceConverter.getFlag()}${logic.totalCredit}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.whiteColor(),
                                          fontSize: 15.5
                                      ),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: boxShadow()
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white,width: 2),
                                        shape: BoxShape.circle
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: const Icon(
                                      Icons.keyboard_arrow_down, color: Colors.white,)),

                                const SizedBox(width: 20,),

                                Column(
                                  children: [
                                    const Text("Expenses",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.5
                                      ),),
                                    const SizedBox(height: 5,),
                                    Text("${PriceConverter.getFlag()}${logic.totalDebit}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15.5
                                      ),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10,),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 20,),
                      Text("Transaction",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                        ),),
                    ],
                  ),

                  const SizedBox(height: 25,),

                  if(logic.model.isEmpty)...[

                    const NotFound(isExpand: false,message: "Opp!s No Transaction",iconData: Icons.wallet_rounded,),

                  ]else...[
                    ListView.builder(
                      itemCount: logic.model.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: boxShadow()
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${logic.model[index].type}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),),
                                  const SizedBox(height: 5,),
                                  Text("${logic.model[index].details}"),
                                ],
                              ),

                              Text("${PriceConverter.getFlag()}""${logic.model[index].amount}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold
                                ),)
                            ],
                          ),
                        );
                      },),

                  ]
                ],





              ],
            );
          },
        ),
      ),
    );
  }
}


class WalletHeader extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  WalletHeader({
    this.expandedHeight = 200,
  });


  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return SizedBox(
      height: expandedHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [

          SizedBox(
            height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
            child: AppBar(
                backgroundColor: appBarSize < kToolbarHeight ?  Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(0.9),
                elevation: 0.0,
                title: Opacity(
                  opacity: 1.0 - percent,
                  child: const Text("Wallet",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: kToolbarHeight,
            bottom: 0.0,
            child: Opacity(
              opacity: percent,
              child: Container(
                alignment: Alignment.center,
                child: const Padding(
                  padding: EdgeInsets.only(right: kToolbarHeight / 2 , top: kToolbarHeight , left: kToolbarHeight / 2 ,),
                  child: Column(
                    children: [

                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  String getYearOnly(String str){
    var parts = str.split('-');
    return parts[0].trim();
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
