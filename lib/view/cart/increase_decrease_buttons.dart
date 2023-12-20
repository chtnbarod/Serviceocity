import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../theme/app_colors.dart';
import 'circle_icon_button.dart';

class IncreaseDecreaseButtons extends StatelessWidget {
  final Function()? onDecrease;
  final Function()? onIncrease;
  final Function()? onAddToCart;
  final bool? isAddToCart;
  final bool? isDecrease;
  final bool? isIncrease;
  final double buttonSize;
  final int? cartCount;

  const IncreaseDecreaseButtons({
    Key? key,
    this.onDecrease,
    this.onAddToCart,
    this.onIncrease,
    this.isDecrease = false,
    this.isAddToCart = false,
    this.isIncrease = false,
    this.buttonSize = 30,
    this.cartCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: buttonSize,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary,width: 0.5),
        color: AppColors.primaryColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(10)
      ),
      padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          if(cartCount==0)...[
            if(isAddToCart ?? false)...[
              SizedBox(
                  width: (buttonSize),
                  height: (buttonSize),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: (buttonSize/1.5),
                          height: (buttonSize/1.5),
                          child: const CircularProgressIndicator(strokeWidth: 1,color: AppColors.primary,)),
                    ],
                  )),
            ]else...[
              const Text("Add",
                style: TextStyle(
                    color: AppColors.primary
                ),),

            ]
          ]else...[
            if(isDecrease ?? false)...[
              SizedBox(
                  width: (buttonSize),
                  height: (buttonSize),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: (buttonSize/1.5),
                          height: (buttonSize/1.5),
                          child: const CircularProgressIndicator(strokeWidth: 1,color: AppColors.primary,)),
                    ],
                  )),
            ]else...[
              CircleIconButton(
                onTap: onDecrease,
                iconData: FlutterRemix.subtract_line,
                buttonSize: buttonSize,
              ),
            ],
            const Spacer(),
            SizedBox(
              height: (buttonSize),
              child: Center(
                child: Text("${cartCount??0}",
                  style: const TextStyle(
                      color: AppColors.primary
                  ),),
              ),
            ),
            const Spacer(),
            if((isIncrease ?? false))...[
              SizedBox(
                  width: (buttonSize),
                  height: (buttonSize),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: (buttonSize/1.5),
                          height: (buttonSize/1.5),
                          child: const CircularProgressIndicator(strokeWidth: 1,color: AppColors.primary,)),
                    ],
                  )),
            ]else...[
              CircleIconButton(
                onTap: onIncrease,
                iconData: FlutterRemix.add_line,
                buttonSize: buttonSize,
              ),
            ],
          ],
        ],
      ),
    );
  }
}
