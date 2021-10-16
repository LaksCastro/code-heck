import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shinoa/theme.dart';
import 'package:shinoa/view/context_menu.dart';
import 'package:shinoa/view/store.dart';

import 'display.dart';
import 'keyboard.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  late final Store _store;

  @override
  void initState() {
    super.initState();

    _store = Store();
  }

  @override
  void dispose() {
    _store.dispose();

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
        title: ContextMenu(store: _store),
      ),
      body: Column(
        children: [
          Display(store: _store),
          KeyBoard(store: _store),
        ],
      ),
    );
  }
}
