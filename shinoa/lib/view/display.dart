import 'package:flutter/material.dart';
import 'package:shinoa/theme.dart';
import 'package:shinoa/view/store.dart';

class Display extends StatefulWidget {
  final Store store;

  const Display({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  TextEditingController get _controller => widget.store.controller;

  Widget _buildHistory() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: AnimatedBuilder(
          animation: widget.store.previous,
          builder: (context, child) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              reverse: true,
              children: [
                const Padding(padding: EdgeInsets.only(bottom: 12)),
                Text(
                  widget.store.previous.value,
                  style: _kHistoryTextStyle,
                  textAlign: TextAlign.right,
                ),
                const Padding(padding: EdgeInsets.only(bottom: 12)),
              ],
            );
          },
        ),
      ),
    );
  }

  static const _kEqualTextStyle = TextStyle(
    color: kTextColor,
    fontSize: 40,
  );
  static const _kResultTextStyle = TextStyle(color: kLightText, fontSize: 40);
  static const _kHistoryTextStyle = TextStyle(color: kTextColor, fontSize: 20);

  Widget _buildResult() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '=',
            style: _kEqualTextStyle,
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              cursorColor: kAccentColor,
              textAlign: TextAlign.end,
              style: _kResultTextStyle,
              controller: _controller,
              readOnly: true,
              showCursor: true,
              autofocus: true,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHistory(),
            _buildResult(),
          ],
        ),
      ),
    );
  }
}
