import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shinoa/theme.dart';
import 'package:shinoa/view/calculator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// Lock orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

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
      home: const Calculator(),
    );
  }
}
