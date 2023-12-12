import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData dark() => ThemeData(
  fontFamily: "Roboto",
  primaryColor: AppColors.primary,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    color: AppColors.primary,

  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: AppColors.primary,
    secondary: AppColors.primary,
  ),
);
