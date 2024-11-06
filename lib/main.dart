import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizzapp/getstarted.dart';
import 'package:quizzapp/test.dart';
import 'package:quizzapp/welcome.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
      // home: TestPage(),
    );
  }
}
