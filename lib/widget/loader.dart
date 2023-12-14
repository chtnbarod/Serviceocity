import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (Get.height*0.55)+kToolbarHeight,
      alignment: Alignment.center,
      child: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
              strokeWidth: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
