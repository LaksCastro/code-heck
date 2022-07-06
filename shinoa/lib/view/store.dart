import 'package:flutter/cupertino.dart';

class Store {
  final controller = TextEditingController(text: '0');

  final previous = ValueNotifier<String>('');

  void dispose() {
    controller.dispose();
  }

  void clear() {
    controller.text = '0';

    moveCursorToTheEnd();
  }

  void moveCursorToTheEnd() {
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );
  }
}
