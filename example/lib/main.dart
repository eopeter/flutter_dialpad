import 'package:flutter/material.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child:
            DialPad(
                enableDtmf: true,
                //outputMask: "(000) 000-0000",
                hideSubtitle: false,
                backspaceButtonIconColor: Colors.red,
                buttonTextColor: Colors.white,
                dialOutputTextColor: Colors.white,
                keyPressed: (value){
                  print('$value was pressed');
                },
                makeCall: (number){
                  print(number);
                }
            )
        ),
      ),
    );
  }
}
