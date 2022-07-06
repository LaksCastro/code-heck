import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom/no_glow_scroll_behavior.dart';
import 'theme.dart';
import 'view/calculator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// Set status bar color
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: kBackgroundColor, // navigation bar color
      statusBarColor: kBackgroundColor, // status bar color
    ),
  );

  /// Lock orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shinoa App',
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: NoGlowScrollBehavior(),
          child: child!,
        );
      },
      theme: ThemeData(
        fontFamily: kFontFamily,
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const Calculator(),
    );
  }
}
