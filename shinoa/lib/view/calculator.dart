import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shinoa/theme.dart';

import 'display.dart';
import 'keyboard.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        brightness: Brightness.dark,
        elevation: 0,
      ),
      body: Column(
        children: [
          Display(),
          Keyboard(),
        ],
      ),
    );
  }
}
