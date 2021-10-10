import 'package:flutter/services.dart';
import 'package:killua/widgets/animated_clock.dart';
import 'package:killua/widgets/date_timer.dart';
import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xFF212628);
const kPrimaryColor = Color(0xFFDC3644);
const kLightColor = Color(0xFF3A454A);
const kCardColor = Color(0xFF2B353A);
const kSecondaryColor = Color(0xFF297CDF);
const kFontFamily = 'Kanit-Regular';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const kIconSize = 30.0;

  Widget _buildActionIcon() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Center(
        child: Container(
          width: kIconSize,
          height: kIconSize,
          decoration: BoxDecoration(
            color: kLightColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Container(
              width: kIconSize / 2,
              height: kIconSize / 2,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: kBackgroundColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Clock',
          style: TextStyle(fontFamily: kFontFamily),
        ),
        actions: [
          _buildActionIcon(),
        ],
      ),
      body: Center(
        child: Column(
          children: const [
            ClockWrapper(),
            DateTimer(),
          ],
        ),
      ),
    );
  }
}
