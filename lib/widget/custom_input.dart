import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomInput extends StatelessWidget {
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? textController;
  final String? hintText;
  final String? labelText;
  final int? maxLength;
  final bool obscureText;
  final bool enabled;
  final int maxLine;
  final Color? textColor;
  final Color? fillColor;
  final double horizontalPadding;
  final double borderRadius;
  final double fontSize;
  final bool border;
  final TextInputType? keyboardType;
  final Function(String string)? onTextChanged;

  const CustomInput({
    Key? key,
    this.suffixIcon,
    this.prefixIcon,
    this.textController,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.enabled = true,
    this.maxLine = 1,
    this.textColor,
    this.fillColor,
    this.maxLength,
    this.border = true,
    this.borderRadius = 10,
    this.horizontalPadding = 10.0,
    this.fontSize = 14,
    this.keyboardType,
    this.onTextChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLine,
      maxLength: maxLength,
      keyboardType: keyboardType,
      controller: textController,
      autofocus: false,
      onChanged: onTextChanged,
      obscureText: obscureText,
      enabled: enabled,
      style: TextStyle(
        fontSize: fontSize,
        color: textColor ?? AppColors.textColor(),
      ),
      decoration: InputDecoration(
        filled: fillColor != null,
        fillColor: fillColor,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: fontSize),
        labelStyle: TextStyle(fontSize: fontSize),
        labelText: labelText,
        counterText: "",
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: horizontalPadding),
        focusedBorder: !border ? null : OutlineInputBorder(
          borderSide: const BorderSide(
            //width: 1,
            color: AppColors.primaryDark,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0.5,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
