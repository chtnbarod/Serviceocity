import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:serviceocity/theme/app_colors.dart';

import '../../../widget/custom_button.dart';

class ReschedulingReason{
  final IconData iconData;
  final String title;
  final String message;
  ReschedulingReason({required this.iconData,required this.title,required this.message});
}

class RescheduleReason extends StatefulWidget {
  final Function(bool toProceed)? callback;
  const RescheduleReason({super.key, this.callback});

  @override
  State<RescheduleReason> createState() => _RescheduleReasonState();
}

class _RescheduleReasonState extends State<RescheduleReason> {
  final List<ReschedulingReason> reschedulingReason = [
    ReschedulingReason(iconData: Icons.checklist,title: "Tool & expertise",message: "Expert therapists who bring beds and curated oils"),
    ReschedulingReason(iconData: Icons.repeat,title: "Flexibility",message: "Easily reschedule,cancel and repeat with same profession"),
  ];

  int? selectReason;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text("You`ll miss out benefits, consider rescheduling instead Reason",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold
            ),),

          const SizedBox(height: 20,),

          for(int i = 0; i < reschedulingReason.length ; i++)...[
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey,width: 0.7))
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(reschedulingReason[i].iconData),
                  const SizedBox(width: 10,),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(reschedulingReason[i].title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),),
                        const SizedBox(height: 5,),
                        Text(reschedulingReason[i].message,
                        style: const TextStyle(
                          color: Colors.black54
                        ),),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],

          const SizedBox(height: 30,),

          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){
                    if(widget.callback != null){
                      widget.callback!(false);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    height: 50,
                    child: Center(child: Text("Proceed to cancel",
                    style: TextStyle(
                      color: AppColors.redColor()
                    ),)),
                  ),
                ),
              ),
              const SizedBox(width: 20,),
              Expanded(
                child: CustomButton(
                  text: "Reschedule",
                  height: 50,
                  onTap: (){
                    if(widget.callback != null){
                      widget.callback!(true);
                    }
                  },
                ),
              ),
            ],
          )

        ],
      ),
    );
  }

}
