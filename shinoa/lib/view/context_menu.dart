import 'package:flutter/material.dart';
import 'package:shinoa/theme.dart';
import 'package:shinoa/view/store.dart';

class ContextMenu extends StatefulWidget {
  const ContextMenu({Key? key, required this.store}) : super(key: key);
  final Store store;

  @override
  _ContextMenuState createState() => _ContextMenuState();
}

class _ContextMenuState extends State<ContextMenu> {
  static const _kButtonLabelPadding = 12.0;

  TextEditingController get _controller => widget.store.controller;

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

  void _backspace() {
    final text = _controller.text;
    final textSelection = _controller.selection;
    final selectionLength = textSelection.end - textSelection.start;
    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      _controller.text = newText;
      _controller.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    }
    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }
    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }

  bool _isUtf16Surrogate(int value) => value & 0xF800 == 0xD800;

  Widget _buildBackspaceButton() {
    return GestureDetector(
      onTap: _backspace,
      child: Row(
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
      ),
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
