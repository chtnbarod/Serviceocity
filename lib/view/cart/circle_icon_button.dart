import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class CircleIconButton extends StatelessWidget {
  final double? width;
  final IconData iconData;
  final Function()? onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final double elevation;
  final int? badgeCount;
  final bool? isLoading;

  const CircleIconButton({
    Key? key,
    this.width,
    required this.onTap,
    required this.iconData,
    this.backgroundColor,
    this.iconColor,
    this.elevation = 0,
    this.badgeCount,
    this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(((width ?? 40) / 2)),
      elevation: elevation,
      child: InkWell(
        borderRadius: BorderRadius.circular(((width ?? 40) / 2)),
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: (width ?? 30),
          height: (width ?? 30),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              (isLoading ?? false)
                  ? Center(
                child: SizedBox(
                  width: ((width ?? 40) / 3),
                  height: ((width ?? 40) / 3),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primaryColor(),
                  ),
                ),
              )
                  : badgeCount != null
                  ? Container(
                width: (width ?? 40),
                height: (width ?? 40),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor(),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$badgeCount',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppColors.whiteColor(),
                    letterSpacing: -0.4,
                  ),
                ),
              )
                  : Icon(
                iconData,
                size: ((width ?? 40) / 2),
                color:
                iconColor ?? AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
