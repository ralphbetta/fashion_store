import 'package:fashion_shop/paymentGateway/paypal/payment.dart';
import 'package:flutter/material.dart';

payPalNavigation(BuildContext context, scaffoldKey) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) => Payment(
        onFinish: (number) async {
          // payment done
          final snackBar = SnackBar(
            content: Text("Successfull! - $number"),
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          scaffoldKey.currentState!.showSnackBar(snackBar);
        },
      ),
    ),
  );
}
