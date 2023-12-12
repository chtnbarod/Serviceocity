import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/routes.dart';
import 'package:serviceocity/theme/app_colors.dart';
import 'package:serviceocity/widget/common_image.dart';

import '../../widget/custom_button.dart';
import 'logic.dart';

class LoginPage extends GetView<LoginLogic> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            CommonImage(
              assetPlaceholder: "assets/images/app_logo_3.png",
              height: 180,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1.5,
              radius: 0,
            ),

            const Text("Leaving You with a Peace of mind",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16
              ),),

            const SizedBox(height: 10,),

            const Text("Quality, Convenience, Affordability",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),),

            const SizedBox(height: 50,),

            // Container(
            //   decoration: BoxDecoration(
            //       border: Border.all(color: AppColors.textColor(), width: 1),
            //       borderRadius: BorderRadius.circular(5)
            //   ),
            //   margin: const EdgeInsets.symmetric(horizontal: 20),
            //   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            //   child: Row(
            //     children: [
            //       Container(
            //         //width: 100,
            //         height: 40,
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 5, vertical: 2),
            //         decoration: BoxDecoration(
            //           color: AppColors.whiteColor(),
            //           borderRadius: BorderRadius.circular(4),
            //         ),
            //         child: const Row(
            //           children: [
            //             CommonImage(
            //               assetPlaceholder: 'assets/images/india.png',
            //               width: 40,
            //             ),
            //             Padding(
            //               padding: EdgeInsets.symmetric(horizontal: 5),
            //               child: Text("+91",
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.bold
            //                 ),),
            //             )
            //           ],
            //         ),
            //       ),
            //
            //       Container(
            //         width: 1,
            //         height: 40,
            //         margin: const EdgeInsets.symmetric(horizontal: 10),
            //         padding: const EdgeInsets.symmetric(
            //             horizontal: 5, vertical: 2),
            //         decoration: const BoxDecoration(
            //             border: Border(right: BorderSide(width: 1))
            //         ),
            //       ),
            //
            //       Flexible(
            //         child: TextField(
            //           controller: controller.numberController,
            //           keyboardType: TextInputType.phone,
            //           decoration: const InputDecoration(
            //             border: InputBorder.none,
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),

            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.textColor(), width: 1),
                  borderRadius: BorderRadius.circular(5)
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor(),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: CountryListPick(
                      appBar: AppBar(
                        backgroundColor: Colors.white,
                        centerTitle: true,
                        title: const Text('Choose you Country'),
                      ),
                      theme: CountryTheme(
                        isShowFlag: true,
                        isShowTitle: false,
                        isShowCode: true,
                        isDownIcon: true,
                        showEnglishName: true,
                      ),
                      initialSelection: '+91',
                      onChanged: (CountryCode? code) {
                        controller.countryCodeController.text = code?.dialCode??"+91";
                      },
                    ),
                  ),

                  Container(
                    width: 1,
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 2),
                    decoration: const BoxDecoration(
                        border: Border(right: BorderSide(width: 1))
                    ),
                  ),

                  Flexible(
                    child: TextField(
                      controller: controller.numberController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 30,),


            GetBuilder<LoginLogic>(
              assignId: true,
              builder: (logic) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () {
                      logic.sendOTP();
                    },
                    child: CustomButton(
                      text: "Continue",
                      isLoading: logic.inProcess,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
