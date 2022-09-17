import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/screens/main/account/components/accountCards.dart';
import 'package:fashion_shop/screens/profile/editProfile.dart';
import 'package:fashion_shop/screens/main/account/components/license.dart';
import 'package:fashion_shop/screens/main/account/components/policy.dart';
import 'package:fashion_shop/storage/db.dart';
import 'package:fashion_shop/utilities/route.dart';
import 'package:fashion_shop/utilities/style.dart';
import 'package:fashion_shop/widgets/alertBox.dart';
import 'package:fashion_shop/widgets/topProfile.dart';
import 'package:flutter/material.dart';

import '../../mainScreen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    privacyPolicy();
    termsOfUse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig size = SizeConfig();
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.getPercentageWidth(4)),
          child: Column(
            children: [
              ProfileTop(user: user),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleDivider(title: "PROFILE"),
                      SizedBox(
                        height: size.getPercentageHeight(1),
                      ),
                      /*---------------------------------
                        Profile Section
                        ---------------------------------*/
                      AccountCard(
                        title: "Profile Details",
                        caption: user.email,
                        icon: Icons.person,
                        action: () {
                          reversibleNavigation(context, ProfileScreen());
                        },
                      ),
                      lineDivider(size),
                      const TitleDivider(title: "PAYMENT"),
                      /*---------------------------------
                        Bank Details
                        ---------------------------------*/
                      AccountCard(
                        title: "Bank Details",
                        caption: "Add Bank or paypal account",
                        icon: Icons.account_balance,
                        action: () {
                          popUp(context, "Upcoming Soon", []);
                        },
                      ),
                      /*---------------------------------
                        Title and price section
                        ---------------------------------*/
                      AccountCard(
                        title: "Transactions",
                        caption: "History of all transactions",
                        icon: Icons.credit_card,
                        action: () {
                          irreversibleNavigate(
                              context,
                              MainScreen(
                                activePage: 3,
                              ));
                        },
                      ),
                      lineDivider(size),
                      TitleDivider(title: "SETTINGS"),
                      AccountCard(
                        title: "Push Nothifications",
                        caption: "",
                        icon: Icons.notifications_active_outlined,
                        hasSwitch: true,
                        switchState: user.pushNotification,
                      ),
                      AccountCard(
                          title: "Email Notifications",
                          caption: "",
                          hasSwitch: true,
                          switchState: user.emailNotification,
                          icon: Icons.email_outlined),
                      AccountCard(
                        title: "Terms of Use",
                        caption: "",
                        icon: Icons.receipt_long,
                        action: () {
                          showTermsOfUse(context);
                        },
                      ),
                      AccountCard(
                        title: "Privacy Policy",
                        caption: "",
                        icon: Icons.privacy_tip_outlined,
                        action: () {
                          showPrivacyPolicy(context);
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  Container lineDivider(SizeConfig size) {
    return Container(
      width: size.getPercentageWidth(100),
      margin: EdgeInsets.only(bottom: size.getPercentageWidth(0)),
      color: Colors.grey,
      height: 0.15,
    );
  }
}

/*-------------------------
Title divider
---------------------------*/
class TitleDivider extends StatelessWidget {
  const TitleDivider({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    SizeConfig size = SizeConfig();
    return Padding(
      padding: EdgeInsets.only(
          top: size.getPercentageHeight(2),
          bottom: size.getPercentageHeight(2)),
      child: Text(
        title,
        style: TextStyle(color: Colors.grey.shade700),
      ),
    );
  }
}

/*-------------------------
Top Screen Section
---------------------------*/
