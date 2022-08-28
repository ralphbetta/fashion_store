import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/providers/theme.dart';
import 'package:fashion_shop/utilities/colors.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Function? action;
  final String title;
  final bool isLoading;
  const Button(
      {Key? key, this.action, required this.title, this.isLoading = false})
      : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  int activeCount = 0;
  double cHeight = SizeConfig.screenHeight;
  double cWidth = SizeConfig.screenWidth;

  @override
  Widget build(BuildContext context) {
    double cWidth = SizeConfig.screenWidth;

    return ElevatedButton(
      onPressed: () {
        widget.action;
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.isLoading
              ? Container(
                  width: 18,
                  height: 18,
                  margin: EdgeInsets.only(right: cWidth * 0.05),
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                    backgroundColor: Colors.white,
                  ),
                )
              : const SizedBox(),
          Text(widget.title)
        ],
      ),
      style: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
          backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).scaffoldBackgroundColor),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(vertical: 20)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Theme.of(context).primaryColor)))),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final Function()? action;
  final String title;
  final bool isLoading;
  final int padding;
  const PrimaryButton(
      {Key? key,
      this.action,
      required this.title,
      this.isLoading = false,
      this.padding = 0})
      : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    double cWidth = SizeConfig.screenWidth;
    ThemeData themeData = Theme.of(context);
    return ElevatedButton(
      onPressed: widget.action,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.isLoading
              ? Container(
                  width: 18,
                  height: 18,
                  margin: EdgeInsets.only(right: cWidth * 0.05),
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                    backgroundColor: Colors.white,
                  ),
                )
              : const SizedBox(),
          Text(widget.title)
        ],
      ),
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          // backgroundColor:
          //     MaterialStateProperty.all<Color>(Colors.transparent),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: SizeConfig().getPercentageWidth(widget.padding))),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.transparent)))),
    );
  }
}

class GradientButton2 extends StatefulWidget {
  final Function()? action;
  final String title;
  final bool isLoading;
  const GradientButton2(
      {Key? key, this.action, required this.title, this.isLoading = false})
      : super(key: key);

  @override
  State<GradientButton2> createState() => _GradientButton2State();
}

class _GradientButton2State extends State<GradientButton2> {
  @override
  Widget build(BuildContext context) {
    double cWidth = SizeConfig.screenWidth;
    ThemeData themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black26.withOpacity(0.2),
              offset: Offset(0, 2),
              blurRadius: 5.0)
        ],
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          //stops: const [0.0, 1.0],
          colors: [
            Colors.red,
            themeData.primaryColor,
          ],
        ),
        // color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        onPressed: widget.action,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.isLoading
                ? Container(
                    width: 18,
                    height: 18,
                    margin: EdgeInsets.only(right: cWidth * 0.05),
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                      backgroundColor: Colors.white,
                    ),
                  )
                : const SizedBox(),
            Text(widget.title)
          ],
        ),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            // backgroundColor:
            //     MaterialStateProperty.all<Color>(Colors.transparent),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.symmetric(vertical: 20)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.transparent)))),
      ),
    );
  }
}
