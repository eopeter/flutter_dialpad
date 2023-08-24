import 'package:flutter/material.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:flutter_dialpad_example/widgets/ui_app_bar.dart';

class DialPadPlain extends StatelessWidget {
  const DialPadPlain({super.key});

  void _makeCall(String number) {
    print('calling $number');
  }

  void _keyPressed(String number) {
    print(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIAppBar(title: 'DialPad Plain-style'),
      body: DialPad(
        makeCall: _makeCall,
        keyPressed: _keyPressed,
      ),
    );
  }
}
