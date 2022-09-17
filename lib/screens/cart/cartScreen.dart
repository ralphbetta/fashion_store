// ignore_for_file: file_names

import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/paymentGateway/card/card.dart';
import 'package:fashion_shop/paymentGateway/card/card2.dart';
import 'package:fashion_shop/paymentGateway/card/paystack.dart';
import 'package:fashion_shop/paymentGateway/paypal/paypalNav.dart';
import 'package:fashion_shop/paymentGateway/razorpay/services.dart';
import 'package:fashion_shop/screens/cart/components/calculations.dart';
import 'package:fashion_shop/screens/cart/components/cartCard.dart';
import 'package:fashion_shop/screens/cart/components/cartPaymentButton.dart';
import 'package:fashion_shop/storage/db.dart';
import 'package:fashion_shop/utilities/route.dart';
import 'package:fashion_shop/utilities/style.dart';
import 'package:fashion_shop/widgets/button.dart';
import 'package:fashion_shop/widgets/circleButton.dart';
import 'package:fashion_shop/widgets/customAppBar.dart';
import 'package:fashion_shop/widgets/rowSeperator.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<PaymentMethod> iOSPaymentGate = [
    PaymentMethod(
        image: "https://i.ibb.co/j53xN85/paypal.png", method: "paypal"),
    PaymentMethod(
        image: "https://i.ibb.co/M8xQgpR/razorpay.png", method: "razorpay"),
  ];

  List<PaymentMethod> androidPaymentGate = [
    PaymentMethod(
        image: "https://i.ibb.co/wCKDgxr/google-pay.png", method: "google-pay"),
    PaymentMethod(
        image: "https://i.ibb.co/j53xN85/paypal.png", method: "paypal"),
    PaymentMethod(
        image: "https://i.ibb.co/M8xQgpR/razorpay.png", method: "razorpay"),
    PaymentMethod(
        image: "https://i.ibb.co/CBFgvcY/stripe.png", method: "stripe"),
  ];

  int activePayment = 0;

  String activeGateway = "paypal";

  void assignGateWay(int index) {
    Theme.of(context).platform.name == "iOS"
        ? setState(() {
            activeGateway = iOSPaymentGate[index].method;
          })
        : setState(() {
            activeGateway = androidPaymentGate[index].method;
          });
  }

  void proceedPayment() {
    if (activeGateway == "paypal") {
      payPalNavigation(context, scaffoldKey);
    } else if (activeGateway == "razorpay") {
      PayNow(context: context).openCheckout(_razorpay);
    }
  }

  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    //initialize razorpay and it functionalities
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        PayNow(context: context).handleExternalWallet);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        PayNow(context: context).handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
        PayNow(context: context).handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig size = SizeConfig();
    ThemeData themeData = Theme.of(context);

    return Scaffold(
        /*----------------------------
      Custom app bar
      ------------------------------------*/
        appBar: customAppBar(context, themeData, hasBack: true),
        body: SafeArea(
            child: Column(
          children: [
            /*----------------------------
            cart item display section
            ------------------------------------*/
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(20))),
                    width: double.infinity,
                    height: size.getPercentageHeight(58),
                    child: ListView(
                      children: [
                        ...List.generate(
                            cartProduct.length,
                            (index) => CartCard(
                                  themeData: themeData,
                                  size: size,
                                  index: index,
                                ))
                      ],
                    ),
                  ),
                ],
              ),
            )),
            /*----------------------------
              Payment method section
              ------------------------------------*/
            seperator(context, "Payment Method"),
            Container(
              width: double.infinity,
              height: size.getPercentageHeight(8),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig().getPercentageWidth(1)),
                child: Row(
                  children: [
                    ...List.generate(
                      Theme.of(context).platform.name == "iOS"
                          ? iOSPaymentGate.length
                          : androidPaymentGate.length,
                      (index) => PaymentButton(
                        active: activePayment == index ? true : false,
                        paymentImage: Theme.of(context).platform.name == "iOS"
                            ? iOSPaymentGate[index].image
                            : androidPaymentGate[index].image,
                        action: () {
                          setState(() {
                            activePayment = index;
                            assignGateWay(index);
                          });
                          print(activeGateway);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),

            /*----------------------------
            pricing display section
            ------------------------------------*/
            Container(
              padding: EdgeInsets.symmetric(
                  //vertical: SizeConfig().getPercentageWidth(2),
                  horizontal: SizeConfig().getPercentageWidth(5)),
              height: SizeConfig().getPercentageHeight(17),
              child: Column(
                children: [
                  calculationRow(context, "Subtotal", getSubTotal(),
                      colored: false),
                  calculationRow(context, "Discount", "10",
                      colored: false, isAmount: false),
                  calculationRow(context, "Shipping",
                      double.parse(getShipping()).toStringAsFixed(2),
                      colored: false),
                  calculationRow(context, "Total", getTotalPrice(),
                      colored: true),
                ],
              ),
            ),

            /*----------------------------
              bottom display section
              ------------------------------------*/
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: size.getPercentageWidth(4)),
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
                    icon: Icons.payment_outlined,
                    iconColor: Theme.of(context).primaryColor,
                  ),
                  PrimaryButton(
                    title: "Checkout",
                    padding: 25,
                    action: () {
                      print(user.toJson());
                      proceedPayment();
                      //paystack integration
                      //reversibleNavigation(context, Index());
                    },
                  ),
                ],
              ),
            )
          ],
        )));
  }
}

/*----------------------------
      Calculation row
      ------------------------------------*/
calculationRow(BuildContext context, String title, String value,
    {bool colored = false, bool isAmount = true}) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: darkPrimaryStyle(context, 17, false).copyWith(
              color: colored ? Theme.of(context).primaryColor : Colors.black),
        ),
        Text(
          isAmount ? "\$$value" : "%$value",
          style: darkPrimaryStyle(context, 17, true).copyWith(
              color: colored ? Theme.of(context).primaryColor : Colors.black),
        ),
      ],
    ),
  );
}

/*----------------------------
      Payment Method model
      ------------------------------------*/
class PaymentMethod {
  final String image;
  final String method;

  PaymentMethod({required this.image, required this.method});
}
