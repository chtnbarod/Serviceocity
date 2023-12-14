import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/theme/app_colors.dart';
import 'package:serviceocity/utils/price_converter.dart';

import 'logic.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              color: AppColors.primary
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    Get.back();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.arrow_back
                    ,color: Colors.white,),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Wallet Amount",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12
                    ),),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(PriceConverter.getFlag(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13
                        ),),
                        const SizedBox(width: 2,),
                        const Text("1050",
                          style: TextStyle(
                              fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          Positioned(
            top: 130,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
              ),
              height: Get.height,
              width: Get.width,
              child: const Column(
                children: [

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
