import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/models/transaction.dart';
import 'package:fashion_shop/storage/db.dart';
import 'package:fashion_shop/utilities/style.dart';
import 'package:fashion_shop/widgets/rowSeperator.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig size = SizeConfig();
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                seperator(context, "Hello Mike!"),
                Padding(
                  padding: EdgeInsets.only(left: size.getPercentageWidth(4)),
                  child: Text("Total Transactions: " +
                      tempTransaction.length.toString()),
                )
              ],
            ),
          ),
        )),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.getPercentageWidth(4)),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          width: size.getPercentageWidth(100),
          height: size.getPercentageHeight(70),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(
                  tempTransaction.length,
                  (index) =>
                      TransactionCard(transaction: tempTransaction[index]),
                )
              ],
            ),
          ),
        )
      ],
    )));
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final TransactionModel transaction;

  Color _switcher(String status, BuildContext context) {
    if (status == "completed") {
      return Colors.green;
    } else if (status == "pending") {
      return Theme.of(context).primaryColor;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig size = SizeConfig();
    return Container(
        width: size.getPercentageWidth(100),
        height: size.getPercentageHeight(10),
        margin: EdgeInsets.only(top: size.getPercentageWidth(2)),
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            boxShadow: [
              BoxShadow(color: Colors.grey.shade100, blurRadius: 4.9)
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "\$" + transaction.amount.toString(),
              style: darkPrimaryStyle(context, 20, true),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  transaction.title,
                  style: darkPrimaryStyle(context, 15, true),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  transaction.date,
                  style: TextStyle(color: Colors.grey.shade500),
                ),
              ],
            ),
            Container(
              child: Text(
                transaction.status,
                style: const TextStyle(color: Colors.white),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: _switcher(transaction.status, context),
                  borderRadius: BorderRadius.circular(10)),
            )
          ],
        ));
  }
}
