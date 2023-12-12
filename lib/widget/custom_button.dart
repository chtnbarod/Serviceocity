import 'package:flutter/material.dart';
import 'package:serviceocity/theme/app_colors.dart';


class CustomButton extends StatelessWidget {
  final Color? color;
  final String? text;
  final Widget? label;
  final IconData? iconData;
  final double? horizontalPadding;
  final bool isLoading;
  final bool isEnable;
  final Function()? onTap;
  final double? fontSize;
  final double? borderRadius;
  final Color? fontColor;
  final FontWeight? fontWeight;
  final double height;

  const CustomButton({
    Key? key,
    this.height = 50,
    this.color,
    this.text,
    this.label,
    this.iconData,
    this.horizontalPadding,
    this.isEnable = true,
    this.isLoading = false,
    this.onTap,
    this.fontSize,
    this.borderRadius,
    this.fontColor,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDisable = (isLoading || !isEnable);
    Color btnColor = !isDisable ? (color ?? AppColors.primary) : (color ?? AppColors.primary.withOpacity(0.3));
    return Material(
      borderRadius: BorderRadius.circular((borderRadius ?? 5)),
      color: btnColor,
      child: InkWell(
        borderRadius: BorderRadius.circular((borderRadius ?? 5)),
        onTap: (isLoading || !isEnable) ? null : onTap,
        child: Container(
          height: (height),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular((borderRadius ?? 5)),
          ),
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 15),
          child: Stack(
            alignment: Alignment.center,
            children: [

              Opacity(
                opacity: isLoading ? 0 : 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(label != null)...[
                      label!
                    ]else...[
                      if(iconData != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Icon(iconData!,size: 20,color: fontColor ?? AppColors.iconColor()),
                        ),
                      const SizedBox(width: 5,),
                      Text(text ?? "Click Now",
                        style: TextStyle(
                          color: fontColor ?? Colors.white,
                          fontSize: (fontSize ?? 14),
                          letterSpacing: -0.4,
                          fontWeight: fontWeight ?? FontWeight.w400,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              //
              if(isLoading)...[
                const SizedBox(
                 height: 24,
                 width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}