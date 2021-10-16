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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 25,
              color: kAccentColor,
            )
          ],
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
                        ? ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(kBackgroundColor),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: const BorderSide(
                                  color: kPaperColor,
                                  width: 3,
                                ),
                              ),
                            ),
                          )
                        : equal
                            ? ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kAccentColor),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              )
                            : ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kPaperColor),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                    onPressed: () {
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
                    },
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
    );
  }

  void _insertText(String text) {
    final controllerText = _controller.text;

    final max = controllerText.length;

    final textSelection = _controller.selection;

    final start = textSelection.start;
    final end = textSelection.end;

    final newText = controllerText.replaceRange(
      start == -1 ? max : start,
      end == -1 ? max : end,
      text,
    );

    final textLength = text.length;
    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + textLength,
      extentOffset: textSelection.start + textLength,
    );
  }

  bool isOperator(String x) =>
      x == '+' || x == '-' || x == '*' || x == '%' || x == '=' || x == '/';

  void equalPressed() {
    final parser = Parser();
    final exp = parser.parse(_controller.text);
    final cm = ContextModel();
    final eval = exp.evaluate(EvaluationType.REAL, cm);

    widget.store.previous.value = _controller.text;

    _controller.text = '$eval'.substring(0, '$eval'.length.clamp(0, 8));
    widget.store.moveCursorToTheEnd();
  }
}
