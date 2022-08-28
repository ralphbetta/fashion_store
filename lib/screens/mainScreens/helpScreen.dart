import 'package:flutter/material.dart';

class HelpScrenn extends StatefulWidget {
  const HelpScrenn({Key? key}) : super(key: key);

  @override
  State<HelpScrenn> createState() => _HelpScrennState();
}

class _HelpScrennState extends State<HelpScrenn> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("HelpSceen")),
    );
  }
}
