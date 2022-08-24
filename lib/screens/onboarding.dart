import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/models/category.dart';
import 'package:fashion_shop/screens/home.dart';
import 'package:fashion_shop/storage/dataset.dart';
import 'package:fashion_shop/storage/db.dart';
import 'package:fashion_shop/utilities/route.dart';
import 'package:fashion_shop/utilities/style.dart';
import 'package:fashion_shop/widgets/button.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: customOverlay(themeData),
      ),
      body: SafeArea(
          child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.05),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig().getPercentageWidth(5),
                  vertical: SizeConfig().getPercentageHeight(1)),
              child: Text(
                "Choose your Favourite Fashion categories",
                textAlign: TextAlign.center,
                style: darkPrimaryStyle(context, SizeConfig.extraLarge, true),
              ),
            ),
            Text(
              "you can choose more than one",
              style: lightPrimaryStyle(context, 15, false),
            ),
            /*---------------------------------
              Grid Categories
              ---------------------------------*/
            SizedBox(
              height: SizeConfig().getPercentageHeight(5),
            ),
            Expanded(
                child: Container(
              child: GridView.builder(
                  itemCount: onboardingData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //items per row
                    mainAxisSpacing: 20, //spacing between each box
                    childAspectRatio: 3.0, //adjusting item height
                    crossAxisSpacing: 15, //spacing between
                  ),
                  itemBuilder: (BuildContext context, index) {
                    return OnboardingCard(
                      onboardingData: onboardingData,
                      index: index,
                    );
                  }),
            )),
            PrimaryButton(
              title: "Continue",
              action: () {
                irreversibleNavigate(context, Home());
              },
            ),
            SizedBox(
              height: SizeConfig().getPercentageHeight(2),
            ),
            /*---------------------------------
              Skip Button
              ---------------------------------*/
            const Button(title: "Skip for now")
          ],
        ),
      )),
    );
  }
}

class OnboardingCard extends StatefulWidget {
  OnboardingCard(
      {Key? key,
      required this.onboardingData,
      required this.index,
      this.selected = false})
      : super(key: key);

  final List<CategoryModel> onboardingData;
  final int index;
  bool selected;

  @override
  State<OnboardingCard> createState() => _OnboardingCardState();
}

class _OnboardingCardState extends State<OnboardingCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.selected = !widget.selected;
          widget.selected
              ? favoriteCat.add(widget.onboardingData[widget.index])
              : favoriteCat.remove(widget.onboardingData[widget.index]);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig().getPercentageWidth(7)),
        child: Row(
          children: [
            Image(
                width: SizeConfig().getPercentageWidth(4),
                image: AssetImage(
                    "assets/images/categories/${widget.onboardingData[widget.index].image}")),
            SizedBox(
              width: SizeConfig().getPercentageWidth(3),
            ),
            Text(
              widget.onboardingData[widget.index].title,
              style: TextStyle(
                  color: !widget.selected ? Colors.black87 : Colors.white),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: widget.selected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            border: Border.all(
                width: 1,
                color: !widget.selected
                    ? Colors.grey.shade300
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
