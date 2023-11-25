import 'package:flutter/material.dart';

import 'package:flutter_dialpad/flutter_dialpad.dart';

import '../widgets/ui_app_bar.dart';

class DialPadIos extends StatelessWidget {
  const DialPadIos({super.key});

  void _makeCall(String number) {
    print('calling $number');
  }

  void _keyPressed(String number) {
    print(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIAppBar(title: 'DialPad iOS-style'),
      body: DialPad.ios(
        makeCall: _makeCall,
        keyPressed: _keyPressed,
        enableDtmf: true,
      ),
    );
  }
}
