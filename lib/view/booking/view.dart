import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/routes.dart';
import 'package:serviceocity/utils/date_converter.dart';
import 'package:serviceocity/view/booking/logic.dart';
import 'package:serviceocity/view/cart/view.dart';
import 'package:serviceocity/view/order_detail/binding.dart';
import 'package:serviceocity/view/order_detail/view.dart';
import 'package:serviceocity/widget/loader.dart';
import 'package:serviceocity/widget/not_found.dart';


class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Booking"),
        actions: [
          IconButton(onPressed: (){
            Get.offAllNamed(rsBasePage);
          }, icon: const Icon(Icons.home))
        ],
      ),

      body: GetBuilder<BookingLogic>(
        assignId: true,
        builder: (logic) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [

                if(logic.inProgress)...[
                  const Loader()
                ]else...[
                  if(logic.list.isEmpty)...[
                    const NotFound()
                  ]else...[

                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: logic.list.length,
                        itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: InkWell(
                            onTap: (){
                              Get.to(() => const OrderDetailPage(),binding: OrderDetailBinding(),arguments: { "order_id" : logic.list[index].orderId  });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: boxShadow(),
                                borderRadius: BorderRadius.circular(15)
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(getOrderStatusText(logic.list[index].orderStatus??""),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                          color: getOrderStatusColor((logic.list[index].orderStatus??""))
                                        ),),
                                      const SizedBox(height: 5,),
                                      Text((logic.list[index].serviceName??"").toCapitalizeFirstLetter(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                      ),),
                                      const SizedBox(height: 5,),
                                      Text(logic.list[index].categoryName??"",
                                        style: const TextStyle(
                                            color: Colors.black54
                                        ),
                                      ),
                                      // Text(
                                      //     "${(logic.list[index].??"").toDateDMMMY()} At ${logic.list[index].placeOrder?.time??""}",
                                      //   style: const TextStyle(
                                      //     color: Colors.black54
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(Icons.arrow_forward_ios,color: Colors.black54,size: 20,),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },),
                    )


                  ]
                ]
              ],
            ),
          );
        },
      ),
    );
  }
}

Color? getOrderStatusColor(String status){
  if(status == "0" || status == "1"){
    return Colors.blue;
  }
  if(status == "2"){
    return Colors.deepPurple;
  }
  if(status == "3"){
    return Colors.green;
  }
  if(status == "4"){
    return Colors.red;
  }
  return null;
}

String getOrderStatusText(String status){
  if(status == "0"){
    return "Booking Pending";
  }
  if(status == "1"){
    return "Booking In Process";
  }
  if(status == "2"){
    return "Booking accepted";
  }
  if(status == "2"){
    return "Booking Completed";
  }
  if(status == "4"){
    return "Booking cancelled";
  }
  return "";
}

bool orderIsCompleted(String status){
  if(status == "3"){
    return true;
  }
  if(status == "4"){
    return true;
  }
  return false;
}
