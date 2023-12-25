import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/model/RecentOrderModel.dart';
import 'package:serviceocity/utils/date_converter.dart';

import '../../../core/di/api_provider.dart';
import '../../../utils/price_converter.dart';
import '../../../widget/common_image.dart';
import '../../order_detail/binding.dart';
import '../../order_detail/view.dart';

class RecentOrder extends StatelessWidget {
  final bool isNew;
  final RecentOrderModel? recentOrderModel;
  const RecentOrder({super.key,this.isNew = false,this.recentOrderModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(() => const OrderDetailPage(),binding: OrderDetailBinding(),arguments: { "order_id" : recentOrderModel?.orderId  });
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
                  imageUrl: "${ApiProvider.url}/${recentOrderModel?.image}",
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
                        child: Text(recentOrderModel?.name??"",
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
                              price: recentOrderModel?.price,
                              salePrice: recentOrderModel?.salePrice
                          ),
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 10
                            ),),
                          const SizedBox(width: 5,),
                          if((double.tryParse(recentOrderModel?.salePrice??"0")??0)>0)
                            Text("${PriceConverter.getFlag()}${recentOrderModel?.price??""}",
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
                          Text((recentOrderModel?.time??"").toMinToHM(),
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
