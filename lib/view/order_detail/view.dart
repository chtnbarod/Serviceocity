import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/routes.dart';
import 'package:serviceocity/theme/app_colors.dart';
import 'package:serviceocity/utils/date_converter.dart';
import 'package:serviceocity/utils/price_converter.dart';
import 'package:serviceocity/view/checkout/refund_policy.dart';
import 'package:serviceocity/view/order_detail/ask/cancel_reason.dart';
import 'package:serviceocity/view/order_detail/logic.dart';
import 'package:serviceocity/view/order_detail/reschedule.dart';
import 'package:serviceocity/view/time_slots/logic.dart';
import 'package:serviceocity/widget/common_image.dart';
import 'package:serviceocity/widget/loader.dart';
import 'package:serviceocity/widget/not_found.dart';

import '../../widget/bottom_sheet.dart';
import '../booking/view.dart';
import 'ask/reschedule_reason.dart';

//
class OrderDetailPage extends StatelessWidget {
  final bool fromOrder;

  const OrderDetailPage({super.key, this.fromOrder = false});

  Future<bool> _onWillPop() async {
    if(fromOrder){
      Get.offAllNamed(rsBasePage);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Order Placed"),
      ),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: GetBuilder<OrderDetailLogic>(
          assignId: true,
          builder: (logic) {
            bool isCompleted = logic.orders.isNotEmpty && orderIsCompleted(logic.orders[0].orderStatus??"");
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    if(logic.inProcess)...[
                      const Loader()
                    ]else...[
                      if(logic.orders.isEmpty)...[
                        const NotFound()
                      ]else...[
                        Row(
                          children: [
                            if(logic.orders[0].orderStatus == "4")...[
                              Icon(Icons.close, color: AppColors.redColor(),),
                            ]else...[
                              const Icon(Icons.calendar_month, color: AppColors.primary,),
                            ],

                            const SizedBox(width: 10,),
                            Text(getOrderStatusText(logic.orders[0].orderStatus??""),
                              style: const TextStyle(
                                  fontSize: 15
                              ),),
                          ],
                        ),

                        if(logic.orders[0].orderStatus == "4")...[
                          const SizedBox(height: 20,),
                          const Text("Your Request was cancelled",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                          ),),

                          const SizedBox(height: 30,),

                          Container(
                            height: 5,
                            color: Colors.grey.withOpacity(0.1),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ],


                        if(logic.orders[0].orderStatus == "0" || logic.orders[0].orderStatus == "1")...[
                          const SizedBox(height: 30,),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text("Finding a professional",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold
                                      ),),

                                    SizedBox(height: 10,),

                                    Text(
                                      "A professional will be assigned 2 hours and 30 minutes before before the booking time.",
                                      style: TextStyle(
                                        // fontSize: 13,
                                        // fontWeight: FontWeight.bold
                                          color: Colors.grey
                                      ),),
                                  ],
                                ),
                              ),

                              Expanded(
                                  flex: 3,
                                  child: Icon(
                                    Icons.manage_search, color: AppColors.primary,
                                    size: 40,))
                            ],
                          ),
                        ],


                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30,),

                            const Text("Booking Details",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                              ),),

                            const SizedBox(height: 20,),

                            Row(
                              children: [

                                const Icon(Icons.location_on_outlined, size: 15,),
                                const SizedBox(width: 20,),

                                Flexible(child: Text(logic.orders[0].userAddress ?? "",
                                  style: const TextStyle(
                                      fontSize: 12
                                  ),))

                              ],
                            ),

                            const SizedBox(height: 20,),

                            Row(
                              children: [

                                const Icon(Icons.access_time, size: 15,),
                                const SizedBox(width: 20,),

                                Flexible(child: Text(
                                  "${logic.orders[0].date ?? ""} At ${logic.orders[0].time ?? ""}",
                                  style: const TextStyle(
                                      fontSize: 12
                                  ),))

                              ],
                            ),
                          ],
                        ),


                       if(!isCompleted)
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: (){
                                    Get.bottomSheet(
                                      buildBottomSheet(
                                        child: RescheduleReason(
                                          callback: (toProceed){
                                            Get.back();
                                            if(toProceed){
                                              Get.bottomSheet(
                                                buildBottomSheet(
                                                  child: Reschedule(
                                                    orderId: logic.orderId,
                                                    categoryId: logic.orders.isEmpty ? null : logic.orders[0].categoryId,
                                                  ),
                                                ),
                                                enableDrag: true,
                                                isScrollControlled: true,
                                                barrierColor: Colors.black38,
                                                isDismissible: false,
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      enableDrag: true,
                                      isScrollControlled: true,
                                      barrierColor: Colors.black38,
                                      isDismissible: false,
                                    );
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black,width: 0.5),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                      child: const Center(child: Text("Reschedule"))),
                                ),
                              ),
                              const SizedBox(width: 20,),
                              Expanded(
                                child: InkWell(
                                  onTap: (){
                                    Get.bottomSheet(
                                      buildBottomSheet(
                                        child: CancelReason(
                                          callback: (reason){
                                            Get.back();
                                            logic.cancelBooking(reason);
                                          },
                                        ),
                                      ),
                                      enableDrag: true,
                                      isScrollControlled: true,
                                      barrierColor: Colors.black38,
                                      isDismissible: false,
                                    );
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.red,width: 0.5),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      height: 45,
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Center(
                                          child: logic.isCancelBooking ? const Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                height: 24,
                                                width: 24,
                                                child: CircularProgressIndicator(strokeWidth: 1,color: Colors.red,),
                                              ),
                                            ],
                                          ) :
                                      const Text("Cancel Booking",
                                      style: TextStyle(
                                        color: Colors.red
                                      ),))),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30,),

                            const Text("Order Details",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                              ),),

                            const SizedBox(height: 20,),

                            for(int i = 0;i < logic.orders.length;i++)...[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text((logic.orders[i].service?.name ?? "").toCapitalizeFirstLetter(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                          fontWeight: FontWeight.w500
                                        ),),
                                      Row(
                                        children: [
                                          Text("${PriceConverter.getFlag()}${logic.orders[i].unitCost ?? ""}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold
                                            ),),
                                          const SizedBox(width: 10,),
                                          Text("${PriceConverter.getMultiplication()} ${logic.orders[i].quantity ?? ""}",
                                            style: const TextStyle(
                                                fontSize: 14
                                            ),),
                                        ],
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 15,),
                                ],
                              ),
                            ],
                          ],
                        ),

                        const SizedBox(height: 30,),

                        Container(
                          height: 5,
                          color: Colors.grey.withOpacity(0.1),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                        ),

                        const RefundPolicy(),

                      ]
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
