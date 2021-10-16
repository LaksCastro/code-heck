import 'package:flutter/material.dart';
import 'package:shinoa/theme.dart';
import 'package:shinoa/view/calculator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: kFontFamily,
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: Calculator(),
    );
  }
}
