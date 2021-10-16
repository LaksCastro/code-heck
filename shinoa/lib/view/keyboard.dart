import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:shinoa/theme.dart';

class KeyBoard extends StatefulWidget {
  final TextEditingController controller;

  const KeyBoard({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _KeyBoardState createState() => _KeyBoardState();
}

class _KeyBoardState extends State<KeyBoard> {
  TextEditingController get _controller => widget.controller;

  final bgPrimaryColor = const Color(0xff222831);
  final bgSecundaryColor = const Color(0xff393e46);
  final highlightColor = const Color(0xff00adb5);

  var screenOperation = '';
  var screenResult = '';
  var previus = '';

  final List<String> buttons = [
    'C',
    '%',
    '+=',
    '/',
    '7',
    '8',
    '9',
    'X',
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
    return Column(children: <Widget>[
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
                                side: const BorderSide(color: kPaperColor)),
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
                      clearScreenOp();
                      clearScreenResult();
                    } else if (buttons[index] == 'DEL') {
                      removeLastChar();
                    } else if (buttons[index] == '=') {
                      equalPressed();
                    } else if (isOperator(previus) &&
                        isOperator(buttons[index])) {
                      return;
                    } else {
                      setState(() {
                        screenOperation += buttons[index];
                        previus = buttons[index];
                      });
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
    ]);
  }

  void _insertText(String text) {
    final text = _controller.text;
    final textSelection = _controller.selection;

    final newText =
        text.replaceRange(textSelection.start, textSelection.end, text);

    final textLength = text.length;

    _controller.text = newText;
    _controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + textLength,
      extentOffset: textSelection.start + textLength,
    );
  }

  bool isOperator(String x) {
    if (x == '+' || x == '-' || x == '*' || x == '%' || x == '=' || x == '/') {
      return true;
    }
    return false;
  }

  void clearScreenOp() {
    setState(() {
      screenOperation = '';
      previus = '';
    });
  }

  void clearScreenResult() {
    setState(() {
      screenResult = '';
      previus = '';
    });
  }

  void removeLastChar() {
    setState(() {
      screenOperation =
          screenOperation.substring(0, screenOperation.length - 1);
    });
  }

  void equalPressed() {
    String a = screenOperation;
    Parser p = Parser();
    Expression exp = p.parse(a);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    setState(() {
      screenResult = eval.toString();
      clearScreenOp();
    });
  }
}
