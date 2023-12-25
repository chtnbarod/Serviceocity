import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/theme/app_colors.dart';
import 'package:serviceocity/widget/common_image.dart';

import '../../utils/assets.dart';
import 'logic.dart';

class SplashPage extends GetView<SplashLogic> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.checkLogin();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


            const SizedBox(height: 30,),


            CommonImage(
              assetPlaceholder: "assets/images/spalsh.png",
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.8,
            ),


            const Padding(
              padding: EdgeInsets.only(bottom: 70),
              child: Text("Trusted by countless Homeowners",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 15
              ),),
            ),

          ],
        ),
      ),
    );
  }
}
