import 'package:flutter/material.dart';

Widget indicator(bool active, BuildContext context) {
  return Container(
    width: active ? 20 : 9,
    height: 9,
    margin: const EdgeInsets.only(right: 5),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: active ? Theme.of(context).primaryColor : Colors.grey),
  );
}
