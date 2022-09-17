import 'dart:core';
import 'package:fashion_shop/config/AppConfig.dart';
import 'package:fashion_shop/paymentGateway/paypal/services.dart';
import 'package:fashion_shop/screens/cart/components/calculations.dart';
import 'package:fashion_shop/storage/db.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Payment extends StatefulWidget {
  final Function onFinish;

  const Payment({Key? key, required this.onFinish}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PaymentState();
  }
}

class PaymentState extends State<Payment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? checkoutUrl;
  String? executeUrl;
  String? accessToken;
  Services services = Services();

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();

        final transactions = getOrderParams();
        debugPrint("This is the entire transaction order parameters");
        debugPrint(transactions.toString());
        final res =
            await services.createPaypalPayment(transactions, accessToken);
        print("this is te response");
        print(res);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
          });
        }
      } catch (e) {
        print('exception: ' + e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        _scaffoldKey.currentState!.showSnackBar(snackBar);
      }
    });
  }

  // item name, price and quantity
  String itemName1 = 'iPhone 11';
  String itemPrice1 = '200';
  int quantity1 = 1;

  String itemName = 'iPhone 8';
  String itemPrice = '100';
  int quantity = 1;

  Map<String, dynamic> getOrderParams() {
    //this is where the list of all the purchased item is included.

    List<Map> items = [
      ...List.generate(
          cartProduct.length,
          (index) => {
                "name": cartProduct[index].name,
                "quantity": cartProduct[index].orderQty,
                "price": cartProduct[index].price,
                "currency": AppConfig.defaultCurrency["currency"]
              }),
      {
        "name": "shipping",
        "quantity": "1",
        "price": double.parse(getShipping()).toStringAsFixed(2),
        "currency": AppConfig.defaultCurrency["currency"]
      }
    ];

    // checkout invoice details
    String totalAmount = getTotalPrice();
    String subTotalAmount = getSubTotal();
    String shippingCost = getShipping();
    int shippingDiscountCost = 0;
    String userFirstName = user.firstname;
    String userLastName = user.lastname;
    String addressCity = user.apt;
    String addressStreet = user.address;
    String addressZipCode = user.zipcode;
    String addressCountry = user.country;
    String addressState = user.state;
    String addressPhoneNumber = user.mobile;

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {
              "subtotal": totalAmount,
              "shipping": "0",
              "shipping_discount": ((-1.0) * shippingDiscountCost).toString()
            }
          },
          "description": "The payment transaction description.",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
            if (isEnableShipping && isEnableAddress)
              "shipping_address": {
                "recipient_name": userFirstName + " " + userLastName,
                "line1": addressStreet,
                "line2": "",
                "city": addressCity,
                "country_code": addressCountry,
                "postal_code": addressZipCode,
                "phone": addressPhoneNumber,
                "state": addressState
              },
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("this this is the checkout url");
    debugPrint(checkoutUrl);
    debugPrint("this is the execute url");
    debugPrint(executeUrl);

    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                services
                    .executePayment(executeUrl, payerID, accessToken)
                    .then((id) {
                  widget.onFinish(id);
                  Navigator.of(context).pop();
                });
              } else {
                Navigator.of(context).pop();
              }
              Navigator.of(context).pop();
            }
            if (request.url.contains(cancelURL)) {
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }
}
