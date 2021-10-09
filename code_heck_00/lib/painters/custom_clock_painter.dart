import 'dart:math';

import 'package:code_heck_00/main.dart';
import 'package:flutter/material.dart';

class CustomClockPainter extends CustomPainter {
  static const kCentralPointSize = 10.0;

  static const kSecondsWidth = 2.0;
  static const kMinutesWidth = 10.0;
  static const kHoursWidth = 10.0;

  Offset _calcCenter(Size size) => size.center(Offset.zero);

  void _drawCentralPoint(Canvas canvas, Size size) {
    final center = _calcCenter(size);

    final centralPointColor = Paint()..color = Colors.white;
    final backgroundPaint = Paint()..color = kBackgroundColor;

    canvas
      ..drawCircle(center, kCentralPointSize, centralPointColor)
      ..drawCircle(center, kCentralPointSize / 2, backgroundPaint);
  }

  void _drawLine(
    Canvas canvas,
    Size size, {
    required double strokeWidth,
    required Color color,
    required double lineWidth,
    required double radians,
  }) {
    assert((() {
      if (strokeWidth > size.height / 2) {
        throw Exception('You need specify a valid [strokeWidth]');
      }

      if (lineWidth < 0 && lineWidth > 1) {
        throw Exception('[lineWidth] must be between 0.0 and 1.0');
      }

      return true;
    })());

    final center = _calcCenter(size);

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;

    final radius = size.height / 2 * lineWidth;

    final x = center.dx + radius * cos(radians);
    final y = center.dy + radius * sin(radians);

    canvas.drawLine(Offset(x, y), center, paint);
  }

  void _drawRect(
    Canvas canvas,
    Size size, {
    required Color color,
    required double radians,
    required double width,
  }) {
    assert((() {
      return true;
    })());

    canvas.save();

    final paint = Paint()..color = color;

    final radius = size.height / 2;

    final center = _calcCenter(size);

    final x = center.dx + radius * cos(radians);
    final y = center.dy + radius * sin(radians);

    rotate(canvas, x, y, radians);

    canvas.drawRect(
      Rect.fromCenter(center: Offset(x, y), width: width, height: width),
      paint,
    );

    canvas.restore();
  }

  void rotate(Canvas canvas, double cx, double cy, double angle) {
    canvas.translate(cx, cy);
    canvas.rotate(angle);
    canvas.translate(-cx, -cy);
  }

  double get _minutesRadians => _toRadians(
      max: 1000 * 60 * 60,
      current: (() {
        final millisecond = DateTime.now().millisecond;
        final seconds = DateTime.now().second * 1000;
        final minutes = DateTime.now().minute * 60 * 1000;

        final milliseconds = millisecond + seconds + minutes;

        return milliseconds / 1;
      })());

  double get _secondsRadians => _toRadians(
        max: 60 * 1000,
        current:
            DateTime.now().millisecond / 1 + (DateTime.now().second * 1000),
      );

  double get _hoursRadians => _toRadians(
      max: 1000 * 60 * 60 * 24 / 2,
      current: (() {
        final millisecond = DateTime.now().millisecond;
        final seconds = DateTime.now().second * 1000;
        final minutes = DateTime.now().minute * 60 * 1000;
        final hours = DateTime.now().hour * 60 * 60 * 1000;

        final milliseconds = millisecond + seconds + minutes + hours;

        return milliseconds / 1;
      })());

  double _toRadians({required double max, required double current}) {
    final tween = Tween(begin: -pi / 2, end: pi * 1.5);

    final value = current / max;

    return tween.transform(value);
  }

  void _drawSecondsLine(Canvas canvas, Size size) => _drawLine(
        canvas,
        size,
        color: kPrimaryColor,
        lineWidth: 0.8,
        radians: _toRadians(
          max: 60 * 1000,
          current:
              DateTime.now().millisecond / 1 + (DateTime.now().second * 1000),
        ),
        strokeWidth: kSecondsWidth,
      );

  void _drawMinutesLine(Canvas canvas, Size size) => _drawLine(
        canvas,
        size,
        color: kCardColor,
        lineWidth: 0.6,
        radians: _minutesRadians,
        strokeWidth: kMinutesWidth,
      );

  void _drawHoursLine(Canvas canvas, Size size) => _drawLine(
        canvas,
        size,
        color: kLightColor,
        lineWidth: 0.45,
        radians: _hoursRadians,
        strokeWidth: kHoursWidth,
      );

  void _drawSecondsRect(Canvas canvas, Size size) => _drawRect(
        canvas,
        size,
        color: kPrimaryColor,
        radians: _secondsRadians,
        width: kSecondsWidth,
      );

  void _drawMinutesRect(Canvas canvas, Size size) => _drawRect(
        canvas,
        size,
        color: kCardColor,
        radians: _minutesRadians,
        width: kMinutesWidth,
      );

  void _drawHoursRect(Canvas canvas, Size size) => _drawRect(
        canvas,
        size,
        color: kLightColor,
        radians: _hoursRadians,
        width: kHoursWidth,
      );

  void _drawOriginMarker(Canvas canvas, Size size) {
    final paint = Paint()..color = kSecondaryColor;

    final radius = size.height / 2;

    final center = _calcCenter(size);

    const radians = -pi / 2;

    final x = center.dx + radius * cos(radians);
    final y = center.dy + radius * sin(radians);

    const width = 5.0;

    canvas.drawCircle(Offset(x, y), width, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    _drawMinutesLine(canvas, size);
    _drawHoursLine(canvas, size);
    _drawSecondsLine(canvas, size);

    _drawCentralPoint(canvas, size);

    _drawMinutesRect(canvas, size);
    _drawHoursRect(canvas, size);
    _drawSecondsRect(canvas, size);

    _drawOriginMarker(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
