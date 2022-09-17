import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/models/category.dart';
import 'package:fashion_shop/models/product.dart';
import 'package:fashion_shop/storage/category_temp.dart';
import 'package:fashion_shop/storage/db.dart';
import 'package:fashion_shop/storage/products_temp.dart';
import 'package:fashion_shop/utilities/style.dart';
import 'package:fashion_shop/widgets/productCard.dart';
import 'package:fashion_shop/widgets/rowSeperator.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  /*---------------------------------
  Update Categories
  ---------------------------------*/
  void updateCategories() {
    if (onboardingData.first.title != 'All') {
      onboardingData.insert(0, CategoryModel(title: "All", image: ""));
    }
  }

  List<ProductModel> _thisProduct = favouriteProduct;

  //String activeCategories = 'All';

  void loadProduct(String activeCategories) {
    if (activeCategories == 'all') {
      setState(() {
        _thisProduct = productTempData
            .where((element) => favouriteProduct.contains(element))
            .toList();
      });
    } else {
      setState(() {
        _thisProduct = favouriteProduct
            .where(
                (element) => element.category == activeCategories.toLowerCase())
            .toList();
      });
    }
  }

  int favInCArt() {
    return favouriteProduct
        .where((element) => cartProduct.contains(element))
        .toList()
        .length;
  }

  int activeCatIndex = 0;
  int activeBottomIndex = 0;
  int activeAdvert = 0;

  @override
  void initState() {
    updateCategories();
    productTempData.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig size = SizeConfig();
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          /*---------------------------------
            Trending seperator
            ---------------------------------*/
          seperator(
            context,
            "Hello! Marthins",
          ),
          /*---------------------------------
              Trending Slider
              ---------------------------------*/
          Container(
              width: size.getPercentageWidth(100),
              height: size.getPercentageHeight(15),
              padding: EdgeInsets.symmetric(
                horizontal: size.getPercentageWidth(5),
                //vertical: size.getPercentageHeight(2),
              ),
              child: Column(
                children: [
                  const Text(
                      "Here is a list of your favoiurite producs. Feel free to place an order from here"),
                  SizedBox(
                    height: size.getPercentageHeight(3),
                  ),
                  Row(
                    children: [
                      FavCart(count: favouriteProduct.length, isFav: true),
                      SizedBox(
                        width: size.getPercentageWidth(5),
                      ),
                      FavCart(count: favInCArt())
                    ],
                  )
                ],
              )),

          /*---------------------------------
            Categories seperator
            ---------------------------------*/
          seperator(
            context,
            "Categories",
          ),
          /*---------------------------------
              Categories Slider
              ---------------------------------*/
          SizedBox(
            width: size.getPercentageWidth(100),
            height: size.getPercentageHeight(5),
            child: ListView.builder(
                itemCount: onboardingData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: () {
                      //print(onboardingData[index].title);
                      loadProduct(onboardingData[index].title.toLowerCase());
                      setState(() {
                        activeCatIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: size.getPercentageWidth(5)),
                      margin: EdgeInsets.only(left: size.getPercentageWidth(3)),
                      child: Text(
                        onboardingData[index].title,
                        style: TextStyle(
                            color: activeCatIndex == index
                                ? Colors.white
                                : Colors.black87),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: activeCatIndex == index
                              ? themeData.primaryColor
                              : Colors.grey.shade200),
                    ),
                  );
                }),
          ),
          /*---------------------------------
              Product Grid display
            ---------------------------------*/
          Expanded(
              child: _thisProduct.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: size.getPercentageHeight(3)),
                      padding: EdgeInsets.only(
                          right: size.getPercentageWidth(3),
                          left: size.getPercentageWidth(1)),
                      child: GridView.builder(
                          itemCount: _thisProduct.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, //items per row
                            mainAxisSpacing: 20, //spacing between each box
                            childAspectRatio: 0.77, //adjusting item height
                            crossAxisSpacing: 10, //spacing between
                          ),
                          itemBuilder: (BuildContext context, index) {
                            return ProductCard(
                              index: index,
                              product: _thisProduct[index],
                            );
                          }),
                    )
                  : const Center(
                      child: Text(
                          "there is no active product within this categories"),
                    )),
        ],
      )),
    );
  }
}

class FavCart extends StatelessWidget {
  const FavCart({Key? key, required this.count, this.isFav = false})
      : super(key: key);

  final int count;
  final bool isFav;

  @override
  Widget build(BuildContext context) {
    SizeConfig size = SizeConfig();
    return Expanded(
        child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.getPercentageWidth(5),
        vertical: size.getPercentageHeight(1),
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 4.9)],
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isFav ? Icons.favorite : Icons.shopping_cart,
            color: Theme.of(context).primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              count.toString(),
              style: darkPrimaryStyle(context, 20, true),
            ),
          ),
          isFav ? Text("inFav") : Text("inCart")
        ],
      ),
    ));
  }
}
