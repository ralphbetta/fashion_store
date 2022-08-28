import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/storage/db.dart';
import 'package:fashion_shop/storage/products_temp.dart';
import 'package:fashion_shop/utilities/style.dart';
import 'package:fashion_shop/widgets/button.dart';
import 'package:fashion_shop/widgets/circleButton.dart';
import 'package:fashion_shop/widgets/customAppBar.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig size = SizeConfig();
    ThemeData themeData = Theme.of(context);
    return Scaffold(
        appBar: customAppBar(context, themeData, hasBack: true),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: size.getPercentageHeight(40),
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
                    icon: Icons.shopping_cart,
                    iconColor: Theme.of(context).primaryColor,
                  ),
                  PrimaryButton(
                    title: "Add to chart",
                    padding: 25,
                    action: () {
                      print("object");
                    },
                  ),
                ],
              ),
            )
          ],
        )));
  }
}

class CartCard extends StatefulWidget {
  const CartCard(
      {Key? key,
      required this.themeData,
      required this.size,
      required this.index})
      : super(key: key);

  final ThemeData themeData;
  final SizeConfig size;
  final int index;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  void _reduceQuantity() {
    if (cartProduct[widget.index].orderQty > 1) {
      setState(() {
        cartProduct[widget.index].orderQty =
            cartProduct[widget.index].orderQty - 1;
      });
    } else {
      setState(() {
        cartProduct.remove(cartProduct[widget.index]);
      });
    }
  }

  void _increaseQuantity() {
    if (cartProduct[widget.index].orderQty <=
        int.parse(cartProduct[widget.index].quantity)) {
      setState(() {
        cartProduct[widget.index].orderQty =
            cartProduct[widget.index].orderQty + 1;
      });
    }
  }

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig().getPercentageWidth(5)),
      child: Row(
        children: [
          Checkbox(
              value: isSelected,
              activeColor: widget.themeData.primaryColor,
              onChanged: (bool? value) {
                setState(() {
                  isSelected = !isSelected;
                });
              }),
          Container(
            width: widget.size.getPercentageWidth(14),
            height: widget.size.getPercentageWidth(14),
            margin: EdgeInsets.only(right: widget.size.getPercentageWidth(2)),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(productTempData[widget.index].image))),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cartProduct[widget.index].name,
                style: darkPrimaryStyle(context, 16, true),
              ),
              Text(
                cartProduct[widget.index].category,
                style: TextStyle(color: Colors.grey.shade400),
              ),
              Text(
                "\$ ${cartProduct[widget.index].price}",
                style: primaryStyle(context, 18, true),
              ),
            ],
          ),
          Expanded(child: Container()),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    _reduceQuantity();
                  },
                  icon: const Icon(Icons.remove)),
              Text(
                cartProduct[widget.index].orderQty.toString(),
                style: darkPrimaryStyle(context, 18, true),
              ),
              IconButton(
                  onPressed: () {
                    _increaseQuantity();
                  },
                  icon: Icon(
                    Icons.add,
                    color: widget.themeData.primaryColor,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
