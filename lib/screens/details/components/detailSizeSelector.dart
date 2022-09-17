import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/utilities/style.dart';
import 'package:flutter/material.dart';

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
