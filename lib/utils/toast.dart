import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/theme/app_colors.dart';

class Toast {


  static void show({String? title,
    String toastMessage = "",
    bool isError = false,
    IconData? iconData,
    Color? backgroundColor}) {

    Get.snackbar(
      title??"",
      titleText: title == null ? const SizedBox() : null,
      backgroundColor: isError ? AppColors.redColor() : AppColors.primary,
      borderRadius: 5,
      barBlur: 10,
      icon: iconData != null ? Icon(iconData,color: Colors.white,) : null,
      colorText: Colors.white,
      toastMessage,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),

      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      shouldIconPulse: true,
      mainButton: TextButton(
        onPressed: () {
          Get.back(); // Snackbar ko dismiss karna hai
        },
        child: const Text(
          'Dismiss',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

  }
}
