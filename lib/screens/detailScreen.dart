import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/models/product.dart';
import 'package:fashion_shop/storage/db.dart';
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

  @override
  Widget build(BuildContext context) {
    SizeConfig size = SizeConfig();
    return Scaffold(
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
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(30))),
                    child: Image(image: AssetImage(widget.product.image)),
                  ),
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
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.getPercentageWidth(4),
                        bottom: size.getPercentageWidth(3)),
                    child: const Rating(
                      avgRate: 3,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.getPercentageWidth(4)),
                    child: Text(widget.product.desc),
                  ),
                  seperator(context, "Size"),
                  widget.product.category == 'shoes'
                      ? ShoeSizeSelector()
                      : SizeSelector(size: size)
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

class ShoeSizeSelector extends StatefulWidget {
  const ShoeSizeSelector({Key? key}) : super(key: key);

  @override
  State<ShoeSizeSelector> createState() => _ShoeSizeSelectorState();
}

class _ShoeSizeSelectorState extends State<ShoeSizeSelector> {
  List size = ["20", "24", "30", "32", "38", "40", "48"];
  int activeSize = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig().getPercentageWidth(4)),
      child: SizedBox(
        width: SizeConfig().getPercentageWidth(100),
        height: SizeConfig().getPercentageWidth(10),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ...List.generate(
                size.length,
                (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          activeSize = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: activeSize == index
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade200),
                        child: Center(
                          child: Text(
                            size[index],
                            style: darkPrimaryStyle(context, 18, true),
                          ),
                        ),
                        width: SizeConfig().getPercentageWidth(10),
                        height: SizeConfig().getPercentageWidth(10),
                        margin: EdgeInsets.only(
                            right: SizeConfig().getPercentageWidth(4)),
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}

class SizeSelector extends StatefulWidget {
  const SizeSelector({
    Key? key,
    required this.size,
  }) : super(key: key);

  final SizeConfig size;

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  List size = ["S", "M", "L", "XL"];
  int activeSize = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: widget.size.getPercentageWidth(4)),
      child: Row(
        children: [
          ...List.generate(
              size.length,
              (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        activeSize = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: activeSize == index
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade200),
                      child: Center(
                        child: Text(
                          size[index],
                          style: darkPrimaryStyle(context, 18, true),
                        ),
                      ),
                      width: SizeConfig().getPercentageWidth(10),
                      height: SizeConfig().getPercentageWidth(10),
                      margin: EdgeInsets.only(
                          right: SizeConfig().getPercentageWidth(4)),
                    ),
                  ))
        ],
      ),
    );
  }
}

class Rating extends StatelessWidget {
  final int avgRate;
  const Rating({
    required this.avgRate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...List.generate(
            5,
            (index) => Icon(
                  Icons.star,
                  size: 20,
                  color: index + 1 <= avgRate
                      ? Colors.orange
                      : Colors.grey.shade300,
                ))
      ],
    );
  }
}
