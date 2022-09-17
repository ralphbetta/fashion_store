import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final Map regionType;
  final String region;
  final Function(String?)? action;
  const CustomDropdown(
      {Key? key, required this.region, required this.regionType, this.action})
      : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    SizeConfig size = SizeConfig();
    return Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.grey.shade300.withOpacity(0.4),
            borderRadius: BorderRadius.circular(15.4)),
        padding: EdgeInsets.symmetric(horizontal: size.getPercentageWidth(4)),
        margin: const EdgeInsets.only(
          top: 7,
          bottom: 7,
        ),
        child: DropdownButton<String>(
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          value: widget.region,
          isExpanded: true,
          style: const TextStyle(color: Colors.grey),
          underline: const SizedBox(),
          onChanged: widget.action,
          items: widget.regionType
              .map((description, value) {
                return MapEntry(
                    description,
                    DropdownMenuItem<String>(
                      value: description,
                      child: Text(value),
                    ));
              })
              .values
              .toList(),
        ));
  }
}
