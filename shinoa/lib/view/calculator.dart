import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shinoa/theme.dart';
import 'package:shinoa/view/context_menu.dart';

import 'display.dart';
import 'keyboard.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: '2.222');
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        title: ContextMenu(controller: _controller),
      ),
      body: Column(
        children: [
          Display(controller: _controller),
          KeyBoard(controller: _controller),
        ],
      ),
    );
  }
}
