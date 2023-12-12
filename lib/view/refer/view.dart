import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/theme/app_colors.dart';
import 'package:serviceocity/utils/assets.dart';
import 'package:serviceocity/utils/price_converter.dart';
import 'package:serviceocity/view/account/logic.dart';
import 'package:serviceocity/widget/common_image.dart';
import 'package:serviceocity/widget/custom_button.dart';

import '../../utils/circular_border.dart';
import 'logic.dart';

class ReferPage extends StatelessWidget {
  const ReferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<AccountLogic>(
          assignId: true,
          builder: (logic) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  height: 250,
                  decoration: const BoxDecoration(
                      color: AppColors.primary
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 20),
                  child: Column(
                    children: [

                      SizedBox(height: MediaQuery.of(context).padding.top,),

                      Row(
                        children: [
                          InkWell(
                              onTap: (){
                                Get.back();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_back, color: Colors.white,),
                              )),
                        ],
                      ),


                      CommonImage(
                        height: 70,
                        width: 70,
                        radius: 35,
                        imageUrl: "${ApiProvider.url}/" + (logic.userModel?.image??""),
                      ),

                      const SizedBox(height: 15,),

                      Text("Refer now an earn up to ${PriceConverter
                          .getFlag()}500",
                        style: TextStyle(
                            color: AppColors.whiteColor(),
                            fontWeight: FontWeight.bold
                        ),),

                      const SizedBox(height: 5,),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          "send a referral link to friend via whatsapp/facebook or email",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.whiteColor().withOpacity(0.8),
                            fontSize: 12, fontWeight: FontWeight.w300,
                          ),),
                      ),


                    ],
                  ),
                ),

                SizedBox(height: 30,),

                const Text("Referral code",
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),),

                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          border: DashedBorder.fromBorderSide(
                              dashLength: 5, side: BorderSide(
                              color: Colors.black, width: 1)),
                          color: AppColors.appBackground
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: const Center(
                        child: Text(
                          'SHD55G',
                        ),
                      ),
                    ),
                  ],
                ),


                SizedBox(height: 50,),

                const Text("How it work?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),),

                SizedBox(height: 15,),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Icon(Icons.join_full),
                      SizedBox(width: 15,),

                      Flexible(
                        child: Text(
                          "Invite your friend to resister on $appName",
                          style: TextStyle(
                          ),),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Icon(Icons.phone_android),
                      SizedBox(width: 15,),

                      Flexible(
                        child: Text(
                          "When your Friend resister on $appName, both of you get worth ${PriceConverter
                              .getFlag()}500",
                          style: TextStyle(
                          ),),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15, horizontal: 20),
                  child: CustomButton(
                    text: "reffer now".toUpperCase(),
                  ),
                )

              ],
            );
          },
        ),
      ),
    );
  }
}
