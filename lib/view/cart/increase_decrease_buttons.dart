import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:get/get.dart';

import '../../theme/app_colors.dart';
import 'circle_icon_button.dart';

class IncreaseDecreaseButtons extends StatelessWidget {
  final Function()? onDecrease;
  final bool? isDecrease;
  final Function()? onIncrease;
  final bool? isIncrease;
  final double buttonSize;
  final int? cartCount;

  const IncreaseDecreaseButtons({
    Key? key,
    required this.onDecrease,
    this.isDecrease = false,
    required this.onIncrease,
    this.isIncrease = false,
    this.buttonSize = 30,
    this.cartCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 0,
        maxWidth: Get.width
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary,width: 0.5),
        color: AppColors.primaryColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(5)
      ),
      padding: EdgeInsets.symmetric(horizontal: 2,vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(isDecrease ?? false)...[
            SizedBox(
                width: (buttonSize),
                height: (buttonSize),
                child: CircularProgressIndicator(strokeWidth: 1,)),
          ]else...[
            CircleIconButton(
              onTap: onDecrease,
              iconData: FlutterRemix.subtract_line,
              width: buttonSize,
            ),
          ],
          /// when i wrap Container in expanded then it is not working some time
          Container(
            // decoration: BoxDecoration(
            //     color: AppColors.primary,
            //     borderRadius: BorderRadius.all(Radius.circular(4))
            // ),
            height: (buttonSize),
            child: Center(
              child: Text("${cartCount??0}"),
            ),
          ),
          if((isIncrease ?? false))...[
            SizedBox(
                width: (buttonSize),
                height: (buttonSize),
                child: CircularProgressIndicator(strokeWidth: 1,)),
          ]else...[
            CircleIconButton(
              onTap: onIncrease,
              iconData: FlutterRemix.add_line,
              width: buttonSize,
            ),
          ],
        ],
      ),
    );
  }
}