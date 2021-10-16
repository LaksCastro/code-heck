import 'package:flutter/material.dart';
import 'package:shinoa/theme.dart';

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

  Widget _buildTopButtons() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildMenuButton(),
        _buildBackspaceButton(),
      ],
    );
  }

  Widget _buildHistory() {
    return ListView(
      shrinkWrap: true,
      children: const [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '88 x 4 + 1900 - 120 / 4',
            style: TextStyle(color: kTextColor),
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
        child: Column(
          children: [
            _buildTopButtons(),
            _buildHistory(),
            // _buildOperation(),
          ],
        ),
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
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.menu,
      color: kAccentLightColor,
    );
  }
}
