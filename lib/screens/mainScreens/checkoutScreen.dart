import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/widgets/button.dart';
import 'package:fashion_shop/widgets/circleButton.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig size = SizeConfig();
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
        )),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.getPercentageWidth(4)),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: 3, color: Colors.grey.shade300))),
          width: size.getPercentageWidth(100),
          height: size.getPercentageHeight(9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularBotton(
                color: Colors.grey.shade200,
                isImage: false,
                icon: Icons.shopping_cart,
                iconColor: Theme.of(context).primaryColor,
              ),
              PrimaryButton(
                title: "Add to chart",
                padding: 25,
                action: () {
                  print("object");
                },
              ),
            ],
          ),
        )
      ],
    )));
  }
}
