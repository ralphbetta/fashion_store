import 'package:fashion_shop/config/AppConfig.dart';
import 'package:fashion_shop/config/DateTimeConfig.dart';
import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:flutter/material.dart';

void showTermsOfUse(BuildContext context) {
  SizeConfig size = SizeConfig();
  return showAboutDialog(
      context: context,
      applicationVersion: AppConfig.version,
      applicationName: AppConfig.appName,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              AppConfig.termsOfUse,
              textAlign: TextAlign.center,
            ))
      ],
      applicationLegalese: "©${DateTimeConfig.year} ${AppConfig.appName}.com",
      applicationIcon: Image(
        image: const AssetImage("assets/icons/icon.png"),
        width: size.getPercentageWidth(12),
      ));
}

void showPrivacyPolicy(BuildContext context) {
  SizeConfig size = SizeConfig();
  return showAboutDialog(
      context: context,
      applicationVersion: AppConfig.version,
      applicationName: AppConfig.appName,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              AppConfig.privacyPolicy,
              textAlign: TextAlign.center,
            ))
      ],
      applicationLegalese: "©${DateTimeConfig.year} ${AppConfig.appName}.com",
      applicationIcon: Image(
        image: const AssetImage("assets/icons/icon.png"),
        width: size.getPercentageWidth(12),
      ));
}
