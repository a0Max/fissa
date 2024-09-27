import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  static getLightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: AppColor.mainColor,
      hintColor: AppColor.yellowColor,
      fontFamily: "IBMPlexSans",
      colorScheme: const ColorScheme.light(
        primary: AppColor.mainColor,
        secondary: AppColor.mainColor,
      ),
      textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: "IBMPlexSans",
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(
            fontFamily: "IBMPlexSans",
            color: AppColor.greyColor,
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            fontFamily: "IBMPlexSans",
            color: AppColor.mainColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          labelLarge: TextStyle(
            fontFamily: "IBMPlexSans",
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          labelMedium: TextStyle(
            color: AppColor.lightGreyColor2,
            fontFamily: "IBMPlexSans",
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          labelSmall: TextStyle(
            color: AppColor.yellowColor,
            fontFamily: "IBMPlexSans",
            fontSize: 18,
            fontWeight: FontWeight.w500,
          )),
    );
  }
}
