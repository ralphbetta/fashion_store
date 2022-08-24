import 'dart:ui';

import 'package:fashion_shop/config/AppConfig.dart';
import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/models/splash.dart';
import 'package:fashion_shop/screens/login.dart';
import 'package:fashion_shop/utilities/route.dart';
import 'package:fashion_shop/utilities/style.dart';
import 'package:fashion_shop/widgets/button.dart';
import 'package:fashion_shop/widgets/indicator.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double cHeight = SizeConfig.screenHeight;
  double cWidth = SizeConfig.screenWidth;
  int activeCount = 0;

  List<SplashModel> splashData = [
    SplashModel(
        title: "Latest OutFit",
        desc: "There are many new outfits that makes you cool",
        image: "assets/splash/splash1.png"),
    SplashModel(
        title: "Explore Fashion",
        desc:
            "Explore the 2020's hottest fashion, jewellery, accessories and more...",
        image: "assets/splash/splash2.png"),
    SplashModel(
        title: "Select What you love",
        desc:
            "Exclusive curated selection of top brands in the palm of your hands",
        image: "assets/splash/splash3.png")
  ];
  @override
  Widget build(BuildContext context) {
    ThemeData themedata = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: customOverlay(themedata),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: cHeight * 0.02,
              bottom: cHeight * 0.02,
            ),
            child: Text(
              AppConfig.appName,
              textAlign: TextAlign.center,
              style: primaryStyle(context, SizeConfig.extraLarge, true),
            ),
          ),
          SizedBox(
            height: cHeight * 0.55,
            width: cWidth,
            child: PageView.builder(
                itemCount: splashData.length,
                onPageChanged: (int value) {
                  setState(() {
                    activeCount = value;
                  });
                },
                itemBuilder: (context, index) {
                  return SplashContent(
                      cHeight: cHeight,
                      splashData: splashData[index],
                      cWidth: cWidth);
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                  splashData.length,
                  (index) =>
                      indicator(index == activeCount ? true : false, context))
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig().getPercentageWidth(5),
                vertical: SizeConfig().getPercentageWidth(15)),
            child: PrimaryButton(
              title: activeCount == 2 ? "Next" : "Skip",
              action: () {
                irreversibleNavigate(context, const Login());
              },
            ),
          ),
        ],
      )),
    );
  }
}

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.cHeight,
    required this.splashData,
    required this.cWidth,
  }) : super(key: key);

  final double cHeight;
  final SplashModel splashData;
  final double cWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: cHeight * 0.01),
          height: cHeight * 0.4,
          child: Image(image: AssetImage(splashData.image)),
        ),
        Text(
          splashData.title,
          style: darkPrimaryStyle(context, 20, true),
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: cHeight * 0.03),
            width: cWidth * 0.6,
            child: Text(splashData.desc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                ))),
      ],
    );
  }
}
