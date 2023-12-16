import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/routes.dart';
import 'package:serviceocity/theme/app_colors.dart';

class ThankYouPage extends StatelessWidget {
  const ThankYouPage({super.key});

  Future<bool> _onWillPop() async{
    Get.offAllNamed(rsBasePage);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Order Placed"),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.greenColor(),width: 5)
                  ),
                  padding: const EdgeInsets.all(2),
                  child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.greenColor(),width: 2)
                      ),
                      padding: const EdgeInsets.all(25),
                      child: Icon(Icons.thumb_up_alt,size: 40,color: AppColors.greenColor(),))),

              const SizedBox(height: 20,),

              Text("Order Successfully Placed",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.greenColor(),
                fontSize: 17,
                fontWeight: FontWeight.bold
              ),),

            ],
          ),
        ),
      ),
    );
  }
}
