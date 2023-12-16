import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildBottomSheet({required Widget child}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [

      Material( // Wrap InkWell with Material
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              height: 34,
              width: 34,
              margin: const EdgeInsets.only(bottom: 15,right: 15),
              child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.close)),
            ),
          ],
        ),
      ),
      child,
    ],
  );
}