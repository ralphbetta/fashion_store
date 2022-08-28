import 'package:fashion_shop/screens/cartScreen.dart';
import 'package:fashion_shop/storage/db.dart';
import 'package:fashion_shop/utilities/route.dart';
import 'package:fashion_shop/utilities/style.dart';
import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context, ThemeData themeData,
    {bool hasBack = false}) {
  return AppBar(
    leading: hasBack
        ? IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios))
        : IconButton(onPressed: () {}, icon: Icon(Icons.menu_rounded)),
    actions: [
      IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
      Stack(
        children: [
          IconButton(
              onPressed: () {
                reversibleNavigation(context, const CartScreen());
              },
              icon: const Icon(Icons.shopping_bag_outlined)),
          Positioned(
            right: 5,
            top: 3,
            child: CircleAvatar(
              radius: 9,
              backgroundColor: themeData.primaryColor,
              child: Text(
                cartProduct.length.toString(),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          )
        ],
      ),
    ],
    systemOverlayStyle: customOverlay(themeData),
  );
}
