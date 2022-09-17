import 'package:fashion_shop/models/product.dart';
import 'package:fashion_shop/screens/details/detailScreen.dart';
import 'package:fashion_shop/screens/main/favouriteScreen.dart';
import 'package:fashion_shop/screens/main/account/accountScreen.dart';
import 'package:fashion_shop/screens/main/scanner.dart';
import 'package:fashion_shop/screens/main/transactions.dart';
import 'package:fashion_shop/screens/main/homeScreen.dart';
import 'package:fashion_shop/storage/products_temp.dart';
import 'package:fashion_shop/utilities/route.dart';
import 'package:fashion_shop/widgets/customAppBar.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// ignore: must_be_immutable
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
    Scanner(),
    TransactionScreen(),
    AccountScreen()
  ];

  String? scanResult;

  Future scancode() async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          '#FFFFAD2C', "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      scanResult = 'Failed to get platform';
    }
    if (!mounted) return;
    setState(() => this.scanResult = scanResult);
    List foundProducts = productTempData
        .where((element) => element.barCode == scanResult)
        .toList();

    if (foundProducts.isNotEmpty) {
      reversibleNavigation(
          context,
          DetailScreen(
            product: foundProducts.first,
          ));
    } else {
      _showMessage("product with ID $scanResult is out of stock");
    }
  }

  _showMessage(String message,
      [Duration duration = const Duration(seconds: 4)]) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: duration,
      action: SnackBarAction(
          label: 'CLOSE',
          onPressed: () =>
              ScaffoldMessenger.of(context).removeCurrentSnackBar()),
    ));
  }

  List<Map> bottomNavData = [
    {"icon": Icons.home, "index": 0},
    {"icon": Icons.favorite, "index": 1},
    {"icon": Icons.pedal_bike, "index": 2},
    {"icon": Icons.payment, "index": 3},
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
          scancode();
        },
        child: const Icon(Icons.qr_code_scanner_outlined), //icon inside button
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin: 6,
        child: Row(
          /*--------------------------------
          children inside bottom appbar
          -------------------------------*/
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
                  index == 2 ? scancode() : _switchPage(index);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
