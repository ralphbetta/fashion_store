import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/utilities/style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AccountCard extends StatefulWidget {
  AccountCard(
      {Key? key,
      required this.title,
      required this.caption,
      this.hasSwitch = false,
      this.switchState = false,
      this.action,
      required this.icon})
      : super(key: key);

  final String title;
  final String caption;
  final IconData icon;
  final bool hasSwitch;
  bool switchState;
  final Function()? action;

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  String _switchDisplay(bool active) {
    String display = "";
    if (active) {
      setState(() => display = "On");
    } else {
      setState(() => display = "Off");
    }
    return display;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig size = SizeConfig();
    return GestureDetector(
      onTap: widget.action,
      child: Padding(
        padding: EdgeInsets.only(bottom: size.getPercentageWidth(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: size.getPercentageWidth(3)),
              child: Icon(
                widget.icon,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: darkPrimaryStyle(context, 18, true),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.getPercentageWidth(1)),
                  child: Text(
                    widget.hasSwitch
                        ? _switchDisplay(widget.switchState)
                        : widget.caption,
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            widget.hasSwitch
                ? Switch.adaptive(
                    activeColor: Theme.of(context).primaryColor,
                    value: widget.switchState,
                    onChanged: (bool value) {
                      setState(() {
                        widget.switchState = !widget.switchState;
                      });
                    })
                : Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Theme.of(context).primaryColor,
                  )
          ],
        ),
      ),
    );
  }
}
