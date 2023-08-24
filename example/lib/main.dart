import 'package:flutter/material.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void _makeCall(String number) {
    print('calling $number');
  }

  void _keyPressed(String number) {
    print(number);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
            child: DialPad(
              makeCall: _makeCall,
              keyPressed: _keyPressed,
              dialButtonColor: Colors.blue,
              buttonColor: Colors.white,
              buttonTextColor: Colors.black54,
            ),
        ),
      ),
    );
  }
}
