import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shinoa/theme.dart';

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

class Display extends StatefulWidget {
  const Display({Key? key}) : super(key: key);

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  static const _kButtonLabelPadding = 12.0;

  Widget _buildMenuButton() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: _kButtonLabelPadding),
          child: MenuHamburger(),
        ),
        Text(
          'MENU',
          style: TextStyle(
            color: kTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBackspaceButton() {
    return Row(
      children: [
        Text(
          'MENU',
          style: TextStyle(
            color: kTextColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: _kButtonLabelPadding),
          child: Icon(
            Icons.backspace_outlined,
            color: kAccentLightColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildMenuButton(),
            _buildBackspaceButton(),
          ],
        ),
      ),
    );
  }
}

class Keyboard extends StatefulWidget {
  const Keyboard({Key? key}) : super(key: key);

  @override
  _KeyboardState createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.red,
      ),
    );
  }
}

class MenuHamburger extends StatefulWidget {
  const MenuHamburger({Key? key}) : super(key: key);

  @override
  _MenuHamburgerState createState() => _MenuHamburgerState();
}

class _MenuHamburgerState extends State<MenuHamburger> {
  static const _size = Size(20, 15);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.menu,
      color: kAccentLightColor,
    );
  }
}
