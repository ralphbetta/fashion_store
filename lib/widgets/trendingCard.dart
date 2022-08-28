import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/models/advert.dart';
import 'package:flutter/material.dart';

class TrendingCard extends StatelessWidget {
  final AdvertModel advert;
  const TrendingCard({Key? key, required this.advert}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig size = SizeConfig();
    return Container(
      width: size.getPercentageWidth(90),
      margin: EdgeInsets.only(
        left: size.getPercentageWidth(4),
        right: size.getPercentageWidth(4),
      ),
      decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: AssetImage(advert.image), fit: BoxFit.fitWidth)),
    );
  }
}
