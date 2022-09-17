import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/utilities/style.dart';
import 'package:flutter/material.dart';

seperator(BuildContext context, String caption,
    {bool more = false, int padding = 4}) {
  SizeConfig size = SizeConfig();
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: size.getPercentageWidth(padding),
        vertical: size.getPercentageHeight(1)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          caption,
          style: darkPrimaryStyle(context, SizeConfig.large, true),
        ),
        more ? const Text("More") : const Text("")
      ],
    ),
  );
}
