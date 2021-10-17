import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shinoa/theme.dart';
import 'package:shinoa/view/store.dart';

class KeyBoard extends StatefulWidget {
  final Store store;

  const KeyBoard({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  _KeyBoardState createState() => _KeyBoardState();
}

class _KeyBoardState extends State<KeyBoard> {
  TextEditingController get _controller => widget.store.controller;

  final bgPrimaryColor = const Color(0xff222831);
  final bgSecundaryColor = const Color(0xff393e46);
  final highlightColor = const Color(0xff00adb5);

  final List<String> buttons = [
    'C',
    '%',
    '+-',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    'i',
    '0',
    '.',
    '=',
  ];

  ButtonStyle _buildCEButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(kBackgroundColor),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: const BorderSide(
            color: kPaperColor,
            width: 3,
          ),
        ),
      ),
    );
  }

  ButtonStyle _buildEqualButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(kAccentColor),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  ButtonStyle _buildDefaultButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(kPaperColor),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  void _onButtonPressed(int index) {
    if (buttons[index] == 'C') {
      widget.store.clear();

      /// clearScreenOp();
      /// clearScreenResult();
    } else if (buttons[index] == 'DEL') {
      /// _backspace();
    } else if (buttons[index] == '=') {
      equalPressed();
    } else {
      _insertText(buttons[index]);
    }
  }

  static const kBottomToolbar = 50.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -kBottomToolbar / 2,
          right: 0,
          left: 0,
          child: Container(
            height: kBottomToolbar,
            decoration: const BoxDecoration(
              color: kAccentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
          ),
        ),
        Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              height: kBottomToolbar / 2,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext contex, int index) {
                    bool equal = buttons[index] == '=';
                    bool ce = buttons[index] == 'C';
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ce
                            ? _buildCEButtonStyle()
                            : equal
                                ? _buildEqualButtonStyle()
                                : _buildDefaultButtonStyle(),
                        onPressed: () => _onButtonPressed(index),
                        child: Text(
                          buttons[index],
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _insertText(String text) {
    final controllerText = _controller.text;

    final max = controllerText.length;

    final textSelection = _controller.selection;

    final start = textSelection.start;
    final end = textSelection.end;

    var newText = controllerText.replaceRange(
      start == -1 ? max : start,
      end == -1 ? max : end,
      text,
    );

    final initialDuplicatedZeros = RegExp(r'^0*');

    final nonNumeric = RegExp(r'[^0-9.]');

    final rawNumbers = newText.split(nonNumeric);

    final formattedNumbers = rawNumbers
        .map((e) => e.length > 1 ? e.replaceAll(initialDuplicatedZeros, '') : e)
        .toList();

    for (var i = 0; i < rawNumbers.length; i++) {
      newText = newText.replaceAll(rawNumbers[i], formattedNumbers[i]);
    }
    final textLength = text.length;
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + textLength,
      extentOffset: textSelection.start + textLength,
    );

    widget.store.moveCursorToTheEnd();
  }

  bool isOperator(String x) =>
      x == '+' || x == '-' || x == '*' || x == '%' || x == '=' || x == '/';

  void equalPressed() {
    final parser = Parser();
    final exp = parser.parse(_controller.text);
    final cm = ContextModel();
    final eval = exp.evaluate(EvaluationType.REAL, cm);

    widget.store.previous.value = _controller.text;

    var text = '$eval'.substring(0, '$eval'.length.clamp(0, 8));

    _controller.text = text;
    widget.store.moveCursorToTheEnd();
  }
}
