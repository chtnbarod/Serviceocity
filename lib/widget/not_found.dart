import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotFound extends StatelessWidget {
  final String? message;
  final IconData? iconData;
  final bool isExpand;
  const NotFound({super.key,this.message,this.iconData,this.isExpand = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isExpand ? (Get.height*0.55)+kToolbarHeight : null,
      alignment: Alignment.center,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            if(iconData != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Icon(iconData,size: 35,color: Colors.black38,),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text((message ?? "Opp! Not Found"),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black54
                      ),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
