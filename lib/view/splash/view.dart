import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            CommonImage(
              assetPlaceholder: "assets/images/spalsh.jpeg",
              width: MediaQuery.of(context).size.width/2,
            )

          ],
        ),
      ),
    );
  }
}
