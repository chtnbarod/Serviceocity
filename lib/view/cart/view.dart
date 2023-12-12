import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/utils/date_converter.dart';
import 'package:serviceocity/utils/price_converter.dart';
import 'package:serviceocity/widget/common_image.dart';
import 'package:serviceocity/widget/custom_button.dart';

import '../../core/routes.dart';
import '../../theme/app_colors.dart';
import 'increase_decrease_buttons.dart';
import 'logic.dart';

List<BoxShadow>? boxShadow({ Color? color, double? blurRadius,Offset? offset }){
  return [
    BoxShadow(
      color: color ?? Colors.grey.shade300,
      blurRadius: blurRadius ?? 4,
      // Shadow position
      offset: offset ?? const Offset(2, 4),
    ),
  ];
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<CartLogic>().getCart();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: GetBuilder<CartLogic>(
        assignId: true,
        builder: (logic) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [


                if(logic.cartModels.isEmpty)...[
                  const SizedBox(height: 80,),
                  if(logic.cartInProgress)...[
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(strokeWidth: 2,),
                      ],
                    )
                  ]else...[
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Your Cart Empty"),
                      ],
                    )
                  ],
                ]else...[
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: logic.cartModels.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.whiteColor(),
                          boxShadow: boxShadow(),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text((logic.cartModels[index].name??"").toCapitalizeFirstLetter(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22
                                      ),),
                                    Row(
                                      children: [


                                        const Text("1 Service"),
                                        const SizedBox(width: 4,),
                                        Container(
                                          width: 5,
                                          height: 5,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black26,
                                          ),
                                        ),
                                        const SizedBox(width: 4,),
                                        Text(
                                            PriceConverter.salePrice2(price: logic.cartModels[index].price,
                                                salePrice: logic.cartModels[index].salePrice)),

                                      ],
                                    ),
                                  ],
                                ),

                                Stack(
                                  children: [
                                    CommonImage(
                                      height: 70,
                                      width: 70,
                                      imageUrl: "${ApiProvider.url}/${logic.cartModels[index].image?[0]??""}",
                                    ),

                                    Positioned(
                                        top: 0,
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: logic.deletingIndex == index ? null : (){
                                                logic.deleteCart(index);
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.red.withOpacity(0.5),
                                                    shape: BoxShape.circle
                                                  ),
                                                  height: 30,
                                                  width: 30,
                                                  child:
                                                  logic.deletingIndex == index ?
                                                      const CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        color: Colors.white,
                                                      ) :
                                                  const Icon(Icons.delete,color: Colors.white,size: 20,)),
                                            ),
                                          ],
                                        ))
                                  ],
                                )
                              ],
                            ),

                            const SizedBox(height: 20,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: IncreaseDecreaseButtons(
                                    cartCount: int.tryParse(logic.cartModels[index].quantity??"0"),
                                    isIncrease: logic.increaseIndex == index,
                                    isDecrease: logic.decreaseIndex == index,
                                    onIncrease: (){
                                      logic.cartIncrease(serviceId: logic.cartModels[index].cartId.toString(),
                                          index: index,
                                          quantity: int.tryParse(logic.cartModels[index].quantity??"1")??1);
                                    },
                                    onDecrease: (){
                                      logic.cartDecrease(serviceId: logic.cartModels[index].cartId.toString(),
                                          index: index,
                                          quantity: int.tryParse(logic.cartModels[index].quantity??"1")??1);
                                    },
                                  ),
                                ),

                                SizedBox(width: Get.width*0.2,),

                                Flexible(
                                  child: CustomButton(
                                    text: "Checkout",
                                    height: 40,
                                    borderRadius: 10,
                                    onTap: (){

                                      Get.toNamed(rsCheckoutPage,arguments: { "cart" : logic.cartModels[index].toJson() });
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
