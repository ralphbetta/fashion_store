import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final int avgRate;
  const Rating({
    required this.avgRate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...List.generate(
            5,
            (index) => Icon(
                  Icons.star,
                  size: 20,
                  color: index + 1 <= avgRate
                      ? Colors.orange
                      : Colors.grey.shade300,
                ))
      ],
    );
  }
}
