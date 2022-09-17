import 'dart:ui';

import 'package:flutter/material.dart';

popUp(BuildContext context, String title, List<Widget> body) async {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    barrierLabel: "Barrier",
    transitionDuration: const Duration(milliseconds: 700),
    //  pageBuilder: (BuildContext context, Animation<double> animation,
    //     Animation<double> secondaryAnimation) {},
    pageBuilder: (_, __, ___) {
      return AlertDialog(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
                child: Text(
              title,
              style: TextStyle(
                  color: title == "Error Alert"
                      ? Colors.red
                      : Theme.of(context).primaryColor),
            )),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel))
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: SingleChildScrollView(
          child: ListBody(
            children: body,
            //<Widget>[],
          ),
        ),
        actions: <Widget>[],
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      Tween<Offset> tween;
      if (animation.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(0, 1), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(0, -1), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(animation),
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  );
}
