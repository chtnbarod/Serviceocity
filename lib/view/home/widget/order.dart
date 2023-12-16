import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/model/FeatureModel.dart';
import 'package:serviceocity/utils/date_converter.dart';
import 'package:serviceocity/utils/price_converter.dart';

import '../../../core/routes.dart';
import '../../../widget/common_image.dart';

class Order extends StatelessWidget {
  final bool isNew;
  final FeatureServices? featureServices;
  const Order({super.key,this.isNew = false,this.featureServices});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed(rsServiceDetailPage,arguments: { 'id' : featureServices?.id });
      },
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width/1.7,
            height: 110,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue,width: 1),
                borderRadius: BorderRadius.circular(10)
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonImage(
                  width: 80,
                  height: 100,
                  imageUrl: "${ApiProvider.url}/${featureServices?.image?[0]??""}",
                ),

                const SizedBox(width: 15,),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
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

                          if(isNew)
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: const Text("New",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12
                              ),),
                          )
                        ],
                      ),

                      Flexible(
                        child: Text(featureServices?.name??"",
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
                          Text(PriceConverter.salePrice2(
                            price: featureServices?.price,
                            salePrice: featureServices?.salePrice
                          ),
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 10
                            ),),
                          const SizedBox(width: 5,),
                         if((double.tryParse(featureServices?.salePrice??"0")??0)>0)
                          Text("${PriceConverter.getFlag()}${featureServices?.price??""}",
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                decoration: TextDecoration.lineThrough
                            ),),
                        ],
                      ),

                      const SizedBox(height: 5,),

                      Row(
                        children: [
                          const Icon(Icons.timelapse,color: Colors.green,size: 10,),
                          const SizedBox(width: 5,),
                          Text((featureServices?.time??"").toMinToHM(),
                            style: const TextStyle(
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
          )
        ],
      ),
    );
  }
}
