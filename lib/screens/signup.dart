import 'package:fashion_shop/config/AppConfig.dart';
import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/screens/login.dart';
import 'package:fashion_shop/screens/onboarding.dart';
import 'package:fashion_shop/screens/splash.dart';
import 'package:fashion_shop/utilities/route.dart';
import 'package:fashion_shop/utilities/style.dart';
import 'package:fashion_shop/widgets/button.dart';
import 'package:fashion_shop/widgets/customeInput.dart';
import 'package:fashion_shop/widgets/horizontalLine.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  /*---------------------------------
  Defining Signup controllers
  ---------------------------------*/
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool rememberMe = true;

  @override
  Widget build(BuildContext context) {
    ThemeData themedata = Theme.of(context);
    double cHeight = SizeConfig.screenHeight;
    double cWidth = SizeConfig.screenWidth;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: customOverlay(themedata),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: cWidth * 0.07),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*---------------------------------
              brand icon
              ---------------------------------*/
              Center(
                child: Container(
                  width: cWidth * 0.3,
                  height: cWidth * 0.3,
                  padding: EdgeInsets.all(
                    cWidth * 0.07,
                  ),
                  child: const Image(
                    image: AssetImage("assets/icons/icon-trans.png"),
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: themedata.primaryColorDark.withOpacity(0.01)),
                ),
              ),
              /*---------------------------------
              Title caption
              ---------------------------------*/
              Padding(
                padding: EdgeInsets.only(
                    top: cHeight * 0.02, bottom: cHeight * 0.05),
                child: Column(
                  children: [
                    Text(
                      "Signup to ${AppConfig.appName}",
                      style: darkPrimaryStyle(context, SizeConfig.large, true),
                    ),
                    const Text(
                      "Please enter your Signup details to continue",
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),

              /*---------------------------------
              Emial form field
              ---------------------------------*/
              Row(
                children: [
                  Text(
                    "Email",
                    style: darkPrimaryStyle(context, 15, true),
                  )
                ],
              ),
              CustomInput(
                emailController: emailController,
                themedata: themedata,
                hintText: "domain@mail.com",
              ),
              /*---------------------------------
              Password form field
            ---------------------------------*/
              Row(
                children: [
                  Text(
                    "Password",
                    style: darkPrimaryStyle(context, 15, true),
                  )
                ],
              ),
              CustomInput(
                emailController: passwordController,
                themedata: themedata,
                hintText: "Enter Password",
                private: true,
              ),

              /*---------------------------------
              Password form field
            ---------------------------------*/
              Row(
                children: [
                  Text(
                    "Confirm Password",
                    style: darkPrimaryStyle(context, 15, true),
                  )
                ],
              ),
              CustomInput(
                emailController: passwordController,
                themedata: themedata,
                hintText: "Confirm Password",
                private: true,
              ),

              /*---------------------------------
               Remember password checkbox
            ---------------------------------*/
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        rememberMe = !rememberMe;
                      });
                    },
                    checkColor: Colors.white,
                    activeColor: themedata.primaryColor,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "By checking, you accept the ",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13.2,
                          ),
                          children: [
                        TextSpan(
                            text: "The Term of service\n",
                            style: TextStyle(
                              color: themedata.primaryColor,
                            )),
                        const TextSpan(text: "and"),
                        TextSpan(
                            text: " Privacy policy",
                            style: TextStyle(
                              color: themedata.primaryColor,
                            )),
                      ])),
                ],
              ),
              SizedBox(
                height: SizeConfig().getPercentageHeight(5),
              ),
              PrimaryButton(
                title: "Signup",
                action: () {
                  irreversibleNavigate(context, const Onboarding());
                },
              ),
              /*---------------------------------
              seperator
              ---------------------------------*/
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig().getPercentageHeight(1)),
                child: Row(
                  children: const [
                    HorizontalLine(),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Or",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    HorizontalLine(),
                  ],
                ),
              ),

              /*---------------------------------
              signup link
              ---------------------------------*/
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: darkPrimaryStyle(context, SizeConfig.small, false),
                  ),
                  GestureDetector(
                    onTap: () {
                      // irreversibleNavigate(context, Signup());
                    },
                    child: GestureDetector(
                      onTap: () {
                        irreversibleNavigate(context, const Login());
                      },
                      child: Text(
                        "Login",
                        style: primaryStyle(context, SizeConfig.small, false),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
