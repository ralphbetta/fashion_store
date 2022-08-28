import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/models/category.dart';
import 'package:fashion_shop/storage/advert_temp.dart';
import 'package:fashion_shop/storage/category_temp.dart';
import 'package:fashion_shop/storage/products_temp.dart';
import 'package:fashion_shop/widgets/productCard.dart';
import 'package:fashion_shop/widgets/rowSeperator.dart';
import 'package:fashion_shop/widgets/trendingCard.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*---------------------------------
  Update Categories
  ---------------------------------*/
  void updateCategories() {
    if (onboardingData.first.title != 'All') {
      onboardingData.insert(0, CategoryModel(title: "All", image: ""));
    }
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
            "Trending",
          ),
          /*---------------------------------
              Trending Slider
              ---------------------------------*/
          SizedBox(
            width: size.getPercentageWidth(100),
            height: size.getPercentageHeight(14),
            child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    activeAdvert = value;
                  });
                },
                itemCount: tempAdvert.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, index) {
                  return TrendingCard(
                    advert: tempAdvert[index],
                  );
                }),
          ),

          /*---------------------------------
              Trending Slider page indicator
              ---------------------------------*/
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                  tempAdvert.length,
                  (index) => Padding(
                        padding: const EdgeInsets.only(right: 5, top: 5),
                        child: CircleAvatar(
                          backgroundColor: activeAdvert == index
                              ? themeData.primaryColor
                              : Colors.grey.shade200,
                          radius: 5,
                        ),
                      ))
            ],
          ),
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
                      setState(() {
                        activeCatIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 15, horizontal: size.getPercentageWidth(5)),
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
              child: Container(
            margin: EdgeInsets.only(top: size.getPercentageHeight(3)),
            padding: EdgeInsets.only(
                right: size.getPercentageWidth(3),
                left: size.getPercentageWidth(1)),
            child: GridView.builder(
                itemCount: productTempData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //items per row
                  mainAxisSpacing: 20, //spacing between each box
                  childAspectRatio: 0.77, //adjusting item height
                  crossAxisSpacing: 10, //spacing between
                ),
                itemBuilder: (BuildContext context, index) {
                  return ProductCard(index: index);
                }),
          )),
        ],
      )),
    );
  }
}
