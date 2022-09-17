// ignore: file_names

class AppConfig {
  static String appName = "SixStore";

  static String version = "Version 1.0.0";

  static String termsOfUse =
      '$appName a multi vendor store app that allows sales and management of any vendor product. Items can be added to favourite for regular purchase with e-payment systems enabled';

  static String privacyPolicy =
      '$appName has not been officially released for distribution';

  static String logo = "assets/icons/icon-trans.png";

  static Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };
}
