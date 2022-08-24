import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  const CustomInput(
      {Key? key,
      required this.emailController,
      required this.themedata,
      required this.hintText,
      this.private = false})
      : super(key: key);

  final TextEditingController emailController;
  final ThemeData themedata;
  final String hintText;
  final bool private;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool isVisble = false;

  void _toggleVisiblity() {
    setState(() {
      isVisble = !isVisble;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 7, bottom: widget.private ? 0 : 0),
      height: 55,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: widget.emailController,
        obscureText: widget.private
            ? isVisble
                ? true
                : false
            : false,
        decoration: InputDecoration(
          suffixIcon: widget.private
              ? IconButton(
                  onPressed: () {
                    _toggleVisiblity();
                  },
                  icon: isVisble
                      ? const Icon(
                          Icons.visibility,
                        )
                      : const Icon(
                          Icons.visibility_off,
                        ))
              : const SizedBox(),
          hintText: widget.hintText,
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: widget.themedata.scaffoldBackgroundColor),
            borderRadius: BorderRadius.circular(15.7),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: widget.themedata.scaffoldBackgroundColor),
            borderRadius: BorderRadius.circular(15.7),
          ),
          border: InputBorder.none,
          filled: true,
          fillColor: widget.themedata.primaryColorDark.withOpacity(0.05),
        ),
      ),
    );
  }
}
