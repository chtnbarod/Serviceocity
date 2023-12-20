import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/routes.dart';
import 'package:serviceocity/theme/app_colors.dart';
import 'package:serviceocity/utils/date_converter.dart';
import 'package:serviceocity/utils/price_converter.dart';
import 'package:serviceocity/view/order_detail/logic.dart';
import 'package:serviceocity/view/time_slots/logic.dart';
import 'package:serviceocity/widget/common_image.dart';
import 'package:serviceocity/widget/loader.dart';
import 'package:serviceocity/widget/not_found.dart';

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
                        const Row(
                          children: [
                            Icon(Icons.calendar_month, color: AppColors.primary,),
                            SizedBox(width: 10,),
                            Text("Booking Accepted",
                              style: TextStyle(
                                  fontSize: 15
                              ),),
                          ],
                        ),

                        const SizedBox(height: 50,),

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
                                  "${logic.orders[0].date ?? ""}At${logic.orders[0].time ?? ""}",
                                  style: const TextStyle(
                                      fontSize: 12
                                  ),))

                              ],
                            ),
                          ],
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

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const SizedBox(height: 30,),

                            Container(
                              height: 5,
                              color: Colors.grey.withOpacity(0.1),
                              margin: const EdgeInsets.symmetric(vertical: 10),
                            ),

                            const SizedBox(height: 10,),

                            const Text("Cancellation policy",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                              ),),

                            const SizedBox(height: 5,),

                            const Text(
                              "Free cancellation if done more than 3 hrs before the service or if professional isn`t not assigned. A fee will be changed otherwise",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13,
                                  color: Colors.black54
                              ),),

                            const SizedBox(height: 10,),

                            const Text("Learn more",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline
                              ),),
                          ],
                        )
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
