import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/models/user.dart';
import 'package:fashion_shop/utilities/style.dart';
import 'package:flutter/material.dart';

class ProfileTop extends StatelessWidget {
  const ProfileTop({
    Key? key,
    required this.user,
    this.hasEdit = false,
  }) : super(key: key);

  final UserModel user;
  final bool hasEdit;

  @override
  Widget build(BuildContext context) {
    SizeConfig size = SizeConfig();
    return Row(
      children: [
        Stack(
          children: [
            Container(
              width: size.getPercentageWidth(25),
              height: size.getPercentageWidth(25),
              margin: EdgeInsets.only(right: size.getPercentageWidth(5)),
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(user.image)),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.amber),
            ),
            hasEdit
                ? Positioned(
                    right: 22,
                    top: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: IconButton(
                            color: Colors.white,
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit,
                              size: 18,
                            )),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${user.firstname} ${user.lastname}",
              style: darkPrimaryStyle(context, 25, true),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: size.getPercentageWidth(2)),
              child: Text(
                user.email,
                style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: size.getPercentageWidth(1),
                  horizontal: size.getPercentageWidth(2)),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.amber,
                    radius: 15,
                    child: Icon(
                      Icons.currency_pound,
                      size: 17,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: size.getPercentageWidth(3),
                  ),
                  Text(
                    double.parse(user.amountSpent.toString())
                        .toStringAsFixed(2),
                    style: darkPrimaryStyle(context, 20, true)
                        .copyWith(color: Colors.white),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
