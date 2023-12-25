import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serviceocity/core/di/api_client.dart';
import 'package:serviceocity/utils/date_converter.dart';
import 'package:serviceocity/view/order_detail/logic.dart';
import 'package:serviceocity/view/time_slots/logic.dart';

import '../../core/di/api_provider.dart';
import '../../model/TimeslotsModel.dart';
import '../../theme/app_colors.dart';
import '../../utils/toast.dart';
import '../../widget/custom_button.dart';
import '../../widget/not_found.dart';

// RescheduleReason
// CancelReason
class Reschedule extends StatefulWidget {
  final String? orderId;
  final String? categoryId;
  final Function(String date,String time)? callback;
  const Reschedule({super.key, this.orderId, this.categoryId,this.callback});

  @override
  State<Reschedule> createState() => _RescheduleState();
}

class _RescheduleState extends State<Reschedule> {

  List<TimeslotsModel> list = [];
  bool inProcess = false;
  bool slotNotFound = false;

  @override
  void initState() {
    super.initState();
    getTimeSlot();
  }

  String? selectedDate;
  String? selectedTime;
  getTimeSlot() async{
    list.clear();
    selectedTime = null;
    inProcess = true;
    slotNotFound = false;
    setState(() {});
    await Get.find<ApiClient>().getAPI("${ApiProvider.getTimeslots}?category_id=${widget.categoryId}&selected_date=${getDate(selectedDate: selectedDate)}").then((value) => {
      if(value.statusCode == 200){
        value.body.forEach((v) {
          selectedDate ??= v['days'][0]['date'];
          list.add(TimeslotsModel.fromJson(v));
        }),
      }else if(value.statusCode == 404){
        slotNotFound = true
      }
    }).whenComplete(() => setState(() {
        inProcess = false;
      })
    );
  }

  bool validate(){

    if(selectedDate == null){
      Toast.show(toastMessage: "Please Select Date",isError: true);
      return false;
    }

    if(selectedTime == null){
      Toast.show(toastMessage: "Please Select Time",isError: true);
      return false;
    }
    return true;
  }

  bool isProceed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 50),

          if(inProcess)...[
            Container(
              height: 3,
              margin: const EdgeInsets.only(bottom: 10),
              child: const LinearProgressIndicator(),
            ),
          ],

          if(list.isNotEmpty)
            SizedBox(
              height: 70,
              child: ListView.builder(
                itemCount: list[0].days?.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  DateTime? dateTime = (list[0].days?[index].date??"").toDateTime();
                  bool isSelected = selectedDate == (list[0].days?[index].date??"");
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                      onTap: (){
                        selectedDate = list[0].days?[index].date;
                        getTimeSlot();
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

                            Text("${list[0].days?[index].dayName}"),

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

          if(slotNotFound)...[
            const SizedBox(height: 20,),
            const NotFound(isExpand: false,message: "Opp! time slot not available",iconData: Icons.access_alarm_outlined,)
          ],

          if(list.isNotEmpty)...[

            const SizedBox(height: 30,),

            if(list[0].tslot?.isNotEmpty??false)
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text("Select start time of service",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),),
              ),


            GridView.builder(
              itemCount: list[0].tslot?.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 2
              ),
              itemBuilder: (context, index) {
                bool isSelected =  selectedTime == (list[0].tslot?[index]??"");
                return InkWell(
                  onTap: (){
                    selectedTime = list[0].tslot?[index];
                    setState(() {});
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

                        Text((list[0].tslot?[index]??""),
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
                if(!validate()) return;
                // if(widget.callback != null){
                //   widget.callback!(selectedDate??"",selectedTime??"");
                // }
                setState(() {
                  isProceed = true;
                });
                Get.find<OrderDetailLogic>().reschedule(selectedDate??"",selectedTime??"").whenComplete(() => Get.back()
                );
              },
              isLoading: isProceed,
            ),

            const SizedBox(height: 15,),
          ],
        ],
      ),
    );
  }
}
