import 'package:flutter/material.dart';
import 'package:flutter_dialpad_example/screens/dialpad_selection.dart';

import 'screens/dialpad_metro.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        iconTheme: IconThemeData(size: 36),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: DialPadSelection(),
    );
  }
}
