import 'package:fashion_shop/models/product.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final ProductModel product;
  const DetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late ScrollController _scrollController;
  Color _textColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _textColor = _isSliverAppBarExpanded ? Colors.black : Colors.blue;
        });
      });
  }

  //----------
  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }
//----------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //1
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            //2
            SliverAppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              expandedHeight: 350.0,
              collapsedHeight: 70,
              flexibleSpace: FlexibleSpaceBar(
                // titlePadding: EdgeInsets.all(0),
                title: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                color: _textColor, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Sub title",
                            textScaleFactor: 0.7,
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                      Text(
                        widget.product.price,
                        textScaleFactor: 1.0,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(30)),
                      image: DecorationImage(
                          image: AssetImage(widget.product.image))),
                ),
                // stretchModes: const [StretchMode.zoomBackground],
              ),

              pinned: true,
              snap: false,
              floating: false,

              // bottom: AppBar(
              //     backgroundColor: Colors.amber,
              //     leading: Container(),
              //     actions: [
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             widget.product.name,
              //             textScaleFactor: 0.9,
              //             style: TextStyle(color: _textColor),
              //           ),
              //           Text(
              //             "Sub Descript",
              //             textScaleFactor: 0.9,
              //             style: TextStyle(color: Colors.grey.shade200),
              //           ),
              //         ],
              //       ),
              //     ]),
            ),

            //3
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, int index) {
                  return ListTile(
                    leading: Container(
                        padding: EdgeInsets.all(8),
                        width: 100,
                        child: Placeholder()),
                    title: Text('Place ${index + 1}', textScaleFactor: 2),
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
