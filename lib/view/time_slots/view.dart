import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/theme/app_colors.dart';
import 'package:serviceocity/utils/toast.dart';

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
        centerTitle: true,
      ),
      body: GetBuilder<TimeSlotsLogic>(
        assignId: true,
        builder: (logic) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 10,),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: (){
                      Get.to(SelectAddressPage(
                        callback: (dynamic json){
                          logic.setAddress(json: json);
                          // print("DDDDSSSS  $json");
                        },
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [

                            const Icon(Icons.home, color: Colors.deepPurple,),
                            SizedBox(width: 20,),
                            Text(logic.address?.address1 ??  "Select Address",
                              style: TextStyle(
                                  fontWeight: logic.address?.address1 != null ? FontWeight.bold : null
                              ),)

                          ],
                        ),

                        Icon(Icons.arrow_forward_ios, color: Colors.deepPurple,)
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10,),

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

                Flexible(
                  child: Container(
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
                    List<String> parts = (logic.list[0].days?[index]??"").split(' ');
                    bool isSelected = logic.selectedDate == (logic.list[0].days?[index]??"");
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: (){
                          logic.selectedDate = logic.list[0].days?[index];
                          logic.getTimeSlot();
                        },
                        child: Container(
                          width: 50,
                          height: 70,
                          decoration: BoxDecoration(
                              border: Border.all(width: isSelected ? 0.8 : 0.3,color: isSelected ? Colors.blue : Colors.black26),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [


                             if(parts.isNotEmpty)
                              Text(parts[0]??''),

                              const SizedBox(height: 5,),
                             if(parts.length > 1)
                              Text(parts[1]??'',
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


                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    itemCount: logic.list[0].tslot?.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      bool isSelected =  logic.selectedTime == (logic.list[0].tslot?[index]??"");
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: (){
                            logic.selectedTime = logic.list[0].tslot?[index];
                            logic.update();
                          },
                          child: Container(
                            width: 80,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(width: isSelected ? 0.8 : 0.3,color: isSelected ? Colors.blue : Colors.black26),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Text(logic.list[0].tslot?[index]??""),

                              ],
                            ),
                          ),
                        ),
                      );
                    },),
                ),

                const SizedBox(height: 15,),

                CustomButton(
                  text: "Proceed",
                  onTap: () {
                    logic.orderNow();
                  },
                ),

                const SizedBox(height: 15,),
              ],
              ],
            ),
          );
        },
      ),
    );
  }
}
