import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:flutter/material.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({
    Key? key,
    required this.paymentImage,
    this.action,
    this.active = false,
  }) : super(key: key);

  final String paymentImage;
  final bool active;
  final Function()? action;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: action,
      child: Container(
        // margin:
        //     EdgeInsets.only(left: SizeConfig.screenWidth * 0.027),
        width: SizeConfig.screenWidth * 0.21,
        height: SizeConfig.screenWidth * 0.12,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: active
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade300)),
        child: Image(image: NetworkImage(paymentImage)),
      ),
    ));
  }
}
