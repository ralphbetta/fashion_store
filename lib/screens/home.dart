import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/models/category.dart';
import 'package:fashion_shop/screens/onboarding.dart';
import 'package:fashion_shop/storage/dataset.dart';
import 'package:fashion_shop/storage/products_temp.dart';
import 'package:fashion_shop/utilities/style.dart';
import 'package:fashion_shop/widgets/circleButton.dart';
import "package:flutter/material.dart";

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /*---------------------------------
  Update Categories
  ---------------------------------*/
  void updateCategories() {
    onboardingData.insert(0, CategoryModel(title: "All", image: ""));
  }

  int activeCatIndex = 0;

  int activeBottomIndex = 0;

  @override
  void initState() {
    updateCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    SizeConfig size = SizeConfig();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu_rounded)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          Stack(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_bag_outlined)),
              Positioned(
                right: 5,
                top: 3,
                child: CircleAvatar(
                  radius: 9,
                  backgroundColor: themeData.primaryColor,
                  child: const Text(
                    '0',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              )
            ],
          ),
        ],
        systemOverlayStyle: customOverlay(themeData),
      ),
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
          Container(
            width: size.getPercentageWidth(100),
            height: size.getPercentageHeight(12),
            child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, index) {
                  return TrendingCard();
                }),
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
                        /*---------------------------------
                        Categories Slider
                        ---------------------------------*/
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
                  return Container(
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
                            ),
                            Positioned(
                              right: 15,
                              top: 15,
                              child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.favorite,
                                        size: 15,
                                        color: Colors.red,
                                      ))),
                            )
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
                                  Text(
                                    productTempData[index].name,
                                    style: darkPrimaryStyle(context, 17, true),
                                  ),
                                  SizedBox(
                                    height: size.getPercentageWidth(2),
                                  ),
                                  Text(
                                    "\$ " + productTempData[index].price,
                                    style: primaryStyle(context, 16, true),
                                  ),
                                ],
                              ),
                              CircularBotton(
                                  color: themeData.primaryColor,
                                  isImage: false,
                                  icon: Icons.add_shopping_cart)
                            ],
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(width: 1, color: Colors.grey.shade200)),
                  );
                }),
          )),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeData.primaryColor,
        onPressed: () {},
        child: const Icon(Icons.fingerprint), //icon inside button
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(), //shape of notch
        notchMargin: 6,
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: themeData.primaryColor),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.grey.shade300,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.grey.shade300,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.grey.shade300,
              ),
              onPressed: () {},
            ),
          ],
        ),

        // BottomNavigationBar(
        //   elevation: 0,
        //   showSelectedLabels: false,
        //   showUnselectedLabels: false,
        //   backgroundColor: Theme.of(context).primaryColor.withAlpha(0),
        //   selectedItemColor: Theme.of(context).colorScheme.onSurface,
        //   items: [
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.access_alarm,
        //             size: 30,
        //             color: Theme.of(context).colorScheme.onBackground),
        //         label: 'Edit'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.ac_unit_outlined,
        //             size: 30,
        //             color: Theme.of(context).colorScheme.onBackground),
        //         label: 'Home'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.access_alarm,
        //             size: 30,
        //             color: Theme.of(context).colorScheme.onBackground),
        //         label: 'Edit')
        //   ],
        // ),
      ),
    );
  }
}

seperator(BuildContext context, String caption, {bool more = false}) {
  SizeConfig size = SizeConfig();
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: size.getPercentageWidth(4),
        vertical: size.getPercentageHeight(1)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          caption,
          style: darkPrimaryStyle(context, SizeConfig.large, true),
        ),
        more ? const Text("More") : const Text("")
      ],
    ),
  );
}

class TrendingCard extends StatelessWidget {
  const TrendingCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig size = SizeConfig();
    return Container(
      width: size.getPercentageWidth(90),
      margin: EdgeInsets.only(left: size.getPercentageWidth(4)),
      decoration: BoxDecoration(
          color: Colors.amber, borderRadius: BorderRadius.circular(10)),
    );
  }
}
