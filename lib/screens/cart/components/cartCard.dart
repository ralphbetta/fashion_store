import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/storage/db.dart';
import 'package:fashion_shop/storage/products_temp.dart';
import 'package:fashion_shop/utilities/style.dart';
import 'package:flutter/material.dart';

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
  /*----------------------------
      product quantity reduction
      ------------------------------------*/
  void _reduceQuantity() {
    if (cartProduct[widget.index].orderQty > 1) {
      setState(() {
        cartProduct[widget.index].orderQty =
            cartProduct[widget.index].orderQty - 1;
      });
    }
  }

  /*----------------------------
    product quantity increamentor
      ------------------------------------*/
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
              SizedBox(
                width: SizeConfig().getPercentageWidth(40),
                child: Text(
                  cartProduct[widget.index].name,
                  overflow: TextOverflow.ellipsis,
                  style: darkPrimaryStyle(
                    context,
                    16,
                    true,
                  ),
                ),
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
