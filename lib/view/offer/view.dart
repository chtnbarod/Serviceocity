import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/widget/common_image.dart';
import 'package:serviceocity/widget/not_found.dart';

import '../../utils/price_converter.dart';
import '../../widget/loader.dart';
import 'logic.dart';

class OfferPage extends StatelessWidget {
  final Function(dynamic json)? callback;
  const OfferPage({super.key,this.callback});

  @override
  Widget build(BuildContext context) {
    Get.find<OfferLogic>().getOffer();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Offer"),
        centerTitle: true,
      ),
      body: GetBuilder<OfferLogic>(
        assignId: true,
        builder: (logic) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              if(logic.inProcess)...[
                const Loader(),
              ]else...[
                if(logic.discounts.isEmpty)...[
                  const NotFound(message: "Offer Not Available",)
                ]else...[
                  ListView.builder(
                    itemCount: logic.discounts.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5,color: Colors.black26),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(
                                children: [

                                  CommonImage(
                                    height: 50,
                                    width: 50,
                                    radius: 10,
                                    imageUrl: "${ApiProvider.url}/${logic.discounts[index].banner}",
                                  ),

                                  const SizedBox(width: 20,),

                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        if(logic.discounts[index].type == "amount")
                                          Text("Cashback up to ${PriceConverter.getFlag()}${logic.discounts[index].amount??""}",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17
                                            ),),

                                        if(logic.discounts[index].type == "percent")
                                          Text("Cashback up to ${PriceConverter.getFlag()}${logic.discounts[index].percent??""}%",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17
                                            ),),

                                        Text(logic.discounts[index].code??"",
                                          style: const TextStyle(
                                              fontSize: 14
                                          ),),

                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                ],
                              ),
                            ),

                            InkWell(
                              onTap: logic.isApplyIndex == index ? null : (){
                                logic.applyCoupon(index).then((value) => {
                                  if(value){
                                    if(callback != null){
                                      callback!({
                                        "id" : logic.discounts[index].id,
                                        "amount" : logic.discounts[index].amount,
                                        "percent" : logic.discounts[index].percent,
                                        "type" : logic.discounts[index].type,
                                        "code" : logic.discounts[index].code
                                      }),
                                      Get.back(),
                                    }
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0.5,color:  Colors.blue),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                                child:

                                logic.isApplyIndex == index ?
                                    const CircularProgressIndicator() :
                                const Text("Apply",
                                  style: TextStyle(
                                      color: Colors.blue
                                  ),),
                              ),
                            )
                          ],
                        ),
                      );
                    },)
                ],
              ]
            ],
          );
        },
      ),
    );
  }
}
