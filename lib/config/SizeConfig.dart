import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenHeight;
  static late double screenWidth;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;
  }
  //initialize it at your main screen

  static double bodyTextSize = 16.0;

  static double extraLarge = 28.0;
  static double large = 20.0;
  static double mediumTextSize = 18.0;
  static double small = 15;

  double getPercentageHeight(int percentage) {
    return SizeConfig.screenHeight * percentage * 0.01;
  }

  double getPercentageWidth(int percentage) {
    return SizeConfig.screenWidth * percentage * 0.01;
  }
}
