import 'package:flutter/material.dart';

class CircularBotton extends StatelessWidget {
  final Function()? action;
  final String image;
  final Color color;
  final bool isImage;
  final IconData? icon;
  const CircularBotton({
    Key? key,
    this.action,
    this.image = "",
    this.isImage = true,
    required this.color,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
            radius: 19,
            backgroundColor: color,
            child: isImage
                ? Image(
                    width: 18,
                    color: Colors.white,
                    image: AssetImage(image),
                  )
                : Icon(
                    icon,
                    color: Colors.white,
                  )),
      ),
    );
  }
}
