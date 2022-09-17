import 'package:flutter/material.dart';

class CircularBotton extends StatelessWidget {
  final Function()? action;
  final String image;
  final Color color;
  final Color iconColor;
  final bool isImage;
  final IconData? icon;
  const CircularBotton({
    Key? key,
    this.action,
    this.image = "",
    this.iconColor = Colors.white,
    this.isImage = true,
    required this.color,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Center(
              child: isImage
                  ? Image(
                      width: 18,
                      color: Colors.white,
                      image: AssetImage(image),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 1.0),
                      child: Icon(
                        icon,
                        size: 20,
                        color: iconColor,
                      ),
                    ),
            )),
      ),
    );
  }
}
