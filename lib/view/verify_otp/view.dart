import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/theme/app_colors.dart';
import 'package:serviceocity/view/verify_otp/logic.dart';
import 'package:serviceocity/view/verify_otp/otp_view.dart';
import 'package:serviceocity/widget/common_image.dart';
import 'package:serviceocity/widget/custom_button.dart';
import 'package:telephony/telephony.dart';

import '../../main.dart';
import '../../utils/toast.dart';


class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {



  @override
  void initState() {
    super.initState();
    Get.find<VerifyOtpLogic>().initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const SizedBox(height: 100,),

              CommonImage(
                assetPlaceholder: "assets/images/app_logo_3.png",
                height: 180,
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.5,
                radius: 0,
              ),

              const Text("OTP Verification",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                ),),

              const SizedBox(height: 10,),

              GetBuilder<VerifyOtpLogic>(
                assignId: true,
                builder: (logic) {
                  return Text("We sent otp on your number ${logic.phone ?? ""}",
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),);
                },
              ),

              const SizedBox(height: 50,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GetBuilder<VerifyOtpLogic>(
                  assignId: true,
                  builder: (logic) {
                    return Column(
                      children: [
                        OtpView(
                          key: logic.otpKey,
                          otpCallBack: (s) {
                            logic.otpString = s;
                          },
                        ),

                        Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              if(logic.time.value > 0)
                                Text(logic.getTime(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),),

                              TextButton(onPressed: (logic.resentOtpProgress ||
                                  logic.time.value > 0)
                                  ? null
                                  : () {
                                logic.reSendOTP();
                              }, child: const Text("Resend OTP",
                                style: TextStyle(
                                    fontSize: 14
                                ),),
                              ),

                              if(logic.resentOtpProgress)
                                const SizedBox(
                                  height: 14,
                                  width: 14,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,),
                                ),
                            ],
                          );
                        })
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 30,),

              GetBuilder<VerifyOtpLogic>(
                assignId: true,
                builder: (logic) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        logic.verifyOtp();
                      },
                      child: CustomButton(
                        text: "Verify",
                        isLoading: logic.inProcess,
                      ),
                    ),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
