import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';

class MenuItem extends StatelessWidget {
  final String? title;
  final Function()? onClick;
  final IconData? icon;
  final Widget? rightWidget;
  final bool hideRightWidget;
  final bool isLast;
  final bool isWarning;
  final double hPadding;
  final bool enable;
  final bool isSmall;

  const MenuItem({
    Key? key,
    this.title,
    this.onClick,
    this.icon,
    this.rightWidget,
    this.hPadding = 0.0,
    this.isLast = false,
    this.hideRightWidget = false,
    this.enable = true,
    this.isWarning = false,
    this.isSmall = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enable ? onClick : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20,),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 20,),
              Icon(
                icon,
                size: 20
              ),
              const SizedBox(width: 20,),
              Flexible(
                child: Text(
                  title??"",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.iconColor(),
                  ),
                ),
              ),
              SizedBox(width: 20,),
            ],
          ),

          SizedBox(height: 20,),
          if (!isLast)
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.grayColor().withOpacity(0.3),
            ),
        ],
      ),
    );
  }
}
