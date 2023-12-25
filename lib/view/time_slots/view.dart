import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/theme/app_colors.dart';
import 'package:serviceocity/utils/date_converter.dart';
import 'package:serviceocity/utils/toast.dart';
import 'package:serviceocity/view/time_slots/payment_mode.dart';
import 'package:serviceocity/widget/not_found.dart';

import '../../widget/bottom_sheet.dart';
import '../../widget/custom_button.dart';
import '../select_address/view.dart';
import 'logic.dart';

class TimeSlotsPage extends StatelessWidget {
  const TimeSlotsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Pick TimeSlots"),
      ),
      body: GetBuilder<TimeSlotsLogic>(
        assignId: true,
        builder: (logic) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  InkWell(
                    onTap: (){
                      Get.bottomSheet(
                        buildBottomSheet(
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth: Get.width,
                              maxHeight: Get.height*0.7,
                              minHeight: 0
                            ),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                )
                            ),
                            padding: const EdgeInsets.all(20),
                            child: SelectAddressPage(
                              callback: (dynamic json){
                                logic.setAddress(json: json);
                              },
                            ),
                          )
                        ),
                        enableDrag: true,
                        isScrollControlled: true,
                        barrierColor: Colors.black38,
                        isDismissible: false,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              children: [

                                Icon(
                                  (logic.address?.type??"").toUpperCase() == "HOME" ? Icons.home :
                                  Icons.location_on,
                                  color: Colors.deepPurple,),
                                const SizedBox(width: 20,),
                                Flexible(
                                  child: Text(logic.address?.address1 ??  "Select Address",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: logic.address?.address1 != null ? FontWeight.bold : null
                                    ),),
                                )

                              ],
                            ),
                          ),

                          const Icon(Icons.arrow_forward_ios, color: Colors.deepPurple,)
                        ],
                      ),
                    ),
                  ),


                  Container(
                    height: 3,
                    color: Colors.grey.withOpacity(0.1),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                  ),

                  const SizedBox(height: 10,),

                  const Text("When should the professional arrive?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                    ),),

                  const SizedBox(height: 5),

                  const Text("Your Service will take approx 5hrs",
                    style: TextStyle(
                        fontSize: 13
                    ),),

                  const SizedBox(height: 20),

                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: const EdgeInsets.all(20),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.access_alarm_outlined, color: AppColors.primary,
                          size: 35,),
                        SizedBox(width: 20,),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Get Service",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),),

                              Flexible(
                                child: Text(
                                  "Service at tha earliest available time slot",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                if(logic.inProcess)...[
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(strokeWidth: 2,),
                    ],
                  )
                ],

                if(logic.list.isNotEmpty)
                 SizedBox(
                  height: 70,
                  child: ListView.builder(
                    itemCount: logic.list[0].days?.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      DateTime? dateTime = (logic.list[0].days?[index].date??"").toDateTime();
                      bool isSelected = logic.selectedDate == (logic.list[0].days?[index].date??"");
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: (){
                            logic.selectedDate = logic.list[0].days?[index].date;
                            logic.getTimeSlot();
                          },
                          child: Container(
                            width: 50,
                            height: 70,
                            decoration: BoxDecoration(
                                border: Border.all(width: isSelected ? 1 : 0.3,color: isSelected ? AppColors.primary : Colors.black26),
                                borderRadius: BorderRadius.circular(5),
                                color: isSelected ? AppColors.primary.withOpacity(0.1) : null
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Text("${logic.list[0].days?[index].dayName}"),

                                const SizedBox(height: 5,),
                               if(dateTime != null)
                                Text("${dateTime.day??''}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                          ),
                        ),
                      );
                    },),
                ),

                if(logic.slotNotFound)...[
                  const SizedBox(height: 20,),
                  const NotFound(isExpand: false,message: "Opp! time slot not available",iconData: Icons.access_alarm_outlined,)
                ],

                if(logic.list.isNotEmpty)...[

                  const SizedBox(height: 30,),

                  if(logic.list[0].tslot?.isNotEmpty??false)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text("Select start time of service",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                      ),),
                    ),


                  GridView.builder(
                    itemCount: logic.list[0].tslot?.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                       crossAxisSpacing: 8.0,
                       mainAxisSpacing: 8.0,
                        childAspectRatio: 2
                    ),
                    itemBuilder: (context, index) {
                      bool isSelected =  logic.selectedTime == (logic.list[0].tslot?[index]??"");
                      return InkWell(
                        onTap: (){
                          logic.selectedTime = logic.list[0].tslot?[index];
                          logic.update();
                        },
                        child: Container(
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(width: isSelected ? 1 : 0.3,color: isSelected ? AppColors.primary : Colors.black26),
                              borderRadius: BorderRadius.circular(5),
                              color: isSelected ? AppColors.primary.withOpacity(0.1) : null
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text((logic.list[0].tslot?[index]??""),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,),

                            ],
                          ),
                        ),
                      );
                    },),

                  const SizedBox(height: 15,),

                  CustomButton(
                    text: "Proceed",
                    onTap: () {
                      if(!logic.validate()) return;
                      Get.bottomSheet(
                        buildBottomSheet(
                            child: Container(
                              constraints: BoxConstraints(
                                  minWidth: Get.width,
                                  maxHeight: Get.height*0.4,
                                  minHeight: 0
                              ),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  )
                              ),
                              padding: const EdgeInsets.all(20),
                              child: PaymentMode(
                                onPaymentTab: (PaymentMethod? mode){
                                  Get.back();
                                  if(mode != null){
                                    logic.orderNow(mode: mode);
                                  }
                                },
                              ),
                            )
                        ),
                        enableDrag: true,
                        isScrollControlled: true,
                        barrierColor: Colors.black38,
                        isDismissible: false,
                      );
                    },
                    isLoading: logic.orderInProcess,
                  ),

                  const SizedBox(height: 15,),
                ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
