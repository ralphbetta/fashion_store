import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/models/product.dart';
import 'package:fashion_shop/screens/cart/cartScreen.dart';
import 'package:fashion_shop/screens/details/components/detailRating.dart';
import 'package:fashion_shop/screens/details/components/detailSizeSelector.dart';
import 'package:fashion_shop/storage/db.dart';
import 'package:fashion_shop/utilities/route.dart';
import 'package:fashion_shop/utilities/style.dart';
import 'package:fashion_shop/widgets/button.dart';
import 'package:fashion_shop/widgets/circleButton.dart';
import 'package:fashion_shop/widgets/rowSeperator.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final ProductModel product;
  const DetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  /*---------------------------------
  Favourite function
  ---------------------------------*/
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
  /*---------------------------------
  Add and remove from cart function
  ---------------------------------*/

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

  @override
  Widget build(BuildContext context) {
    SizeConfig size = SizeConfig();
    return Scaffold(
        /*---------------------------------
        Detailpage appBar
        ---------------------------------*/
        appBar: AppBar(
          leading: CircularBotton(
            color: Colors.white,
            isImage: false,
            icon: Icons.arrow_back_ios,
            iconColor: Colors.black87,
            action: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.grey.shade200,
          actions: [
            CircularBotton(
              color: Colors.white,
              isImage: false,
              icon: Icons.favorite,
              iconColor: favouriteProduct.contains(widget.product)
                  ? Colors.red
                  : Colors.grey.shade300,
              action: () {
                //print(favouriteProduct);
                _initiateFavourite(widget.product);
                print(favouriteProduct);
              },
            )
          ],
        ),

        /*---------------------------------
        Detailpage body
        ---------------------------------*/
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*---------------------------------
                   Product Image display
                  ---------------------------------*/
                  Container(
                    width: double.infinity,
                    height: size.getPercentageHeight(40),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(30))),
                    child: Image(image: AssetImage(widget.product.image)),
                  ),
                  /*---------------------------------
                  Title and price section
                  ---------------------------------*/
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: size.getPercentageWidth(2),
                        horizontal: size.getPercentageWidth(4)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name,
                              textScaleFactor: 1.6,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.product.category,
                              textScaleFactor: 1,
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                        Text(
                          "\$ ${widget.product.price}",
                          style: primaryStyle(context, 20, true),
                        ),
                      ],
                    ),
                  ),
                  /*---------------------------------
                   Rating Section
                  ---------------------------------*/
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.getPercentageWidth(4),
                        bottom: size.getPercentageWidth(3)),
                    child: const Rating(
                      avgRate: 3,
                    ),
                  ),
                  /*---------------------------------
                  Size selector
                  ---------------------------------*/
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.getPercentageWidth(4)),
                    child: Text(widget.product.desc),
                  ),
                  seperator(context, "Size"),
                  widget.product.category == 'shoes'
                      ? const ShoeSizeSelector()
                      : SizeSelector(size: size)
                ],
              ),
            )),
            /*---------------------------------
              Detailpage footer
              ---------------------------------*/
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: size.getPercentageWidth(3)),
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
                    action: () {
                      reversibleNavigation(context, const CartScreen());
                    },
                  ),
                  PrimaryButton(
                    title: cartProduct.contains(widget.product)
                        ? "Remove From Cart"
                        : "Add to chart",
                    padding: 23,
                    action: () {
                      _initiateCart(widget.product);
                    },
                  ),
                ],
              ),
            )
          ],
        )));
  }
}
