import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/model/ServiceModel.dart';
import 'package:serviceocity/utils/date_converter.dart';
import 'package:serviceocity/utils/price_converter.dart';

import '../../../core/di/api_provider.dart';
import '../../../core/routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widget/add_to_cart_button.dart';
import '../../../widget/common_image.dart';

class VerticalAddon extends StatelessWidget {
  final Addons? addons;
  final Function(dynamic json)? onUpdate;
  final Function(dynamic json)? onAddToCart;
  const VerticalAddon({super.key,this.addons,this.onAddToCart,this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: (){
            Get.back();
            Get.toNamed(rsServiceDetailPage,arguments: { 'id' : addons?.id });
          },
          child: Container(
            height: 110,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue,width: 1),
                borderRadius: BorderRadius.circular(10)
            ),
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CommonImage(
                        width: 70,
                        height: 100,
                        imageUrl: "${ApiProvider.url}/${addons?.image?[0]}",
                      ),

                      const SizedBox(width: 10,),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text("4.5",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    SizedBox(width: 5,),
                                    Icon(Icons.star,color: Colors.green,)
                                  ],
                                ),
                              ],
                            ),

                            Flexible(
                              child: Text(addons?.name??"",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10
                                ),),
                            ),

                            const SizedBox(height: 8,),

                            Row(
                              children: [
                                Text("Start From ${PriceConverter.salePrice2(
                                  price: addons?.price,
                                  salePrice: addons?.salePrice
                                )}",
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10
                                  ),),
                                // SizedBox(width: 5,),
                                // Text("\u{20B9} ${serviceModel?.price}",
                                //   style: TextStyle(
                                //       color: Colors.grey,
                                //       fontSize: 10,
                                //       decoration: TextDecoration.lineThrough
                                //   ),),
                              ],
                            ),

                            const SizedBox(height: 5,),

                            Row(
                              children: [
                                Icon(Icons.timelapse,color: Colors.green,size: 10,),
                                SizedBox(width: 5,),
                                Text("${addons?.time??""}".toMinToHM(),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                  ),),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  color: Colors.white,
                  child: AddToCartButton(
                    quantity: int.tryParse((addons?.cart?.quantity??"").toString())??0,
                    cartId: addons?.cart?.id,
                    serviceId: addons?.id,
                    onUpdate: onUpdate,
                    onAddToCart: onAddToCart,
                  ),
                )

                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(5),
                //     boxShadow: const [
                //       BoxShadow(
                //         color: Color(0xffDDDDDD),
                //         blurRadius: 6.0,
                //         spreadRadius: 2.0,
                //         offset: Offset(0.0, 0.0),
                //       )
                //     ],
                //   ),
                //   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                //   margin: const EdgeInsets.only(right: 10),
                //   child: const Text("Select",
                //     style: TextStyle(
                //         color: AppColors.primary
                //     ),),
                // )
              ],
            ),
          ),
        ),

        // Positioned(
        //   right: 0,
        //   bottom: 0,
        //   child: Container(
        //     color: Colors.white,
        //     child: AddToCartButton(
        //       quantity: int.tryParse((addons?.cart?.quantity??"").toString())??0,
        //       cartId: addons?.cart?.id,
        //       serviceId: addons?.id,
        //       onUpdate: onUpdate,
        //       onAddToCart: onAddToCart,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
