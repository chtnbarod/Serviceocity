import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_viewer_elite/html_viewer_elite.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/theme/app_colors.dart';
import 'package:serviceocity/utils/date_converter.dart';
import 'package:serviceocity/utils/price_converter.dart';
import 'package:serviceocity/view/cart/increase_decrease_buttons.dart';
import 'package:serviceocity/view/cart/logic.dart';
import 'package:serviceocity/widget/common_image.dart';

import '../category/widget/addons_service.dart';
import 'logic.dart';

class ServiceDetailPage extends StatelessWidget {
  const ServiceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Service"),
        centerTitle: true,
      ),
      body: GetBuilder<ServiceDetailLogic>(
        assignId: true,
        builder: (logic) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                CommonImage(
                  height: 200,
                  width: 800,
                  imageUrl: ApiProvider.url +"/"+ (logic.serviceDetailsModel?.image?[0]??""),
                ),

                const SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(logic.serviceDetailsModel?.name??"",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),),

                    Column(
                      children: [

                        if(logic.serviceDetailsModel?.cart != null)...[
                          SizedBox(
                            width: 100,
                            child: IncreaseDecreaseButtons(
                                cartCount: int.tryParse(logic.serviceDetailsModel?.cart?.quantity??"0"),
                                onDecrease: (){
                                  logic.updateCart(isIncrease: false);
                                },
                                onIncrease: (){
                                  logic.updateCart(isIncrease: true);
                                },
                                isIncrease: logic.isIncrease,
                              isDecrease: logic.isDecrease,
                            ),
                          )
                        ]else...[
                          InkWell(
                            onTap: logic.addInCart ? null : (){
                              logic.addToCart();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: AppColors.primary,width: 1)
                              ),
                              height: 35,
                              width: 80,
                              margin: const EdgeInsets.only(right: 10),
                              alignment: Alignment.center,
                              child:
                              logic.addInCart ?
                              const Padding(
                                padding: EdgeInsets.all(2.0),
                                child: SizedBox(
                                    height: 12,
                                    width: 12,
                                    child: CircularProgressIndicator(strokeWidth: 1,)),
                              ) :
                              Text("Add",
                                style: TextStyle(
                                    color: AppColors.blackColor(),
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                          ),
                        ],

                        const SizedBox(height: 10,),

                       if(logic.serviceDetailsModel?.addons?.isNotEmpty??false)
                        InkWell(
                            onTap: () {
                              Get.bottomSheet(
                                AddonsService(list: logic.serviceDetailsModel?.addons),
                                enableDrag: true,
                                isScrollControlled: true,
                                barrierColor: Colors.transparent,
                                isDismissible: false,
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text("See Option"),
                            ))
                      ],
                    )
                  ],
                ),

                const Row(
                  children: [
                    Icon(Icons.star,size: 20,color: AppColors.primary,),
                    Text("4.8 (1.5K)"),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Row(
                      children: [
                        Text("${PriceConverter.getFlag()} ",
                        style: const TextStyle(
                          color: AppColors.primary
                        ),),
                        Text("Start @${PriceConverter.salePrice2(
                          price: logic.serviceDetailsModel?.price,
                          salePrice: logic.serviceDetailsModel?.salePrice
                        )}"),
                      ],
                    ),
                    const SizedBox(width: 10,),

                    const Icon(Icons.access_time,size: 18,color: AppColors.primary),
                    const SizedBox(width: 5,),
                    Text((logic.serviceDetailsModel?.time??"").toMinToHM()),
                  ],
                ),

                const SizedBox(height: 10,),

                Html(
                  data: logic.serviceDetailsModel?.details??"",
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
