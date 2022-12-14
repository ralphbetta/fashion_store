import 'package:fashion_shop/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeClass {
  //static late ThemeMode currentTheme = ThemeMode.light;
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  static Color primaryColor = const Color(0xFFFFAD2C);
  static Color altPrimary = Color.fromARGB(255, 239, 194, 122);

  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: scaffoldBackgroundColorLight,
    secondaryHeaderColor: Colors.white,
    backgroundColor: Colors.white,
    hintColor: Colors.black.withOpacity(0.4),
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary:
            primaryColor), //this affect the textinput and active prefix color
    primaryColorDark: const Color(0xFF0F1D3F),
    splashColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    brightness: Brightness.light,
    textTheme: TextTheme(
      bodyText1: TextStyle(color: kTextColor.withOpacity(0.5)),
      headline6: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'Poppins',
    canvasColor: const Color(0xFF101A21),
    scaffoldBackgroundColor: const Color(0xFF101A21),
    backgroundColor: scaffoldBackgroundColorDark,
    secondaryHeaderColor: Colors.white,
    hintColor: const Color(0xffA3A3A3),
    primaryColor: white,
    splashColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: white),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: Colors.white),
      headline6: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );
}

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return Colors.red;
}
