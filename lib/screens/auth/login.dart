import 'package:fashion_shop/config/AppConfig.dart';
import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/screens/onboarding.dart';
import 'package:fashion_shop/screens/auth/signup.dart';
import 'package:fashion_shop/screens/splash.dart';
import 'package:fashion_shop/utilities/route.dart';
import 'package:fashion_shop/utilities/style.dart';
import 'package:fashion_shop/widgets/button.dart';
import 'package:fashion_shop/widgets/customeInput.dart';
import 'package:fashion_shop/widgets/horizontalLine.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  /*---------------------------------
  Defining Login controllers
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
                      "Login to ${AppConfig.appName}",
                      style: darkPrimaryStyle(context, SizeConfig.large, true),
                    ),
                    const Text(
                      "Please enter your login details to continue",
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
                  Text(
                    'Remember me',
                    style: darkPrimaryStyle(context, 15, false, opacity: 0.7),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    "Forgot Password?",
                    style: darkPrimaryStyle(context, 15, true),
                  )
                ],
              ),
              SizedBox(
                height: SizeConfig().getPercentageHeight(5),
              ),
              PrimaryButton(
                title: "Login",
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
              Container(
                decoration: BoxDecoration(
                    color: themedata.primaryColorDark.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(40)),
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig().getPercentageWidth(4),
                  horizontal: SizeConfig().getPercentageWidth(5),
                ),
                margin: EdgeInsets.only(
                    bottom: SizeConfig().getPercentageHeight(3)),
                child: Row(
                  children: [
                    Image(
                        width: SizeConfig().getPercentageWidth(5),
                        image:
                            const AssetImage("assets/images/icons/google.png")),
                    SizedBox(
                      width: SizeConfig().getPercentageWidth(18),
                    ),
                    const Text("Login with Google")
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
                    "Don't have an account? ",
                    style: darkPrimaryStyle(context, SizeConfig.small, false),
                  ),
                  GestureDetector(
                    onTap: () {
                      irreversibleNavigate(context, const Signup());
                    },
                    child: Text(
                      "Sign Up",
                      style: primaryStyle(context, SizeConfig.small, false),
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
