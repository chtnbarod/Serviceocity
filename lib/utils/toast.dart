import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Toast {


  static void show({String? title,
    String toastMessage = "",
    bool isError = false,
    IconData? iconData,
    Color? backgroundColor}) {

    Get.snackbar(
        title??"",
        titleText: title == null ? const SizedBox() : null,
        backgroundColor: isError ? Colors.red : backgroundColor ?? Colors.green,
        borderRadius: 0,
        barBlur: 10,
        icon: iconData != null ? Icon(iconData,color: Colors.white,) : null,
        colorText: Colors.white,
        toastMessage,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(0)
    );

  }
}
