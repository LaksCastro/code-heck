import 'package:code_heck_00/main.dart';
import 'package:code_heck_00/painters/custom_clock_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ClockWrapper extends StatefulWidget {
  const ClockWrapper({Key? key}) : super(key: key);

  @override
  _ClockWrapperState createState() => _ClockWrapperState();
}

class _ClockWrapperState extends State<ClockWrapper>
    with SingleTickerProviderStateMixin {
  static const kPadding = 45.0;

  late final AnimationController _controller;

  late final Animation<double> _boxShadowAnimation;

  static const _kMinBlurRadius = 2.0;
  static const _blurRadius = 14.0 - _kMinBlurRadius;

  static const _kMinOffsetY = 2.0;
  static const _kOffsetX = 0.0;
  static const _kOffsetY = 14 - _kMinOffsetY;

  static const _kMinSpreadRadius = 1.0;
  static const _spreadRadius = 6.0 - _kMinSpreadRadius;

  static const _kShadowColor = Color(0x44000000);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
      duration: const Duration(milliseconds: 2000),
      value: 1,
    );

    _boxShadowAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Listener(
          onPointerDown: (details) =>
              _controller.forward(from: _controller.value),
          onPointerUp: (details) =>
              _controller.reverse(from: _controller.value),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final value = _boxShadowAnimation.value;
              final rValue = 1.0 - value;

              return Container(
                child: const CustomClockAnimation(),
                decoration: BoxDecoration(
                  border: Border.all(color: kLightColor),
                  shape: BoxShape.circle,
                  color: kBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: (rValue * _blurRadius) + _kMinBlurRadius,
                      color: _kShadowColor,
                      offset: Offset(
                          _kOffsetX, (rValue * _kOffsetY) + _kMinOffsetY),
                      spreadRadius:
                          (_spreadRadius * rValue) + _kMinSpreadRadius,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CustomClockAnimation extends StatefulWidget {
  const CustomClockAnimation({Key? key}) : super(key: key);

  @override
  _CustomClockAnimationState createState() => _CustomClockAnimationState();
}

class _CustomClockAnimationState extends State<CustomClockAnimation> {
  late final Stream<void> _ticker;

  @override
  void initState() {
    super.initState();

    _ticker = Stream<void>.periodic(const Duration(milliseconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<void>(
      stream: _ticker,
      builder: (context, snapshot) {
        return CustomPaint(
          painter: CustomClockPainter(),
        );
      },
    );
  }
}
