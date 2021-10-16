import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shinoa/theme.dart';

class ContextMenu extends StatefulWidget {
  const ContextMenu({Key? key}) : super(key: key);

  @override
  _ContextMenuState createState() => _ContextMenuState();
}

class _ContextMenuState extends State<ContextMenu> {
  static const _kButtonLabelPadding = 12.0;

  Widget _buildMenuButton() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: _kButtonLabelPadding),
          child: Icon(
            Icons.menu,
            color: kAccentLightColor,
          ),
        ),
        const Text(
          'MENU',
          style: TextStyle(
            color: kTextColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildBackspaceButton() {
    return Row(
      children: [
        const Text(
          'DELETE',
          style: TextStyle(
            color: kTextColor,
            fontSize: 16,
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

  @override
  Widget build(BuildContext context) {
    return _buildTopButtons();
  }
}
