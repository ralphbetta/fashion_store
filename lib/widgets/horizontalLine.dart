// ignore: file_names
import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:flutter/material.dart';

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double cWidth = SizeConfig.screenWidth;
    return Expanded(
      child: Container(
        color: Colors.grey,
        width: cWidth * 0.4,
        height: 0.5,
      ),
    );
  }
}
