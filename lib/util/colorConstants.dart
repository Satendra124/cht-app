import 'package:cht/util/ui_helper.dart';
import 'package:flutter/material.dart';

class AppColors {
  static final backgroundColor = Color(0xff273C5C);
  static final secondaryColor = Color(0xff4572B5);
  static final backgroundColorLite = Color(0xff4572B5);
  static final thirdColor = Colors.white;
  static final shadowColor = Colors.black;
  static final textColor = Colors.white;
  static final scaffoldColor = lighten(AppColors.backgroundColor, 0.05);
}

class AppStyles {
  static ButtonStyle buttonStyleBIG = ButtonStyle(
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      padding: MaterialStateProperty.all(EdgeInsets.all(8)),
      textStyle: MaterialStateProperty.all(
          TextStyle(color: AppColors.textColor, fontSize: 25)),
      backgroundColor:
          MaterialStateProperty.all(darken(AppColors.backgroundColor, 0.05)),
      minimumSize: MaterialStateProperty.all(Size(250, 60)));
}

class ColorLight {
  static final themeColor = Color(0xff5142AB);
  static final white = Color(0xffFFFFFF);
  static final secondaryColor = Color(0xffFF8354);
  static final errorColor = Color(0xffFF5413);
  static final materialBackground = Color(0xffEDEBF7);
  static final black = Color(0xff000000);
}
