import 'dart:async';

import 'package:flutter/material.dart';
import 'package:killua/main.dart';

class DateTimer extends StatefulWidget {
  const DateTimer({Key? key}) : super(key: key);

  @override
  _DateTimerState createState() => _DateTimerState();
}

class _DateTimerState extends State<DateTimer> {
  late Timer _timer;

  late DateTime _now;

  @override
  void initState() {
    super.initState();

    _initTimeHandler();
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  void _initTimeHandler() {
    _now = DateTime.now();

    void computation(Timer timer) {
      final now = DateTime.now();

      if (now.second != _now.second || now.hour != _now.hour) {
        setState(() => _now = now);
      }
    }

    _timer = Timer.periodic(const Duration(seconds: 1), computation);
  }

  InlineSpan _buildTimer() {
    // ignore: prefer_typing_uninitialized_variables
    var hour;
    _now.hour <= 12
        ? hour = '${_now.hour}'.padLeft(2, '0')
        : hour = '${_now.hour - 12}'.padLeft(2, '0');
    final minute = '${_now.minute}'.padLeft(2, '0');

    return TextSpan(
      text: '$hour:$minute',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 36,
        fontFamily: kFontFamily,
      ),
    );
  }

  InlineSpan _buildPmAm() {
    final amPm = _now.hour >= 12 ? 'PM' : 'AM';

    return TextSpan(
      text: '  $amPm',
      style: TextStyle(
        color: Colors.white.withOpacity(.2),
        fontSize: 18,
        fontFamily: kFontFamily,
      ),
    );
  }

  Widget _buildTimezone() {
    return Text(
      'Current Timezone - IN',
      style: TextStyle(
        color: Colors.white.withOpacity(.2),
        fontSize: 12,
        fontFamily: kFontFamily,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTimezone(),
        const Divider(color: Colors.transparent, height: 5),
        Text.rich(
          TextSpan(
            children: [
              _buildTimer(),
              _buildPmAm(),
            ],
          ),
        ),
      ],
    );
  }
}
