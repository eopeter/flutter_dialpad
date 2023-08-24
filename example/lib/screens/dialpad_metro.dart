import 'package:flutter/material.dart';

import 'package:flutter_dialpad/flutter_dialpad.dart';
import '../widgets/ui_app_bar.dart';

class DialPadMetro extends StatelessWidget {
  const DialPadMetro({super.key});

  void _makeCall(String number) {
    print('calling $number');
  }

  void _keyPressed(String number) {
    print(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIAppBar(title: 'DialPad Metro-style'),
      body: DialPad.metro(
        makeCall: _makeCall,
        keyPressed: _keyPressed,
      ),
    );
  }
}
