import 'dart:async';
import 'dart:io';

import 'package:fashion_shop/config/AppConfig.dart';
import 'package:fashion_shop/screens/cart/components/calculations.dart';
import 'package:fashion_shop/storage/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:http/http.dart' as http;

String backendUrl = 'https://sixstore.herokuapp.com';
String paystackPublicKey = 'pk_test_f672446f712995874236116871669f032e7c0b65';
const String appName = 'sixstore';
bool inProgress = false;
bool isLocal = false;

/* --------------------
  Card details
  ---------------------*/
String? cardNumber;
String? cvv;
int? expiryMonth;
int? expiryYear;

class CardPayment extends StatefulWidget {
  const CardPayment({Key? key}) : super(key: key);

  @override
  State<CardPayment> createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final plugin = PaystackPlugin();
  /* --------------------
  Initialization
  ---------------------*/
  @override
  void initState() {
    plugin.initialize(publicKey: paystackPublicKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: const Text(appName)),
      body: SafeArea(
          child: inProgress
              /*------------------------------------------
              Circular radius indicator
              ---------------------------------------------*/
              ? Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Platform.isIOS
                      ? const CupertinoActivityIndicator()
                      : const CircularProgressIndicator(),
                )
              : Center(
                  child: Column(
                    children: [
                      /*------------------------------------------
                      Get card popup formField
                      ---------------------------------------------*/
                      getPlatformButton('Charge Card', () {
                        // startAfreshCharge(formKey, () {});
                        //startAfreshCharge()
                      }),
                    ],
                  ),
                )),
    );
  }
}

/*------------------------------------------
Global Button
---------------------------------------------*/
Widget getPlatformButton(String string, Function() function) {
  // is still in progress
  Widget widget;
  if (Platform.isIOS) {
    widget = CupertinoButton(
      onPressed: function,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      color: CupertinoColors.activeBlue,
      child: Text(
        string,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  } else {
    widget = ElevatedButton(
      onPressed: function,
      child: Text(
        string.toUpperCase(),
        style: const TextStyle(fontSize: 17.0),
      ),
    );
  }
  return widget;
}

PaymentCard getCardFromUI() {
  return PaymentCard(
      number: cardNumber,
      cvc: cvv,
      expiryMonth: expiryMonth,
      expiryYear: expiryYear,
      name: 'Ismail Adebola Emeka',
      addressCountry: 'Nigeria',
      addressLine1: '90, Nnebisi Road, Asaba, Deleta State');
}

// startAfreshCharge(GlobalKey<FormState> formKey, Function callback, PaystackPlugin plugin, BuildContext context) async {
//   formKey.currentState?.save();
//   Charge charge = Charge();
//   charge.card = getCardFromUI();

//   // setState(() => _inProgress = true);
//   callback(true);

//   if (isLocal) {
//     // Set transaction params directly in app (note that these params
//     // are only used if an access_code is not set. In debug mode,
//     // setting them after setting an access code would throw an exception

//     charge
//       ..amount = int.parse(
//           double.parse(getTotalPrice()).toStringAsFixed(0)) // In base currency
//       ..email = user.email
//       ..reference = getReference()
//       ..putCustomField('Charged From', 'Flutter SDK');
//     chargeCard(charge, plugin, context);
//   } else {
//     // Perform transaction/initialize on Paystack server to get an access code
//     // documentation: https://developers.paystack.co/reference#initialize-a-transaction
//     charge.accessCode = await _fetchAccessCodeFrmServer(_getReference());
//     chargeCard(charge, plugin, context);
//   }
// }

String getReference() {
  String platform;
  if (Platform.isIOS) {
    platform = 'iOS';
  } else {
    platform = 'Android';
  }
  return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
}

// chargeCard(Charge charge, PaystackPlugin plugin, BuildContext context) async {
//   final response = await plugin.chargeCard(context, charge: charge);
//   final reference = response.reference;
//   if (response.status) {
//     verifyOnServer(reference);
//     return;
//   }
//   // The transaction failed. Checking if we should verify the transaction
//   if (response.verify) {
//     verifyOnServer(reference);
//   } else {
//     //setState(() => _inProgress = false);
//     updateStatus(reference, response.message);
//   }
// }

// void verifyOnServer(String? reference) async {
//   updateStatus(reference, 'Verifying...');
//   String url = '$backendUrl/verify/$reference';
//   try {
//     http.Response response = await http.get(Uri.parse(url));
//     var body = response.body;
//     updateStatus(reference, body);
//   } catch (e) {
//     updateStatus(
//         reference,
//         'There was a problem verifying %s on the backend: '
//         '$reference $e');
//   }
//   //setState(() => _inProgress = false);
// }

updateStatus(String? reference, String message, BuildContext context) {
  showMessage('Reference: $reference \n\ Response: $message', context,
      const Duration(seconds: 7));
}

showMessage(String message, BuildContext context,
    [Duration duration = const Duration(seconds: 4)]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: duration,
    action: SnackBarAction(
        label: 'CLOSE',
        onPressed: () => ScaffoldMessenger.of(context).removeCurrentSnackBar()),
  ));
}
