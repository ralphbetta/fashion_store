import 'package:fashion_shop/screens/cartScreen.dart';
import 'package:fashion_shop/screens/mainScreens/favouriteScreen.dart';
import 'package:fashion_shop/screens/mainScreens/accountScreen.dart';
import 'package:fashion_shop/screens/mainScreens/checkoutScreen.dart';
import 'package:fashion_shop/screens/mainScreens/helpScreen.dart';
import 'package:fashion_shop/screens/mainScreens/homeScreen.dart';
import 'package:fashion_shop/storage/db.dart';
import 'package:fashion_shop/utilities/route.dart';
import 'package:fashion_shop/utilities/style.dart';
import 'package:fashion_shop/widgets/customAppBar.dart';
import "package:flutter/material.dart";

class MainScreen extends StatefulWidget {
  int activePage;
  MainScreen({Key? key, this.activePage = 0}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pages = const [
    HomeScreen(),
    FavouriteScreen(),
    HelpScrenn(),
    CheckoutScreen(),
    AccountScreen()
  ];

  List<Map> bottomNavData = [
    {"icon": Icons.home, "index": 0},
    {"icon": Icons.favorite, "index": 1},
    {"icon": Icons.pedal_bike, "index": 2},
    {"icon": Icons.shopping_cart, "index": 3},
    {"icon": Icons.person, "index": 4}
  ];

  void _switchPage(int index) {
    setState(() {
      widget.activePage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: customAppBar(context, themeData),
      body: pages[widget.activePage],
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeData.primaryColor,
        onPressed: () {
          _switchPage(2);
        },
        child: const Icon(Icons.qr_code_scanner_outlined), //icon inside button
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin: 6,
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: <Widget>[
            ...List.generate(
              bottomNavData.length,
              (index) => IconButton(
                icon: Icon(bottomNavData[index]['icon'],
                    color: index == 2
                        ? Colors.white
                        : index == widget.activePage
                            ? themeData.primaryColor
                            : Colors.grey.shade300),
                onPressed: () {
                  _switchPage(index);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
