import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_viewer_elite/html_viewer_elite.dart';
import 'package:serviceocity/view/about/about_us.dart';

import '../home/logic.dart';

class RefundPolicy extends StatelessWidget {
  const RefundPolicy({Key? key});



  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeLogic>(
      assignId: true,
      builder: (logic) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Cancellation policy",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Html(
              data: logic.settingModel?.refundPolicy??"",
            ),

            InkWell(
              onTap: () {
                Get.to(AboutUs(data: logic.settingModel?.refundPolicy,title: "Cancellation policy",));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                child: Text(
                  "Learn more",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
