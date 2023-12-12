import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/view/signup/logic.dart';
import 'package:serviceocity/widget/custom_button.dart';
import 'package:serviceocity/widget/custom_input.dart';

import '../../theme/app_colors.dart';


class SignupPage extends GetView<SignupLogic> {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text("Share some brief to serve you batter",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400
                ),),

              SizedBox(height: 50,),

              CustomInput(
                hintText: "Enter Your Name",
                fontSize: 16,
                textController: controller.nameController,
              ),

              SizedBox(height: 20,),

              CustomInput(
                hintText: "Email Id (Optional)",
                fontSize: 16,
                textController: controller.emailController,
              ),

              SizedBox(height: 20,),

              CustomInput(
                hintText: "Reffer code (Optional)",
                fontSize: 16,
                textController: controller.refferController,
              ),

              const SizedBox(height: 20,),


              GetBuilder<SignupLogic>(
                assignId: true,
                builder: (logic) {
                  return CustomButton(
                    text: "Continue",
                    isLoading: logic.inProcess,
                    onTap: () {
                      logic.signUp();
                    },
                  );
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}
