import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/models/product.dart';
import 'package:fashion_shop/screens/detailScreen.dart';
import 'package:fashion_shop/storage/db.dart';
import 'package:fashion_shop/storage/products_temp.dart';
import 'package:fashion_shop/utilities/colors.dart';
import 'package:fashion_shop/utilities/route.dart';
import 'package:fashion_shop/utilities/style.dart';
import 'package:fashion_shop/widgets/circleButton.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    void _initiateFavourite(ProductModel product) {
      if (favouriteProduct.contains(product)) {
        setState(() {
          favouriteProduct.remove(product);
        });
      } else {
        setState(() {
          favouriteProduct.add(product);
        });
      }
    }

    void _initiateCart(ProductModel product) {
      if (cartProduct.contains(product)) {
        setState(() {
          cartProduct.remove(product);
        });
      } else {
        setState(() {
          cartProduct.add(product);
        });
      }
    }

    Color _cartBtnColor(ProductModel product, BuildContext context) {
      if (!cartProduct.contains(product)) {
        return Theme.of(context).primaryColor;
      } else {
        return Colors.grey.shade300;
      }
    }

    IconData _cartIcon(ProductModel product, BuildContext context) {
      if (!cartProduct.contains(product)) {
        return Icons.add_shopping_cart;
      } else {
        return Icons.remove_shopping_cart;
      }
    }

    SizeConfig size = SizeConfig();
    ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {
        reversibleNavigation(
            context,
            DetailScreen(
              product: productTempData[widget.index],
            ));
      },
      child: Container(
        margin: EdgeInsets.only(left: size.getPercentageWidth(2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: size.getPercentageHeight(21),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade200),
                  child: Image(
                      image: AssetImage(productTempData[widget.index].image)),
                ),
                Positioned(
                    right: 0,
                    top: 0,
                    child: CircularBotton(
                      color: white,
                      isImage: false,
                      icon: Icons.favorite,
                      iconColor: favouriteProduct
                              .contains(productTempData[widget.index])
                          ? Colors.red
                          : Colors.grey.shade300,
                      action: () {
                        //print(favouriteProduct);
                        _initiateFavourite(productTempData[widget.index]);
                        print(favouriteProduct);
                      },
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: SizeConfig().getPercentageWidth(28),
                        child: Text(
                          productTempData[widget.index].name,
                          style: darkPrimaryStyle(context, 15, true),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: size.getPercentageWidth(2),
                      ),
                      Text(
                        "\$ " + productTempData[widget.index].price,
                        style: primaryStyle(context, 16, true),
                      ),
                    ],
                  ),
                  CircularBotton(
                    color:
                        _cartBtnColor(productTempData[widget.index], context),
                    isImage: false,
                    icon: _cartIcon(productTempData[widget.index], context),
                    action: () {
                      _initiateCart(productTempData[widget.index]);
                      print(cartProduct);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: Colors.grey.shade200)),
      ),
    );
  }
}
