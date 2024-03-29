import 'package:flutter/material.dart';
import 'package:flutter_dialpad_example/screens/dialpad_selection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
