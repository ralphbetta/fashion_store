import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextStyle primaryStyle(BuildContext context, double size, bool bold) {
  ThemeData themeData = Theme.of(context);
  return TextStyle(
      color: themeData.primaryColor,
      fontSize: size,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal);
}

TextStyle darkPrimaryStyle(BuildContext context, double size, bool bold,
    {double opacity = 1.0}) {
  ThemeData themeData = Theme.of(context);
  return TextStyle(
      color: themeData.primaryColorDark.withOpacity(opacity),
      fontSize: size,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal);
}

TextStyle lightPrimaryStyle(BuildContext context, double size, bool bold,
    {double opacity = 1.0}) {
  ThemeData themeData = Theme.of(context);
  return TextStyle(
      color: Colors.grey.withOpacity(opacity),
      fontSize: size,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal);
}

SystemUiOverlayStyle customOverlay(ThemeData themedata) {
  return SystemUiOverlayStyle(
      statusBarColor: themedata.scaffoldBackgroundColor,
      statusBarIconBrightness: Brightness.dark);
}
