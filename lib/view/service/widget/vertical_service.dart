import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_provider.dart';
import 'package:serviceocity/model/ServiceModel.dart';
import 'package:serviceocity/theme/app_colors.dart';
import 'package:serviceocity/utils/date_converter.dart';
import 'package:serviceocity/utils/price_converter.dart';
import 'package:serviceocity/widget/bottom_sheet.dart';

import '../../../core/routes.dart';
import '../../../widget/common_image.dart';
import 'addons_service.dart';

class VerticalService extends StatelessWidget {
  final ServiceModel? serviceModel;
  const VerticalService({super.key,this.serviceModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed(rsServiceDetailPage,arguments: { 'id' : serviceModel?.id });
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CommonImage(
                    width: 50,
                    height: 80,
                    imageUrl: "${ApiProvider.url}/${serviceModel?.image?[0]}",
                  ),

                  const SizedBox(width: 10,),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("4.5",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold
                                  ),),
                                SizedBox(width: 5,),
                                Icon(Icons.star,color: Colors.green,size: 15,)
                              ],
                            ),
                          ],
                        ),

                        Flexible(
                          child: Text((serviceModel?.name??"").toCapitalizeFirstLetter(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 10
                            ),),
                        ),

                        const SizedBox(height: 4,),

                        Row(
                          children: [
                            Flexible(
                              child: Text("Start From ${PriceConverter.salePrice2(
                                price: serviceModel?.price,
                                salePrice: serviceModel?.salePrice
                              )}",
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10
                                ),),
                            ),
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
                            const Icon(Icons.timelapse,color: Colors.green,size: 12,),
                            const SizedBox(width: 5,),
                            Text("${serviceModel?.time}".toMinToHM(),
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  //decoration: TextDecoration.lineThrough
                              ),),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

           if(serviceModel?.addons?.isNotEmpty??false)
            InkWell(
              onTap: () {
                Get.bottomSheet(
                  buildBottomSheet(child: AddonsService(list: serviceModel?.addons)),
                  enableDrag: true,
                  isScrollControlled: true,
                  barrierColor: Colors.black38,
                  isDismissible: false,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffDDDDDD),
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                      offset: Offset(0.0, 0.0),
                    )
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                margin: const EdgeInsets.only(right: 10),
                child: const Text("Select",
                style: TextStyle(
                  color: AppColors.primary
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
