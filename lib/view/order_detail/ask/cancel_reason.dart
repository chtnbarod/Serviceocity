import 'package:flutter/material.dart';
import 'package:serviceocity/utils/assets.dart';
import 'package:serviceocity/widget/custom_button.dart';

class CancelReason extends StatefulWidget {
  final Function(String text)? callback;
  const CancelReason({super.key, this.callback});

  @override
  State<CancelReason> createState() => _CancelReasonState();
}

class _CancelReasonState extends State<CancelReason> {
  final List<String> reasons = [
    "Booking address is incorrect",
    "Service no longer required",
    "Placed the request by mistake",
    "Hired someone else outside $appName",
    "Professional not assigned"
  ];

  int? selectReason;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
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

          Text("Cancellation Reason",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold
          ),),

          SizedBox(height: 15,),

          for(int i = 0; i < reasons.length ; i++)...[
            Row(
              children: [
                Checkbox(value: selectReason == i,
                    shape: const CircleBorder(),
                    onChanged: (bool? isCheck){
                  if(isCheck??false){
                    setState(() {
                      selectReason = i;
                    });
                  }
                }),
                Text(reasons[i]),
              ],
            )
          ],

          const SizedBox(height: 20,),

          CustomButton(
            text: "Cancel Booking",
            isEnable: selectReason != null,
            onTap: (){
              if(widget.callback != null && selectReason != null){
                widget.callback!(reasons[selectReason!]);
              }
            },
          )

        ],
      ),
    );
  }
}
